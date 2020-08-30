class UsersController < ApplicationController
  before_action :set_user, only: [:show, :show_one_week, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:show, :show_one_week, :edit, :update]
  before_action :correct_user, only:[:show, :edit]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info, :basic_info, :basic_info_update]
  before_action :set_one_month, only: :show
  before_action :set_one_week, only: :show_one_week
  
  def index
    @users = User.paginate(page: params[:page]).order(:id)
  end
  
  def index_result
    @users = User.search(params[:search])
    if @users.present?
      @search = params[:search]
    else
      @search = params[:search]
      flash.now[:warning] = "該当がありません。再検索してください！"
    end
  end
  
  def show
  end
  
  def test_api
    @user = User.find(params[:id])
    attendances = @user.attendances
    @api = attendances.map { |attendance| [
      "id": attendance.id, 
      "worked_on": attendance.worked_on,
      "started_at": attendance.started_at.present?? attendance.started_at.strftime("%H:%M") : nil,
      "finished_at": attendance.finished_at.present?? attendance.finished_at.strftime("%H:%M") : nil
      ]
    }
  end
  
  def show_one_week
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録が完了しました。"
      redirect_to user_url(@user)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_url(@user)
    else 
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:warning] = "#{@user.name}を削除しました"
    redirect_to users_url
  end
  
  def basic_info
  end
  
  def basic_info_update
    users = User.all
    users.each do |user| 
      user.update_attributes(basic_time: params[:basic_time], work_time: params[:work_time])
    end
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の勤怠基本情報を更新しました。"
      redirect_to users_url
    else
      flash[:danger] = "#{@user}の勤怠基本情報の更新に失敗しました。" + @user.errors.full_messages.join(",")
      render :edit_basic_info
    end
  end
    
  
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
end
