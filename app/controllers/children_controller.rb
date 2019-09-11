require 'pry'
class ChildrenController < ApplicationController

    def index
        @user = User.find(params[:user_id])
        @children = Child.all.find_by(user_id:params[:user_id])
    end

    def new
        @user = User.find(params[:user_id])
        @child = Child.new
    end

    def create
        @user = User.find(params[:user_id])
        @child = Child.new(child_params(:first_name, :last_name, :user_id))
        @child.base
        if @child.valid?
            @child.save
            @child.personality_id = @child.c_personality
            redirect_to user_child_path(@child)
        else 
            render :new
        end
    end

    def show
        @user = User.find(params[:user_id])
        @child = Child.find(params[:id])
    end

    def edit
        @user = User.find(params[:user_id])
        @child = Child.find(params[:id])
    end

    def update 
        byebug
        @user = User.find(params[:user_id])
        @child = Child.find(params[:id])
        # action(params)
        # @child.aging(@child)
        # # @child.update()
        # byebug
        redirect_to user_child_path
    end 

    # def post_update
    #     @child = Child.find(params[:id])
    # end 

private

    def child_params(*args)
        params.permit(*args)
    end

end
