class UsersController < ApplicationController
	def update_twitter_tokens
		twitter_object = request.env['omniauth.auth'].to_json
		token = env['omniauth.auth']['credentials']['token']
		secret = env['omniauth.auth']['credentials']['secret']
		binding.pry
	end
end
