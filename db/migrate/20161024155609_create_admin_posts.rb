class CreateAdminPosts < ActiveRecord::Migration
  def change
    create_table :admin_posts do |t|
      t.text :url
      t.string :title
      t.text :message
      t.boolean :is_active, default: false

      t.timestamps null: false
    end
  end
end
