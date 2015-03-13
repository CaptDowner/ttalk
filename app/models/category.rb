class Category < ActiveRecord::Base
  has_many :category_phrases
  # http://www.ruby-journal.com/rails-4-changes-join-table-naming-convention/
  has_and_belongs_to_many :phrases, join_table: :category_phrases
#  has_many :phrases, through: :category_phrases
  has_and_belongs_to_many :users

  def populate_by_phrase_key(phrase_key)
    ActiveRecord::Base.transaction do
      Phrase.where(key: phrase_key).each do |phrase|
        phrase.categories << self
      end
    end
  end
end
