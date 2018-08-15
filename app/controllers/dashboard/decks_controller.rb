class Dashboard::DecksController < ApplicationController
  def index
    @decks = current_user.decks
    @current_deck = if current_user.current_deck.nil?
                      "#{t('common.no_deck')}"
                    else
                      current_user.current_deck.title
                    end
  end

  def show
  end

  def new
    @decks = Deck.new
  end

  def create
    @decks = current_user.decks.create(deck_params)

    if @decks.save
      redirect_to dashboard_decks_path
    else
      render 'new'
    end
  end

  def edit
    @decks = Deck.find(params[:id])
  end

  def update
    @decks = Deck.find(params[:id])
 
    if @decks.update(deck_params)
      redirect_to decks_path
    else
      render 'edit'
    end
  end

  def destroy
    @decks = Deck.find(params[:id])
    @decks.destroy
 
    redirect_to decks_path
  end

  private
    def deck_params
      params.require(:deck).permit(:title)
    end
end