class SearchController < ApplicationController
  def search
    @albums = if params[:search].present?
                Album.search(params[:search])
              else
                Album.all
              end
  end
end
