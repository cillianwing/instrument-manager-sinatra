class DeleteTypeOfFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :type_of, :string
  end
end
