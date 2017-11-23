require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { build(:user) }
  
  describe '#valid?' do

    context 'given valid parameters' do
      it { expect(build(:user)).to be_valid }
    end
  
    context 'name is nil' do
      it { expect(user).to be_invalid_on(:name).with(nil) }
    end

    context 'name is blank' do
      it { expect(user).to be_invalid_on(:name).with('     ') }
    end

    context 'name is too long' do
      it { expect(user).to be_invalid_on(:name).with('a' * 51) }
    end
  
    context 'email is nil' do
      it { expect(user).to be_invalid_on(:email).with(nil) }
    end

    context 'email is too long' do
      it { expect(user).to be_invalid_on(:email).with('a' * 244 + '@example.com') }      
    end

    context 'email is valid address' do
      let(:valid_addresses) {
        %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]
      }

      it 'is valid' do
        valid_addresses.each do |valid_address|
          user = build(:user, email: valid_address)
          expect(user).to be_valid
        end
      end
    end

    context 'email is invalid address' do
      let (:invalid_addresses) {
        %w[user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com]
      }

      it 'is invalid' do
        invalid_addresses.each do |invalid_address|
          expect(user).to be_invalid_on(:email).with(invalid_address)
        end
      end
    end

    context 'email is aleady taken' do
      subject(:duplicate_user) { create(:user).dup }
      it { expect(duplicate_user).not_to be_valid }
    end

    context 'password is nil' do
      it { expect(user).to be_invalid_on(:password).with(nil) }
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

  describe '#save!' do

    context 'validation is skipped' do
      
      context 'name is nil' do
        subject(:user) { build(:user, name: nil) }
        it { expect { user.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation) }
      end

      context 'email is nil' do
        subject(:user) { build(:user, email: nil) }
        before { User.skip_callback(:save, :before, :downcase_email) }
        after { User.set_callback(:save, :before, :downcase_email) }
        it { expect { user.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation) }
      end

      context 'password_digest is nil' do
        subject(:user) { build(:user, password_digest: nil) }
        it { expect { user.save!(validate: false) }.to raise_error(ActiveRecord::NotNullViolation) }
      end

      context 'email is aleady taken' do
        subject(:duplicate_user) { create(:user).dup }
        it { expect { duplicate_user.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique) }
      end
    end
  end
end
