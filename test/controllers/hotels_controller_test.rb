require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
   setup do
	
	@hotel=hotels(:onehotel)
	@newhotel=hotels(:twohotel)

    end
 
	test "should get hotelsindex" do
		post allhotels_url, params: {email:"akashkarmakar787@gmail.com", password: 'abc'}
 		assert_response :success
	end
	test "should get hotelsaddress" do
		post hotelsataddress_url, params: {address:"Bhubaneswar",email:"akashkarmakar787@gmail.com", password: 'abc'}
		assert_response :success
	end
	test "should create hotel" do
      assert_difference('Hotel.count') do
      post createhotel_url, params: { hotelname: @newhotel.hotel_name, address: @newhotel.hotel_address } 
    end

    assert_response 201
  end

 end