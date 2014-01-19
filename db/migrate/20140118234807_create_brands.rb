class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :facebook_link
      t.string :youtubeteaser_link
      t.string :youtubecommercial_link
      t.string :topsy_link
      t.integer :seconds
      t.integer :spots


      t.timestamps
    end
  end
end
