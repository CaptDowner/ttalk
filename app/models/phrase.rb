class Phrase < ActiveRecord::Base
  paginates_per 30
  belongs_to :language
  has_many :category_phrases
  has_many :categories, through: :category_phrases
end
