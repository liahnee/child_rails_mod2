class User < ApplicationRecord
    has_many :children, :dependent => :destroy
    has_many :main_children, :dependent => :destroy
    
    has_secure_password

    def max_number
        all = []
        if Child.where(user_id:self.id).count <= 20
            return true
        else
            return false
        end
    end 
end
