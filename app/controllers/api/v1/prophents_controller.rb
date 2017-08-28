module Api
  module V1
      class ProphentsController < ApiController
        def prophents
        	if @user.present?
        		@user_requests = UserRequest.where(status: "pending")
        		if @user_requests.count > 0
        			render json: {success: true, user_requests: @user_requests}
        		else
        			render json: {success: true, message: "User Request not found"}
        		end
        	else
        		render json: {success: true, message: "User not found"}
        	end
        end

        def prophent_message_create
        	@prophent_message = @user.prophent_messages.new(prophent_message_params)
			    if @prophent_message.save
			      render json: {success: true, message: "Prophent Message sent successfully"}
			    else
			      render json: {success: false, error: @prophent_message.errors}
			    end
        end

        def prophent_messages
          @prophent_messages = @user.prophent_messages
          if @prophent_messages.present?
            student_detail = []
            @prophent_messages.each do |h|
              student = UserRequest.find_by(id: h.user_request_id).user
              name = student.try(:name)
              student_detail << {"student_name": name, "title": h.title, "message": h.message, "date": h.created_at, "id": h.id}
            end
            render json: {success: true, message: "get prophent_messages", prophent_messages: student_detail}
          end
        end

        def prophent_message_show
        	@pro_message = ProphentMessage.find_by(id: params[:id])
          @student = UserRequest.find_by(id: @pro_message.user_request_id).user
        	if @pro_message.present?
            message = @pro_message.user_feedback.present? ? @pro_message.user_feedback.try(:message) : ""
        		render json: {success: true, prophent_message: @pro_message, feedback_present: @pro_message.user_feedback.present? ? true : false ,feedback_msg:  message, to: @student.name}
        	else
        		render json: {success: false, error: "Prophent message not found."}
        	end
        end

        private

			  def prophent_message_params
			    params.require(:prophent_message).permit(:title, :message, :user_request_id, :prophent_id)
			  end
      end
  end
end