class ApplicationController < ActionController::Base

  include SessionsHelper

  private
  
    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def role_home_template
      user_role = current_user.admin? ? 'admin' : 'customer'
      "#{user_role}_dash"
    end

end
