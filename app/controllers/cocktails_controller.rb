class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.create(cocktail_strong_params)
    if @cocktail.valid?
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def cocktail_strong_params
    params.require(:cocktail).permit(:name)
  end
end
