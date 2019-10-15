# frozen_string_literal: true

class HotelsController < ApplicationController

  def index
    @hotels = Hotel.all
  end

  def address
    if !params[:address].present?
      render json: { message: 'provide a address' }, status: 406
    else
      @hotels = Hotel.where(hotel_address: params[:address])
      # render json: {address:params[:address], hotels: @hotels}
    end
  end

  def create
    @hotel = Hotel.new(hotel_name: params[:hotelname], hotel_address: params[:address], hotel_rating: params[:hotelraiting])
    if @hotel.save
      response = { message: 'hotel created' }
      render json: response, status: 201
    else
      response = { message: @hotel.errors.full_messages }
      render json: response, status: 422
    end
  end
end
