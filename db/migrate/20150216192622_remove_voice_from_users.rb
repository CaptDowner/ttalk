class RemoveVoiceFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :voice, :integer
  end
end
