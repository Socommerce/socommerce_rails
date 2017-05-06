class Order < ActiveRecord::Base
 has_many :order_items
 after_create :start_receiving_tweet

 def start_receiving_tweet
  RetrieveTweetBackground.perform_in(2.seconds)
 end
end
