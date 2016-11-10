module Api
	module V1
		class ClientsController < ApplicationController
			def index
				@clients = current_user.clients
			end

			def show
				@client = current_user.clients.find(params[:id])
			end

		end
	end
end