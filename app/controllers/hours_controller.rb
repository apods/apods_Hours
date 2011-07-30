class HoursController < ApplicationController
  
  layout 'main_layout'
  
  before_filter :require_login
  
  def index
    @hours = Hour.find_all_by_user_id(current_user.id)
  end
  
  def new
    @hour = Hour.new
  end
  
  def edit
    
  end
  
  def destroy
    
  end

end
