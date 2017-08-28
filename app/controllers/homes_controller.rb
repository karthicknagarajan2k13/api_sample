class HomesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:home, :terms]
  def home
    if user_signed_in?
      if current_user.admin?
        redirect_to homes_admin_path
      elsif current_user.prophent?
        redirect_to prophents_path
      else
        redirect_to homes_index_path
      end
    end
  end

  def terms
    
  end

  def admin
    @prophet_list = User.where(role_id: 2).order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def index
    @admin_info = AdminPost.where(is_active: true).first
  end

  def profile
  end
  def prophet_home
  end
  def your_story
    
  end

  def user_history_message
    
  end

  def prophet_histroy_message
    
  end

  def user_feedback_message
    
  end

  def prophet_message
    
  end

  def user_feedback
    
  end

  # private

  # def user_params
  #   # params.require(:user).permit(:id, :name, :age, :gender, :email, :password, :password_confirmation, :image, :role_id)    
  # end

end
