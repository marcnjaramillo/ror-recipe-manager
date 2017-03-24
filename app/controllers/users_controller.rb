class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Congratulations! You have successfully signed up."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your information successfully updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    session.delete(:user_id)
    flash[:success] = "Your account has been successfully deleted."
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :password)
  end
end
