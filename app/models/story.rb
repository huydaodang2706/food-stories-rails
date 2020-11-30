class Story < ApplicationRecord
    belongs_to :food
    belongs_to :user
  
    validates :title, presence: true
    validates :content, presence: true
    validates :location, presence: true
    
    def next
        # if the first destination is greater the current one exists then return the next destination
        if next_story = self.class.where("id > ?", id).first
          next_story
        else
          Story.first
        end
    end
    
    def previous
        # if the destination is less then current one exists then return the previous destination
        if previous_story = self.class.where("id < ?", id).last
          previous_story
        else
          Story.last
        end
    end
    
    
end
