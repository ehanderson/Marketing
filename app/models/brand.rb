class Brand < ActiveRecord::Base
  attr_accessible :name, :facebook_link, :youtubeteaser_link,
                  :youtubecommercial_link, :topsy_link,
                  :seconds, :spots

  has_many :checkins
end
