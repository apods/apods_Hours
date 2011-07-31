class UsersController < ApplicationController
  
  layout 'main_layout'
  
  before_filter :require_login, :only => [:edit, :update, :show]
  before_filter :authorized_user, :only => [:edit, :update]
  
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
    @button_text = 'Register!'
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
  
  def edit
    @hours = hour_count
    @button_text = 'Save changes!'
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Changes saved!"
      redirect_to root_path
    else
      flash[:error] = "Error, your changes were not saved, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at eugene.sanzi@gmail.com"
      @user.first_name = params[:user][:first_name]
      @user.last_name = params[:user][:last_name]
      @user.status = params[:user][:status]
      @user.email = params[:user][:email]
      redirect_to edit_user_path(@user)
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
    
    private
    
    def authorized_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
end
