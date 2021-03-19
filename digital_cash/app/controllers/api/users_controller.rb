class Api::UsersController < ApiController
	skip_before_action :authorize_request, only: %i[greeting]

	def greeting
	  json_response({ rails_version: '5.2', ruby_version: '2.6', msg: 'E aí! Tamo em produção! Wagnão!' }, :ok)
	end 
end
