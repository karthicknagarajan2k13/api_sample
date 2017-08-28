class ProphentMessagesController < ApplicationController

  def index
    if current_user.admin?
      @histories = ProphentMessage.all.paginate(page: params[:page], per_page: 10)
    else
      @histories = current_user.prophent_messages.paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @prophent_message = current_user.prophent_messages.build
  end

  def create
    @prophent_message = current_user.prophent_messages.new(prophent_message_params)
    if @prophent_message.save
      flash[:success] = 'Accepted'
      redirect_to prophents_path
    else
      flash[:error] = @prophent_message.errors.full_messages
      render 'new'
    end
  end

  def show
    @pro_message = ProphentMessage.find(params[:id])
  end

  def delete
    
  end

  private

  def prophent_message_params
    params.require(:prophent_message).permit(:title, :message, :user_request_id, :prophent_id)
  end
end
