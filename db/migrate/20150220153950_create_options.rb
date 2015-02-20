class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :user_id
      t.string :voice
      t.string :lang_abbrv

      t.timestamps null: false
    end
  end
end
