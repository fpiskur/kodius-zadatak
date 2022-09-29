class MessagesController < ApplicationController

  before_action :admin_user,     only: [:custom_message]
  
  def send_custom_message
    message = params[:message]
    users = User.joins(:reservations).where("check_in_at <= ? AND check_out_at > ?", Date.today, Date.today)
    users.each do |user|
      if !user.admin?
        user.message = message
        user.send_custom_message_email
      end
    end
    flash[:success] = "Email sent to all present customers"
    redirect_to root_url
  end

  private

    # Confirms an admin user
    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
