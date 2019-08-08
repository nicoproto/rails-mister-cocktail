class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @dose = Dose.new(dose_strong_params)

    cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = cocktail

    if @dose.save
      redirect_to cocktail_path(cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  def dose_strong_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
