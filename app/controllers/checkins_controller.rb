class CheckinsController < ApplicationController
require 'nokogiri'
require 'watir'
require 'csv'
# require 'typhoeus'
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

  # def new


      # link = 'https://www.facebook.com/Axe'
        # page = Typhoeus::Request.get(link, :timeout => 5000)
        # doc = Nokogiri::HTML.parse(page.body)
        # test = doc.css('a').text
        # puts test
        #   large_likes = doc.css("h2").text.scan(/[a-z]?(\d+\W\d+\W+\d+\W+)likes/).first
        #   small_likes = doc.css('h2').text.scan(/[a-z]?(\d+\W+\d+\W+)likes/).first
        #   talking_about = doc.css("h2").text.scan(/(\d+\W+\d+) talking/).first
        #   talking_large = doc.css("h2").text.scan(/(\d+\W+\d+\W+\d+) talking/).first
        #   talking_small = doc.css("h2").text.scan(/(\d+) talking/).first
        # likes = large_likes || small_likes
        # talking = talking_about || talking_large || talking_small
        # if likes != nil
        #   like = likes.first.gsub(/[^0-9]/, "")
        #   talk = talking.first.gsub(/[^0-9]/, "")
        #   puts like
        #   puts talk
        # else
        #  puts likes
        #  puts talking
        # end

  #   render :new
  # end

  def new
    @brands = Brand.all
    browser = Watir::Browser.new
    @brands.each do |brand|
      link = brand.facebook_link
        browser.goto link
        doc = Nokogiri::HTML.parse(browser.html)
          large_likes = doc.css("h2").text.scan(/[a-z]?(\d+\W\d+\W+\d+\W+)likes/).first
          small_likes = doc.css('h2').text.scan(/[a-z]?(\d+\W+\d+\W+)likes/).first
          talking_about = doc.css("h2").text.scan(/(\d+\W+\d+) talking/).first
          talking_large = doc.css("h2").text.scan(/(\d+\W+\d+\W+\d+) talking/).first
          talking_small = doc.css("h2").text.scan(/(\d+) talking/).first
        likes = large_likes || small_likes
        talking = talking_about || talking_large || talking_small
        if likes != nil
          like = likes.first.gsub(/[^0-9]/, "")
          talk = talking.first.gsub(/[^0-9]/, "")
          Checkin.create(brand_id: brand.id, talking: talk, likes: like)
        else
        Checkin.create(brand_id: brand.id, talking: talking, likes: likes)
        end
      end
    render :new
  end
end
