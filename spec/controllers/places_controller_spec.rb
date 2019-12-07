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
      post :create, params: { place: { name: '' } }
      expect(response).to redirect_to root_path

      place = Place.last
      expect(place.name).to eq('')
    end
  end
end
