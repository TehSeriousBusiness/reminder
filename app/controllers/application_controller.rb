class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user
#  after_filter :ifNotLoggedIn

  protected
  def set_user
    @user = User.find(session[:id]) if @user.nil? && session[:id]
  end

  def login_required
    return true if @user
    access_denied
    return false
  end

  def access_denied
    session[:return_to] = request.request_uri
    flash[:error] = 'Oops. You need to login before you can view that page.'
    redirect_to :controller => 'users', :action => 'login'
  end
  
  def ifNotLoggedIn
	if request.request_uri != "/"
		if @user.nil?
			redirect_to '/'
		end
	end
  end
end
