class AddModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mode, :integer
  end
end
