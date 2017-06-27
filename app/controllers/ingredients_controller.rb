class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def new
    render :layout => false
  end
end
