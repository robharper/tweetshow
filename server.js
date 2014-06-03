var express = require('express'),
    http = require('http'),
    path = require('path'),
    twitter = require('twitter-api').createClient();

var app = express();

twitter.setAuth ( process.env.TWITTER_KEY, process.env.TWITTER_SECRET );
twitter.fetchBearerToken( function( bearer, raw, status ){
  twitter.setAuth( bearer );
});


app.set('port', process.env.PORT || 3000);


var lastRequest = 0;
var cachedResponses = {};
app.get('/twitter/*', function (req, res) {
  if (Date.now() > lastRequest+10000 || !cachedResponses[req.query.q]) {
    // Been a while since we allowed a request through...
    lastRequest = Date.now();
    console.log('Requesting from twitter: ' + req.query.q);
    twitter.get(req.path.replace('/twitter/', ''), req.query, function( data, error, status ) {
      cachedResponses[req.query.q] = data;
      res.send(data);
    });
  } else {
    // Return cached data
    console.log('Returning cached data...');
    res.send(cachedResponses[req.query.q]);
  }
});


app.configure('development', function() {
  app.use(express.logger());
  app.use(express.static(path.join(__dirname, '.tmp')));
  app.use(express.static(path.join(__dirname, 'app')));
});

app.configure('production', function() {
  app.use(express.static(path.join(__dirname, 'dist')));
});

// Start
var server = http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});