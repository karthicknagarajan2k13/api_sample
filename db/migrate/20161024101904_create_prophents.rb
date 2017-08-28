class CreateProphents < ActiveRecord::Migration
  def change
    create_table :prophents do |t|

      t.timestamps null: false
    end
  end
end
