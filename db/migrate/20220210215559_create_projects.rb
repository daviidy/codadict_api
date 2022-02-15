class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.boolean :status
      t.text :description
      t.float :budget
      t.boolean :visibility
      t.integer :user_id
      
      t.timestamps
    end
  end
end
