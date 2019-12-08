class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def update
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank?
    @place.update_attributes(place_params)

    if @place.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def new
    @place = Place.new
  end

  def index
  end

  def show
    @place = Place.find_by_id(params[:id])
     return render_not_found if @place.blank?
  end

  def edit
    @place = Place.find_by_id(params[:id])
     return render_not_found if @place.blank?
  end

  def create
    @place = current_user.places.create(place_params)
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

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end
end
