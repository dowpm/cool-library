class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to user_path(current_user) if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash["alert alert-info"] = "You have successfully registered and logged in."
      # render plain: flash[:notice]
      redirect_to user_path(@user)
    else 
      render :new
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:full_name,:author,:email, :password, :password_confirmation)
  end
end
