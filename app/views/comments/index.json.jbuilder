# frozen_string_literal: true

json.array! @comments do |comment|
  json.post comment.post
  json.username comment.user.username
  json.hotel comment.hotel.hotel_name
end
