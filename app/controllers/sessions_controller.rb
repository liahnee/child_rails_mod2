class SessionsController < ApplicationController
    before_action :require_login
    skip_before_action :require_login, only: [:new, :create, :root]
    
    def new            
        render :layout => 'no_login'
    end

    def create
        if params[:username] || !params[:username].empty?
            if User.find_by(username: params[:username])
                @user = User.find_by(username: params[:username])
                if @user.authenticate(params[:password])
                    log_in(@user)
                    redirect_to user_path(@user.id)
                end
            else
                render :new, :layout => 'no_login'
            end
        else 
            render :new,  :layout => 'no_login'
        end
    end

    def destroy
        session.delete :user_id
        redirect_to login_path
    end

    def root 
        if session[:user_id] != nil 
            render :layout => 'application' 
        else
            render :layout => 'no_login'
        end
    end
    
    private

    def session_params
        params.require(:user).permit(:username, :password)
    end
    
    def require_login
        return head(:forbidden) unless session[:user_id]
    end

end
