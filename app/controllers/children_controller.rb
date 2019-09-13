require 'pry'
class ChildrenController < ApplicationController
    before_action :require_login

    def index
        @children = Child.all.find_by(user_id:params[:user_id])
    end

    def new

        @child = Child.new
    end

    def create

        @child = Child.new(child_params(:first_name, :last_name, :user_id))
        @child.base
        if @child.save
            @child.c_personality
            if @child.personality_id
                # binding.pry
                redirect_to user_child_path(@current_user, @child)
            else
                @child.destroy
                render :new
            end
        else
            render :new
        end
    end

    def show

        @child = Child.find(params[:id])
        render :layout => 'child' 
    end

    def edit

        @child = Child.find(params[:id])
        render :layout => 'child_edit' 
    end

    def update 

        @child = Child.find(params[:id])
        @child.action(params)
        @child.aging(@child)
        @child.save
        redirect_to user_child_path(@current_user, @child)
    end 

    def destroy
        @child = Child.find(params[:id])
        @temp_name = @child.full_name
        @child.destroy!
        redirect_to user_children_path, :notice => "#{@temp_name} is not your child anymore."
    end

    def independence

        @child = Child.find(params[:id])
        @child.job_id = @child.temp_job_id
        @child.save
        redirect_to user_child_path(@current_user, @child)
    end

private

    def child_params(*args)
        params.permit(*args)
    end

end
