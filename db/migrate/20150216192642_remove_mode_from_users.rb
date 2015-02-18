class RemoveModeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :mode, :integer
  end
end
