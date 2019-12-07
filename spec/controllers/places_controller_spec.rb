require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe "places#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "places#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "places#create action" do
    it "should successfully create a new place in our database" do
      post :create, params: { place: { address: '' } }
      expect(response).to redirect_to root_path

      place = Place.last
      expect(place.address).to eq('')
    end

    it "should properly deal with validation errors" do
      post :create, params: { place: { address: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Place.count).to eq 0
    end
  end
end
