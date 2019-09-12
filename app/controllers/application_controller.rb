class ApplicationController < ActionController::Base

    def current_user
        session[:user]
    end
    
end
