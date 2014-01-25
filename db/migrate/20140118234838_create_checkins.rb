class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :likes
      t.string :talking
      t.integer :brand_id
      t.string :checkin_time
      t.string :youtube_teaser
      t.string :youtube_commercial
      t.string :sentiment_score
      t.timestamps
    end
  end

end
