class Project < ActiveRecord::Base
  

  has_many :tasks
  has_many :project_categories
  has_many :categories, through: :project_categories

  belongs_to :client
  belongs_to :user
  validates_presence_of :name,:client_id,:start_date
  #when arguments are passed for a method use : before ,and for options for the method we pass : after, the values for the options we pass : before 
  
  validates_length_of :description, minimum:10
  validates_presence_of :status



#custom validations
#this validation will only get invoked at the time of creating a new record, and not updating

#validate :check_status_on_create, on: :create 
validate :check_start_date , on: :create
#validate :check_client, on: :create
validate :check_proj_name , on: :create



def overdue
   self.tasks.where('is_completed =? AND due_date <?',false, Date.today)
end

def incomplete
	self.tasks.where('is_completed =?',false)
end

def complete
	self.tasks.where('is_completed=?',true)
end

def calc_completed
	(self.complete.size/self.tasks.size.to_f) *100
end

def calc_incompleted
	(self.incomplete.size/self.tasks.size.to_f) *100
end

def calc_overdue
	(self.overdue.size/self.tasks.size.to_f) *100
end

private

=begin
def check_status_on_create
	if self.status != "new"
		errors.add(:status,"is not new")
    end
end
=end


def check_start_date
	if !self.start_date.nil?
	 if self.start_date > Date.today + 7.days
		errors.add(:date,"is created greater than 1 week")
    end
 end
end

=begin
def check_client
	no_of_proj=Project.where('client_id = ?', self.client_id).count 
	if no_of_proj >=2 
	 errors.add(:client_id,"more than 2")
	end 

end
=end


def check_proj_name
	proj_name = Project.pluck('name')
	if proj_name.include?(self.name)
		errors.add(:name ,"already exist")
	end
end
end