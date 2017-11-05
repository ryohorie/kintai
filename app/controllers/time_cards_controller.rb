class TimeCardsController < ApplicationController
  def index
  end

  def show
    @time_card = TimeCard.today(current_user)

    if request.xhr?
      ajax_action
    end
  end

  private

    def ajax_action
      if params[:in]
        @time_card.in_time = Time.now
      elsif params[:out]
        @time_card.out_time = Time.now
      end

      if @time_card.save
        render json: { status: 'success', time_card: @time_card }
      else
        render json: { status: 'error' }
      end
    end
end
