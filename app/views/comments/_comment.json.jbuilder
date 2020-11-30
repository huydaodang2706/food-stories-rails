json.extract! comment, :id, :user_id, :stories, :content, :created_at, :updated_at
json.url comment_url(comment, format: :json)
