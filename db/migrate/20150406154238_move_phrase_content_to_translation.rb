class MovePhraseContentToTranslation < ActiveRecord::Migration

  def up
    print "Moving contents of all phrases into translations "
    ActiveRecord::Base.transaction do
      Phrase.unscoped.select(:id, :key).distinct.each do |phrase|
        print "#{phrase.key}: "
        Phrase.where(key: phrase['key']).each do |trans|
          print "."
          phrase.translations.create(
            phrase_text: trans.phrase_text,
            audio_file: trans.audio_file,
            language_id: trans.language_id,
          )
        end
        print "\n"
      end
    end
  end

  def down
    Translation.delete_all
  end
end
