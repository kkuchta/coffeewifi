require 'yelp'

filename = "#{Rails.root}/config/yelp.yml"
yelp_dev_credentials =
  if File.exists?(filename)
    YAML.load_file(filename)
  else
    {}
  end

Yelp.client.configure do |config|
  config.consumer_key = ENV['YELP_CONSUMER_KEY'] || yelp_dev_credentials['YELP_CONSUMER_KEY']
  config.consumer_secret = ENV['YELP_CONSUMER_SECRET'] || yelp_dev_credentials['YELP_CONSUMER_SECRET']
  config.token = ENV['YELP_TOKEN'] || yelp_dev_credentials['YELP_TOKEN']
  config.token_secret = ENV['YELP_TOKEN_SECRET'] || yelp_dev_credentials['YELP_TOKEN_SECRET']
end
