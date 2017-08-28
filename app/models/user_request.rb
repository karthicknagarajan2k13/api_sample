class UserRequest < ActiveRecord::Base
  belongs_to :user, foreign_key: :student_id
  has_one :prophent_message
end
