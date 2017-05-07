class Api::V1::OrdersController < Api::V1::BaseController
  def order_detail
  end

  def send_message
  	user_id = params[:user_id]
  	message = params[:message]
  	client = initialize_rest_api
  	puts "Sending message from api"
    cli.create_direct_message(user_id, message)
    render json: {message: "message have been sent to #{user_id}"}, status: 200
  end

  def initialize_rest_api
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = 'a0UmBU7AHn0fFneQ10zYwP0Kk'
        config.consumer_secret     = 'JZEqUgKJsTrYjjvYv1wO4jtrNpy50pwoTUwr4UAro3pPxS7Hhw'
        config.access_token        = '3139928784-rExJZIOTg77V1833ptq7YKbMq4rfok8y4AnIkfd'
        config.access_token_secret = 'Z8USEigXd6l1KwCywJ9oH3inoQha3zRSNUCSdrxv25tBz'
      end 
      @client
    end
end