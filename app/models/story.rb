class Story < ApplicationRecord
    belongs_to :food
    belongs_to :user
    
    has_many :comment, -> { order "created_at DESC" }
    has_one_attached :image  
  
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

    def self.search_by_category(category_id)
      Story.joins("INNER JOIN foods ON food_id = foods.id 
        INNER JOIN categories ON foods.category_id = categories.id").
      where("categories.id = ?","#{category_id}")
    end

    def self.search_by_food(food_id)
      Story.joins("INNER JOIN foods ON food_id = foods.id").
      where("foods.id = ?","#{food_id}")
    end
end