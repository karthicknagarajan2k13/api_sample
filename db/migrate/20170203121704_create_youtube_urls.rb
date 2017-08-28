class CreateYoutubeUrls < ActiveRecord::Migration
  def change
    create_table :youtube_urls do |t|
      t.string :url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
