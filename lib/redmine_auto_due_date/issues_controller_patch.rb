module RedmineAutoDueDate
  module IssuesControllerPatch

    private

    def build_new_issue_from_params
      super

      if action_name == 'create' &&
        @issue.due_date.blank? &&
        @issue.project.module_enabled?('create_due_date')

        x = CreateDueDate.where(project_id: @issue.project_id).first ||
          Setting.plugin_redmine_auto_due_date['create_due_date'].to_i

        @issue.due_date = Date.today + x.days
      end
    end

    def update_issue_from_params
      return unless super

      if @issue.project.module_enabled?('update_due_date') &&
        @issue.assigned_to == User.current &&
        @issue.status == IssueStatus.find_by(name: 'In Progress')

        y = UpdateDueDate.where(project_id: @issue.project_id).first ||
          Setting.plugin_redmine_auto_due_date['update_due_date'].to_i

        @issue.due_date = Date.today + y.days
      end

      true
    end

  end
end