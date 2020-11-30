class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :stories, :content
end
