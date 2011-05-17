class SessionsController < ApplicationController
  
  layout 'main_layout'
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.authenticate(params[:session][:peoplesoft_num], params[:session][:password])
    if @user.nil?
      flash[:error] = "Invalid input, make sure you entered your\npeoplesoft number and password correctly.\nIf you have not registered this semester, please do so."
      redirect_to login_path
    end
    # for the benefit of new people using this, flash.now is used
    # here because there is an implicit render at the end of every
    # function, regular flash is used before a redirect.
    flash.now[:success] = "Login successful!"
  end
  
  def destroy
  end
  
end
