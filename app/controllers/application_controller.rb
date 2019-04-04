class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user#, :require_login, :require_author
    before_action :require_login

    private

    def logged_in?
        !!current_user
    end

    def current_user
        if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def require_login
        # puts 'require_login--------------------->'
        unless logged_in?
        flash["alert alert-info"] = "You must be logged in to access this section."
        redirect_to login_path
        end
    end

    def require_author
        # puts 'require_author--------------------->'
        unless current_user.try(:author)
            flash["alert alert-info"] = "You cant access this section, you're not an author."
            redirect_to books_path
        end
    end
end
