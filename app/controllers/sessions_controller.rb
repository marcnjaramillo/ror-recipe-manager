class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_back_or @user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def auth
  auth = request.env["omniauth.auth"]
  @user = User.find_or_create_by(uid:auth[:uid]) do |u|
    u.username = auth[:info][:name]
    u.email = auth[:info][:email]
  end
  if @user.save
    session[:user_id] = @user.id
    flash[:success] = "You have successfully signed up."
    redirect_back_or(user_path(@user))
  else
    flash.now[:danger] = @user.errors.full_messages_for(:email).join(" / ")
    render :new
  end
end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You have been signed out."
    redirect_to root_url
  end
end
