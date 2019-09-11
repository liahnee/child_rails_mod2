class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        redirect_to user_children_path(@user, @user.children)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params(:username, :password))
        if @user.save
            redirect_to :show
        else 
            render :new
        end
    end

private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end
