class MetadataController < ApplicationController
  def keys
    respond_to do |format|
      format.json { render json: MetadataHelper.get_allowed_keys }
    end
  end

  def all
    respond_to do |format|
      format.json { render json: MetadataHelper.get_configured_metadata }
    end
  end
end
