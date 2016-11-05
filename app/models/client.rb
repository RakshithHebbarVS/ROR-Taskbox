class Client < ActiveRecord::Base
   
   acts_as_paranoid
   belongs_to :user
   has_many :project_categories
   has_many :projects , through: :project_categories
   has_many :projects
   validates_presence_of :name, :email, :mobile
   validates_numericality_of :mobile
   validates_length_of :mobile, is: 10
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
   validates_uniqueness_of :email
 
   def list_tasks
      client_task = []
      self.projects.each do |project|
         project.tasks.each do |task|
            client_task.push(task)
         end
      end
      return client_task
   end

   

	def details
		"#{name} - #{company}"
	end
end
