class HomeController < ApplicationController


#   def destroy
#     @brand = Brand.find(params[:id])
#     @brand.destroy
#     render :new
#   end

  def index

    @brands = Brand.all
    render :index

  end

end

