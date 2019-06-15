class CreateInstrumentAccessories < ActiveRecord::Migration
  def change
    create_table :instrument_accessories do |t|
      t.integer :instrument_id
      t.integer :accessory_id

      t.timestamps null: false
    end
  end
end
