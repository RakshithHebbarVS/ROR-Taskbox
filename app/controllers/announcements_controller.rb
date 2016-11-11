class AnnouncementsController < ApplicationController

	before_action :authenticate_user!

	def index
		@announcements = current_user.announcements
	end

	def new
		@announcement = Announcement.new
	end

	def create
       @announcement = Announcement.new(announcement_params)
       if @announcement.save 
       	 Notification.on_create(@announcement).deliver
       	redirect_to announcements_path, notice:"Successfully created announcement"
       else
       	render action: "new"
       end

	end



    private
	def announcement_params
		params[:announcement].permit(:title,:body,:user_id)
	end

end
