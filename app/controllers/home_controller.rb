class HomeController < ApplicationController
  def index
  	@random_card = Card.expired.sample
  end

  def check
  	@card = Card.find(params[:id])
  	@result = @card.translation_correct?(params[:user_text])

  	if @result
  	  flash[:notice] = "Correct!"
  	else
  	  flash[:error] = "Wrong!"
  	end

  	redirect_to root_path
  end
end

