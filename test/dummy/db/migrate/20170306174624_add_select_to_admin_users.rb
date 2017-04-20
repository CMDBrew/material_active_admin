class AddSelectToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :select, :string
  end
end
