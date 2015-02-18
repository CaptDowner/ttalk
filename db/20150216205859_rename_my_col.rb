class RenameMyCol < ActiveRecord::Migration
  def self.up
    rename_column :phrases, :audio_path, :audio_file
  end

  def self.down
    rename_column :phrases, :audio_file, :audio_path
  end
end
