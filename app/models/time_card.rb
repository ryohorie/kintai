class TimeCard < ApplicationRecord
  belongs_to :user

  validates :year, presence: true
  validates :month, presence: true
  validates :day, presence: true
  validate :valid_date
  validates :in_time, presence: true, if: lambda { |m| !m.out_time.nil? }
  validate :out_time_is_later_than_in_time

  class << self
    def today(user)
      date = Date.today
      self.new(user: user, year: date.year, month: date.month, day: date.day)
    end
  end

  private

    def valid_date
      if !positive_integer?(year) ||
        !positive_integer?(month) ||
        !positive_integer?(day) ||
        !Date.valid_date?(year, month, day)

        errors[:base] << '不正な日付です'
      end
    end

    def positive_integer?(value)
      !value.nil? && value.integer? && value > 0
    end

    def out_time_is_later_than_in_time
      return if in_time.nil? || out_time.nil?

      if in_time > out_time
        errors[:base] << '退社時間は、出社時間より後の時間である必要があります'
      end
    end
end
