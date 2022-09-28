class ReservationsController < ApplicationController

  before_action :logged_in_user
  before_action :get_room,          only: [:create]
  before_action :reservation_available, only: [:create]

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      flash[:success] = "Reservation saved!"
      redirect_to root_url
    else
      flash.now[:danger] = "Error saving reservation"
      render 'rooms/show', status: :unprocessable_entity
    end
  end

  private

    def reservation_params
      params.require(:reservation).permit(:check_in_at, :check_out_at)
    end

    def get_room
      @room = Room.find(params[:room_id])
    end

    def reservation_available
      # Get any overlaps
      sql = ":check_out_at >= check_in_at AND check_out_at > :check_in_at"
      reservations = @room.reservations.where(sql,
              check_out_at: params[:reservation][:check_out_at], check_in_at: params[:reservation][:check_in_at])
      # In case there are overlaps display flash message
      if reservations.any?
        flash[:danger] = "Those dates are not available for reservation"
        redirect_to room_path(@room)
      end
    end

end
