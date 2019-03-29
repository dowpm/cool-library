class SessionsController < ApplicationController
    skip_before_action :require_login
    
    def new
    end

    def create
        if auth_hash = auth
            @user = User.find_or_create_by_omniauth(auth_hash)
            session[:user_id] = @user.id
            flash[:notice] = "You're logged in."
            render plain: flash[:notice]
            # redirect_to books_path
        else
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
    end

    def destroy
        session.clear unless session[:user_id].nil?
        flash[:notice] = "You have successfully logged out."
        redirect_to login_path
    end

    private
 
    def auth
        request.env['omniauth.auth']
    end

end
  