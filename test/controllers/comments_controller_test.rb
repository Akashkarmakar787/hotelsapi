# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @hotel = hotels(:onehotel)
    @comment = comments(:onecomment)
  end
  test 'check for emailid presence for allcomments' do
    post allcomments_url
    assert_response 406
  end
  test 'should get commentsindex' do
    post allcomments_url, params: { email: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    assert_equal comments(:onecomment).post, server_response[0]["post"]
    assert_equal comments(:onecomment).user.username, server_response[0]["username"]
    assert_equal comments(:onecomment).hotel.hotel_name, server_response[0]["hotel"] 
  end
  
  test 'test for login unsuccessful in all comments' do
    post allcomments_url, params: { email: 'random@gmail.com', password: 'random' }, as: :json
    assert_response 401
  end

  test 'check for emailid presence for usercomments' do
    post usercomments_url
    assert_response 406
  end
  test 'check for useremail presence for usercomments' do
    post usercomments_url,params:{email:"akashkarmakar787@gmail.com"}
    assert_response 406
  end
  test 'should get usercomments' do
    post usercomments_url, params: { email: 'akashkarmakar787@gmail.com', useremail: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    assert_equal comments(:onecomment).post, server_response[0]["post"]
    assert_equal comments(:onecomment).hotel.hotel_name, server_response[0]["hotel"]

    #puts JSON.parse(response.body)
  end
  test 'user not found' do
    post usercomments_url, params:{ email: 'akashkarmakar787@gmail.com', useremail: 'notpresent@gmail.com', password: 'abc' }, as: :json
    assert_response 404
  end
  test 'test for login unsuccessful in user comments' do
    post usercomments_url, params: { email: 'random@gmail.com',useremail:"user@gamil.com", password: 'random' }, as: :json
    assert_response 401
  end
  test 'check for emailid presence for hotelcomments' do
    post hotelcomments_url
    assert_response 406
  end
  test 'should get hotelcomments' do
    post hotelcomments_url,
         params: { email: 'akashkarmakar787@gmail.com', password: 'abc', address: 'Bhubaneswar', hotelname: 'utkal' }, as: :json
    assert_response :success
    server_response=JSON.parse(response.body)
    assert_equal comments(:onecomment).post, server_response[0]["post"]
    assert_equal comments(:onecomment).user.username, server_response[0]["username"]
    assert_equal comments(:onecomment).user.email, server_response[0]["useremail"]
        #puts JSON.parse(response.body)

  end
  test ' check hotel not found ' do
    post hotelcomments_url, params: { email: 'akashkarmakar787@gmail.com', password: 'abc'}, as: :json
    assert_response 404
  end
  test 'test for login unsuccessful in hotel comments' do
    post hotelcomments_url, params: { email: 'random@gmail.com',useremail:"user@gamil.com", password: 'random' }, as: :json
    assert_response 401
  end
end
