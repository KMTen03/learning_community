class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :title, null: false
      t.integer :learning_content, null: false
      t.integer :learning_time, null: false
      t.timestamps
    end
  end
end
