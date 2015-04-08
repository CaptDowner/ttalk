class RemoveRedundantPhrases < ActiveRecord::Migration
  def change
    phrase_ids = []
    Translation.select(:phrase_id).distinct.each do |phrase_id|
      phrase_ids << phrase_id['phrase_id']
    end

    puts Phrase.where('id not in (?)', phrase_ids).count
    fail "done"
  end
end
