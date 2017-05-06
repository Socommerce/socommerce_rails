class TwitterController < ApplicationController

	def show
		render text: request.env['omniauth.auth'].to_json
	end
end
