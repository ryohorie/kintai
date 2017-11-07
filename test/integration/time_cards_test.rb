require 'test_helper'

class TestCardsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_1)
  end

  test 'in and out' do
    skip
    # TODO: xhr:trueでpostしてもコントローラーのアクションで、request.xhr?が真にならない
    assert_difference 'TimeCard.count', 0 do
      post timecard_path, xhr: true, params: { name: 'in' }
    end

    log_in_as(@user)
    assert_difference 'TimeCard.count', 1 do
      post timecard_path, xhr: true, params: { name: 'in' }
    end
  end
end
