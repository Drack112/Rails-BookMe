# frozen_string_literal: true

Rails.configuration.stripe = {
  publishable_key: ENV['stripe_publishable_key'],
  secret_key: ENV['stripe_api_key']
}
