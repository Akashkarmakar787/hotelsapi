require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
   
    test "should get usersindex" do
    	post allusers_url, params: {email:"akashkarmakar787@gmail.com", password: 'abc'}
 	assert_response :success
    end

end