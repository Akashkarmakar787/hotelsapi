
require 'test_helper'
class UserTest < ActiveSupport::TestCase
  test 'check for nil user details' do
    user = User.new
    assert_not user.save, 'provide all user details'
  end


  test 'email should be unique' do
    u=User.new(email:"test@gamil.com", password:"abc", username:"test")
    u.save
    u=User.new(email:"test@gamil.com", password:"abc", username:"test")
    assert_not u.valid?

  end
  test 'username should not be too long' do
    u=User.new(username:"jslakdjfkljakldfalkfklasldkfdafs", email:"test@gmail.com", password:"password")
    assert_not u.valid? 'username should not exceed 20 characters'
  end
end