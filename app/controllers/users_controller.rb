class UsersController < ApplicationController
	def update_twitter_tokens
		twitter_object = request.env['omniauth.auth'].to_json
		token = env['omniauth.auth']['credentials']['token']
		secret = env['omniauth.auth']['credentials']['secret']
		twitter_id = env['omniauth.auth']['uid']
		twitter_name = env['omniauth.auth']['info']['name']
		current_user.update token: token, secret: secret, name: twitter_name, twitter_id: twitter_id
		redirect_to root_path
	end
end
