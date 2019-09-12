require 'pry'
class ChildrenController < ApplicationController
    before_action :require_login

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
        if @child.save
            @child.c_personality
            if @child.personality_id
                # binding.pry
                redirect_to user_child_path(@user, @child)
            else
                Child.destory(@child.id)
                render :new
            end
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
        @user = User.find(params[:user_id])
        @child = Child.find(params[:id])
        @child.action(params)
        @child.aging(@child)
        @child.save
        redirect_to user_child_path(@user, @child)
    end 

    # def post_update
    #     @child = Child.find(params[:id])
    # end 

    def delete
        @child = Child.find(params[:id])
        @child.destory
        redirect_to user_children_path
    end

    def independence
        @user = User.find(params[:user_id])
        @child = Child.find(params[:id])
        @child.job_id = @child.temp_job_id
        @child.save
        redirect_to user_child_path(@user, @child)
    end

private

    def child_params(*args)
        params.permit(*args)
    end

    def require_login
        return head(:forbidden) unless session[:id] == params[:id]
    end

end
