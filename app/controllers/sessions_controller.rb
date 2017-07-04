class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to auctions_path, notice: "#{@user.first_name} succesfully logged in"
    else
      flash.now[:alert] = "Wrong email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to auctions_path, notice: "Signed Out"
  end
end
