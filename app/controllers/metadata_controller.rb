class MetadataController < ApplicationController
  def keys
    respond_to do |format|
      format.json { render json: VideoHelper.get_allowed_metadata_keys }
    end
  end

  def all
    respond_to do |format|
      format.json { render json: VideoHelper.get_configured_metadata }
    end
  end
end
