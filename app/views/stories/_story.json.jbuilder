json.extract! story, :id, :title, :content, :location, :user_id, :food_id, :recommendation, :created_at, :updated_at
json.url story_url(story, format: :json)
