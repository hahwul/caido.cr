+++
title = "CaidoClient"
description = "The GraphQL client interface"
weight = 1
+++

## Overview

`CaidoClient` is the main entry point for interacting with Caido's GraphQL API. It POSTs GraphQL documents to the endpoint, handles authentication, and provides a single `query` method for executing all operations.

## Constructors

### `.new(endpoint, token)`

```crystal
CaidoClient.new(endpoint : String, token : String? = nil, connect_timeout : Time::Span? = nil, read_timeout : Time::Span? = nil)
```

Creates a client that sends `Authorization: Bearer <token>`. When `token` is omitted it falls back to the `CAIDO_AUTH_TOKEN` environment variable; with neither, no `Authorization` header is sent.

| Parameter | Type | Description |
|-----------|------|-------------|
| `endpoint` | `String` | The Caido GraphQL API endpoint URL |
| `token` | `String?` | Access token (default: `CAIDO_AUTH_TOKEN`) |
| `connect_timeout` | `Time::Span?` | Connect timeout (default: none) |
| `read_timeout` | `Time::Span?` | Read timeout (default: none) |

```crystal
client = CaidoClient.new("http://localhost:8080/graphql")
```

### `.new(endpoint, headers)`

```crystal
CaidoClient.new(endpoint : String, headers : Hash(String, String), connect_timeout : Time::Span? = nil, read_timeout : Time::Span? = nil)
```

Creates a client with custom headers for authentication or other purposes. `CAIDO_AUTH_TOKEN` is not read.

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
client.query(query : String, variables = {} of String => String) : {JSON::Any?, JSON::Any?, Bool}
```

Executes a GraphQL query or mutation and returns a `{data, errors, loading}` tuple. `data` is the response's `data` entry (`nil` if absent). A response carrying `errors` raises `GraphQLError` instead of returning, so `errors` is `nil` (or an empty/null entry) whenever the call returns.

| Parameter | Type | Description |
|-----------|------|-------------|
| `query` | `String` | A GraphQL query or mutation string |
| `variables` | `Hash` or any JSON-serializable value | Sent as the request's `variables` object, never interpolated into the document |

```crystal
query = CaidoQueries::Runtime.info
data, _errors, _loading = client.query(query)
puts data.try &.["runtime"]
```

## Errors

| Exception | Raised when |
|-----------|-------------|
| `CaidoClient::ConnectionError` | No GraphQL response was produced: connection failure, timeout, TLS error, invalid endpoint, non-2xx status, or a body that is not a JSON object |
| `CaidoClient::GraphQLError` | The server answered with `errors`. `#errors` holds the messages, `#raw_errors` the untouched `errors` entry, `#data` any partial `data` |

Both descend from `CaidoClient::Error`. Endpoint credentials (`https://user:token@host/...`) are redacted from every message.

## Authentication

The client supports two authentication modes:

### Automatic (Environment Variable)

When no `token` is passed, the client checks for the `CAIDO_AUTH_TOKEN` environment variable:

```crystal
# Set in your environment:
# export CAIDO_AUTH_TOKEN="your-token"

client = CaidoClient.new("http://localhost:8080/graphql")
# Authorization header is set automatically
```

### Manual (Custom Headers)

When using the `headers` constructor, you provide headers directly:

```crystal
client = CaidoClient.new(
  "http://localhost:8080/graphql",
  {"Authorization" => "Bearer your-token"}
)
```

## Dependencies

`CaidoClient` uses only the Crystal standard library (`HTTP::Client` and `JSON`); there are no runtime shard dependencies.
