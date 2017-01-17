class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]

  def index
  end

  def new
    @user = User.new
  end

  def edit
    render 'show'
  end

  def update
    _user_params = user_params.reject{|k, v| v.blank?}
    @user.assign_attributes(_user_params)
    if @user.save
      render json: {code: 0, msg: '更新成功'}
    else
      render json: {code: -1, msg: "更新失败,#{@user.errors.full_messages.join(",")}"}
    end

  end

  def show
    @user ||= current_user
  end

  def destroy
    # @user = User.find(params[:id])
    # @user.destroy
    # flash[:success] = "删除成功！"
    # redirect_to users_path(page: params[:page])
  end

  private
  def user_params
    params.require(:user).permit(
      :phone, :password, :email, :name, :surname,
      addresses_attributes: [:id, :detail_address, :_destroy]
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
