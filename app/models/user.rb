class User < ApplicationRecord
    has_many :children
    
    validates :username, uniqueness: true
    validates :password, length: { in: 4..20 }

    
end
