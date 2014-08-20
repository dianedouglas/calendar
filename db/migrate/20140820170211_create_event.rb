class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :name, :string
    end
  end
end
