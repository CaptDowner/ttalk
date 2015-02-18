class AddAbbrevToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :abbrev, :integer
  end
end
