class TimeCardsController < ApplicationController
  before_action :logged_in_user

  def index
    today = Date.today
    @year = today.year
    @month = today.month
    @time_cards = monthly_time_cards(current_user, @year, @month)
  end

  def show
    @time_card = TimeCard.today(current_user)

    if request.xhr?
      ajax_show_action
    end
  end

  private

    # 指定年月の全ての日のタイムカードの配列を取得する（タイムカードが存在しない日はnil）
    def monthly_time_cards(user, year, month)
      number_of_days_in_month = Date.new(year, month, 1).next_month.prev_day.day
      results = Array.new(number_of_days_in_month) # 月の日数分nilで埋めた配列を用意
      time_cards = TimeCard.monthly(user, year, month)
      time_cards.each do |card|
        results[card.day - 1] = card
      end
      results
    end

    # Ajaxでshowアクションが呼ばれた場合のハンドラ
    def ajax_show_action
      if params[:in]
        @time_card.in_time = Time.now
      elsif params[:out]
        @time_card.out_time = Time.now
      end

      if @time_card.save
        render json: { status: 'success', time_card: @time_card, working_status: @time_card.working_status }
      else
        render json: { status: 'error' }
      end
    end
end
