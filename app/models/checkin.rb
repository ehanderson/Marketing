
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

  def self.data_lookup(topsy_link, youtubeteaser_link, facebook_link, brand_id, checkin)
    # self.youtubeteaser(youtubeteaser_link)
    # self.facebook(facebook_link, brand_id)
    self.topsy(topsy_link)
#     Checkin.create(brand_id: brand_id, talking: @talking, likes: @likes,
#                     youtube_teaser: @teaser, sentiment_score: @sentiment_score,
#                     youtube_teaser_up: @teaser_up, youtube_teaser_down: @teaser_down,
#                     checkin_time: checkin)
# # puts @likes
#     Checkin.create(brand_id: brand_id, talking: @talking, likes: @likes,
#                     youtube_teaser: @teaser,
#                     youtube_teaser_up: @teaser_up, youtube_teaser_down: @teaser_down,
#                     checkin_time: checkin)
  end


# budlightURL  = "http://otter.topsy.com/sentiment.js?callback=jQuery183020111811463721097_1390424113194&q=Bud+Light&mintime=1390337735&call_timestamp=1390424135360&apikey=09C43A9B270A470B8EB8F2946A9369F3&_=1390424136116"
# budweiserURL = "http://otter.topsy.com/sentiment.js?callback=jQuery183030369035387411714_1390415434804&q=Budweiser&call_timestamp=1390415435061&apikey=09C43A9B270A470B8EB8F2946A9369F3&_=1390415435405"


def self.topsy(topsy_link)
  response = HTTParty.get(topsy_link).body
  # puts "emily is trying to see you matched data"
  matched_data = response.match(/({"request".*[^);])/)
    # puts matched_data
    puts response
    # puts "you should between these"
  # hash = JSON.parse(matched_data)
 # @sentiment_score = hash["response"]["results"][1]["stats"]["average"]["sentiment_score"]
 # puts @sentiment_score
# puts news_search(budlightURL)
# puts news_search(budweiserURL)


end


  # def self.topsy(driver, topsy_link)
  #  if topsy_link != nil
  #     driver.navigate.to topsy_link
  #     @sentiment_score = driver.find_element(:class, 'sentiment-label').text.gsub(/[^0-9]/, "")
  #   else
  #     @sentiment_score = nil
  #   end
  #   @sentiment_score
  # end

  def self.youtubeteaser(youtubeteaser_link)
    if youtubeteaser_link != nil
      page = Typhoeus::Request.get(youtubeteaser_link, :timeout => 5000)
      doc = Nokogiri::HTML.parse(page.body)
      @teaser_up = doc.css('.likes-count').text.gsub(/[^0-9]/, "")
      @teaser_down = doc.css('.dislikes-count').text.gsub(/[^0-9]/, "")
      @teaser = doc.css(".watch-view-count").text.gsub(/[^0-9]/, "")
    else
     @teaser = nil
     @teaser_down = nil
     @teaser_up = nil
    end
  end

  def self.facebook(facebook_link, brand_id)
    if facebook_link != nil
      page = Typhoeus::Request.get(facebook_link, :timeout => 5000)
      doc = Nokogiri::HTML.parse(page.body)
      self.likes(doc, brand_id)
      self.talking(doc)
    end
  end

  def self.likes(doc, brand_id)
    likes = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W\d+\W+\d+\W+)likes/)
    if likes.empty?
      likes = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+)likes/)
    end
      @likes = likes.first.first.gsub(/[^0-9]/, "")
  end

  def self.talking(doc)
    talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+\d+\W+)talking/)
    if talking.empty?
      talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+)talking/)
    end
    if talking.empty?
      talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+)talking/)
    end
    @talking = talking.first.first.gsub(/[^0-9]/, "")
  end

end
