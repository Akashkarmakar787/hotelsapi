# frozen_string_literal: true

json.array! @hotels do |hotel|
  json.hotel_name hotel.hotel_name
  json.hotel_rating hotel.hotel_rating
end
