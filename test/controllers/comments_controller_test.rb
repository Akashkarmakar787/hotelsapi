# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @hotel = hotels(:onehotel)
    @comment = comments(:onecomment)
  end
  test 'should get commentsindex' do
    post allcomments_url, params: { email: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
    assert_response :success
  end

  test 'should get usercomments' do
    post usercomments_url, params: { email: 'akashkarmakar787@gmail.com', useremail: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
    assert_response :success
  end
  test 'should get hotelcomments' do
    post hotelcomments_url,
         params: { email: 'akashkarmakar787@gmail.com', password: 'abc', address: 'Bhubaneswar', hotelname: 'utkal' }, as: :json
    assert_response :success
  end
end
