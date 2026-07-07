class ComponentsController < ApplicationController
  include ManagesParts

  UNITS = %w[ea pack set g L].freeze
  STATUSES = { "draft" => "Draft", "active" => "Active", "inactive" => "Inactive", "archived" => "Archived" }.freeze
  SKU_PREFIXES = { "GFT" => "Gift", "PKG" => "Packaging" }.freeze

  def index
    @components = Component.includes(restrictions: :restriction_name).order(:name).to_a
  end

  def show
    @component = Component.find(params[:id])
  end

  def new
    @component = Component.new
    clone_from_component
    load_form_collections
  end

  def create
    @component = Component.new(component_params)

    if @component.save
      sync_restrictions(@component, :component)
      redirect_to components_path, notice: "Component saved."
    else
      load_form_collections
      @selected_sku_prefix = params.dig(:component, :sku_prefix)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @component = Component.find(params[:id])
    load_form_collections
  end

  def update
    @component = Component.find(params[:id])
    @component.image.purge if params.dig(:component, :remove_image) == "1"

    if @component.update(component_params.except(:sku_prefix))
      sync_restrictions(@component, :component)
      redirect_to components_path, notice: "Component saved."
    else
      load_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def clone_from_component
    source = Component.find_by(id: params[:clone_from])
    return unless source

    @component.name = "#{source.name} (copy)"
    @component.status = source.status
    source.restrictions.each { |restriction| @component.restrictions.build(restriction_name: restriction.restriction_name) }
    @selected_sku_prefix = source.sku_prefix
  end

  def load_form_collections
    @restriction_options = RestrictionName.order(:name)
  end

  def component_params
    params.require(:component).permit(:name, :status, :sku_prefix, :image)
  end
end
