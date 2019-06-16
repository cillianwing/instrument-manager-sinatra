class UpdateTypeForAll < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :type, :string
    add_column :users, :type_of, :string
    remove_column :instruments, :type, :string
    add_column :instruments, :type_of, :string
    remove_column :accessories, :type, :string
    add_column :accessories, :type_of, :string
  end
end
