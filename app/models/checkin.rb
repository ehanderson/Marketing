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

  def self.topsy(topsy_link)
    response = HTTParty.get(topsy_link).body
    matched_data = response.match(/({"request".*}[^);])/).to_s
    hash = JSON.parse(matched_data)
    sentiment_score = hash["response"]["results"][1]["stats"]["average"]["sentiment_score"]
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

  def self.get_facebook_data(user_oauth_token, brand)
    collection = {}
    brand.delete!(' ')
    graph = Koala::Facebook::API.new(user_oauth_token)
    info = graph.get_object(brand)
    collection[:likes] = info["likes"]
    collection[:talking_about_count] = info["talking_about_count"]
    collection
  end

end
