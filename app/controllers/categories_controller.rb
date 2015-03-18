class CategoriesController < ApplicationController
  before_filter: :authenticate_user!
end
