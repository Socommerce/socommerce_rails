class RetrieveTweetBackground
  include Sidekiq::Worker
  sidekiq_options queue: "tweet"

  def perform
# ENV["RAILS_ENV"] ||= "development"
# root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
# require File.join(root, 'environment')

# log = File.join(root, 'log', 'stream.log')

TweetStream.configure do |conf|
  conf.consumer_key        = 'a0UmBU7AHn0fFneQ10zYwP0Kk'
  conf.consumer_secret     = 'JZEqUgKJsTrYjjvYv1wO4jtrNpy50pwoTUwr4UAro3pPxS7Hhw'
  conf.oauth_token         = '3139928784-rExJZIOTg77V1833ptq7YKbMq4rfok8y4AnIkfd'
  conf.oauth_token_secret  = 'Z8USEigXd6l1KwCywJ9oH3inoQha3zRSNUCSdrxv25tBz'
  conf.auth_method         = :oauth
end

# daemon = TweetStream::Daemon.new('tweet_streamer', log_output: true)
# daemon.on_inited do
#   ActiveRecord::Base.connection.reconnect!
#   ActiveRecord::Base.logger = Logger.new(File.open(log, 'a'))
# end
# daemon.userstream do |status|
#   binding.pry
#   puts status.text
# end

client = TweetStream::Client.new  
# daemon.on_inited do
#   ActiveRecord::Base.connection.reconnect!
#   ActiveRecord::Base.logger = Logger.new(File.open(log, 'a'))
# end
client.userstream do |status|
  puts status.text
  @result = HTTParty.post(
      "http://0e819fc5.ngrok.io/api/publicstream", 
      :headers => { 'Content-Type' => 'application/json' },
      :body => tweet_data(status.text).to_json
      )
  puts @result

  @data = status.text.split(",")
  if(@data.length > 1)
   Order.create(name: @data[0], movie_name: @data[0].replace("@anbullavignesh",""),theatre_name: @data[1], no_of_seats: @data[2], time: @data[3])
  end
  puts JSON.parse(status)
end
  end

  def tweet_data tweet
    {
      "tweet_detail": tweet
    }
  end

end