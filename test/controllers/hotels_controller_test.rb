# frozen_string_literal: true

require 'test_helper'
class CommentsControllerTest < ActionDispatch::IntegrationTest
  

  setup do
    @hotel = hotels(:onehotel)
    @newhotel = hotels(:twohotel)
    @user=users(:one)
    post '/authenticate' ,params:{email:@user.email,password:'abc'}
    @token= JSON.parse(response.body)["auth_token"]
  
  end
  
  test 'should get hotelsindex' do
    post allhotels_url, headers:{Authorization:@token},as: :json
    #post request.headers["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
    server_response=JSON.parse(response.body)
    json1=server_response.to_json
    json2 = Hotel.all.to_json(only:[:hotel_name,:hotel_address,:hotel_rating])
    #puts json2
    old, new = Yajl::Parser.parse(json1), Yajl::Parser.parse(json2)
    result = JsonCompare.get_diff(old, new)
    #puts result
    #assert_equal result,{}
    #assert_equal server_response[1]["hotel_name"], hotels(:onehotel).hotel_name
    #assert_equal server_response[1]["hotel_address"], hotels(:onehotel).hotel_address
    #assert_equal server_response[1]["hotel_rating"], hotels(:onehotel).hotel_rating
    assert_response :success
  end
  
  
  test "address presence check" do
    post hotelsataddress_url, headers:{Authorization:@token}
    assert_response 406
  end

  test 'should get hotels at address' do
    post hotelsataddress_url, headers:{Authorization:@token}, params: { address: 'Bhubaneswar'}, as: :json
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
  
  test 'should create hotel' do
    assert_difference('Hotel.count') do
      post createhotel_url, headers:{Authorization:@token}, params: { hotelname: @newhotel.hotel_name, address: @newhotel.hotel_address }
    end
    assert_response 201
  end

  test 'should not create hotel' do
    assert_no_difference('Hotel.count') do
      post createhotel_url, headers:{Authorization:@token}
    end
    assert_response 422
  end
  
end
