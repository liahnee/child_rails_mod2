class ApplicationController < ActionController::Base
    before_action :current_user

    def log_in(user)
        session[:user_id] = user.id
    end

    def require_login
        return head(:forbidden) unless params[:user_id].to_i == @current_user.id || params[:id].to_i == @current_user.id
    end

    def current_user
        # byebug
        @current_user ||= User.find_by(id:session[:user_id])
    end

end
