class HoursController < ApplicationController
  
  layout 'main_layout'
  
  def index
    @hours = Hour.find_all_by_user_id(current_user.id)
  end

end
