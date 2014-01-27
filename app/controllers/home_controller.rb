class HomeController < ApplicationController

#   def destroy
#     @brand = Brand.find(params[:id])
#     @brand.destroy
#     render :new
#   end

  def index
    @brands = Brand.order(:name)
    # @brands = [Brand.find_by_name('Axe'), Brand.find_by_name('Audi'), Brand.find_by_name('Bud Light')]
    render :index
  end

end

