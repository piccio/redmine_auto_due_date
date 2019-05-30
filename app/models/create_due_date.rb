class CreateDueDate < ActiveRecord::Base
  validates :project_id, presence: true, uniqueness: true
  validates :days, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end