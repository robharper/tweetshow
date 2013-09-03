TweetShow = window.TweetShow


Tweet = TweetShow.Tweet

Gardenhose =

  query: TweetShow.settings.query
  
  queue: []

  cursor: null

  lastSeenIdx: -1

  lastChosenIdx: null

  photoChance: 0.75

  # Return latest tweets not seen, otherwise random
  nextTweet: ->
    if @lastSeenIdx < @queue.length-1
      @lastSeenIdx += 1
      @queue[@lastSeenIdx]
    else
      @randomTweet()

  # Return a random tweet
  randomTweet: ->
    # Photo or any tweet?
    if Math.random() < @photoChance
      queue = _.filter @queue, (tweet) -> tweet.hasPhoto()
    else
      queue = @queue

    # Create x randomly biased towards 1
    gen = => Math.floor(queue.length * Math.sqrt(Math.random())) 
    idx = gen()
    idx = gen() while @queue.indexOf(queue[idx]) == @lastChosenIdx and queue.length > 1
    @lastChosenIdx = @queue.indexOf(queue[idx])
    queue[idx]

  updateQueue: ->
    handleResults = (reply) =>
      console.log(reply) if TweetShow.settings.debug
      return unless reply.statuses?
      @cursor = reply?.search_metadata?.refresh_url
      for data in reply.statuses by -1
        tweet = new Tweet(data)
        @queue.push(tweet)

    if @cursor?
      $.ajax(
        url: '/twitter/search/tweets'+@cursor
      ).then(handleResults)      
    else
      $.ajax(
        url: '/twitter/search/tweets'
        data: {q: @query}
      ).then(handleResults)


# Make first request
Gardenhose.updateQueue()
# ... and every 30 seconds
setInterval(->
  Gardenhose.updateQueue()
,TweetShow.settings.updateTime)


TweetShow.Gardenhose = Gardenhose