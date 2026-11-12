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
| newline (`\n`) | `\n` |
| carriage return (`\r`) | `\r` |
| tab (`\t`) | `\t` |
| backspace (`\b`) | `\b` |
| form feed (`\f`) | `\f` |
| other control characters (U+0000 to U+001F) | `\u00XX` |

```crystal
safe = CaidoUtils.escape_graphql_string("user \"input\" here\n")
# => "user \\\"input\\\" here\\n"
```

## Pagination

### `.build_pagination`

```crystal
CaidoUtils.build_pagination(after : String? = nil, first : Int32? = nil, before : String? = nil, last : Int32? = nil) : String
```

Constructs a pagination clause for GraphQL queries. Omitted (`nil`) arguments are left out; cursors are escaped.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `after` | `String?` | `nil` | Cursor to page forward from |
| `first` | `Int32?` | `nil` | Number of items after `after` |
| `before` | `String?` | `nil` | Cursor to page backward from |
| `last` | `Int32?` | `nil` | Number of items before `before` |

```crystal
CaidoUtils.build_pagination(first: 10)
# => "first: 10"

CaidoUtils.build_pagination(first: 10, after: "abc123")
# => "after: \"abc123\" first: 10"
```

## Filtering

### `.build_filter_clause`

```crystal
CaidoUtils.build_filter_clause(filter : String?) : String
```

Constructs a filter clause for GraphQL queries. Returns an empty string when the filter is `nil`.

| Parameter | Type | Description |
|-----------|------|-------------|
| `filter` | `String?` | The filter expression |

```crystal
CaidoUtils.build_filter_clause("host:example.com")
# => "filter: \"host:example.com\""

CaidoUtils.build_filter_clause(nil)
# => ""
```

## Array Building

### `.build_string_array`

```crystal
CaidoUtils.build_string_array(items : Array(String)) : String
```

Converts a Crystal string array into the comma-separated, escaped elements of a GraphQL list. The surrounding `[ ]` are not included.

| Parameter | Type | Description |
|-----------|------|-------------|
| `items` | `Array(String)` | Array of strings to convert |

```crystal
CaidoUtils.build_string_array(["*.example.com", "api.test.com"])
# => "\"*.example.com\", \"api.test.com\""
```

## Optional Strings

### `.build_optional_string`

```crystal
CaidoUtils.build_optional_string(key : String, value : String?) : String?
```

Creates an optional `key: "value"` argument with the value escaped. Returns `nil` when the value is `nil`.

| Parameter | Type | Description |
|-----------|------|-------------|
| `key` | `String` | The argument name |
| `value` | `String?` | The string value |

```crystal
CaidoUtils.build_optional_string("name", "my-value")
# => "name: \"my-value\""

CaidoUtils.build_optional_string("name", nil)
# => nil
```
