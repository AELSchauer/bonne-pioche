class ComponentsController < ApplicationController
  UNITS = %w[ea pack set g L].freeze
  STATUSES = { "draft" => "Draft", "active" => "Active", "inactive" => "Inactive", "archived" => "Archived" }.freeze
  RESTRICTION_LABELS = {
    "caffeine_free" => "Caffeine-free",
    "gluten_free" => "Gluten-free",
    "nut_free" => "Nut-free"
  }.freeze
  SKU_PREFIXES = { "GFT" => "Gift", "PKG" => "Packaging" }.freeze

  def index
    @components = Component.includes(:restrictions, subcategory: :category).order(:name).to_a
  end

  def new
    @component = Component.new
    load_form_collections
  end

  def create
    @component = Component.new(component_params)

    if @component.save
      sync_restrictions
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

    if @component.update(component_params.except(:sku_prefix))
      sync_restrictions
      redirect_to components_path, notice: "Component saved."
    else
      load_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_form_collections
    @restriction_options = Restriction.names.keys
    @next_sku_numbers = next_sku_numbers
    @categories = Category.includes(:subcategories).order(:name)
  end

  def component_params
    params.require(:component).permit(:name, :subcategory_id, :status, :sku_prefix)
  end

  def sync_restrictions
    names = Array(params.dig(:component, :restrictions)).reject(&:blank?)
    @component.restrictions.where.not(name: names).destroy_all
    existing_names = @component.restrictions.pluck(:name)
    (names - existing_names).each { |name| @component.restrictions.create(name: name) }
  end

  def next_sku_numbers
    SKU_PREFIXES.keys.index_with { |prefix| next_sku_number(prefix) }
  end

  def next_sku_number(prefix)
    last = Component.where(sku_prefix: prefix).maximum(:sku_number) || 0
    "%04d" % (last + 1)
  end
end
