class UserFeedbacksController < ApplicationController

  before_action :set_user_feedback

  def new
    @feedback = @message.build_user_feedback
  end

  def create
    @feedback = @message.build_user_feedback(user_feedback_params)
    if @feedback.save
      flash[:success] = "Feedback created successfully"
      if current_user.prophent?
        redirect_to prophent_messages_path 
      else
        redirect_to student_history_path
      end
    else
      flash[:error] = @feedback.errors.full_messages
      render 'new'
    end
  end

  private

  def user_feedback_params
    params.require(:user_feedback).permit(:message, :prophent_message_id)
  end

  def set_user_feedback
    @message = ProphentMessage.find(params[:prophent_message_id])
  end
end
