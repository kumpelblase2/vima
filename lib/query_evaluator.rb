class QueryEvaluator
  def initialize(query, keys)
    @query = query
    @metadata = keys
  end

  def run(model)
    transformed = QueryTransformer.new.apply(QueryParser.new.parse(@query))
    text_search, normal_queries = transformed[:query].select { |node| node.is_applicable?(@metadata) }.partition { |q| q.is_a? QueryNodes::TextSearchNode }
    current = normal_queries.map { |elem| elem.apply(model, @metadata).selector }
    text_queries = text_search.map { |elem| elem.apply(model, @metadata).selector }
    full_selectors = current + text_queries
    model.and(*full_selectors)
  end
end
