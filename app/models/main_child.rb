class MainChild < ApplicationRecord
    belongs_to :child
    belongs_to :user

    def index
        @user
    end

    def new
        @user
    end 

    def create
        @user 

        redirect_to :index
    end

    def edit
    end

    def update
    end

    def delete
    end

end
