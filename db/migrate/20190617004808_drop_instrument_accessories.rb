class DropInstrumentAccessories < ActiveRecord::Migration
  def change
    drop_table :instrument_accessories
  end
end
