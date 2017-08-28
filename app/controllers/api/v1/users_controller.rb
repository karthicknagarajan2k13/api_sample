module Api
  module V1
      class UsersController < ApiController
        def profile
        	if @user.present?
        		@profile =  {Name: @user.try(:name), Age: @user.try(:age), Gender: @user.try(:gender), Email: @user.try(:email), Image_url_status: @user.image.present? , Image_url: @user.image.url}
          	render json: {success: true, user_profile: @profile, message: "Profile"}
          else
          	render json: {success: false, message: "User not Found"}
          end
        end

        def admin_post
          @admin = User.find_by(role_id: 3)
          @video = YoutubeUrl.last
          @admin_post = @admin.admin_posts
          @active_post = @admin_post.where(is_active: true)
          post = []
          @active_post.each do |h|
            post << {"Title": "#{h.try(:title)}", "Message": "#{h.try(:message)}"}
          end
          if @active_post.present?
            render json: {success: true, admin_name: @admin.name, admin_post_url: @video.url, admin_post_url_status: @video.url.present? , post: post, message: "Get admin post"}
          else
            render json: {success: false, message: "Admin post not Found"}
          end
        end

        def video_url
          if @user.present?
            @video = YoutubeUrl.last
            if @video.present?
              render json: {success: true, url: @video.url, message: "Get video Url"}
            else
              render json: {success: false, message: "Url not Found"}
            end
          end 
        end

        def user_detail
          @user_detail = @user
          if @user.present?
            render json:{success: true, user_name: @user.name, user_mail: @user.email, user_image_status: @user.image.present?, user_image_url: @user.image.url }
          else
            render json: {success: false, message: "User detail not Found"}
          end
        end

        def student_history
          if @user.present?
            @histroy = @user.user_requests.where(status: 'Accepted')
            if @histroy.count > 0
              histroy = []
              @histroy.each do |h|
                histroy << {"id": h.prophent_message.try(:id), "Title": "#{h.prophent_message.try(:title)}", "ProphentName": "#{h.prophent_message.try(:user).try(:name)}", "AcceptAt": "#{h.try(:accepted_at)}"}
              end
              render json: {success: true, message: "Get histroy", histroy: histroy}
            else
              render json: {success: false, message: "No histroy found"}
            end
          else
            render json: {success: false, message: "User not Found"}
          end
        end

        def prophent_history
          if @user.present?
            @histroy = @user.prophent_messages
            if @histroy.count > 0
              render json: {success: true, histroy: @histroy}
            else
              render json: {success: true, message: "No histroy"}
            end
          else
            render json: {success: false, message: "User not Found"}
			    end
			  end

        def user_feedback
          @prophent_message = ProphentMessage.find_by(id: params[:prophent_message_id])
          if @prophent_message.present?
            @feedback = @prophent_message.build_user_feedback(user_feedback_params)
            if @feedback.save
              render json: {success: true, message: "Feedback Create successfully"}
            else
              render json: {success: false, error: @feedback.errors}
            end
          else
            render json: {success: false, message: "Prophent Message not found."}
          end
        end

        def profile_edit
          if @user.present?
            begin
              if params[:image].present?
                data = params[:image].gsub(" ", "+")
                data_uri = data.split(",")[1]
                extention = "png"
                encoded_image = data_uri
                decoded_image = Base64.decode64(encoded_image)
                img_name = "tmp/img_#{Time.now.to_i}.#{extention}"
                File.open(img_name, "wb") { |f| f.write(decoded_image) }
                @user.image = File.open(img_name)
                @user.save
              end
            rescue Exception => e
              p "something went wrong"
              p e
            end
            @user.update(user_params)
            p 'profile_edit errors'
            p @user.errors
            render json: {success: true, message: 'User update successfully'}
          else
            render json: {success: false, message: 'User not found'}
          end
        end

        def profile_detail
          if @user.present?
            render json: {success: true, user: @user}
          else
            render json: {success: false, message: 'User not found'}
          end
        end

        def user_signout
          p "desvise destroy details"
          render json: {success: true, message: "successfully signout"}
        end

        private

        def user_feedback_params
          params.require(:user_feedback).permit(:message, :prophent_message_id)
        end

        def user_params
          params.require(:user).permit(:id, :name, :age, :gender, :email, :password, :password_confirmation, :image, :role_id)
        end
      end
  end
end