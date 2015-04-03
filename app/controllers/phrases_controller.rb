class PhrasesController < ApplicationController
  def index
    @phrases = Phrase.all
  end

  def show
    @phrase = Phrase.find(params[:id])
  end
end
