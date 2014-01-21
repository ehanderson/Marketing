class CheckinsController < ApplicationController
require 'nokogiri'
# require 'watir'
require 'typhoeus'
require 'selenium-webdriver'

  def new
    # browser = Watir::Browser.new
    @brands = Brand.all
    driver = Selenium::WebDriver.for :firefox

    @brands.each do |brand|
      facebook_link = brand.facebook_link
      topsy_link = brand.topsy_link

      if facebook_link != nil
        page = Typhoeus::Request.get(facebook_link, :timeout => 5000)
        doc = Nokogiri::HTML.parse(page.body)

        likes = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W\d+\W+\d+\W+)likes/)
        if likes.empty?
          likes = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+)likes/).first.first.gsub(/[^0-9]/, "")
        else
          likes = likes.first.first.gsub(/[^0-9]/, "")
        end

        talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+\d+\W+)talking/)
        if talking.empty?
          talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+)talking/)
        end

        if talking.empty?
          talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+)talking/).first.first.gsub(/[^0-9]/, "")
        else
          talking = talking.first.first.gsub(/[^0-9]/, "")
        end
      end


      driver.navigate.to topsy_link
      element = driver.find_element(:class, 'sentiment-label').text.gsub(/[^0-9]/, "")

          Checkin.create(brand_id: brand.id, talking: talking, likes: likes,
                        sentiment_score: element,
                        checkin_time: Time.now)
      # topsy_link = brand.topsy_link

      #   if topsy_link != nil
      #     browser.goto topsy_link
      #       doc = Nokogiri::HTML.parse(browser.html)
      #       sentiment_score = doc.css("span").text.scan(/Tweets(\d+)/).first.first
      #   else
      #     topsy_link = nil
      #   end

      # youtubeteaser_link = brand.youtubeteaser_link

      #   if youtubeteaser_link != nil
      #     browser.goto youtubeteaser_link
      #     doc = Nokogiri::HTML.parse(browser.html)
      #     browser.goto youtubeteaser_link
      #     teaser = doc.css(".watch-view-count").text.gsub(/[^0-9]/, "")
      #   else
      #     teaser = nil
      #   end
      #     Checkin.create(brand_id: brand.id, talking: talking, likes: likes,
      #                     sentiment_score: sentiment_score, checkin_time: Time.now,
      #                     youtube_teaser: teaser)
       #  puts brand.name
       #  puts likes
       #  puts talking
       #  puts sentiment_score
       #  puts teaser
      end
    render :complete
      driver.execute_script "window.onbeforeunload = function(e){};"
      driver.quit
  end
end
