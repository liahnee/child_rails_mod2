class MainChildrenController < ApplicationController
    def show
        @mchild = MainChild.find(params[:id])
        @child = Child.find(@mchild.child_id)
    end
end
