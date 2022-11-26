class DashbordJob < ApplicationJob
  def perform(*args)
    p Booking.last!
  end
end
