class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def new
    render 'ingredients/_new_ingredient', :layout => false
  end
end
