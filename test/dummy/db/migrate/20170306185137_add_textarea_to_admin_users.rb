class AddTextareaToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :textarea, :text
  end
end
