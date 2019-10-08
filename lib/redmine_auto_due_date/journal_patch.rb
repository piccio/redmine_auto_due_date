module RedmineAutoDueDate
  module JournalPatch

    def self.prepended(base)
      base.after_create :set_due_date
    end

    private

    def set_due_date
      issue = self.issue

      unless issue.nil?
        prerequisites = issue.project.module_enabled?('update_due_date') &&
          issue.assigned_to == User.current &&
          issue.status == IssueStatus.find_by(name: 'In Progress')
        extension = UpdateDueDate.where(project_id: issue.project_id).first ||
          Setting.plugin_redmine_auto_due_date['update_due_date'].to_i

        if prerequisites
          issue.init_journal(User.first)
          issue.current_journal.notify = false
          issue.update_attribute(:due_date, Date.today + extension.days)
        end
      end
    end

  end
end