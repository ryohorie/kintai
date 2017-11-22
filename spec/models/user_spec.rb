require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#valid?' do

    context 'given valid parameters' do
      it { expect(build(:user)).to be_valid }
    end
  
    context 'name is emtpy' do
      it { expect(build(:user_with_empty_name)).not_to be_valid }
    end

    context 'name is blank' do
      it { expect(build(:user_with_blank_name)).not_to be_valid }
    end

    context 'name is too long' do
      it { expect(build(:user_with_too_long_name)).not_to be_valid }
    end
  
    context 'email is empty' do
      it { expect(build(:user_with_empty_email)).not_to be_valid }
    end

    context 'email is too long' do
      it { expect(build(:user_with_too_long_email)).not_to be_valid }
    end

    context 'email is valid address' do
      let(:valid_addresses) {
        %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]
      }

      it do
        valid_addresses.each do |valid_address|
          expect(build(:user, email: valid_address)).to be_valid
        end
      end
    end

    context 'email is invalid address' do
      let (:invalid_addresses) {
        %w[user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com]
      }

      it do
        invalid_addresses.each do |invalid_address|
          expect(build(:user, email: invalid_address)).not_to be_valid
        end
      end
    end

    context 'email address is aleady taken' do
      let (:duplicate_user) { create(:user).dup }
      it { expect(duplicate_user).not_to be_valid }
    end

    context 'password is empty' do
      it { expect(build(:user_with_empty_password)).not_to be_valid }
    end
  end

  describe '#save' do
    
    context 'email contains upper-case letters' do
      let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

      it 'downcase before save' do
        user = create(:user, email: mixed_case_email)
        expect(user.reload.email).to eq mixed_case_email.downcase
      end
    end
  end
end
