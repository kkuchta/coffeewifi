require 'yelp'

yelp_dev_credentials = YAML.load_file("#{Rails.root}/config/yelp.yml")

Yelp.client.configure do |config|
  config.consumer_key = ENV['YELP_CONSUMER_KEY'] || yelp_dev_credentials['YELP_CONSUMER_KEY']
  config.consumer_secret = ENV['YELP_CONSUMER_SECRET'] || yelp_dev_credentials['YELP_CONSUMER_SECRET']
  config.token = ENV['YELP_TOKEN'] || yelp_dev_credentials['YELP_TOKEN']
  config.token_secret = ENV['YELP_TOKEN_SECRET'] || yelp_dev_credentials['YELP_TOKEN_SECRET']
end
