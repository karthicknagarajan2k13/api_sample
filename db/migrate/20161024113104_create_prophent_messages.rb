class CreateProphentMessages < ActiveRecord::Migration
  def change
    create_table :prophent_messages do |t|
      t.string :title
      t.text :message
      t.integer :user_request_id
      t.integer :prophent_id

      t.timestamps null: false
    end
  end
end
