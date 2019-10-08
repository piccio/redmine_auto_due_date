module RedmineAutoDueDate
  module IssuePatch

    def self.prepended(base)
      base.after_create :set_due_date
    end

    private

    def set_due_date
      prerequisites = self.project.module_enabled?('create_due_date') &&
        self.due_date.blank?
      extension = CreateDueDate.where(project_id: self.project_id).first ||
        Setting.plugin_redmine_auto_due_date['create_due_date'].to_i

      if prerequisites
        self.init_journal(User.first)
        self.current_journal.notify = false
        self.update_attribute(:due_date, Date.today + extension.days)
      end
    end

  end
end