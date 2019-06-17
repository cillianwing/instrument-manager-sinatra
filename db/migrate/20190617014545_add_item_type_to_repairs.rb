class AddItemTypeToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :item_type, :string
  end
end
