class SingersController < ApplicationController
  before_action :set_singer, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin?, except: [:index, :show]
  # GET /singers or /singers.json
  def index
    @singers = Singer.all
  end

  # GET /singers/1 or /singers/1.json
  def show
    @albums = Album.where(singer_id: @singer.id).order("created_at DESC")
    a = []
    @albums.each do |album|
        a.push(album.avg_rating(album)) if album.avg_rating(album) > 0
    end
    @avr = a.inject(0.0) { |sum, el| sum + el } / a.size
    @sin = RSpotify::Artist.search(@singer.name).first
    @playlist = RSpotify::Playlist.search("This is #{@singer.name}").first
    @thisis = "https://open.spotify.com/embed/playlist/#{@playlist.id}?utm_source=generator"
    @mostpop = "https://open.spotify.com/embed/track/#{@sin.top_tracks(:US).first.id}?utm_source=generator"
  end

  # GET /singers/new
  def new
    @singer = Singer.new
  end

  # GET /singers/1/edit
  def edit
  end

  # POST /singers or /singers.json
  def create
    @singer = Singer.new(singer_params)
    @singer.user_id = current_user.id
    @singer.avatar = RSpotify::Artist.search(@singer.name).first.images.first["url"] if @singer.name != "Kanye West"
    @singer.avatar = "Снимок экрана от 2022-12-14 17-16-05.png" if @singer.name == "Kanye West"
    respond_to do |format|
      if @singer.save
        format.html { redirect_to singer_url(@singer), notice: (t "singer_create") }
        format.json { render :show, status: :created, location: @singer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @singer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /singers/1 or /singers/1.json
  def update
    respond_to do |format|
      if @singer.update(singer_params)
        format.html { redirect_to singer_url(@singer), notice: (t "singer_update") }
        format.json { render :show, status: :ok, location: @singer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @singer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /singers/1 or /singers/1.json
  def destroy
    @singer.destroy

    respond_to do |format|
      format.html { redirect_to singers_url, notice: (t "singer_destroy") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_singer
      @singer = Singer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def singer_params
      params.require(:singer).permit(:name, :born, :biography, :genres, :inst, :avatar)
    end
end
