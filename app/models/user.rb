class User < ApplicationRecord
    has_many :children
    has_many :user_children
    
    validates :username, uniqueness: true
    validates :password, length: { in: 6..20 }

    
end
