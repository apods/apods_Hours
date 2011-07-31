class UsersController < ApplicationController
  
  layout 'main_layout'
  
  def index
  end
  
  def show
    if @user.nil?
      redirect_to login_path
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to hours_path
    else
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
end
