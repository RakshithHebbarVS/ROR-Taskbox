class ChangeColumnTypesProjects < ActiveRecord::Migration
  def change
  	#change_column :projects , :budget, :float
  	remove_column :projects, :budget, :float
  	add_column :projects, :budget, :float
  end
end
