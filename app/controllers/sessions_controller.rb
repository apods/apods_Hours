class SessionsController < ApplicationController
  
  layout 'main_layout'
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.authenticate(params[:session][:peoplesoft_num], params[:session][:password])
    if @user.nil?   # authentication was unsuccessful, there is no matching record in the database for this user
      flash[:error] = "Invalid input, make sure you entered your\npeoplesoft number and password correctly.\nIf you have not registered this semester, please do so."
      redirect_to login_path
    else    
      # user was authenticated, proceed to sign them in
      sign_in @user
      # for the benefit of new people using this, flash.now is used
      # here because there is an implicit render at the end of every
      # function, regular flash is used before a redirect.
      flash.now[:success] = "Login successful!"
      redirect_to hours_path
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "You are now signed out!"
    redirect_to root_path
  end
  
end
