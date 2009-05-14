class CreateRolesUsersTable < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.integer :role_id
      t.integer :user_id
      t.timestamps
    end

  end

  def self.down
    drop_table :roles_users
  end
end
