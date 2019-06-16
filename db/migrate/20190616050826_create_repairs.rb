class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.string :item_type
      t.string :item_name
      t.string :work
      t.integer :cost
      t.string :status
      t.integer :duration
      t.date :start_date

      t.timestamps null: false
    end
  end
end
