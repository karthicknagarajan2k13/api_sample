module Api
  module V1
      class AdminsController < ApiController
        def prophent_create
        	if @user.admin?
	        	@prophent = User.new(user_params)
	        	@prophent.role_id = Role.find_by(name: "Prophent").id
	        	if @prophent.save
	       			render json: {success: true, message: "Prophent Create Successfully"}
	       		else
	       			render json: {success: false, error: @prophent.errors}
	       		end
       		else
        		render json: {success: false, message: "Not allowed to access"}
        	end
        end

        def index
        	if @user.admin?
	        	role_id = Role.find_by(name: "Prophent").id
	        	@prophet_list = User.where(role_id: role_id)
	        	if @prophet_list.count > 0
	        		render json: {success: true, prophet_list: @prophet_list}
	        	else
	        		render json: {success: false, message: "No Prophent"}
	        	end
        	else
        		render json: {success: false, message: "Not allowed to access"}
        	end
        end

        def all_prophent_messages
        	if @user.admin?
        		@prophent_messages = ProphentMessage.all
                if @prophent_messages.count > 0
                  render json: {success: true, prophent_messages: @prophent_messages}
                else
                  render json: {success: false, message: "No prophent message"}
                end
        	else
        		render json: {success: false, message: "Not allowed to access"}
        	end
        end

        def admin_posts_create
        	@admin_post = @user.admin_posts.new(admin_post_params)
        	if @admin_post.save
        		render json: {success: true, message: "Admin post create successfully"}
        	else
        		render json: {success: false, error: @admin_post.errors}
        	end
        end

        def admin_posts
        	if @user.admin?
        		@admin_posts = AdminPost.all
        		if @admin_posts.count > 0 
        			render json: {success: true, admin_posts: @admin_posts}
        		else
        			render json: {success: false, message: "No admin posts"}
        		end
        	else
        		render json: {success: false, message: "Not allowed to access"}
        	end
        end

        def admin_posts_update
        	@admin_post = AdminPost.find_by(id: params[:admin_post_id])
        	if @admin_post.present?
        		if @admin_post.update(admin_post_params)
        			render json: {success: true, message: "Admin post update successfully"}
        		else
        			render json: {success: false, message: @admin_post.errors }
        		end
        	else
        			render json: {success: false, message: "Admin post not found" }
        	end
        end

        def admin_posts_delete
        	@admin_post = AdminPost.find_by(id: params[:admin_post_id])
        	if @admin_post.present?
        		if @admin_post.destroy
        			render json: {success: true, message: "Admin post delete successfully"}
        		else
        			render json: {success: false, message: @admin_post.errors }
        		end
        	else
        			render json: {success: false, message: "Admin post not found" }
        	end
        end

        private

			  def user_params
			    params.require(:user).permit(:id, :name, :age, :gender, :email, :password, :password_confirmation, :image, :role_id)    
			  end

			  def admin_post_params
		      params.require(:admin_post).permit(:url, :title, :message, :is_active, :user_id)
		    end
      end
  end
end