class TasksController < ApplicationController
	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to project_path(@task.project_id) , notice: "Successfully created Task"
		else
			render action :"new"
		end
	end

	def mark_as_complete
		task = Task.find(params[:task_id])
		task.update_attributes(is_completed: true)
		Notification.task_completed(task).deliver
		redirect_to :back, notice: "Successfully completed task"
	end

	
	def mark_as_incomplete
		task = Task.find(params[:task_id])
		task.update_attributes(is_completed: false)
		Notification.task_incompleted(task).deliver
		redirect_to :back, notice: "task not completed"
	end



		def task_params
			params[:task].permit(:title, :project_id, :is_completed, :due_date)
		end
end
