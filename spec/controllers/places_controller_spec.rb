require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe "places#show action" do
    it "should successfully show the page if the place is found" do
      place = FactoryBot.create(:place)
      get :show, params: { id: place.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the place is not found" do
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "places#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "places#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "places#create action" do

    it "should require users to be logged in" do
      post :create, params: { place: { address: '595 S. Clinton St, Denver, CO 80247' } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new place in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { place: { address: '595 S. Clinton St, Denver, CO 80247' } }
      expect(response).to redirect_to root_path

      place = Place.last
      expect(place.address).to eq('595 S. Clinton St, Denver, CO 80247')
      expect(place.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      place_count = Place.count
      post :create, params: { place: { address: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(place_count).to eq Place.count
    end
  end
end
