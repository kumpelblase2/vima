class SmartPlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = SmartPlaylist.all
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    if @playlist
      @playlist["videos"] = SearchHelper.query(Video, @playlist.query)
    end
  end

  # GET /playlists/new
  def new
    @playlist = SmartPlaylist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = SmartPlaylist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html {redirect_to @playlist, notice: 'Playlist was successfully created.'}
        format.json {render :show, status: :created, location: @playlist}
      else
        format.html {render :new}
        format.json {render json: @playlist.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html {redirect_to @playlist, notice: 'Playlist was successfully updated.'}
        format.json {render :show, status: :ok, location: @playlist}
      else
        format.html {render :edit}
        format.json {render json: @playlist.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html {redirect_to playlists_url, notice: 'Playlist was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def playlist_select
    @playlists = SmartPlaylist.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = SmartPlaylist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:smart_playlist).permit(:name, :query)
    end
end
