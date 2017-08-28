class ProphentsController < ApplicationController

  def index
    @requests = UserRequest.where(status: "pending").paginate(page: params[:page], per_page: 10)
  end

  def prophent_history
    @prophent_histories = current_user.prophent_messages
  end
end
