class SessionsController < ApplicationController
    def new
    end

    def create

        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:notice] = "You're logged in."
            render plain: flash[:notice]
            # redirect_to books_path
        else 
            flash[:alert] = "Invalid username/password."
            render :new
        end
    end

    def destroy
        session.clear unless session[:user_id].nil?
        flash[:notice] = "You have successfully logged out."
        redirect_to login_path
    end

end
  