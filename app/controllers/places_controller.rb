class PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def index
  end

  def create
    @place = Place.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def place_params
    params.require(:place).permit(:address)
  end
end
