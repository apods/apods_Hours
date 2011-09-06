class UsersController < ApplicationController
  
  before_filter :require_login, :only => [:edit, :update, :show]
  before_filter :authorized_user, :only => [:edit, :update]
  before_filter :authorized_admin, :only => :index
  
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    if !signed_in?
      redirect_to login_path
    end
  end
  
  def new
    @user = User.new
    @button_text = 'Register!'
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      redirect_to hours_path
    else
      @user.password = ""
      @user.password_confirmation = ""
      @button_text = 'Register!'
      render 'new'
    end
  end
  
  def edit
    @button_text = 'Save changes!'
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Changes saved!"
      redirect_to root_path
    else
      @button_text = 'Save changes!'
      render :action => :edit
    end
  end
  
  private
    
    private
    
    def authorized_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
    def authorized_admin
      redirect_to root_path unless current_user.admin?
    end
    
end
