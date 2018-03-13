App.CustomComments =

  show_pending_aproval: () ->
    $(".pending-aproval").show();

  initialize: ->

    $('[id^=comment-as-organism]').change ->
      text_field_id = "#{$(this).context.id}-name"
      if ($(this).val()) > 0
        $("##{text_field_id}").show('slow')
      else
        $("##{text_field_id}").hide('slow')
