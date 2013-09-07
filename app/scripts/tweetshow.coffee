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
  query: '#sueandmatt2013'
  slideTime: 7000
  updateTime: 30000

# Application namespace + settings
TweetShow = 
  settings: _.defaults(env, settingsDefaults)


# Keyboard interface:
$(window).on('keypress', (evt) ->
  switch (evt.keyCode ? evt.which)
    when 'h'.charCodeAt(0) then $('.help').toggle()
    when 't'.charCodeAt(0) then $('body').toggleClass('theme-alt')
)
    

# Expose globally
window.TweetShow = TweetShow