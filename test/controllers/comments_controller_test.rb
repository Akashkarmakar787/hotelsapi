# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @hotel = hotels(:onehotel)
    @comment = comments(:onecomment)
    post '/authenticate' ,params:{email:@user.email,password:'abc'}
    @token= JSON.parse(response.body)["auth_token"]
  end
  
  test 'should get commentsindex' do
    post allcomments_url, headers:{Authorization:@token}, as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    json1= server_response.to_json
    #assert_equal comments(:onecomment).post, server_response[0]["post"]
    #assert_equal comments(:onecomment).user.username, server_response[0]["username"]
    #assert_equal comments(:onecomment).hotel.hotel_name, server_response[0]["hotel"] 
  end
  
  test 'check for useremail presence for usercomments' do
    post usercomments_url,params:{email:"akashkarmakar787@gmail.com"}, headers:{Authorization:@token}, as: :json
    assert_response 406
  end

  test 'should get usercomments' do
    post usercomments_url, params: {  useremail: 'akashkarmakar787@gmail.com' }, headers:{Authorization:@token}, as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    assert_equal comments(:onecomment).post, server_response[0]["post"]
    assert_equal comments(:onecomment).hotel.hotel_name, server_response[0]["hotel"]
    #puts JSON.parse(response.body)
  end

  test 'user not found' do
    post usercomments_url, params:{  useremail: 'notpresent@gmail.com' }, headers:{Authorization:@token}, as: :json
    assert_response 404
  end
  
  test 'should get hotelcomments' do
    post hotelcomments_url,
    params: { address: 'Bhubaneswar', hotelname: 'utkal' }, headers:{Authorization:@token},as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    assert_equal comments(:onecomment).post, server_response[0]["post"]
    assert_equal comments(:onecomment).user.username, server_response[0]["username"]
    assert_equal comments(:onecomment).user.email, server_response[0]["useremail"]
    #puts JSON.parse(response.body)
  end

  test ' check hotel not found ' do
    post hotelcomments_url,  headers:{Authorization:@token}, as: :json
    assert_response 404
  end
  
end
