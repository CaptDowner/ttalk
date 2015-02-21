class Phrase < ActiveRecord::Base
  belongs_to :language
  has_many :category_phrases
  has_many :categories, through: :category_phrases
end
