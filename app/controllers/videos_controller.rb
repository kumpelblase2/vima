class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    order_by = params[:order] || default_ordering
    direction = params[:dir] || default_ordering_direction

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
    Rails.cache.delete_matched("values_*")
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
    Rails.cache.delete_matched("values_*")
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
    Rails.cache.delete_matched("values_*")
    VideoHelper.clear_thumbnails @video
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_all
    Rails.cache.delete_matched("values_*")
    included_names = params[:include] || []
    video_ids = params[:videoIds]
    videos = Video.find(video_ids)

    update_params = MetadataHelper.fix_metadata_types(video_params).select {|k, _| included_names.member?(k)}
    array_params = update_params.select { |_,v| v.is_a?(Array) }
    non_array_params = update_params.reject { |_,v| v.is_a?(Array) }
    videos.each do |v|
      v.assign_attributes(non_array_params)
      array_params.each do |key, value|
        v[key] = (v[key] + value).uniq
      end
      v.save
    end

    redirect_to params[:redirect_to]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    def default_ordering
      Rails.configuration.library.fetch("defaults", Hash.new).fetch("order_by", :name)
    end

    def default_ordering_direction
      Rails.configuration.library.fetch("defaults", Hash.new).fetch("order_direction", :asc)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      updateable_parameters = MetadataHelper.get_updatable_parameters
      params.require(:video).permit(:name, :selected_thumbnail, *updateable_parameters)
    end
end
