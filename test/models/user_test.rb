require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: '山田太郎', email: 'yamada_taro@example.com',
              password: 'password', password_confirmation: 'password')
  end

  test 'should be valid' do
    assert @user.valid?
  end
end
