# frozen_string_literal: true

json.array! @comments do |comment|
  json.post comment.post
  json.hotel comment.hotel.hotel_name
end
