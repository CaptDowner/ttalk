class Phrase < ActiveRecord::Base
  default_scope { order('phrase_text ASC') }
  paginates_per 22
  belongs_to :language
  has_many :category_phrases
  has_many :translations
  # http://www.ruby-journal.com/rails-4-changes-join-table-naming-convention/
  has_and_belongs_to_many :categories, join_table: :category_phrases
#  has_many :categories, through: :category_phrases

  module Kamanari
    def total_pages
      total_pages = self.total_pages
    end
  end
end
