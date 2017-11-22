require 'rails_helper'

RSpec.describe TimeCard, type: :model do

  let(:user) { create(:user) }
  let(:time_card) { TimeCard.new(user: user, year: 2017, month: 11, day: 4) }

  describe '#valid?' do

    context 'given valid parameters' do
      it { expect(time_card).to be_valid }
    end

    context 'year is absent' do
      before { time_card.year = nil }
      it { expect(time_card).not_to be_valid }
    end

    context 'year is not positive integer' do
      before { time_card.year = 'abcd' }
      it { expect(time_card).not_to be_valid }

      before { time_card.year = -1 }
      it { expect(time_card).not_to be_valid }
    end

    

    context 'month is absent' do
      before { time_card.month = nil }
      it { expect(time_card).not_to be_valid }
    end

    context 'day is not present' do
      before { time_card.day = nil }
      it { expect(time_card).not_to be_valid }
    end

    # context 'year, month, day are string' do
    #   let(:invalid_year) { 'abcd' }
    #   let(:invalid_month_day) { 'ab' }

    #   it do
    #     time_card.year = invalid_year
    #     expect(time_card).not_to be_valid
    #   end

    #   it do
    #     time_card.month = invalid_month_day
    #     expect(time_card).not_to be_valid        
    #   end

    #   it do
    #     time_card.day = invalid_month_day
    #     expect(time_card).not_to be_valid
    #   end
    # end      

    # context 'year, month, day are negative integer' do
    #   it do
    #     time_card = TimeCard.new(user: user, year: -1, month: 11, day: 4)
    #     expect(time_card).not_to be_valid

    #     time_card = TimeCard.new(user: user, year: 2017, month: -1, day: 4)
    #     expect(time_card).not_to be_valid

    #     time_card = TimeCard.new(user: user, year: 2017, month: 11, day: -1)
    #     expect(time_card).not_to be_valid
    #   end
    # end

    # context 'combination of year, month, date are valid date' do
    #   it do
    #     time_card = TimeCard.new(user: user, year: 2017, month: 2, day: 29)
    #     expect(time_card).to be_valid
    #   end
    # end
  
  end
end
