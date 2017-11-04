require 'test_helper'

class TimeCardTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_1)
    @time_card = TimeCard.new(user: @user, year: 2017, month: 11, day: 4)
  end

  def assert_valid
    assert @time_card.valid?
  end

  def assert_not_valid
    assert_not @time_card.valid?
  end

  test 'should be valid' do
    assert_valid
  end

  test 'year shold be present' do
    @time_card.year = nil
    assert_not_valid
  end

  test 'month should be present' do
    @time_card.month = nil
    assert_not_valid
  end

  test 'day should be present' do
    @time_card.day = nil
    assert_not_valid
  end

  test 'year, month, date should be positive integer' do
    time_card = TimeCard.new(user: @user, year: 'abcd', month: 11, day: 4)
    assert_not time_card.valid?

    time_card = TimeCard.new(user: @user, year: -1, month: 11, day: 4)
    assert_not time_card.valid?
    
    time_card = TimeCard.new(user: @user, year: 2017, month: 'ab', day: 4)
    assert_not time_card.valid?
  
    time_card = TimeCard.new(user: @user, year: 2017, month: -1, day: 4)
    assert_not time_card.valid?

    time_card = TimeCard.new(user: @user, year: 2017, month: 11, day: 'ab')
    assert_not time_card.valid?

    time_card = TimeCard.new(user: @user, year: 2017, month: 11, day: -1)
    assert_not time_card.valid?
  end

  test 'combination of year, month, date should be valid date' do
    time_card = TimeCard.new(user: @user, year: 2017, month: 2, day: 29)
    assert_not time_card.valid?
  end

  test 'in_time should be present if out_time is present' do
    @time_card.out_time = Time.now
    assert_not_valid
  end

  test 'out_time should be later than in_time' do
    in_time = Time.now
    out_time = in_time - 10
    @time_card.in_time = in_time
    @time_card.out_time = out_time
    assert_not_valid
  end
end
