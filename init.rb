require 'redmine_auto_due_date/hooks/view_layouts_base_html_head_hook'
require 'redmine_auto_due_date/issue_patch'
require 'redmine_auto_due_date/journal_patch'

Rails.configuration.to_prepare do
  unless Issue.included_modules.include? RedmineAutoDueDate::IssuePatch
    Issue.prepend(RedmineAutoDueDate::IssuePatch)
  end

  unless Journal.included_modules.include? RedmineAutoDueDate::JournalPatch
    Journal.prepend(RedmineAutoDueDate::JournalPatch)
  end
end

Redmine::Plugin.register :redmine_auto_due_date do
  name 'Redmine Auto Due Date'
  author 'Roberto Piccini'
  description "when creating a ticket set the due date, if empty, to (today + X days). when the assignee updates a ticket and if the status is 'in progress' update the due date to (today + Y days)"
  version '2.1.1'
  url 'https://github.com/piccio/redmine_auto_due_date'
  author_url 'https://github.com/piccio'

  settings default: { 'create_due_date' => nil, 'update_due_date' => nil }, partial: 'settings/auto_due_date'

  project_module :create_due_date do
    permission :view_create_due_dates, create_due_dates: [:show], require: :member
    permission :manage_create_due_dates, create_due_dates: [:new, :create, :edit, :update, :destroy], require: :member
  end

  project_module :update_due_date do
    permission :view_update_due_dates, update_due_dates: [:show], require: :member
    permission :manage_update_due_dates, update_due_dates: [:new, :create, :edit, :update, :destroy], require: :member
  end

  menu :project_menu, :create_due_dates, { controller: 'create_due_dates', action: 'show' },
       caption: Proc.new { I18n.t(:create_due_date_menu_title, scope: :auto_due_date) }, before: :settings,
       param: :project_id

  menu :project_menu, :update_due_dates, { controller: 'update_due_dates', action: 'show' },
       caption: Proc.new { I18n.t(:update_due_date_menu_title, scope: :auto_due_date) }, before: :settings,
       param: :project_id
end
