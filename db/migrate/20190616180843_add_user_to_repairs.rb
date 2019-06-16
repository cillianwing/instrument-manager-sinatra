class AddUserToRepairs < ActiveRecord::Migration
  def change
    add_column :repairs, :user_id, :integer
  end
end
