class AssembliesController < ApplicationController
  include ManagesParts

  STATUSES = { "draft" => "Draft", "active" => "Active", "inactive" => "Inactive", "archived" => "Archived" }.freeze
  SKU_PREFIXES = { "GFT" => "Gift", "PKG" => "Packaging" }.freeze
  TYPES = { "GiftAssembly" => "Gift assembly / Kit", "Assembly" => "Assembly / Sub-Assembly" }.freeze

  def index
    @assemblies = Assembly.includes(restrictions: :restriction_name).order(:name).to_a
  end

  def new
    @assembly = Assembly.new
    clone_from_assembly
    load_form_collections
  end

  def create
    @assembly = assembly_class.new(assembly_params)

    if @assembly.save
      sync_restrictions(@assembly, :assembly)
      redirect_to assemblies_path, notice: "Assembly saved."
    else
      load_form_collections
      @selected_type = params.dig(:assembly, :type)
      @selected_sku_prefix = params.dig(:assembly, :sku_prefix)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @assembly = Assembly.find(params[:id])
    load_form_collections
  end

  def update
    @assembly = Assembly.find(params[:id])

    if @assembly.update(assembly_params.except(:sku_prefix))
      sync_restrictions(@assembly, :assembly)
      redirect_to assemblies_path, notice: "Assembly saved."
    else
      load_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def assembly_class
    TYPES.key?(params.dig(:assembly, :type)) ? params[:assembly][:type].constantize : Assembly
  end

  def clone_from_assembly
    source = Assembly.find_by(id: params[:clone_from])
    return unless source

    @assembly.name = "#{source.name} (copy)"
    @assembly.status = source.status
    source.restrictions.each { |restriction| @assembly.restrictions.build(restriction_name: restriction.restriction_name) }
    source.assembly_line_items.each do |line_item|
      new_line_item = @assembly.assembly_line_items.build(quantity: line_item.quantity)
      line_item.line_item_options.each do |option|
        new_line_item.line_item_options.build(option_type: option.option_type, option_id: option.option_id, is_primary: option.is_primary)
      end
    end
    @selected_type = source.type || "Assembly"
    @selected_sku_prefix = source.sku_prefix
  end

  def load_form_collections
    @restriction_options = RestrictionName.order(:name)
    @option_groups = {
      "Components" => Component.order(:name).map { |c| [ c.name, "Component-#{c.id}" ] },
      "Sub-assemblies" => Assembly.where.not(id: @assembly.id).order(:name).map { |a| [ a.name, "Assembly-#{a.id}" ] }
    }
  end

  def assembly_params
    params.require(:assembly).permit(:name, :status, :sku_prefix, :msrp, :msrp_url,
      assembly_line_items_attributes: [ :id, :quantity, :_destroy,
        line_item_options_attributes: [ :id, :option_ref, :is_primary, :_destroy ] ])
  end
end
