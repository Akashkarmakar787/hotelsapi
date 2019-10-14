# frozen_string_literal: true

require 'test_helper'
require 'yajl'
require 'json-compare'

class CommentsControllerTest < ActionDispatch::IntegrationTest

	setup do
    @user = users(:one) 
  end
  test 'should get usersindex' do
     post allusers_url, params: { email: 'akashkarmakar787@gmail.com', password: 'abc' }, as: :json
     assert_response :success
    
     server_responses= JSON.parse(response.body)
     

     json1 = server_responses.to_json
     #puts json1

     json2 = User.all.to_json(only:[:email,:username])


     #puts json2
     old, new = Yajl::Parser.parse(json1), Yajl::Parser.parse(json2)
     result = JsonCompare.get_diff(old, new)
     #puts result
     assert_equal result,{}
    

  end
  test 'emailid non presence' do
     post allusers_url
     assert_response 406
  end
  test 'should not get userindex' do
     post allusers_url, params: {email:"random@gmail.com", password:"random"}
     assert_response 401

  end
  test 'create user' do
    assert_difference('User.count') do
    post createuser_url, params:{email:"newuser@gmail.com", password:"newuser", username:"newuser"}
    end
    assert_response :success

  end
  test 'user creation should fail' do
    assert_no_difference('User.count') do
      post createuser_url
    end
    assert_response 422
  end
  
end
