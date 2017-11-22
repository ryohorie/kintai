require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) do
    User.new(name: '山田太郎', email: 'yamada_taro@example.com',
              password: 'password', password_confirmation: 'password')
  end

  describe '#valid?' do

    context 'given valid parameters' do
      it { expect(user).to be_valid }
    end
  
    context 'name not present' do
      before { user.name = "     " }
      it { expect(user).not_to be_valid }
    end

    context 'name too long' do
      before { user.name = "a" * 51 }
      it { expect(user).not_to be_valid }
    end
  
    context 'email not present' do
      before { user.email = "     " }
      it { expect(user).not_to be_valid }
    end

    context 'email too long' do
      before { user.email = "a" * 244 + "@example.com" }
      it { expect(user).not_to be_valid }
    end

    context 'given valid email addresses' do
      let(:valid_addresses) {
        %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]
      }
      
      it do
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end

    context 'given invalid email addresses' do
      let (:invalid_addresses) {
        %w[user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com]
      }

      it do
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
    end

    context 'given existing email address' do
      let(:duplicate_user) { user.dup }

      it do
        user.save
        expect(duplicate_user).not_to be_valid
      end
    end

    context 'password not present' do
      before { user.password = user.password_confirmation = " " * 6 }
      it { expect(user).not_to be_valid }
    end
  end

  describe '#save' do
    
    context 'upper-case letters in email address' do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it 'downcase before save' do
        user.email = mixed_case_email
        user.save
        expect(user.email).to eq mixed_case_email.downcase
      end
    end
  end
end
