class ApplicationController < ActionController::Base

    def redirect_to_user_new
        redirect_to new_user_path
    end
    
end
