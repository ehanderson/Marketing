class Checkin < ActiveRecord::Base
  attr_accessible :brand_id, :likes, :talking, :checkin_time,
                  :youtube_teaser, :youtube_commercial,
                  :sentiment_score

  belongs_to :brand
end
