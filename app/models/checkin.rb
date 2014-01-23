class Checkin < ActiveRecord::Base
  attr_accessible :brand_id, :likes, :talking, :checkin_time,
                  :youtube_teaser, :youtube_commercial,
                  :sentiment_score

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

end
