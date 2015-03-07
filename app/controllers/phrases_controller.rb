class PhrasesController < ApplicationController
  def new
    @phrase=Phrase.new
  end

  def index
    @phrases = Phrase.where(language_id: 10).order('phrase_text').page(params[:page]).per(20)
  end

  def show
    @phrase = Phrase.find(params[:id])
  end

  def create
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
    @phrase = Phrase.find(params[:id])  
  end

  def update
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
    phrase = Phrase.find(params[:id])
    phrase.destroy
    redirect_to phrases_path, :notice => "Phrase deleted."
  end

end
