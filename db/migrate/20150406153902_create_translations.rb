class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :phrase_text
      t.string :audio_file
      t.references :language, index: true
      t.references :phrase, index: true
      t.timestamps
    end
    add_foreign_key :translations, :languages
    add_foreign_key :translations, :phrases
  end
end
