class SessionsController < ApplicationController
  
  layout 'main_layout'
  
  def new
    @user = User.new
  end
  
  def create
  end
  
  def destroy
  end
  
end
