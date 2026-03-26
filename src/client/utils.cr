# Utility functions for Caido client

module CaidoUtils
  # Escapes a string for safe use in GraphQL queries
  # Prevents GraphQL injection attacks by escaping special characters
  def self.escape_graphql_string(value : String) : String
    String.build(value.bytesize) do |io|
      value.each_char do |char|
        case char
        when '\\'  then io << "\\\\"
        when '"'   then io << "\\\""
        when '\n'  then io << "\\n"
        when '\r'  then io << "\\r"
        when '\t'  then io << "\\t"
        when '\b'  then io << "\\b"
        when '\f'  then io << "\\f"
        else
          if char.ord < 0x20
            io << "\\u"
            io << char.ord.to_s(16).rjust(4, '0')
          else
            io << char
          end
        end
      end
    end
  end

  # Helper to build pagination clauses
  def self.build_pagination(after : String? = nil, first : Int32? = nil, before : String? = nil, last : Int32? = nil) : String
    clauses = [] of String
    clauses << %Q(after: "#{escape_graphql_string(after)}") if after
    clauses << "first: #{first}" if first
    clauses << %Q(before: "#{escape_graphql_string(before)}") if before
    clauses << "last: #{last}" if last
    clauses.join(" ")
  end

  # Helper to build optional update fields for mutations
  def self.build_optional_fields(fields : Array(Tuple(String, String?))) : Array(String)
    parts = [] of String
    fields.each do |key, value|
      parts << %Q(#{key}: "#{escape_graphql_string(value)}") if value
    end
    parts
  end

  # Helper to build filter clause
  def self.build_filter_clause(filter : String?) : String
    filter ? %Q(filter: "#{escape_graphql_string(filter)}") : ""
  end

  # Helper to build an array of strings for GraphQL
  def self.build_string_array(items : Array(String)) : String
    items.map { |item| %Q("#{escape_graphql_string(item)}") }.join(", ")
  end

  # Helper to build optional string argument
  def self.build_optional_string(key : String, value : String?) : String?
    value ? %Q(#{key}: "#{escape_graphql_string(value)}") : nil
  end
end
