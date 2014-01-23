class Checkin < ActiveRecord::Base
  attr_accessible :brand_id, :likes, :talking, :checkin_time,
                  :youtube_teaser, :youtube_commercial,
                  :sentiment_score

  belongs_to :brand

  def self.youtubeteaser(youtubeteaser_link)
      if youtubeteaser_link != nil
        page = Typhoeus::Request.get(youtubeteaser_link, :timeout => 5000)
        doc = Nokogiri::HTML.parse(page.body)
        teaser = doc.css(".watch-view-count").text.gsub(/[^0-9]/, "")
        puts teaser
      end

  end
  def self.facebook(facebook_link)
    if facebook_link != nil
      @page = Typhoeus::Request.get(facebook_link, :timeout => 5000)
      @doc = Nokogiri::HTML.parse(@page.body)
      self.likes(facebook_link, @doc)
      self.talking(facebook_link, @doc)
    end
  end

  def self.likes(facebook_link, doc)
    likes = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W\d+\W+\d+\W+)likes/)
    if likes.empty?
      likes = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+)likes/)
    end
    likes = likes.first.first.gsub(/[^0-9]/, "")
  end

  def self.talking(facebook_link, doc)
    talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+\d+\W+)talking/)
    if talking.empty?
      talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+\d+\W+)talking/)
    end
    if talking.empty?
      talking = doc.css('meta')[4].attributes["content"].value.scan(/(\d+\W+)talking/).first.first.gsub(/[^0-9]/, "")
    else
      talking = talking.first.first.gsub(/[^0-9]/, "")
    end
    talking
  end

end
