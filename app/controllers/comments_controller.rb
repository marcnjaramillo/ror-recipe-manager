class CommentsController < ApplicationController
  before_action :has_recipe

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.recipe = @recipe
    @comment.save
    render json: @comment, status: 201
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comments_params)
      flash[:success] = "Recipe successfully updated."
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    user = comment.user
    comment.destroy
    flash[:success] = "Recipe successfully deleted."
    redirect_to recipe_path(@recipe)
  end


  private

  def has_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
