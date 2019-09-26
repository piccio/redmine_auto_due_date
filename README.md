redmine_auto_due_date
=

when creating a ticket set the due date, if empty, to (today + X days).

when the assignee updates a ticket and if the status is in progress update the due date to (today + Y days); if the assignee is empty then do nothing.

X and Y have a default global value and a project's local value that override the global one. 

the default global value is configurable only by admin, the project's local value have a set of permission to operate to it.

these 2 features are project's modules that could be enabled or not.

if module is enabled and the global value is left empty then it will be equal to 0.

use version 1.x on redmine 3.x (tested on redmine 3.4.4)

use version 2.x on redmine 4.x (tested on redmine 4.0.4)

#####TO DO:
assignee and in progress constraints could be configurable.
