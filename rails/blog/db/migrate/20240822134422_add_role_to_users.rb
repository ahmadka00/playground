class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, null: false, default: User::ROLE_USER
  end
end
