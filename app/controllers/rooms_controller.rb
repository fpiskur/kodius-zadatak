class RoomsController < ApplicationController

  before_action :logged_in_user

  def index
    if current_user.admin?
      if params[:q] && params[:q] == 'available'
        @rooms = Room.first(3)
      elsif params[:q] && params[:q] == 'booked'
        @rooms = Room.last(3)
      else
        @rooms = Room.first(3)
      end
    else
      @rooms = Room.all
    end
  end

end
