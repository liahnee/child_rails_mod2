class PersonalitiesController < ApplicationController

    def new
        @user = User.find(params[:user_id])
        @child = Child.find(params[:child_id])
    end

    def create
        @child = Child.find(params[:child_id])
        if @child.personality_id
            redirect_to user_child_path(@child)
        else 
            render :new
        end
    end 
    


end
