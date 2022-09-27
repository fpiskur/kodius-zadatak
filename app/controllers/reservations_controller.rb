class ReservationsController < ApplicationController

  before_action :logged_in_user

  def create
    @room = Room.find(params[:room_id])
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

end
