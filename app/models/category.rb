class Category < ActiveRecord::Base
  has_many :category_phrases
  has_many :phrases, through: :category_phrases
end
