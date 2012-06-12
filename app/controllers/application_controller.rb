class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  layout :layout_by_resource

  protected
  
  def layout_by_resource
    if devise_controller? && 
      (controller_name == 'registrations' || controller_name == 'sessions')
      "public"
    else
      "application"
    end
  end


  private
  
  def require_admin
    unless current_user and current_user.is_admin
      flash[:error] = "You must be an administrator to access this section"
      redirect_to root_url
    end
  end
end
