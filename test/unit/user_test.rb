
require 'test_helper'
class UserTest < ActiveSupport::TestCase
  test 'check for nil user details' do
    user = User.new
    assert_not user.save, 'provide all user details'
  end

  test 'email should be unique' do
    user1=User.new(email:"test@gamil.com", password:"abc", username:"test")
    user1.save
    user2=User.new(email:"test@gamil.com", password:"abc", username:"test")
    assert_not user2.valid?
  end

  test 'username should not be too long' do
    user=User.new(username:"jslakdjfkljakldfalkfklasldkfdafs", email:"test@gmail.com", password:"password")
    assert_not user.valid? 'username should not exceed 20 characters'
  end
end