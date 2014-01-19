class Brand < ActiveRecord::Base
  attr_accessible :name, :link, :seconds, :spots

  has_many :checkins
end
