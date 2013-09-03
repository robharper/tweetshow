templates = 
  photo: Handlebars.compile( $('#photo-card').html() )
  text: Handlebars.compile( $('#text-card').html() )


Handlebars.registerHelper('fromNow', (date) ->
  return '' unless date
  return new Handlebars.SafeString( moment(date).fromNow() )
)

class Card
  constructor: (model) ->
    @model = model
    if @model.hasPhoto()
      @template = templates.photo
    else
      @template = templates.text
    
  render: ->
    @$el = $.parseHTML( @template(@model) )


window.TweetShow.Card = Card