class SearchController < ApplicationController
  def search
    if params[:search].present?
      @albums = Album.search(params[:search])
    else
      @albums = Album.all
    end
  end
end
