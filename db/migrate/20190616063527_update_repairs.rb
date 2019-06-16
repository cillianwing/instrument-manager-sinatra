class UpdateRepairs < ActiveRecord::Migration
  def change
    remove_column :repairs, :item_type, :string
  end
end
