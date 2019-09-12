class UsersController < ApplicationController
    before_action :require_login
    skip_before_action :require_login, only: [:index, :new, :create]


    def index
        @users = User.all
        @current_user = User.find_by(username: session[:username])
    end

    def show
        @user = User.find(session[:id])
        @my_children = []
        Child.all.each do |child|
           if child.user_id == @user.id
                @my_children << child
           end
        end
        @main_children = []
        MainChild.all.each do |child|
           if child.user_id == @user.id
                @main_children << child
           end
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:username] = @user[:username]
            redirect_to login_path
        else 
            render :new
        end
    end

private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def current_user
        session[:id]
    end

    def require_login
        return head(:forbidden) unless current_user
    end
    
end
