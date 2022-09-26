class RoomsController < ApplicationController

  before_action :logged_in_user

  def index
    if current_user.admin?
      # default list (for 'available' rooms)
      @rooms = Room.joins(:reservations).where("check_out_at < ? OR check_in_at > ?", Date.today, Date.today).uniq

      if params[:status] && params[:status] == 'booked'
        @rooms = Room.joins(:reservations).where("check_in_at <= ? AND check_out_at > ?", Date.today, Date.today)
      end

    else
      if params[:price_from] && params[:price_to]
        @rooms = Room.all.where("price_per_day >= ? AND price_per_day <= ?", params[:price_from], params[:price_to])
        render locals: { from: params[:price_from], to: params[:price_to] }
      elsif params[:date_from] && params[:date_to]
        # @rooms = Room.joins(:reservations).where.not("")
      end
      
    end
  end

end
