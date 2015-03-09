class AddLanguageIdToUsersTable < ActiveRecord::Migration
  def change
    remove_column :users, :language_id
    add_reference :users, :language, index: true
  end
end
