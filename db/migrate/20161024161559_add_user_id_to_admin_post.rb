class AddUserIdToAdminPost < ActiveRecord::Migration
  def change
    add_column :admin_posts, :user_id, :integer
  end
end
