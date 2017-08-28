module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        include TokenHelper, JsonRenderHelper
        skip_before_action :authenticate_scope!, only: [:update]
        skip_before_action :authenticate_user!
        skip_before_action :verify_authenticity_token
        before_action :parse_request
        before_action :auth_user, only: [:update]

        def create
          email = params[:user][:email]
          check_user = User.find_by(email: email)
          if check_user
            p 'Email A----------------'
            render_failed({ success: false, msg: "Email Already taken" })
          else
            @user = User.new(user_params)
            p '---------------------------------------------'
            p @user.errors.full_messages
            begin
              if params[:image].present? and params[:image] != "data:image/jpeg;base64,null"
                data = params[:image].gsub(" ", "+")
                data_uri = data.split(",")[1]
                extention = "png"
                encoded_image = data_uri
                decoded_image = Base64.decode64(encoded_image)
                img_name = "tmp/img_#{Time.now.to_i}.#{extention}"
                File.open(img_name, "wb") { |f| f.write(decoded_image) }
                @user.image = File.open(img_name)
              end
            rescue Exception => e
              p "something went wrong"
              p e
            end
            @user.role_id = Role.find_by(name: "Student").id
            if @user.save
              render_success(msg: "Registration Success",
                             success: true,
                             auth_token: @user.generate_auth_token)
            else
              render_failed({ errors: @user.errors.full_messages },
                            :bad_request)
            end
          end
        end
        private
        def user_params
          params.require(:user).permit(:id, :name, :age, :gender, :email, :password, :password_confirmation, :image, :role_id)
        end
      end
    end
  end
end