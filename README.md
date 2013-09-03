# Tweetshow


> Made for a friend's wedding in 90 minutes - judge not

Photo-centric slideshow of tweets matching a query, live updating. Uses a simple express proxy endpoint that handles OAuth on the server.  Lots of brutal assumptions built-in.

### To Use

```
npm install
bower install

grunt build
node server.js
```

Server relies on three environment variables:
 - `NODE_ENV` - the usual, "production" serves from `/dist`
 - `TWITTER_KEY` - OAuth client key
 - `TWITTER_SECRET` - OAuth client secret