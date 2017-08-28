class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|
      t.string :status
      t.integer :student_id
      t.integer :prophent_id
      t.date :accepted_at

      t.timestamps null: false
    end
  end
end
