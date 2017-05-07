class RetrieveTweetBackground
  include Sidekiq::Worker
  sidekiq_options queue: "tweet"

  def perform user_id
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
    tenant_user_id = User.find(user_id).twitter_id.to_i
    client = TweetStream::Client.new  
    # daemon.on_inited do
    #   ActiveRecord::Base.connection.reconnect!
    #   ActiveRecord::Base.logger = Logger.new(File.open(log, 'a'))
    # end
    # client.userstream do |status|
    TweetStream::Client.new.follow(tenant_user_id) do |status|
      puts status.text
      puts status.user.id
      puts status.user.name
      puts "Requesting node"
      @user_id = status.user.id  
      @user_name = status.user.name
      @result = HTTParty.post(
          "https://socommercenodejs.herokuapp.com/api/publicstream", 
          :headers => { 'Content-Type' => 'application/json' },
          :body => tweet_data(status.text, @user_id, @user_name).to_json
          )
      puts @result
      # @data = status.text.split(",")
      # if(status.text.include?('@anbullavignesh') && (@data.length > 2))
      if @result.present?
       puts "creating order"
       Order.create(name: @result['twitter_user_name'], movie_name: @result['movies_list'], theatre_name: @result['theaters'], no_of_seats: @result['no_of_ticket'], time: @result['timing'])   
       message = @result['dm_message']
       cli = initialize_rest_api
       send_message @user_id, message, cli
      end
    end
  end

  def tweet_data tweet, id, nam
    {
      "tweet_detail": tweet,
      "user_id": id,
      "user_name": nam
    }
  end

  private

    def initialize_rest_api
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = 'a0UmBU7AHn0fFneQ10zYwP0Kk'
        config.consumer_secret     = 'JZEqUgKJsTrYjjvYv1wO4jtrNpy50pwoTUwr4UAro3pPxS7Hhw'
        config.access_token        = '3139928784-rExJZIOTg77V1833ptq7YKbMq4rfok8y4AnIkfd'
        config.access_token_secret = 'Z8USEigXd6l1KwCywJ9oH3inoQha3zRSNUCSdrxv25tBz'
      end 
      @client
    end
    def send_message id, message, cli
      puts "Sending message"
      cli.create_direct_message(id, message)
    end
end