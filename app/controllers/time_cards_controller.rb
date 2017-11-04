class TimeCardsController < ApplicationController
  def index
  end

  def show
    now = Time.now
    @year = now.year
    @month = now.month
    @day = now.day
  end
end
