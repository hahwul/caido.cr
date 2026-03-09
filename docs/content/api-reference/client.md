+++
title = "CaidoClient"
description = "The GraphQL client interface"
weight = 1
+++

## Overview

`CaidoClient` is the main entry point for interacting with Caido's GraphQL API. It wraps a GraphQL client, handles authentication, and provides a single `query` method for executing all operations.

## Constructors

### `.new(endpoint)`

```crystal
CaidoClient.new(endpoint : String)
```

Creates a client with automatic authentication. Reads the `CAIDO_AUTH_TOKEN` environment variable and sets the `Authorization` header automatically.

| Parameter | Type | Description |
|-----------|------|-------------|
| `endpoint` | `String` | The Caido GraphQL API endpoint URL |

```crystal
client = CaidoClient.new("http://localhost:8080/graphql")
```

### `.new(endpoint, headers)`

```crystal
CaidoClient.new(endpoint : String, headers : Hash(String, String))
```

Creates a client with custom headers for authentication or other purposes.

| Parameter | Type | Description |
|-----------|------|-------------|
| `endpoint` | `String` | The Caido GraphQL API endpoint URL |
| `headers` | `Hash(String, String)` | Custom HTTP headers |

```crystal
client = CaidoClient.new(
  "http://localhost:8080/graphql",
  {"Authorization" => "Bearer my-token", "X-Custom" => "value"}
)
```

## Instance Methods

### `#query`

```crystal
client.query(query : String) : JSON::Any
```

Executes a GraphQL query or mutation string and returns the parsed JSON response.

| Parameter | Type | Description |
|-----------|------|-------------|
| `query` | `String` | A GraphQL query or mutation string |

```crystal
query = CaidoQueries::Runtime.info
response = client.query(query)
puts response
```

## Authentication

The client supports two authentication modes:

### Automatic (Environment Variable)

When using the single-argument constructor, the client checks for the `CAIDO_AUTH_TOKEN` environment variable:

```crystal
# Set in your environment:
# export CAIDO_AUTH_TOKEN="your-token"

client = CaidoClient.new("http://localhost:8080/graphql")
# Authorization header is set automatically
```

### Manual (Custom Headers)

When using the two-argument constructor, you provide headers directly:

```crystal
client = CaidoClient.new(
  "http://localhost:8080/graphql",
  {"Authorization" => "Bearer your-token"}
)
```

## Dependencies

`CaidoClient` uses the `crystal-gql` library internally for GraphQL communication. This dependency is installed automatically via `shards install`.
