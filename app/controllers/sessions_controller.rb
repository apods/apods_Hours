class SessionsController < ApplicationController
  
  layout 'main_layout'
  
  def new
    @user = User.new
  end
  
  def create
    reset_session
    @user = User.authenticate(params[:session][:peoplesoft_num], params[:session][:password])
    if @user.nil?   # authentication was unsuccessful, there is no matching record in the database for this user
      flash[:error] = "Make sure you entered your peoplesoft number and password correctly. If you have not registered this semester, please do so."
      render :action => :new
    else    
      # user was authenticated, proceed to sign them in
      sign_in @user
      flash[:success] = "Login successful!"
      redirect_to hours_path
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "You are now signed out!"
    redirect_to root_path
  end
  
end
