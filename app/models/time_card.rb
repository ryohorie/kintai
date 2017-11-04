class TimeCard < ApplicationRecord
  belongs_to :user

  validates :year, presence: true, length: { is: 4 }
  validates :month, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :day, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
end
