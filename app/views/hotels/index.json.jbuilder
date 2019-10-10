json.array! @hotels do |hotel|
	json.hotel_name hotel.hotel_name
	json.hotel_address hotel.hotel_address
	json.hotel_rating hotel.hotel_rating

end