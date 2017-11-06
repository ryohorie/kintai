# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#timecard-form').on 'ajax:success', (event) ->
    response = event.detail[0]
    if response.status is 'success'
      update_view(response)
    else
      alert 'error'

  update_view = (response) ->
    time_card = response.time_card

    if time_card
      if time_card.in_at && !time_card.out_at
        in_enable = false
        out_enable = true
      else if time_card.out_at
        in_enable = false
        out_enable = false

    $('#in').prop('disabled', !in_enable)
    $('#out').prop('disabled', !out_enable)
    $('#work-status').text(working_status(response.working_status))

  working_status = (status) ->
    switch status
      when 'not_arrived' then '未出社'
      when 'working' then '勤務中'
      when 'left' then '退社済'