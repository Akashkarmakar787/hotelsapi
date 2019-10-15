# frozen_string_literal: true

require 'test_helper'
class PostTest < ActiveSupport::TestCase
	test 'check for nil comment details' do
    	comment = Comment.new
    	assert_not comment.save, 'provide all comment details'
  	end
end
