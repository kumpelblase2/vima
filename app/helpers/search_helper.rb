module SearchHelper
  def self.query(model, query)
    configured_metadata = MetadataHelper.get_configured_metadata
    metadata_hash = MetadataHelper.get_metadata_hash(configured_metadata)
    QueryEvaluator.new(query, metadata_hash).run(model) or model.all
  end
end