class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :prep_time, :cook_time, :comment_list
  has_many :comments
  has_many :directions
  has_many :recipe_ingredients
  belongs_to :user

  def comment_list
    object.comments.map do |comment|
      {
        id: comment.id,
        user: {
          id: comment.user_id,
          username: User.find(comment.user_id).username
        },
        content: comment.content
      }
    end
  end
end
