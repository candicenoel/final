class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def destroy
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank?
    return render_not_found(:forbidden) if @place.user != current_user
    @place.destroy
    redirect_to root_path
  end

  def update
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank?
    return render_not_found(:forbidden) if @place.user != current_user
    
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
    @places = Place.all
  end

  def show
    @place = Place.find_by_id(params[:id])
     return render_not_found if @place.blank?
  end

  def edit
    @place = Place.find_by_id(params[:id])
    return render_not_found if @place.blank?
    return render_not_found(:forbidden) if @place.user != current_user
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
    params.require(:place).permit(:address, :facility_maps)
  end

end
