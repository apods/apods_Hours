module HoursHelper

  def hour_count(user = current_user)
    hours = Hour.find_all_by_user_id(user.id, :select => :hours)
    count = 0
    hours.each do |hour|
      count += hour.hours
    end
    return count
  end

end
