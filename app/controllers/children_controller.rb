class ChildrenController < ApplicationController

    def new
        @child = Child.new
    end

    def create
        @child = Child.new(child_params(:first_name, :last_name, :user_id))
        if @child.save
            redirect_to :show
        else 
            render :new
        end
    end

    def show
        @child = Child.find(params[:id])
        redirect_to :update
    end

    def index
        @children = Child.all.find_by(user_id:@user_id)
    end

    def edit
        @child = Child.find(params[:id])
        action(params)
        @child.aging
        redirect_to :edit
    end

    def post_update
        @child = Child.find(params[:id])
    end 

private

    def child_params(*args)
        params.require(:child).permit(*args)
    end

end
