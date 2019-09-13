class UsersController < ApplicationController
    before_action :require_login
    skip_before_action :require_login, only: [:index, :new, :create]

    def index
        @users = User.all
        render :layout => 'no_login'    
    end

    def show
        @my_children = []
        Child.all.each do |child|
           if child.user_id == @current_user.id
                @my_children << child
           end
        end
        @main_children = []
        MainChild.all.each do |child|
           if child.user_id == @current_user.id
                @main_children << child
           end
        end
    end

    def new
        @user = User.new
        if session[:user_id] != nil 
        else
            render :layout => 'no_login'
        end
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

end
