# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :authorize_user
  
  helper :all # include all helpers, all the time
  helper_method :current_user
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '767c8fe62c6588033782ff54b5a36038'
  
  def authorize_user
    unless User.find_by_netid(session[:cas_user])
      redirect_to 'http://yale.edu'
    end
  end  
  
  def current_user
    @current_user ||= User.find_by_netid(session[:cas_user]) || User.import_from_ldap(session[:cas_user, true])
  end
  
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
