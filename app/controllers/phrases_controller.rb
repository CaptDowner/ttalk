class PhrasesController < ApplicationController
  def index
    # l gets assigned the language_id of the current_user
    l = Language.where(:abbrv => I18n.locale.to_s).first.id
    @phrases = (Phrase.where(language_id: l)).order("phrase_text").page(params[:page]).per(18)
  end
  
  def new
    @phrase=Phrase.new
  end

  def edit
#    requires_admin
    @phrase = Phrase.find(params[:id])
  end

  def update
#    requires_admin
    @phrase = Phrase.find(params[:id])
    if @phrase.update(phrase_params)
      redirect_to @phrase, notice: "Phrase successfully updated!"
    else
      render :edit
    end
  end

  def show
    @phrase = Phrase.find(params[:id])
  end
end
