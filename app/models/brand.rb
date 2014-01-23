require 'pry'

class Brand < ActiveRecord::Base
  attr_accessible :name, :facebook_link, :youtubeteaser_link,
                  :youtubecommercial_link, :topsy_link,
                  :seconds, :spots

  has_many :checkins

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |brand|
        csv << brand.attributes.values_at(*column_names)
      end
    end
  end

end
