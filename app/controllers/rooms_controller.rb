class RoomsController < ApplicationController

  before_action :logged_in_user
  before_action :validate_price_range, only: [:index]
  before_action :validate_date_range,  only: [:index]

  def index
    if current_user.admin?
      # default list (for available rooms today)
      @rooms = Room.distinct.left_outer_joins(:reservations).where("check_out_at <= ? OR check_in_at > ?",
                          Date.today, Date.today).or(
                            Room.distinct.where.missing(:reservations)).order(:number)
      # List of booked rooms today
      if params[:status] && params[:status] == 'booked'
        @rooms = Room.joins(:reservations).where("check_in_at <= ? AND check_out_at > ?", Date.today, Date.today)
      end

    else  # For when user is a customer
      @rooms = Room.all
      # Price filter
      if params[:price_from] && params[:price_to]
        @rooms = Room.where("price_per_day >= ? AND price_per_day <= ?", params[:price_from], params[:price_to]).order(:price_per_day)
      # Date range filter
      elsif params[:date_from] && params[:date_to]
        # Get any overlaps
        sql = ":date_to >= check_in_at AND check_out_at > :date_from"
        # Get rooms where no overlap exists in reservations + rooms with no reservations yet
        @rooms = Room.distinct.left_outer_joins(:reservations).where.not(sql,
              date_to: params[:date_to], date_from: params[:date_from]).or(Room.distinct.where.missing(:reservations)).order(:number)
      end
      
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.build
  end

  private

    def validate_price_range
      if params[:price_from] && params[:price_to]
        if params[:price_from].blank? || params[:price_to].blank?
          flash[:danger] = 'Please set both "price from" and "price to"!'
          redirect_to rooms_path
        elsif params[:price_from] > params[:price_to]
          flash[:danger] = '"Price from" cannot be larger than "Price to"'
          redirect_to rooms_path
        elsif params[:price_from].to_i < 0
          flash[:danger] = '"Price from" cannot be negative'
          redirect_to rooms_path
        end
      end
    end

    def validate_date_range
      if params[:date_from] && params[:date_to]
        if params[:date_from] >= params[:date_to]
          flash[:danger] = '"Date to" has to be at least one day after "Date from"'
          redirect_to rooms_path
        elsif params[:date_from] < Date.today.to_fs
          flash[:danger] = '"Date from" cannot be in the past'
          redirect_to rooms_path
        end
      end
    end

end
