require 'rails_helper'

RSpec.describe TimeCard, type: :model do

  let(:user) { create(:user) }
  let(:time_card) { TimeCard.new(user: user, year: 2017, month: 11, day: 4) }

  describe '#valid?' do

    context 'given valid parameters' do
      it { expect(time_card).to be_valid }
    end
  end    
end
