class TimeCardsController < ApplicationController
  def index
  end

  def show
    if request.xhr?
      ajax_action
    else
      @time_card = TimeCard.new(current_user)
    end
  end

  private

    def ajax_action
      if params[:in]

      elsif params[:out]

      end
    end
end
