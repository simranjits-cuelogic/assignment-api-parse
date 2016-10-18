require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'user is getting saved without email' do
    assert_not users(:one).save, 'User is getting saved without email.'
  end

  test 'user is getting saved without name' do
    assert_not users(:three).save, 'User is getting saved without name.'
  end

  test 'user is getting saved without city' do
    assert_not users(:four).save, 'User is getting saved without city.'
  end

end
