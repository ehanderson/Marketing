class CheckinsController < ApplicationController

  def show_all
    @brands = Brand.order(:name)
  end

  def data
    @checkins = Checkin.order(:brand_id)
    respond_to do |format|
      format.html
      format.csv { send_data @checkins.to_csv }
      format.xls { send_data @checkins.to_csv(col_sep: "\t") }
    end
  end

  def destroy
    checkin = Checkin.find(params[:id])
    checkin.destroy
    redirect_to :show_checkin_data
  end

  # def perform
  #   driver = Selenium::WebDriver.for :firefox
  #   @brands = Brand.all
  #   checkin = Time.now

  #   @brands.each do |brand|
  #     facebook_link = brand.facebook_link
  #     youtubeteaser_link = brand.youtubeteaser_link
  #     topsy_link = brand.topsy_link
  #     Checkin.data_lookup(driver, topsy_link, youtubeteaser_link, facebook_link, brand.id, checkin)
  #   end
  #   render :new
  #     driver.execute_script "window.onbeforeunload = function(e){};"
  #     driver.quit
  # end

  def new
    # driver = Selenium::WebDriver.for :firefox
    @brands = Brand.all
    checkin = Time.now

    @brands.each do |brand|
      facebook_link = brand.facebook_link
      youtubeteaser_link = brand.youtubeteaser_link
      topsy_link = brand.topsy_link
      Checkin.data_lookup( topsy_link, youtubeteaser_link, facebook_link, brand.id, checkin)
    end
    render :new
      # driver.execute_script "window.onbeforeunload = function(e){};"
      # driver.quit
  end

end

