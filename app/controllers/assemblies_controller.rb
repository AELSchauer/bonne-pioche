class AssembliesController < ApplicationController
  include ManagesParts

  STATUSES = { "draft" => "Draft", "active" => "Active", "inactive" => "Inactive", "archived" => "Archived" }.freeze
  RESTRICTION_LABELS = {
    "caffeine_free" => "Caffeine-free",
    "gluten_free" => "Gluten-free",
    "nut_free" => "Nut-free"
  }.freeze
  SKU_PREFIXES = { "GFT" => "Gift", "PKG" => "Packaging" }.freeze
  TYPES = { "GiftAssembly" => "Gift assembly / Kit", "Assembly" => "Assembly / Sub-Assembly" }.freeze

  def index
    @assemblies = Assembly.includes(:restrictions, subcategory: :category).order(:name).to_a
  end

  def new
    @assembly = Assembly.new
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

  def load_form_collections
    @restriction_options = Restriction.names.keys
    @next_sku_numbers = SKU_PREFIXES.keys.index_with { |prefix| next_sku_number(Assembly, prefix) }
    @categories = categories_with_subcategories
    @option_groups = {
      "Components" => Component.order(:name).map { |c| [ c.name, "Component-#{c.id}" ] },
      "Sub-assemblies" => Assembly.where.not(id: @assembly.id).order(:name).map { |a| [ a.name, "Assembly-#{a.id}" ] }
    }
  end

  def assembly_params
    params.require(:assembly).permit(:name, :subcategory_id, :status, :sku_prefix,
      assembly_line_items_attributes: [ :id, :quantity, :_destroy,
        line_item_options_attributes: [ :id, :option_ref, :is_primary, :_destroy ] ])
  end
end
