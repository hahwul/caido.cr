+++
title = "Basic Usage"
description = "Client setup, queries, and mutations"
weight = 2
+++

## Creating a Client

The `CaidoClient` is the main entry point. It wraps a GraphQL client and handles authentication:

```crystal
require "caido"

# With automatic auth token from CAIDO_AUTH_TOKEN env var
client = CaidoClient.new "http://localhost:8080/graphql"

# With custom headers
client = CaidoClient.new(
  "http://localhost:8080/graphql",
  {"Authorization" => "Bearer my-token"}
)
```

## Making Queries

Use the `CaidoQueries` module to build queries, then execute them with `client.query`:

```crystal
# Get all requests (paginated)
query = CaidoQueries::Requests.all(first: 10)
response = client.query(query)
puts response

# Get a specific request by ID
query = CaidoQueries::Requests.by_id("request-id")
response = client.query(query)
puts response

# Get current viewer info
query = CaidoQueries::Viewer.info
response = client.query(query)
puts response
```

### Available Query Modules

| Module | Description |
|--------|-------------|
| `Requests` | HTTP request/response history |
| `Sitemap` | Target site structure |
| `Intercept` | Proxy intercept queue and status |
| `Scopes` | Target scope definitions |
| `Findings` | Security findings |
| `Projects` | Project management |
| `Workflows` | Automation workflows |
| `Replay` | Request replay sessions |
| `Automate` | Automated attack sessions |
| `Viewer` | Current user info |
| `Runtime` | Caido version and platform |
| `InstanceSettings` | Instance configuration |
| `DNS` | DNS rewrites and upstreams |
| `UpstreamProxies` | Proxy chaining config |
| `Tamper` | Request/response tamper rules |
| `Assistant` | AI assistant sessions |
| `Environments` | Environment variables |
| `Plugins` | Installed plugins |

## Making Mutations

Use the `CaidoMutations` module for write operations:

```crystal
# Create a security finding
mutation = CaidoMutations::Findings.create(
  request_id: "req-123",
  title: "XSS Found",
  description: "Reflected XSS in search parameter",
  reporter: "my-scanner"
)
response = client.query(mutation)
puts response

# Create a scope
mutation = CaidoMutations::Scopes.create(
  name: "Target",
  allowlist: ["*.example.com"],
  denylist: ["admin.example.com"]
)
response = client.query(mutation)
puts response
```

### Available Mutation Modules

| Module | Description |
|--------|-------------|
| `Requests` | Update request metadata, render |
| `Sitemap` | Create/delete sitemap entries |
| `Intercept` | Forward/drop messages, pause/resume |
| `Scopes` | CRUD scope operations |
| `Findings` | Create/update/delete/export findings |
| `Projects` | Select/create/delete projects |
| `Workflows` | CRUD and run workflows |
| `Replay` | Manage replay sessions and collections |
| `Automate` | Manage automated attack sessions |
| `Tamper` | Manage tamper rules and collections |
| `DNS` | Configure DNS rewrites and upstreams |
| `UpstreamProxies` | Configure HTTP/SOCKS proxies |
| `Assistant` | AI assistant session management |
| `Authentication` | Login/logout operations |
| `Tasks` | Cancel running tasks |

## Error Handling

Handle errors from the GraphQL API:

```crystal
begin
  response = client.query(query)
  puts response
rescue ex
  puts "Error: #{ex.message}"
end
```

## Usage Pattern

All operations follow a consistent pattern:

```crystal
# 1. Build the query or mutation string
query = CaidoQueries::Module.method(args)

# 2. Execute it
response = client.query(query)

# 3. Process the response
puts response
```
