class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit]

  def show
  end

  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to current_user
    else
      flash.now[:alert] = 'Please try again'
      render :edit
    end
  end
  
  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :avatar, :remove_avatar)
    end
end
