class CreateUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_feedbacks do |t|
      t.string :message
      t.integer :prophent_message_id

      t.timestamps null: false
    end
  end
end
