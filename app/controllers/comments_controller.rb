# frozen_string_literal: true

class CommentsController < ApplicationController
  def index 
    @comments = Comment.all
  end

  def user
    if !params[:useremail].present?
      render json: { message: "provide user's email id to fetch his comments" }, status: 406
    else
      @user = User.find_by(email: params[:useremail].downcase)
      if @user.present?
        @comments = @user.comments
        # render json: {useremail: params[:useremail], comments:@comments}, status:200
      else
        response={ message: 'user not found' }
        render json: response, status: 404
      end
    end
  end

  def hotel
    @hotel = Hotel.find_by(hotel_name: params[:hotelname], hotel_address: params[:address])
    if !@hotel.present?
      render json: { message: 'hotel not found' }, status: 404
    else
      @comments = @hotel.comments
      # render json: {hotel_name:params[:hotelname], hotel_address:params[:address],comments: @comments}, status: 200
    end
  end
end
