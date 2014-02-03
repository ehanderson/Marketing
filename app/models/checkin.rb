class Checkin < ActiveRecord::Base
  attr_accessible :brand_id, :likes, :talking, :checkin_time,
                  :youtube_teaser, :youtube_commercial,
                  :sentiment_score, :youtube_teaser_up,
                  :youtube_teaser_down, :youtube_commercial_up,
                  :youtube_commercial_down

  belongs_to :brand

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |checkin|
        csv << checkin.attributes.values_at(*column_names)
      end
    end
  end

  def show
    @checkins = Checkin.order(:brand_id)
  end

  def self.create_checkin(oauth_token, time)
    brands = Brand.all
    brands.each do |brand|
      fb_data         = Checkin.get_facebook_data(oauth_token, brand.name)
      topsy_data      = Checkin.topsy(brand.topsy_link)
      youtube_data    = Checkin.youtubeteaser(brand.youtubeteaser_link)
      commercial_data = Checkin.youtubecommercial(brand.youtubecommercial_link)

      Checkin.create!(brand_id: brand.id, talking: fb_data[:talking_about_count], likes: fb_data[:likes],
                      youtube_teaser: youtube_data[:teaser], sentiment_score: topsy_data,
                      youtube_teaser_up: youtube_data[:teaser_up], youtube_teaser_down: youtube_data[:teaser_down],
                      youtube_commercial: commercial_data[:commercial],
                      youtube_commercial_up: commercial_data[:commercial_up],
                      youtube_commercial_down: commercial_data[:commercial_down],
                      checkin_time: time)
    end
  end

  def self.topsy(topsy_link)
    if topsy_link != nil
      response = HTTParty.get(topsy_link).body
      matched_data = response.match(/({"request".*}[^);])/).to_s
      hash = JSON.parse(matched_data)
      sentiment_score = hash["response"]["results"][1]["stats"]["average"]["sentiment_score"]
    else
      sentiment_score = nil
    end
  end

  def self.youtubeteaser(youtubeteaser_link)
    collection = {}
    if youtubeteaser_link != nil
      page = Typhoeus::Request.get(youtubeteaser_link, :timeout => 5000)
      doc = Nokogiri::HTML.parse(page.body)
      teaser_up = doc.css('.likes-count').text.gsub(/[^0-9]/, "")
      teaser_down = doc.css('.dislikes-count').text.gsub(/[^0-9]/, "")
      teaser = doc.css(".watch-view-count").text.gsub(/[^0-9]/, "")
    else
      teaser = nil
      teaser_down = nil
      teaser_up = nil
    end
    collection[:teaser] = teaser
    collection[:teaser_down] = teaser_down
    collection[:teaser_up] = teaser_up
    collection
  end
    def self.youtubecommercial(youtubecommercial_link)
    collection = {}
    if youtubecommercial_link != nil
      page = Typhoeus::Request.get(youtubecommercial_link, :timeout => 5000)
      doc = Nokogiri::HTML.parse(page.body)
      commercial_up = doc.css('.likes-count').text.gsub(/[^0-9]/, "")
      commercial_down = doc.css('.dislikes-count').text.gsub(/[^0-9]/, "")
      commercial = doc.css(".watch-view-count").text.gsub(/[^0-9]/, "")
    else
      commercial = nil
      commercial_down = nil
      commercial_up = nil
    end
    collection[:commercial] = commercial
    collection[:commercial_down] = commercial_down
    collection[:commercial_up] = commercial_up
    collection
  end

  def self.get_facebook_data(user_oauth_token, brand)
    collection = {}
    brand.delete!(' ')
    brand.delete!('&')
    graph = Koala::Facebook::API.new(user_oauth_token)
    info = graph.get_object(brand)
    collection[:likes] = info["likes"]
    collection[:talking_about_count] = info["talking_about_count"]
    collection
  end

end
