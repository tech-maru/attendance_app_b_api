class Api::V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def login_date
    user = User.find_by(email: params[:post][:email].downcase)
    if user && user.authenticate(params[:post][:password])
      serializer = UserSerializer.new(user)
      render json: serializer.serialized_json
    else
      render json:{ status: 'failure', message: "認証に失敗しました。" }
    end
  end
  
  def pick_attendance
    user = User.find(params[:id])
    object_month
    if attendances = user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
      if attendances.present?
        # @sendAttendance = attendances.map { |attendance| [
        #   "id": attendance.id, 
        #   "worked_on": attendance.worked_on,
        #   "started_at": attendance.started_at.present?? attendance.started_at.strftime("%H:%M") : nil,
        #   "finished_at": attendance.finished_at.present?? attendance.finished_at.strftime("%H:%M") : nil
        #   ]
        # }
        render json: { status: "success", attendances: attendances }
      else
        render json: { date: "null" }
      end
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
  
  def create
    user = User.find(params[:id])
    if user.attendances.create(
      worked_on: params[:worked_on],
      started_at: params[:started_at],
      finished_at: params[:finished_at]
      )
      render json: { status: 'success' }
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
  
  def search_attendance
    user = User.find(params[:id])
    if @attendance = user.attendances.find_by(worked_on: Date.current)
      render json: { status: 'success', attendance: @attendance }
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end  
  end
  
  def user_create
    user = User.new(user_params)
    if user.save
      serializer = UserSerializer.new(user)
      render json: serializer.serialized_json
    else
      render json:{ status: 'failure', message: user.errors.messages }
    end
  end

  
  def finished_at
    user = User.find(params[:id])
    attendance = user.attendances.find(params[:attendance_id])
    if attendance.update(finished_at: params[:finished_at])
      render json: { status: 'success' }
    else
      render json:{ status: 'failure', message: 'ERROR' }
    end
  end
    
  private
  
  def object_month
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date.beginning_of_month
    @last_day = @first_day.end_of_month
    @one_week = [*@first_day..@last_day]
  end
  
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
  
end
