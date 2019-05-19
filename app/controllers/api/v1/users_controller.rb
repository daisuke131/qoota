class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:update, :destroy]

  def index
    @users = User.all.order("created_at DESC")
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    current_user.update!(user_params)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
