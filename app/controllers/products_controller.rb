class ProductsController < ApplicationController
  def index
    @products = Product.order(:name)

    respond_to do |format|
      format.html
      format.csv {send_data @products.to_csv}
      format.xls
      format.xlsx
    end
  end

  def import
    Product.import(params[:file])
    redirect_to products_path, notice: 'Products imported.'
  end

end
