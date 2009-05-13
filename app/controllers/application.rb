# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #rofreg wuz in ur app, commentin ur hax
  before_filter CASClient::Frameworks::Rails::Filter
  helper_method :current_user


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '767c8fe62c6588033782ff54b5a36038'


  def current_user
    @current_user ||= User.find_by_netid(session[:cas_user]) || User.import_from_ldap(session[:cas_user], true)
  end

  # See ActionController::Base for details
end
