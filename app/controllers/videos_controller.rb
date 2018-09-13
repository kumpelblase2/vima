class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    order_by = params[:order] || :name
    direction = params[:dir] || 'asc'

    query = params[:search]
    if query and not query.empty?
      @videos = SearchHelper.query(Video.order_by(order_by => direction), query).page(params[:page])
    else
      @videos = Video.order_by(order_by => direction).page(params[:page])
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  def refresh
    CleanupJob.perform_now
    VideoLoadJob.perform_now
  end

  # POST /videos
  # POST /videos.json
  def create
    params = MetadataHelper.fix_metadata_types(video_params)
    @video = Video.new(params)
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    params = MetadataHelper.fix_metadata_types(video_params)
    respond_to do |format|
      if @video.update(params)
        MetadataProviderList.instance.run :video_update, @video
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    VideoHelper.clear_thumbnails @video
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      updateable_parameters = MetadataHelper.get_updatable_parameters
      params.require(:video).permit(:name, :selected_thumbnail, *updateable_parameters)
    end
end
