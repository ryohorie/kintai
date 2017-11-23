require 'rails_helper'

RSpec.describe TimeCard, type: :model do

  subject(:time_card) { build(:time_card) }

  describe '#valid?' do

    context 'given valid parameters' do
      it { expect(time_card).to be_valid }
    end

    context 'year is nil' do
      it { expect(time_card).to be_invalid_on(:year).with(nil) }
    end

    context 'year is not positive integer' do
      it { expect(time_card).to be_invalid_on(:year).with('abcd') }
      it { expect(time_card).to be_invalid_on(:year).with(-1) }
    end

    context 'month is nil' do
      it { expect(time_card).to be_invalid_on(:month).with(nil) }
    end

    context 'month is not positive integer' do
      it { expect(time_card).to be_invalid_on(:year).with('ab') }
      it { expect(time_card).to be_invalid_on(:year).with(-1) }
    end

    context 'day is nil' do
      it { expect(time_card).to be_invalid_on(:day).with(nil) }
    end

    context 'day is not positive integer' do
      it { expect(time_card).to be_invalid_on(:day).with('ab') }
      it { expect(time_card).to be_invalid_on(:day).with(-1) }
    end

    context 'combination of year, month, date is an invalid date' do
      subject(:time_card) { build(:time_card, year: 2017, month: 2, day: 29) }
      it { expect(time_card).not_to be_valid }
    end
  end
end
