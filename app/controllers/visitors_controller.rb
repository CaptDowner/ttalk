class VisitorsController < ApplicationController

  def index
    # @categories = []
    #    @categories = current_user.categories if user_signed_in?
    @categories ||= Category.all
  end

end
