module SessionsHelper

  def sign_in(user)
    user.remember_me!
    cookies[:remember_token] = { :value => user.remember_token, :expires => 1.month.from_now.utc }
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def require_login
    redirect_to login_path unless signed_in?
  end
end
