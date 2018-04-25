require 'csv'

class AddBeforeAndAfterDestroyToCustomWorkflows < ActiveRecord::Migration
  def change
    add_column :custom_workflows, :before_destroy, :text, :null => true
    add_column :custom_workflows, :after_destroy, :text, :null => true

    file = "#{Rails.root}/public/workflow_backup.csv"
    if File.exist?(file)
      csv_text = File.read(file)
      csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers => false)
      csv.each do |row|
        workflow = CustomWorkflow.where(:id => row[0]).first
        unless workflow.nil?
          workflow.update_attribute(:before_save, row[1])
          workflow.update_attribute(:description, row[3])
        end
      end
    end
  end
end
