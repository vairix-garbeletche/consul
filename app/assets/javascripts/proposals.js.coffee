App.Proposals =

  hoverize: (proposals) ->
    $(document).on {
      'mouseenter focus': ->
        $("div.participation-not-allowed", this).show()
        $("div.participation-allowed", this).hide()
      mouseleave: ->
        $("div.participation-not-allowed", this).hide()
        $("div.participation-allowed", this).show()
    }, proposals

  initialize: ->
    App.Proposals.hoverize "div.proposals-create"
    App.Proposals.hoverize "div.proposal-edit"

    $('#publish-as-organism').change ->
      if ($(this).val()) > 0
        $("#responsible-row").show('slow')
      else
        $("#responsible-row").hide('slow')

    false
