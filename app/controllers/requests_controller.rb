class RequestsController < ApplicationController
  def create_request
    UserRequest.create(status: "pending", student_id: current_user.id)
    flash[:info] = "Request sent successfully"
    redirect_to :back
  end

  def delete_request
    @user_request = UserRequest.find_by(id: params[:id])
    @user_request.delete
    redirect_to root_path
  end

  def student_history
    @prophent_histories = current_user.prophent_messages
  end

  def accept_request
    @request = UserRequest.find(params[:id])
    @request.update_attributes(status: "Accepted", prophent_id: current_user.id, accepted_at: Time.now)
    redirect_to new_prophent_message_path(request: @request.id)
  end
end
