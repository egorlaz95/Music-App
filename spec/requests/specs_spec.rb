require 'rails_helper'

RSpec.describe "Specs", type: :request do

  describe 'GET /input' do
    it 'returns http success' do
      get '/en'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /compute' do
    it 'returns http redirection' do
      routes = ['/en/singers', '/en/albums/top_ranked', '/en/albums/worst_ranked']
      routes.each do |path|
        get path
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
