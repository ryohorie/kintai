class TimeCardsController < ApplicationController
  def index
    if request.xhr?
      ajax_index_action
    else
      today = Date.today
      @time_cards = TimeCard.monthly(current_user, today.year, today.month)
    end
  end

  def show
    @time_card = TimeCard.today(current_user)

    if request.xhr?
      ajax_show_action
    end
  end

  private

    def ajax_index_action
    end
  
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
