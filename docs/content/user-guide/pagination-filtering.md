+++
title = "Pagination & Filtering"
description = "Built-in utilities for paginated and filtered queries"
weight = 5
+++

## Overview

caido.cr provides utility functions in `CaidoUtils` to build pagination and filter clauses for GraphQL queries. These are used internally by the query helpers and can also be used when building custom queries.

## Pagination

Many Caido queries support cursor-based pagination with `first` and `after` parameters:

```crystal
# First page
query = CaidoQueries::Requests.all(first: 20)
response = client.query(query)

# Next page using cursor
query = CaidoQueries::Requests.all(first: 20, after: "cursor-from-previous-response")
response = client.query(query)
```

### Building Pagination Clauses

Use `CaidoUtils.build_pagination` to construct pagination arguments:

```crystal
# With first only
clause = CaidoUtils.build_pagination(first: 10)
# => "first: 10"

# With first and after
clause = CaidoUtils.build_pagination(first: 10, after: "cursor123")
# => "first: 10, after: \"cursor123\""
```

### Offset-Based Pagination

Some queries support offset-based pagination:

```crystal
query = CaidoQueries::Requests.by_offset(offset: 0, limit: 50, filter: "")
response = client.query(query)
```

## Filtering

Filter queries using Caido's filter syntax:

```crystal
# Filter requests by host
query = CaidoQueries::Requests.all(first: 10, filter: "host:example.com")
response = client.query(query)

# Filter intercept entries
query = CaidoQueries::Intercept.entries(first: 10, filter: "method:POST")
response = client.query(query)
```

### Building Filter Clauses

Use `CaidoUtils.build_filter_clause` to construct filter arguments:

```crystal
# With filter
clause = CaidoUtils.build_filter_clause(filter: "host:example.com")
# => ", filter: \"host:example.com\""

# Empty filter
clause = CaidoUtils.build_filter_clause(filter: "")
# => ""
```

## Security: String Escaping

When passing user-supplied strings into queries, always use `CaidoUtils.escape_graphql_string` to prevent GraphQL injection:

```crystal
user_input = "test\"injection"
safe_input = CaidoUtils.escape_graphql_string(user_input)
# => "test\\\"injection"
```

The function escapes the following characters:

| Character | Escaped |
|-----------|---------|
| `\` (backslash) | `\\` |
| `"` (double quote) | `\"` |
| newline | `\n` |
| carriage return | `\r` |
| tab | `\t` |
| backspace | `\b` |
| form feed | `\f` |

## Utility Functions

### `build_string_array`

Builds a GraphQL string array from a Crystal array:

```crystal
result = CaidoUtils.build_string_array(["*.example.com", "api.test.com"])
# => "[\"*.example.com\", \"api.test.com\"]"
```

### `build_optional_string`

Creates an optional string argument for GraphQL:

```crystal
result = CaidoUtils.build_optional_string("my-value")
# => "\"my-value\""

result = CaidoUtils.build_optional_string("")
# => ""
```
