class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully registered and logged in."
      render plain: flash[:notice]
    #   redirect_to books_path
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
