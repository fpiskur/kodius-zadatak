class RoomsController < ApplicationController

  before_action :logged_in_user

  def index
    if current_user.admin?
      admin_dashboard
    else  # For when user is a customer
      customer_dashboard
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.build
  end

  private

    def admin_dashboard
      sql = "check_in_at <= ? AND check_out_at > ?"
      # default list (for available rooms today)
      @rooms = Room.distinct.left_outer_joins(:reservations).where.not(sql,
                            Date.today, Date.today).or(
                            Room.distinct.where.missing(:reservations)).order(:number)
      # List of booked rooms today
      if params[:status] && params[:status] == 'booked'
        @rooms = Room.joins(:reservations).where(sql, Date.today, Date.today)
      end
      render role_home_template
    end

    def customer_dashboard
      @rooms = Room.all
      # Date range filter
      if params[:date_from].present? && params[:date_to].present?
        # Get any overlaps
        sql = ":date_to >= check_in_at AND check_out_at > :date_from"
        # Get rooms where no overlap exists in reservations + rooms with no reservations yet
        @rooms = @rooms.distinct.left_outer_joins(:reservations).where.not(sql,
              date_to: params[:date_to], date_from: params[:date_from]).or(Room.distinct.where.missing(:reservations)).order(:number)
      end
      # Price filter
      if params[:price_from].present? && params[:price_to].present?
        @rooms = @rooms.where("price_per_day >= ? AND price_per_day <= ?", params[:price_from], params[:price_to]).order(:number)
      end
      @rooms
      render role_home_template
    end

end
