class AddThumbsToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :youtube_teaser_up, :string
    add_column :checkins, :youtube_teaser_down, :string
    add_column :checkins, :youtube_commercial_up, :string
    add_column :checkins, :youtube_commercial_down, :string
  end
end
