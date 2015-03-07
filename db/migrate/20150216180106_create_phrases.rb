class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :phrase_text
      t.string :audio_file
      t.references :language, index: true

      t.timestamps null: false
    end
    add_foreign_key :phrases, :languages
  end
end
