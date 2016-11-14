class ClientsController < ApplicationController
	
	before_action :authenticate_user!
	def index
		@clients = current_user.clients #Client.where('user_id = ?' ,current_user.id)
	end

	def new
		@client = Client.new
	end

	def create
       @client = Client.new(client_params)
       @client.user_id = current_user.id #used to attach this client to the currently logged in user
       @client.gender = determine_gender(@client.name)
       if @client.save 
       	redirect_to clients_path, notice:"Successfully created client"
       else
       	render action: "new"
       end

	end

	def show
		begin

	    @client = current_user.clients.find(params[:id])
		rescue ActiveRecord::RecordNotFound
        redirect_to clients_path, notice: "Record Not Found"
        end

          

	 	 #@projects=Project.where('client_id=?',@client.id)
	  	 @ongoing_projects = Project.where('client_id=? AND status =?',@client.id,"on-going")
	  	 @completed_projects = Project.where('client_id=? AND status=?',@client.id,"completed")

	end


	def edit
		begin
		@client = current_user.clients.find(params[:id])
		rescue ActiveRecord::RecordNotFound
        redirect_to clients_path, notice: "Record Not Found"
    	end
	end

	def update
		@client = current_user.clients.find(params[:id])
		if @client.update_attributes(client_params)
			redirect_to client_path(@client),notice:"Successfully updated client"
		else
			render action:"edit"
		end
	end

	def destroy
		@client = current_user.clients.find(params[:id])
		@client.destroy
		redirect_to clients_path,notice: "Successfully destroyed"
	end

	def export
		@clients = current_user.clients 
	end

	def export_projects
		client = current_user.clients.find(params[:client_id])
	end

	private

	def client_params
		params[:client].permit(:name,:mobile,:website,:company,:email)
	end
  
    def determine_gender(name)
    	response = HTTParty.get("https://www.gender-api.com/get?name=#{name}&key=pRPLCejozFwCHFbVCR")
    	return response.parsed_response["gender"]
    end

end
