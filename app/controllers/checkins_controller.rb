class CheckinsController < ApplicationController

  def show_all
    @brands = Brand.order(:name)
    @checkins = Checkin.all
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

  # def new
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
    
    # sleep(5700)
    # driver = Selenium::WebDriver.for :firefox
    @brands = []
    @brands << Brand.find_by_name('Axe')
    @brands << Brand.find_by_name('Audi')
    @brands << Brand.find_by_name('Budweiser')
     @brands.each do |brand|
    puts  brand.name
    end
    render :new
      # driver.execute_script "window.onbeforeunload = function(e){};"
      # driver.quit
  end


  def perform
    # driver = Selenium::WebDriver.for :firefox
    @brands = Brand.all
    checkin = Time.now

    @brands.each do |brand|
      facebook_link = brand.facebook_link
      youtubeteaser_link = brand.youtubeteaser_link
      topsy_link = brand.topsy_link
      Checkin.data_lookup(topsy_link, youtubeteaser_link, facebook_link, brand.id, checkin)
    end
    # render :new
      # driver.execute_script "window.onbeforeunload = function(e){};"
      # driver.quit
  end

end

