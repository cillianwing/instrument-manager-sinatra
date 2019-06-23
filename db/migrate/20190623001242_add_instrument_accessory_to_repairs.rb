class AddInstrumentAccessoryToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :instrument_id, :integer
    add_column :repairs, :accessory_id, :integer
  end
end
