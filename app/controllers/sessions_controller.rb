class SessionsController < ApplicationController

    def new
        if params[:username]
            @user = User.find_by(username: params[:username])
        end
    end

    def create
        if params[:username] || !params[:username].empty?
            if @user = User.find_by(username: params[:username])
                if @user.authenticate(params[:password])
                    session[:id] = @user.id
                    redirect_to user_path(@user.id)
                end
            else
                render :new
            end
        else 
            @user = User.find_by(username: params[:username])
            render :new
        end
    end

    def destroy
        session.delete :id
        redirect_to login_path
    end
    
    private

    def session_params
        params.require(:user).permit(:username, :password)
    end

end
