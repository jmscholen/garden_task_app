class RemoveOwnerColumn < ActiveRecord::Migration
  def change
  	remove_column :gardening_tasks, :owner
  end
end
