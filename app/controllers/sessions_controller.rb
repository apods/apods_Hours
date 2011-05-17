class SessionsController < ApplicationController
  
  layout 'main_layout'
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.authenticate(params[:session][:peoplesoft_num], params[:session][:password])
    if @user.nil?
      flash.now[:error] = "Invalid input, make sure you entered your\npeoplesoft number and password correctly.\nIf you have not registered this semester, please do so."
      redirect_to login_path
    end
  end
  
  def destroy
  end
  
end
