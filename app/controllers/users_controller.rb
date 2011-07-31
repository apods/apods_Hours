class UsersController < ApplicationController
  
  layout 'main_layout'
  
  def index
  end
  
  def show
    if !signed_in?
      redirect_to login_path
    end
    @hours ||= hour_count
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
  
  private
    
    def hour_count
      hours = Hour.find_all_by_user_id(current_user.id, :select => :hours)
      count = 0
      hours.each do |hour|
        count += hour.hours
      end
      count
    end
    
end
