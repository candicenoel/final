require 'rails_helper'

RSpec.describe PlacesController, type: :controller do

  describe "places#destroy action" do
    it "should allow a user to destroy places" do
      place = FactoryBot.create(:place)
      delete :destroy, params: { id: place.id }
      expect(response).to redirect_to root_path
      place = Place.find_by_id(place.id)
      expect(place).to eq nil
    end

    it "should return a 404 message if we cannot find a place with the id that is specified" do
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "places#update action" do
    it "should allow users to successfully update places" do
      place = FactoryBot.create(:place, address: 'Initial Value')
      patch :update, params: { id: place.id, place: { address: 'Changed' } }
      expect(response).to redirect_to root_path
      place.reload
      expect(place.address).to eq 'Changed'
    end

    it "should have http 404 error if the place cannot be found" do
      patch :update, params: { id: "YOLOSWAG", place: { address: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      place = FactoryBot.create(:place, address: 'Initial Value')
      patch :update, params: { id: place.id, place: { address: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      place.reload
      expect(place.address).to eq 'Initial Value'
    end
  end

  describe "places#edit action" do
    it "should successfully show the edit form if the place is found" do
      place = FactoryBot.create(:place)
      get :edit, params: { id: place.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the place is not found" do
      get :edit, params: { id: 'SWAG' }
      expect(response).to have_http_status(:not_found)
    end
  end

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
      post :create, params: { place: { address: '' } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new place in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { place: { address: '' } }
      expect(response).to redirect_to root_path

      place = Place.last
      expect(place.address).to eq('')
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
