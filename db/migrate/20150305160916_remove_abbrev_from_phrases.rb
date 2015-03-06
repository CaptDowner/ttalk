class RemoveAbbrevFromPhrases < ActiveRecord::Migration
  def change
    remove_column :phrases, :abbrev, :integer
  end
end
