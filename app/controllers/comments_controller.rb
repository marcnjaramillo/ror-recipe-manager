class CommentsController < ApplicationController
  before_action :has_recipe

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.recipe = @recipe
    @comment.save
    render json: @comment, status: 201
  end



  private

  def has_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
