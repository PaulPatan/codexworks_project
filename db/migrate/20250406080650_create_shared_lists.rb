class CreateSharedLists < ActiveRecord::Migration[8.0]
  def change
    create_table :shared_lists do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :permission

      t.timestamps
    end
  end
end
