class QueryEvaluator
  def initialize(query)
    @query = query
  end

  def run(model)
    transformed = QueryTransformer.new.apply(QueryParser.new.parse(@query))
    text_search, normal_queries = transformed[:query].partition { |q| q.is_a? QueryNodes::TextSearchNode }
    current = normal_queries.reduce(model) { |full, curr| curr.apply(full) }
    text_search.reduce(current) { |full, curr| curr.apply(full) }
  end
end