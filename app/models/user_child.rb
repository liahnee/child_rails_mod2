class UserChild < ApplicationRecord
    belongs_to :user
    has_many :children
end
