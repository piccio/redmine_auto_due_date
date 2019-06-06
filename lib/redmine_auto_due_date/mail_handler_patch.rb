module RedmineAutoDueDate
  module MailHandlerPatch

    private

    def receive_issue
      issue = super

      if issue.due_date.blank? &&
        issue.project.module_enabled?('create_due_date')

        x = CreateDueDate.where(project_id: issue.project_id).first ||
          Setting.plugin_redmine_auto_due_date['create_due_date'].to_i

        issue.update_attribute(:due_date, Date.today + x.days)
      end

      issue
    end

    def receive_issue_reply(issue_id, from_journal=nil)
      journal = super
      issue = journal.journalized

      if issue.project.module_enabled?('update_due_date') &&
        issue.assigned_to == User.current &&
        issue.status == IssueStatus.find_by(name: 'In Progress')

        y = UpdateDueDate.where(project_id: issue.project_id).first ||
          Setting.plugin_redmine_auto_due_date['update_due_date'].to_i

        issue.update_attribute(:due_date, Date.today + y.days)
      end

      journal
    end

  end
end