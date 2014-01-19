class Checkin < ActiveRecord::Base
  attr_accessible :brand_id, :likes, :talking

  belongs_to :brand
end
