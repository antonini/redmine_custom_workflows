class AddMissingCustomWorkflowsPk < ActiveRecord::Migration
  def change
    if table_exists?(:custom_workflows_projects)
      remove_index :custom_workflows_projects, :custom_workflow_id
      remove_index :custom_workflows_projects, :project_id
      change_column_null :custom_workflows_projects, :project_id, false
      change_column_null :custom_workflows_projects, :custom_workflow_id, false
      execute "ALTER TABLE CUSTOM_WORKFLOWS_PROJECTS ADD CONSTRAINT PK_CUSTOM_WORKFLOWS_PROJECTS PRIMARY KEY (PROJECT_ID,CUSTOM_WORKFLOW_ID)"
    end
  end
end
