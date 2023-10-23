class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  def after_sign_in_path_for(resource)
    about_psth
  end
  
  def after_sign_out_path_for(resource)
    about_path
  end
end
