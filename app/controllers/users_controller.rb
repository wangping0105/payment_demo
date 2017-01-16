class UsersController < ApplicationController
  before_action :validate_admin, only: [:index, :destroy]
  DEFAULT_PASSWORD = "111111"

  def index
    @users = User.page(params[:page]).per(params[:per_page])
    if params[:query].present?
      @users = @users.like_any_fields(params[:query], :username, :truename)
    end
    @all_phones =all_phones
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    render 'new'
  end

  def show
    @user ||= current_user
    render 'new'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "删除成功！"
    redirect_to users_path(page: params[:page])
  end


  private
  def user_params
    params.require(:user).permit(:phone, :password, :email, :name, :truename, :surname)
  end
end
