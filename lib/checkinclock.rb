include Clockwork


class CheckinClock
  def perform
    driver = Selenium::WebDriver.for :firefox
    @brands = Brand.all
    checkin = Time.now

    @brands.each do |brand|
      facebook_link = brand.facebook_link
      youtubeteaser_link = brand.youtubeteaser_link
      topsy_link = brand.topsy_link
      Checkin.data_lookup(driver, topsy_link, youtubeteaser_link, facebook_link, brand.id, checkin)
    end


end

