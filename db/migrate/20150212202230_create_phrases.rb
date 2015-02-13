class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :txt
      t.string :fname
      t.string :path
      t.string :categories

      t.timestamps null: false
    end
  end
end
