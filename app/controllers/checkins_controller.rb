class CheckinsController < ApplicationController

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    render :new
  end

  def new
    @brands = Brand.last(5)
    @brands.each do |brand|
      facebook_link = brand.facebook_link
      youtubeteaser_link = brand.youtubeteaser_link
      # topsy_link = brand.topsy_link
      Checkin.youtubeteaser(youtubeteaser_link)
      Checkin.facebook(facebook_link)






    #   # driver.navigate.to topsy_link
    #   # element = driver.find_element(:class, 'sentiment-label').text.gsub(/[^0-9]/, "")

    #       # Checkin.create(brand_id: brand.id, talking: talking, likes: likes,
    #       #               # sentiment_score: element,
    #       #               checkin_time: Time.now)


    # # response = HTTParty.get(topsy_link)
    # # body = response.body
    # # matched_data = body.match(/("request".*[^);])/).to_s
    # # hash = JSON.parse(matched_data)
    # # hash["response"]["results"][1]["stats"]["average"]["sentiment_score"]
    #   # topsy_link = brand.topsy_link

    #   #   if topsy_link != nil
    #   #     browser.goto topsy_link
    #   #       doc = Nokogiri::HTML.parse(browser.html)
    #   #       sentiment_score = doc.css("span").text.scan(/Tweets(\d+)/).first.first
    #   #   else
    #   #     topsy_link = nil
    #   #   end


    #       # browser.goto youtubeteaser_link
    #       # doc = Nokogiri::HTML.parse(browser.html)
    #       # browser.goto youtubeteaser_link
    #     # puts likes
    #     else
    #       teaser = nil
    #     end
    #       Checkin.create(brand_id: brand.id, talking: talking, likes: likes,
    #                      checkin_time: Time.now,
    #                       youtube_teaser: teaser)
    #    #  puts brand.name
        # puts likes
    #    #  puts talking
    #    #  puts sentiment_score
    #    #  puts teaser
      end
    render :new
      # driver.execute_script "window.onbeforeunload = function(e){};"
      # driver.quit
  end
end
