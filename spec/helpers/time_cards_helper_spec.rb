require 'rails_helper'

RSpec.describe TimeCardsHelper, type: :helper do

  describe '#time_diff_str' do
    let(:time_card) { create(:time_card) }
    let(:now) { Time.zone.now }
    subject(:str) { helper.time_diff_str(time_card.work_hours_in_seconds) }
  
    before { time_card.in_at = now }
  
    it do
      time_card.out_at = now + 59
      expect(str).to eq '00:00'
    end

    it do
      time_card.out_at = now + 1.minute
      expect(str).to eq '00:01'
    end

    it do
      time_card.out_at = now + 59.minute
      expect(str).to eq '00:59'
    end

    it do
      time_card.out_at = now + 1.hour
      expect(str).to eq '01:00'
    end

    it do
      time_card.out_at = now + 10.hour
      expect(str).to eq '10:00'
    end

    it do
      time_card.out_at = now + 100.hour
      expect(str).to eq '100:00'
    end
  end
end
