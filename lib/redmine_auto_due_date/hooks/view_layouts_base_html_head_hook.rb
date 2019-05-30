module RedmineAutoDueDate
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context)
        stylesheet_link_tag(:application, plugin: 'redmine_auto_due_date')
      end
    end
  end
end