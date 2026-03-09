+++
title = "Utils"
description = "Utility functions for query building and security"
weight = 4
+++

## Overview

`CaidoUtils` provides utility functions for building GraphQL query components and protecting against injection attacks.

## String Escaping

### `.escape_graphql_string`

```crystal
CaidoUtils.escape_graphql_string(input : String) : String
```

Escapes special characters in a string to prevent GraphQL injection. Always use this when incorporating user-supplied strings into queries.

| Input Character | Escaped Output |
|----------------|----------------|
| `\` (backslash) | `\\` |
| `"` (double quote) | `\"` |
| newline (`\n`) | `\\n` |
| carriage return (`\r`) | `\\r` |
| tab (`\t`) | `\\t` |
| backspace (`\b`) | `\\b` |
| form feed (`\f`) | `\\f` |

```crystal
safe = CaidoUtils.escape_graphql_string("user \"input\" here\n")
# => "user \\\"input\\\" here\\n"
```

## Pagination

### `.build_pagination`

```crystal
CaidoUtils.build_pagination(first : Int32, after : String = "") : String
```

Constructs a pagination clause for GraphQL queries.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `first` | `Int32` | -- | Number of items to fetch |
| `after` | `String` | `""` | Cursor for the next page |

```crystal
CaidoUtils.build_pagination(first: 10)
# => "first: 10"

CaidoUtils.build_pagination(first: 10, after: "abc123")
# => "first: 10, after: \"abc123\""
```

## Filtering

### `.build_filter_clause`

```crystal
CaidoUtils.build_filter_clause(filter : String) : String
```

Constructs a filter clause for GraphQL queries. Returns an empty string if the filter is empty.

| Parameter | Type | Description |
|-----------|------|-------------|
| `filter` | `String` | The filter expression |

```crystal
CaidoUtils.build_filter_clause(filter: "host:example.com")
# => ", filter: \"host:example.com\""

CaidoUtils.build_filter_clause(filter: "")
# => ""
```

## Array Building

### `.build_string_array`

```crystal
CaidoUtils.build_string_array(items : Array(String)) : String
```

Converts a Crystal string array into a GraphQL string array literal.

| Parameter | Type | Description |
|-----------|------|-------------|
| `items` | `Array(String)` | Array of strings to convert |

```crystal
CaidoUtils.build_string_array(["*.example.com", "api.test.com"])
# => "[\"*.example.com\", \"api.test.com\"]"
```

## Optional Strings

### `.build_optional_string`

```crystal
CaidoUtils.build_optional_string(value : String) : String
```

Creates an optional quoted string argument. Returns an empty string if the value is empty.

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | `String` | The string value |

```crystal
CaidoUtils.build_optional_string("my-value")
# => "\"my-value\""

CaidoUtils.build_optional_string("")
# => ""
```
