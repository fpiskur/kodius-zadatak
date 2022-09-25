class RoomsController < ApplicationController

  before_action :logged_in_user

  def index
    if current_user.admin?
      if params[:q] && params[:q] == 'available'
        @reservations = Reservation.where("check_out_at < ? OR check_in_at > ?", Date.today, Date.today)
      elsif params[:q] && params[:q] == 'booked'
        @reservations = Reservation.where("check_in_at <= ? AND check_out_at > ?", Date.today, Date.today)
      else  # Available rooms by default - REFACTOR THIS
        @reservations = Reservation.where("check_out_at < ? OR check_in_at > ?", Date.today, Date.today)
      end
    else
      @rooms = Room.all
    end
  end

end
