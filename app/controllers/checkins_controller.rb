require 'pry'

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

  def new
    driver = Selenium::WebDriver.for :firefox
    brands = Brand.first(2)
    checkin_time = Time.now
    oauth_token = current_user.oauth_token
      

    brands.each do |brand|
      fb_data      = Checkin.get_facebook_data(oauth_token, brand.name)
      topsy_data   = Checkin.topsy(driver, brand.topsy_link)
      youtube_data = Checkin.youtubeteaser(brand.youtubeteaser_link)

      Checkin.create!(brand_id: brand.id, talking: fb_data[:talking_about_count], likes: fb_data[:likes],
                    youtube_teaser: youtube_data[:teaser], sentiment_score: topsy_data,
                    youtube_teaser_up: youtube_data[:teaser_up], youtube_teaser_down: youtube_data[:teaser_down],
                    checkin_time: Time.now)
    end
    redirect_to root_path
      driver.execute_script "window.onbeforeunload = function(e){};"
      driver.quit
  end

end
