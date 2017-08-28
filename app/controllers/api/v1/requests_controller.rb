module Api
  module V1
      class RequestsController < ApiController
        def create_request
        	UserRequest.create(status: "pending", student_id: @user.id)
          render json: {success: true, message: "Successfully create request"}
        end

        def pending_request
          @request_data =[]
          @request = UserRequest.where(status: "pending")
          @request.each do |request|
            user = User.find_by(id: request.student_id)
            if user.present?
              @request_data << { "student_name": user.name, "student_gender": user.gender, "student_age": user.age, "id": request.id}
            end
          end
          render json: {success: true, message: "Successfully get request", request: @request_data}
        end

        def accept_request
          @request = UserRequest.find_by(id: params[:id])
          if @request.present?
            @request.update_attributes(status: "Accepted", prophent_id: @user.id, accepted_at: Time.now)
            render json: {success: true, request_id: @request.id, message: "Request Accepted Successfully"}
          else
            render json: {success: false, message: "User Request not found"}
          end
        end
      end
  end
end