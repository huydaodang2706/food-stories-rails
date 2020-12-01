class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :location, :user_id, :food_id, :recommendation
end
