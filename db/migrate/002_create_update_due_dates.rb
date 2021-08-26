class CreateUpdateDueDates < ActiveRecord::Migration[4.2]
  def change
    create_table :update_due_dates do |t|
      t.references :project, null: false, index: { unique: true }
      t.integer :days, null: false

      t.timestamps null: false
    end
  end
end