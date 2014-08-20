class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.column :name, :string
      t.column :location_id, :int
      t.column :start_date, :date
      t.column :end_date, :date
    end
  end
end
