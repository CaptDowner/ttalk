class AddKeyToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :key, :string
  end
end
