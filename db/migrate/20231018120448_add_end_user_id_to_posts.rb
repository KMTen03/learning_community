class AddEndUserIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :end_user_id, :integer
  end
end
