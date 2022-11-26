class DashBoardJob < ApplicationJob
  sidekiq_options retry: false
  queue_as :default

  def perform(*args)
    puts "Hello My Boy"
  end
end
