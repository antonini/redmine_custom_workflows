require 'csv'

class ChangeCustomWorkflowsDescriptionType < ActiveRecord::Migration
  def self.up
    if table_exists?(:custom_workflows)
      file = "#{Rails.root}/public/workflow_backup.csv"
      custom_workflows = CustomWorkflow.all.to_a
      CSV.open(file, 'w') do |writer|
        custom_workflows.each do |s|
          writer << [s.id, s.before_save, s.name, s.description]
        end
      end
    end
    change_column :custom_workflows, :description, :text, :null => true, :default => nil
  end

  def self.down
  end
end
