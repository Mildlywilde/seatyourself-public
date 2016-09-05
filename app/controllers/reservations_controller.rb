class ReservationsController < ApplicationController

  before_action do
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    if @restaurant.available?(@reservation.party_size, @reservation.time)
      if @reservation.save
        redirect_to users_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to users_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:time, :date, :party_size, :user_id)
  end


end
