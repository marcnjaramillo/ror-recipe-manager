class UsersController < ApplicationController
  def show
    @user = current_user
    @recipes = @user.recipes
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @user }
    end
  end
end
