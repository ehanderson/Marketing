class HomeController < ApplicationController

  def index
    @brands = Brand.order(:name)
    render :index
  end

end

