class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_requests, foreign_key: :student_id
  has_many :prophent_messages, foreign_key: :prophent_id
  belongs_to :role
  has_many :admin_posts
  has_many :auth_tokens
  has_one :youtube_url
  # validates :terms, presence: true
  GENDER_TYPES = ['Male', 'Female']
  validates_numericality_of :age, :only_integer => true, :allow_blank => true
  mount_uploader :image, ImageUploader

  def admin?
    role_id == Role.find_by_name('Admin').id
  end

  def prophent?
    role.name.include?('Prophent')
  end

  def generate_auth_token
    key = Rails.application.secrets.secret_key_base
    exp = (Time.current + 1.day).to_i
    payload = { data: email, exp: exp }
    token = JWT.encode payload, key, 'HS256'
    auth_tokens.create(token: token)
    token
  end
  def self.verify_token(token)
    return false unless AuthToken.where(token: token).first.present?
    detoken = decode_token(token)
    (detoken.present? && (Time.at(detoken.first['exp']) > Time.now))
  end
  def self.decode_token(token)
    key = Rails.application.secrets.secret_key_base
    JWT.decode token, key, true, algorithm: 'HS256'
  rescue
    false
  end

  def self.token_user(token)
    AuthToken.where(token: token).first.user
  end
end
