require 'rails_helper'

RSpec.describe User, type: :model do
  before :example do
    @user = User.new(name: '山田太郎', email: 'yamada_taro@example.com',
              password: 'password', password_confirmation: 'password')
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end
end
