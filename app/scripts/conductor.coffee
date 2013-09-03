TweetShow = window.TweetShow
Gardenhose = TweetShow.Gardenhose
Card = TweetShow.Card


createAndRenderCard = (container) ->
  tweet = Gardenhose.nextTweet()
  return unless tweet?
  card = new Card(tweet)
  card.render()
  container.html(card.$el)


currentCard = 0

doNext = ->
  # Swap cards
  current = $("#card-#{currentCard}")
  currentCard = (currentCard + 1) % 2
  next = $("#card-#{currentCard}")

  current.removeClass('current').addClass('off-deck')
  next.addClass('current')

  setTimeout( ->
    onDeck = current
    onDeck.removeClass('off-deck')
    createAndRenderCard(onDeck)
  , 2000)

  setTimeout(doNext, TweetShow.settings.slideTime)


setTimeout(->
  createAndRenderCard($('#card-1'))
, 4000)

setTimeout(doNext, TweetShow.settings.slideTime)

