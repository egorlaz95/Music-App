require 'rails_helper'

RSpec.describe "Favourites", type: :request do
  describe "GET /view" do
    it "returns http success" do
      get "/favourites/view"
      expect(response).to have_http_status(:success)
    end
  end

end
