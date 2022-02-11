class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.float :price
      t.date :deadline
      t.integer :status
      t.integer :project_id
      

      t.timestamps
    end
  end
end
