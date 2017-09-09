class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :prep_time, :cook_time, :comment_list
  has_many :recipe_ingredients
  has_many :directions

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
