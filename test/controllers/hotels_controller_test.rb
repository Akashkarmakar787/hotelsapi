# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hotel = hotels(:onehotel)
    @newhotel = hotels(:twohotel)
  end
  test 'email id presence' do
    post allhotels_url
    assert_response 406
  end
  test 'should get hotelsindex' do
    post allhotels_url, params: { email: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
    server_response=JSON.parse(response.body)
    json1=server_response.to_json
    json2 = Hotel.all.to_json(only:[:hotel_name,:hotel_address,:hotel_rating])


     #puts json2
     old, new = Yajl::Parser.parse(json1), Yajl::Parser.parse(json2)
     result = JsonCompare.get_diff(old, new)
     #puts result
     assert_equal result,{}
    #assert_equal server_response[1]["hotel_name"], hotels(:onehotel).hotel_name
    #assert_equal server_response[1]["hotel_address"], hotels(:onehotel).hotel_address
    #assert_equal server_response[1]["hotel_rating"], hotels(:onehotel).hotel_rating
    assert_response :success
  end
  test 'test for invalid credentials' do
    post allhotels_url, params:{email:"random@gmail.com", password:"random"}
    assert_response 401
  end
  test 'emailid presence check' do
    post hotelsataddress_url
    assert_response 406
  end
  test "address presence check" do
    post hotelsataddress_url, params:{email:"akashkarmakar787@gmail.com", password:"abc"}
    assert_response 406
  end
  test 'should get hotelsaddress' do
    post hotelsataddress_url, params: { address: 'Bhubaneswar', email: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    json1=server_response.to_json
     #puts json1
    json2 = Hotel.where(hotel_address:"Bhubaneswar").to_json(only:[:hotel_name,:hotel_rating])


     #puts json2
     old, new = Yajl::Parser.parse(json1), Yajl::Parser.parse(json2)
     result = JsonCompare.get_diff(old, new)
     #puts result
     assert_equal result,{}
    #assert_equal server_response[0]["hotel_name"], hotels(:onehotel).hotel_name
    #assert_equal server_response[0]["hotel_rating"], hotels(:onehotel).hotel_rating
  end
  test 'check for invalid credentials' do
    post hotelsataddress_url, params:{address: 'Bhubaneswar', email: 'random@gmail.com', password: 'random' }, as: :json
    assert_response 401
  end
  test 'should create hotel' do
    assert_difference('Hotel.count') do
      post createhotel_url, params: { hotelname: @newhotel.hotel_name, address: @newhotel.hotel_address }
    end
    assert_response 201
  end
  test 'should not create hotel' do
    assert_no_difference('Hotel.count') do
      post createhotel_url
    end
    assert_response 422
  end
end
