class ApplicationController < ActionController::Base
  protect_from_forgery
 
  private
 
  def require_admin
    unless current_user and current_user.is_admin
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_url
    end
  end
end
