class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :type
      t.string :make
      t.string :model
      t.string :status
      t.string :status_comments
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
