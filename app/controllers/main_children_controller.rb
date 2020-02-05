class MainChildrenController < ApplicationController
    before_action :require_login
    skip_before_action :require_login, only: [:show]

    def create
        if !MainChild.find_by(user_id:@current_user.id, child_id:params[:child_id])
            MainChild.create(user_id:@current_user.id, child_id:params[:child_id])
            redirect_to user_child_path(user_id:@current_user.id, id:params[:child_id])
        else 
            redirect_to user_path(id:params[:user_id])
        end
    end

    def show
        @mchild = MainChild.find(params[:id])
        @child = Child.find(@mchild.child_id)
        if session[:user_id] != nil 
            render :layout => 'application' 
        else
            render :layout => 'no_login'
        end
    end

    private

    def require_login
        return head(:forbidden) unless session[:user_id] = params[:user_id]
    end

end
