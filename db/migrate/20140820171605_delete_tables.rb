class DeleteTables < ActiveRecord::Migration
  def change
    remove_column :locations, :location_id, :integer
    remove_column :locations, :start_date, :date
    remove_column :locations, :end_date, :date
    add_column :events, :location_id, :integer
    add_column :events, :start_date, :date
    add_column :events, :end_date, :date
  end
end
