class CreateGardeningTask < ActiveRecord::Migration
  def change
  		create_table :gardening_tasks do |t|
  		t.string :owner	
  		t.string :description
  		t.date :due_date
  		t.timestamps # => created_at updated_at
  	end
  end
end
