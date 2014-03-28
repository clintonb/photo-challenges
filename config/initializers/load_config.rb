APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/app.yml")['all']

TweetStream.configure do |config|
  config.consumer_key = APP_CONFIG['twitter']['consumer_key']
  config.consumer_secret = APP_CONFIG['twitter']['consumer_secret']
  config.oauth_token = APP_CONFIG['twitter']['oauth_token']
  config.oauth_token_secret = APP_CONFIG['twitter']['oauth_token_secret']
  config.auth_method = :oauth
end


Devise.setup do |config|
  config.omniauth :twitter, APP_CONFIG['twitter']['consumer_key'], APP_CONFIG['twitter']['consumer_secret']
end
