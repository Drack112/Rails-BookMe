class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dasboard]

  def index
  end

  def dashboard
    @booking_types = current_user.booking_types
    @bookings = Booking.where(booking_type_id: current_user.booking_type_ids)
  end
end
