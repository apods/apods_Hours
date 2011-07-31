class HoursController < ApplicationController
  
  layout 'main_layout'
  
  before_filter :require_login
  
  def index
    @hours = Hour.find_all_by_user_id(current_user.id)
  end
  
  def new
    @hour = Hour.new
  end
  
  def create
    @hour = current_user.hours.build(params[:hour])
    if @hour.save
      flash[:success] = "Your hour entry has been saved to the database!"
      redirect_to hours_path
    else
      flash[:error] = "Error, your entry was not saved, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at eugene.sanzi@gmail.com"
      redirect_to new_hour_path
    end
  end
  
  def edit
    
  end
  
  def destroy
    @hour = Hour.find(params[:id])
    if !@hour.destroy.nil?
      flash[:success] = "Your hour entry has been deleted!"
    else
      flash[:error] = "Error, your entry was not deleted, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at eugene.sanzi@gmail.com"
    end
    redirect_to hours_path
  end

end
