class ProphentMessage < ActiveRecord::Base
  belongs_to :user, foreign_key: :prophent_id
  belongs_to :user_request
  has_one :user_feedback
  after_create :send_push_notification

  def send_push_notification
    begin
      # badge_count = self.user_request.user.pn_count + 1
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by_name("android")
      n.registration_ids = self.user_request.user.devices#.android_devices.collect(&:device_token)
      n.data = { message: self.message }
      n.priority = 'high'        # Optional, can be either 'normal' or 'high'
      n.content_available = true # Optional
      n.notification = { body: "#{self.user.name} sent an message",
                         title: self.title,
                         icon: 'icon'
                       }
      # n.badge = badge_count
      n.save!
    rescue Exception => e
      p "Android Exception: #{e}"
    end

    begin
      # badge_count = self.user_request.user.try(:pn_count) + 1
      device_tokens = self.user_request.user.devices#.ios_devices.collect(&:device_token)
      device_tokens.each do |device_token|
        n = Rpush::Apns::Notification.new
        n.app = Rpush::Apns::App.find_by_name("ios_dev")
        n.device_token = device_token
        n.alert = "You received a message"
        n.data = { message: self.message }
        # n.badge = badge_count
        n.save!
      end
    rescue Exception => e
      p "IOS Exception: #{e}"
    end

  end
end
