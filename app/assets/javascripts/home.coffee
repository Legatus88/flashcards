$ ->
  $('.check-form').on "ajax:success", (event) ->
     [data, status, xhr] = event.detail
     