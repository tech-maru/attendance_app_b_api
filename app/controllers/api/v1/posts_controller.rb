class Api::V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def login_date
    user = User.find_by(email: params[:post][:email].downcase)
    if user && user.authenticate(params[:post][:password])
      serializer = UserSerializer.new(user)
      render json: serializer.serialized_json
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
  
  def pick_attendance
    user = User.find(params[:id])
    object_month
    if @attendances = user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
      serializer = AttendanceSerializer.new(attendance)
      render json: serializer.serialized_json
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
  
  private
  
  def object_month
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    @one_week = [*@first_day..@last_day]
  end
  
end
