class CreateCategoryPhrases < ActiveRecord::Migration
  def change
    create_table :category_phrases do |t|
      t.references :category, index: true
      t.references :phrase, index: true

      t.timestamps null: false
    end
    add_foreign_key :category_phrases, :categories
    add_foreign_key :category_phrases, :phrases
  end
end
