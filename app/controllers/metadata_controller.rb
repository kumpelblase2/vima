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

  def values
    metadata_name = params[:name]
    values = Rails.cache.fetch("values_" + metadata_name) do
      MetadataHelper.get_values_for_metadata(metadata_name)
    end
    respond_to do |format|
      format.json {render json: values}
    end
  end
end
