class QueryEvaluator
  def initialize(query, keys)
    @query = query.strip
    @metadata = keys
  end

  def run(model)
    transformed = QueryTransformer.new.apply(QueryParser.new.parse(@query))
    applicable_queries = transformed[:query].select { |node| node.is_applicable?(@metadata) }
    as_selectors = applicable_queries.map { |elem| elem.apply(model, @metadata).selector }
    model.and(*as_selectors)
  end
end
