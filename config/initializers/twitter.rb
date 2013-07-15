Twitter.configure do |config|
  config.consumer_key       = APP_CONFIG['twitter_consumer_key']
  config.consumer_secret    = APP_CONFIG['twitter_consumer_secret']
  config.oauth_token        = APP_CONFIG['twitter_oauth_token']
  config.oauth_token_secret = APP_CONFIG['twitter_oauth_token_secret']
end
