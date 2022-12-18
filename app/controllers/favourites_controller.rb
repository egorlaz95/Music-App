class FavouritesController < ApplicationController
  def view
    favourite = Favourite.where(album: Album.find(params[:album]), user: current_user)
    if favourite == []
      Favourite.create(album: Album.find(params[:album]), user: current_user)
      @favourite_exists = true
    else
      favourite.destroy_all
      @favourite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
    redirect_to album_path(Album.find(params[:album]))
  end
end
