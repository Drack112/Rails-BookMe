# frozen_string_literal: true

json.array! @booking_types, partial: 'booking_types/booking_type', as: :booking_type
