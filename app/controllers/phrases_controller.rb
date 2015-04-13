class PhrasesController < ApplicationController
  def index
    # l gets assigned the language_id of the current_user
    l = Language.where(:abbrv => I18n.locale.to_s).first.id
    @phrases = (Phrase.where(language_id: l)).order("phrase_text").page(params[:page]).per(18)
  end

  def new
    @phrase=Phrase.new
    @categories = Category.all
  end

  def edit
#    requires_admin
    @phrase = Phrase.find(params[:id])
    @categories = Category.all
  end

  def update
#    requires_admin
    @phrase = Phrase.find(params[:id])
    if @phrase.update_attributes(phrase_params)
      redirect_to @phrase, notice: "Phrase successfully updated!"
    else
      render :edit
    end
  end

  def create
    @phrase = Phrase.new(phrase_params)
    if @phrase.save
      redirect_to @phrase, notice: "Phrase successfully created!"
    else
      render :new
    end
  end

  def show
    @phrase = Phrase.find(params[:id])
    @categories = Category.all
  end

  private

  def phrase_params
    params.require(:phrase).permit(:phrase_text, :key, :audio_file, :language_id, category_ids: [])
  end

end
