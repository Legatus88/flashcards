class Dashboard::CardsController < ApplicationController
  def index
  	@cards = current_user.cards
  end

  def show
  	@cards = Card.find(params[:id])
  end

  def new
    @cards = Card.new
    @collection = current_user.decks
  end

  def edit
    @cards = Card.find(params[:id])
    @collection = current_user.decks
  end

  def create
    @cards = current_user.cards.create(card_params)

    if @cards.save
      redirect_to dashboard_cards_path
    else
      render 'new'
    end
  end

  def update
    @cards = Card.find(params[:id])
 
    if @cards.update(card_params)
      redirect_to dashboard_cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @cards = Card.find(params[:id])
    @cards.destroy
 
    redirect_to dashboard_cards_path
  end

  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :deck_id)
    end
end
