require "crystal-gql"

class CaidoClient
  @instance : GraphQLClient

  # Initialize with optional auth token (falls back to CAIDO_AUTH_TOKEN env var)
  def initialize(@endpoint : String, token : String? = nil)
    @instance = GraphQLClient.new endpoint

    auth_token = token || ENV["CAIDO_AUTH_TOKEN"]?
    if auth_token
      @instance.headers["Authorization"] = "Bearer #{auth_token}"
    end
  end

  # Initialize with custom headers
  def initialize(@endpoint : String, headers : Hash(String, String))
    @instance = GraphQLClient.new endpoint, headers
  end

  def query(query : String)
    @instance.query query
  end
end
