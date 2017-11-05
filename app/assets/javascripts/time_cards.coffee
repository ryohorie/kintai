# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#timecard-form').on 'ajax:success', (event) ->
    response = event.detail[0]
    if response.status is 'success'
      update_view(response.time_card)
    else
      alert 'error'

  update_view = (time_card) ->
    if time_card
      if time_card.in_time && !time_card.out_time
        in_enable = false
        out_enable = true
      else if time_card.out_time
        in_enable = false
        out_enable = false

    $('#in').prop('disabled', !in_enable)
    $('#out').prop('disabled', !out_enable)
    $('#work-status').text(work_status(time_card))

  work_status = (time_card) ->
    if !time_card.in_time
      '未出社'
    else if time_card.in_time && !time_card.out_time
      '勤務中'
    else if time_card.out_time
      '退社済'