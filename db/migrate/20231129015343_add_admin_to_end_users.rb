class AddAdminToEndUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :admin, :boolean, default: false, null: false
  end
end
