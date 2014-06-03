env = {}
window.location.search.replace /([^?&=]+)=([^&=]*)/g, (_, key, value) ->
  value = decodeURIComponent(value)
  if parseInt(value, 10).toString() is value
    value = parseInt(value, 10)
  else if value is "false" or value is "true"
    value = (value is "true")  
    
  if env.hasOwnProperty(key)
    env[key] = [env[key], value]
  else
    env[key] = value

settingsDefaults = 
  hash: 'cats'
  slideTime: 7000
  updateTime: 30000

settings = _.defaults(env, settingsDefaults)
settings.query ?= '#'+settings.hash

# Application namespace + settings
TweetShow = 
  settings: settings


# Keyboard interface:
$(window).on('keypress', (evt) ->
  switch (evt.keyCode ? evt.which)
    when 'h'.charCodeAt(0) then $('.help').toggle()
    when 't'.charCodeAt(0) then $('body').toggleClass('theme-alt')
)
  
# Setup
$('#hash').text(TweetShow.settings.query)

# Expose globally
window.TweetShow = TweetShow