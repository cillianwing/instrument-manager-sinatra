class DeleteTypeOfFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :type_of, :string
  end
end
