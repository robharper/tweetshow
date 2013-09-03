class Tweet
  constructor: (obj) ->
    _.extend(@, obj)

  hasPhoto: ->
    @entities.media?[0]?.type is 'photo'

  photoUrl: ->
    # TODO find largest size
    photo = @entities.media[0]
    if photo.sizes.large?
      photo.media_url+":large"
    else
      photo.media_url

  cleanBody: ->
    if @hasPhoto()
      @text.replace(@entities.media[0].url, '')
    else
      @text


window.TweetShow.Tweet = Tweet