# frozen_string_literal: true

require 'test_helper'
class PostTest < ActiveSupport::TestCase
  test 'should not save hotel without hotelname and address' do
    hotel = Hotel.new
    assert_not hotel.save, 'title should not be nil'
  end
end
