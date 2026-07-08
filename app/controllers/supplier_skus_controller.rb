class SupplierSkusController < ApplicationController
  before_action :set_supplier

  def index
    @supplier_skus = @supplier.supplier_skus.includes(:supplier_sku_components).order(:name)
  end

  def new
    @supplier_sku = @supplier.supplier_skus.new
    @supplier_sku.supplier_sku_components.build
    load_form_collections
  end

  def create
    @supplier_sku = @supplier.supplier_skus.new(supplier_sku_params)

    if @supplier_sku.save
      redirect_to supplier_supplier_skus_path(@supplier), notice: "SKU saved."
    else
      load_form_collections
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @supplier_sku = @supplier.supplier_skus.find(params[:id])
    load_form_collections
  end

  def update
    @supplier_sku = @supplier.supplier_skus.find(params[:id])

    if @supplier_sku.update(supplier_sku_params)
      redirect_to supplier_supplier_skus_path(@supplier), notice: "SKU saved."
    else
      load_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @supplier_sku = @supplier.supplier_skus.find(params[:id])
    @supplier_sku.destroy
    redirect_to supplier_supplier_skus_path(@supplier), notice: "SKU deleted."
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def load_form_collections
    @components = Component.order(:name)
  end

  def supplier_sku_params
    params.require(:supplier_sku).permit(:name, :sku, :wholesale_cost, :wholesale_quantity, :wholesale_url,
      supplier_sku_components_attributes: [ :id, :component_id, :quantity, :_destroy ])
  end
end
