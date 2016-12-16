class AddColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :end_date, :Date
  end
end
