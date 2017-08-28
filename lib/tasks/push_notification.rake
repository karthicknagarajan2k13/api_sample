namespace :push_notification do
  task :init => :environment do

    # Initialize the Android App
    android_app = Rpush::Gcm::App.find_by_name("android")
    unless android_app.present?
      app = Rpush::Gcm::App.new
      app.name = "android"
      app.auth_key = "AIzaSyDPo4IPbSpTwjlYKAqBwebYeEtqniqCkGQ"
      app.environment = "development"
      app.connections = 1
      app.save!
    end

    Initialize the IOS App
    ios_app = Rpush::Apns::App.find_by_name("ios")
    unless ios_app.present?
      app = Rpush::Apns::App.new
      app.name = "ios"
      app.certificate = File.read("#{Rails.root.to_s}/development.pem")
      app.environment = "development" # APNs environment.
      app.password = ""
      app.connections = 1
      app.save!
    end

  end
end