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
    false
