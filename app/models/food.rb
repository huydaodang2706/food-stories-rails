class Food < ApplicationRecord
    validates :name, presence: true
    has_many :stories
    has_many :users, through: :stories
end
