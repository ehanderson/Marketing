class BrandsController < ApplicationController

  def data
    @brands = Brand.order(:name)
    respond_to do |format|
      format.html
      format.csv { send_data @brands.to_csv }
      format.xls { send_data @brands.to_csv(col_sep: "\t") }
    end
  end

  def show_all
    @brands = Brand.order(:name)
  end

  def destroy
    brand = Brand.find(params[:id])
    brand.checkins.clear
    brand.delete
    redirect_to :show_brand_data
  end

  def edit
    @brand = Brand.find(params[:id])
  end


end
