class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :content
      t.boolean :completed
      t.datetime :deadline
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
