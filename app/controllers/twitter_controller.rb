class TwitterController < ApplicationController

	def show
		render text: request.env['omniauth.auth'].to_json
		binding.pry
		redirect_to_root_path
	end
end
