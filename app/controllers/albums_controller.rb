require 'rspotify'
class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index]
  before_action :is_admin?, except: [:index, :show, :top_ranked, :worst_ranked]

  def top_ranked
    @albums = Album.all
    @ar = []
    @albums.each do |album|
      ax = []
      ax.push(album, album.avg_rating(album)) 
      @ar.push(ax) if album.avg_rating(album) > 0.0
    end
    @ar = @ar.sort_by{|a| -a[1]}
  end

  def worst_ranked
    @albums = Album.all
    @ar = []
    @albums.each do |album|
      ax = []
      ax.push(album, album.avg_rating(album)) 
      @ar.push(ax) if album.avg_rating(album) > 0.0
    end
    @ar = @ar.sort_by{|a| a[1]}
  end

  def index
    @albums = Album.all.order("created_at DESC")
  end

  # GET /albums/1 or /albums/1.json
  def show
    @reviews = Review.where(album_id: @album.id).order("created_at DESC")
    if @reviews.length == 0
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
    @alb = RSpotify::Album.search(@album.title).first
    @link = "https://open.spotify.com/embed/album/#{@alb.id}?utm_source=generator"
  end

  # GET /albums/new
  def new
    @album = current_user.albums.build
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums or /albums.json
  def create
    @album = current_user.albums.build(album_params)
    if Singer.find_by(name: @album.artist)
      @singer = Singer.find_by(name: @album.artist)
      @album.singer_id = @singer.id
      @album.cover = RSpotify::Album.search(@album.title).first.images.first["url"] 
      respond_to do |format|
        if @album.save
          format.html { redirect_to album_url(@album), notice: (t "album_create") }
          format.json { render :show, status: :created, location: @album }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, notice: (t "album_error")
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to album_url(@album), notice: (t "album_update") }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: (t "album_destroy") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title, :artist, :cover)
    end
end
