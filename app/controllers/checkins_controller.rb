class CheckinsController < ApplicationController
require 'nokogiri'
# require 'watir'
# require 'csv'
require 'typhoeus'
require 'uri'
# require 'watier-webdriver'
# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist
# require 'mechanize'
# require 'nokogiri'
# require 'open-uri'

  # def new
  #   agent = Mechanize.new
  #   page = agent.get('https://www.facebook.com/Axe')

  #   search_result = page.css("h2").text.scan(/[a-z]?(\d+\W\d+\W+\d+\W+)likes/).first
  #   puts search_result
  #   render :new
  # end

  def new

    @brands = Brand.last(25)
    @brands.each do |brand|
      facebook_link = brand.facebook_link
      # youtubeteaser_link = "http://youtu.be/IxB_gduT1wM"
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

        Checkin.create(brand_id: brand.id, likes: likes, talking: talking,
                         checkin_time: Time.now )
      end

        # if topsy_link != nil
         # page = Typhoeus::Request.get(topsy_link, :timeout => 5000)
         # doc = Nokogiri::HTML(open(topsy_link))
            # sentiment_score = doc.css("span").text.scan(/Tweets(\d+)/).first
        # else
          # topsy_link = nil
        # end
        # if youtubeteaser_link != nil
         # page = Typhoeus::Request.get(youtubeteaser_link, :timeout => 5000)
         # doc = Nokogiri::HTML(open(youtubeteaser_link))
         # teaser = doc.css('span')[28].children.text.strip.gsub(/[^0-9]/,"")
         # puts teaser
        # end
    end

    render :new
  end

  # def new
  #   @brands = Brand.all
  #   browser = Watir::Browser.new
  #   @brands.each do |brand|
  #     facebook_link = brand.facebook_link
  #     # youtubeteaser_link = brand.youtubeteaser_link
  #     topsy_link = brand.topsy_link
  #     # # youtubecommercial_link = brand.youtubecommercial_link

  #       browser.goto facebook_link
  #         doc = Nokogiri::HTML.parse(browser.html)
  #           large_likes = doc.css("h2").text.scan(/[a-z]?(\d+\W\d+\W+\d+\W+)likes/).first
  #           small_likes = doc.css('h2').text.scan(/[a-z]?(\d+\W+\d+\W+)likes/).first
  #           talking_about = doc.css("h2").text.scan(/(\d+\W+\d+) talking/).first
  #           talking_large = doc.css("h2").text.scan(/(\d+\W+\d+\W+\d+) talking/).first
  #           talking_small = doc.css("h2").text.scan(/(\d+) talking/).first
  #         likes = large_likes || small_likes
  #         talking = talking_about || talking_large || talking_small

  #       if topsy_link != nil
  #         browser.goto topsy_link
  #           sentiment_score = doc.css("span").text.scan(/Tweets(\d+)/).first
  #         else
  #           topsy_link = nil
  #       end

  #       # if youtubeteaser_link != nil
  #       #   browser.goto youtubeteaser_link
  #       #   teaser = doc.css(".watch-view-count").text.gsub(/[^0-9]/, "")
  #       # else
  #       #   teaser = nil
  #       # end
  #       # if youtubecommercial_link != nil
  #       #   browser.goto youtubecommercial_link
  #       # end


  #       if likes != nil
  #         like = likes.first.gsub(/[^0-9]/, "")
  #         talk = talking.first.gsub(/[^0-9]/, "")
  #         Checkin.create(brand_id: brand.id, talking: talk, likes: like ,
  #                         sentiment_score: sentiment_score , checkin_time: Time.now,
  #                       )
  #           # youtubeteaser_link: teaser
  #       else
  #         Checkin.create(brand_id: brand.id, talking: talking, likes: likes,
  #                         sentiment_score: sentiment_score, checkin_time: Time.now,
  #                        )
  #           # youtubeteaser_link: teaser
  #       end
  #     end
  #   render :new
  # end
end
