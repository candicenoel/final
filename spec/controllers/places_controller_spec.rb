require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
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
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
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
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      post :create, params: { place: { address: '' } }
      expect(response).to redirect_to root_path

      place = Place.last
      expect(place.address).to eq('')
      expect(place.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      place_count = Place.count
      post :create, params: { place: { address: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(place_count).to eq Place.count
    end
  end
end
