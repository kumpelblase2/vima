require 'parslet'

# Possible Queries:
#   type:anime
#   type:"Anime"
#   type:anime OR type:ova
#   type:anime AND type:"Anime"
#   "All of this"
#   either of these
#   rating>1 AND rating<8
#   +watched OR -watched
#   ((((abc:123)) AND def:123))
#


class QueryParser < Parslet::Parser
  def joining(joining_rule, separator)
    joining_rule >> (separator >> joining_rule).repeat
  end

  rule(:ws) { str(' ') }

  rule(:key) { match('[a-zA-Z_]').repeat(1).as(:key) }

  rule(:propertyValue) { match('[a-zA-Z0-9_]').repeat(1) }
  rule(:quotedValue) { str('"') >> match('[^\']').repeat >> str('"') }

  rule(:exactText) { str('"') >> match('[a-zA-Z0-9\'\-+_ ]').repeat >> str('"') }
  rule(:simpleText) { match('[a-zA-Z0-9]').repeat }
  rule(:text) { (exactText.as(:exact) | simpleText.as(:simple)).as(:text) }

  rule(:property) { (key >> str(':') >> (quotedValue | propertyValue).as(:value)).as(:property) }

  rule(:number) { match('[0-9]').repeat(1) }
  rule(:date) { number >> str('-') >> number >> str('-') >> number }
  rule(:smallerRange) { key >> str('<') >> (date.as(:date_value) | number.as(:value)) }
  rule(:biggerRange) { key >> str('>') >> (date.as(:date_value) | number.as(:value)) }
  rule(:range) { (smallerRange.as(:smallerRange) | biggerRange.as(:biggerRange)).as(:range) }

  rule(:inclusion) { str('+') >> key }
  rule(:exclusion) { str('-') >> key }
  rule(:boolean) { (inclusion.as(:inclusion) | exclusion.as(:exclusion)).as(:boolean) }

  rule(:element) { boolean | property | range | text }

  rule(:andOp) { str('AND') }
  rule(:orOp) { str('OR') }

  rule(:orExpr) { (andExpr.as(:left) >> ws >> orOp >> ws >> orExpr.as(:right)).as(:or) | andExpr }
  rule(:andExpr) { (expr.as(:left) >> ws >> andOp >> ws >> andExpr.as(:right)).as(:and) | expr }
  rule(:expr) { (str('(') >> joining(orExpr, ws) >> str(')')) | element }

  rule(:fullexpr) { joining(orExpr, ws).as(:query) }

  root :fullexpr
end
