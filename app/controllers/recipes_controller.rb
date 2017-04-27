class RecipesController < ApplicationController

  def index
    @recipes = Recipe.search(params[:search])
  end

  def new
    @user = current_user
    @recipe = Recipe.new
    10.times {
      @recipe.recipe_ingredients.build.build_ingredient
    }
    5.times {
      @recipe.directions.build
    }
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe successfully saved."
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    respond_to do |f|
      f.html { render :show}
      f.json { render json:  @recipe}
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    10.times {
      @recipe.recipe_ingredients.build.build_ingredient
    }
    5.times {
      @recipe.directions.build
    }
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe successfully updated."
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    user = recipe.user
    recipe.destroy
    flash[:success] = "Recipe successfully deleted."
    redirect_to user_path(user)
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :prep_time,
      :cook_time,
      :user_id,
      :search,
      directions_attributes: [:id, :text],
      recipe_ingredients_attributes: [
        :id,
        :quantity,
        ingredient_attributes: [:id, :name]
      ]
    )
  end
end
