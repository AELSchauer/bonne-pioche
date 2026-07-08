class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.includes(:supplier_skus).order(:name)
  end

  def show
    @supplier = Supplier.find(params[:id])
    @supplier_skus = @supplier.supplier_skus.includes(supplier_sku_components: :component).order(:name)
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to suppliers_path, notice: "Supplier saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])

    if @supplier.update(supplier_params)
      redirect_to suppliers_path, notice: "Supplier saved."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to suppliers_path, notice: "Supplier deleted."
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :website_url, :description, :sourcing_channel, :account_status,
      :min_order_dollars, :min_order_free_shipping, :lead_time, :notes)
  end
end
