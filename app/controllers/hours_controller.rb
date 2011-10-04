class HoursController < ApplicationController
  
  before_filter :require_login
  before_filter :authorized_user, :only => [:update, :destroy]
  
  def index
    #@hours = current_user.hours.paginate(:page => params[:page], :per_page => 10)
    @hours = User.find(params[:id]).hours.paginate(:page => params[:page], :per_page => 10)
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
      render :action => :new
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
      render :action => :edit
    end
  end
  
  def destroy
    if !@hour.destroy.nil?
      flash[:success] = "Your hour entry has been deleted!"
    else
      flash[:error] = "Error, your entry was not deleted, please try again. " + 
                      "If you receive this message again, contact Gino Sanzi " + 
                      "at gino.sanzi@gmail.com"
    end
    redirect_to hours_path
  end
  
  def admin_index
    @hours = Hour.all
  end
  
  private
    
    def authorized_user
      @hour = Hour.find(params[:id])
      redirect_to root_path unless current_user == (@hour.user) or current_user.admin?
    end
    
end
