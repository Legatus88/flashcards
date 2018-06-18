class CardsControllerController < ApplicationController
  def index
  	@cards = Card.all
  end

  def show
  	@cards = Card.find(params[:id])
  end

  def new
    @cards = Card.new
  end

  def edit
    @cards = Card.find(params[:id])
  end

  def create
    @cards = Card.new(card_params)
 
    if @cards.save
      redirect_to '/cards'
    else
      render 'new'
    end
  end

  def update
    @cards = Card.find(params[:id])
 
    if @cards.update(card_params)
      redirect_to '/cards'
    else
      render 'edit'
    end
  end

  def destroy
    @cards = Card.find(params[:id])
    @cards.destroy
 
    redirect_to cards_path
  end

  private
  
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
