class HoursController < ApplicationController
  
  layout 'main_layout'
  
  before_filter :require_login
  before_filter :authorized_user, :only => [:update, :destroy]
  
  def index
    @hours = Hour.find_all_by_user_id(current_user.id)
  end
  
  def new
    @hour = Hour.new
  end
  
  def create
    @hour = current_user.hours.build(params[:hour])
    if @hour.save
      flash[:success] = "Your hour entry has been saved!"
      redirect_to hours_path
    else
      flash[:error] = "Error, your entry was not saved, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at eugene.sanzi@gmail.com"
      redirect_to new_hour_path
    end
  end
  
  def edit
    @hour = Hour.find(params[:id])
  end
  
  def update
    if @hour.update_attributes(params[:hour])
      flash[:success] = "Changes saved!"
      redirect_to hours_path
    else
      flash[:error] = "Error, your changes were not saved, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at eugene.sanzi@gmail.com"
      redirect_to edit_hour_path
    end
  end
  
  def destroy
    if !@hour.destroy.nil?
      flash[:success] = "Your hour entry has been deleted!"
    else
      flash[:error] = "Error, your entry was not deleted, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at eugene.sanzi@gmail.com"
    end
    redirect_to hours_path
  end
  
  private
    
    def authorized_user
      @hour = Hour.find(params[:id])
      redirect_to root_path unless current_user == (@hour.user)
    end
    
end
