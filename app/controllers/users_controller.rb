class UsersController < ApplicationController

  def student_history
    @histories = current_user.user_requests.where(status: 'Accepted').paginate(page: params[:page], per_page: 10)
  end

  def show_profile 
  end

  def prophet_new
  	@user = User.new
  end

  def prophet_create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Prophent created successfully"
  	 redirect_to homes_admin_path
    else
      flash[:error] = @user.errors.full_messages
      render 'prophet_new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :age, :gender, :email, :password, :password_confirmation, :image, :role_id)    
  end
end
