class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show,:edit,:update,:destroy]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def index
    @recipes = Recipe.search(params[:search])

    respond_to do |f|
      f.html
      f.json { render json: @recipes }
    end
  end

  def new
    if user_signed_in?
      @recipe = Recipe.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe successfully saved."

      respond_to do |f|
        f.html { redirect_to recipe_path(@recipe) }
        f.json { render json: @recipe }
      end
    else
      render :new
    end
  end

  def show
    if current_user
      @comment = current_user.comments.build(recipe: @recipe)
    end
    respond_to do |f|
      f.html { render :show}
      f.json { render json:  @recipe }
    end
  end

  def edit

  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
      flash[:success] = "Recipe successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe successfully deleted."
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :category,
      :prep_time,
      :cook_time,
      :user_id,
      :search,
      :image,
      directions_attributes: [:id, :text],
      recipe_ingredients_attributes: [
      :id,
      :quantity,
      ingredient_attributes: [:id, :name]])
  end

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
