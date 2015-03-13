class PhrasesController < ApplicationController
  include Authenticable
# before_action :require_signin, except: [:index, :show]
# before_action :require_admin, except: [:index, :show]
  before_action :set_phrase, only: [:show, :edit, :update, :destroy]

  def new
    @phrase=Phrase.new
  end

  def index
    @phrases = Phrase.where(language_id: 10).order('phrase_text').page(params[:page]).per(20)
  end

  def show
    @phrase = Phrase.find(params[:id])
  end

  def get_category(cat)
    # I need to do a result set with the following conditions:
    # a language, a category, and possible a user_id
    # each phrase has a language_id and the correlation between
    # category and phrases is kept in the category_phrases table

    @phrases= Phrase.where(id: CategoryPhrase.where(category_id = cat).phrase_id)
  end

  def create
    requires_admin
    @phrase=  Phrase.create( phrase_params )
   if @phrase.save
     respond_to do |format|
     flash[:notice] = 'Phrase was successfully created.'
     format.html { redirect_to phrases_path }
    end
    else
      render :action => :new
    end
  end

  def edit
    requires_admin
    @phrase = Phrase.find(params[:id])  
  end

  def update
    requires_admin
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

  def destroy
    requires_admin
    phrase = Phrase.find(params[:id])
    phrase.destroy
    redirect_to phrases_path, :notice => "Phrase deleted."
  end

private

  def phrase_params
    params.require(:phrase).permit(:phrase_text, :audio_file, :key, :language_id)
  end

  def set_phrase
    @phrase = Phrase.where(id: params[:id])
  end
end
