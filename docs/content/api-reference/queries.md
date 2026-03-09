+++
title = "Queries"
description = "Complete query module reference"
weight = 2
+++

## Overview

The `CaidoQueries` module contains sub-modules that return pre-built GraphQL query strings. Each method returns a `String` that can be passed to `CaidoClient#query`.

## CaidoQueries::Requests

HTTP request and response history.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.all` | `first`, `filter?`, `after?` | Get paginated requests |
| `.by_id` | `id` | Get a single request with full details |
| `.by_offset` | `offset`, `limit`, `filter` | Get requests with offset pagination |

```crystal
CaidoQueries::Requests.all(first: 10)
CaidoQueries::Requests.all(first: 10, filter: "host:example.com", after: "cursor")
CaidoQueries::Requests.by_id("request-id")
CaidoQueries::Requests.by_offset(offset: 0, limit: 20, filter: "")
```

## CaidoQueries::Sitemap

Target site structure exploration.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.root_entries` | `scope_id` | Get root sitemap entries |
| `.descendant_entries` | `parent_id`, `depth` | Get child entries (DIRECT or ALL) |
| `.by_id` | `id` | Get a single sitemap entry |

```crystal
CaidoQueries::Sitemap.root_entries(scope_id: "scope-id")
CaidoQueries::Sitemap.descendant_entries(parent_id: "entry-id", depth: "DIRECT")
CaidoQueries::Sitemap.by_id("entry-id")
```

## CaidoQueries::Intercept

Proxy intercept queue and configuration.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.entries` | `first`, `filter?`, `after?` | Get intercepted messages |
| `.status` | -- | Get current intercept status |
| `.options` | -- | Get intercept configuration |

## CaidoQueries::Scopes

Target scope definitions.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.all` | -- | Get all scopes |
| `.by_id` | `id` | Get a single scope |

## CaidoQueries::Findings

Security findings management.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.all` | `first`, `after?` | Get paginated findings |
| `.by_id` | `id` | Get a single finding |
| `.reporters` | -- | Get available reporter names |

## CaidoQueries::Projects

Project management.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.current` | -- | Get the current active project |
| `.all` | -- | Get all projects (cloud feature) |

## CaidoQueries::Workflows

Automation workflow queries.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.all` | -- | Get all workflows |
| `.by_id` | `id` | Get a single workflow |
| `.node_definitions` | -- | Get available workflow node types |

## CaidoQueries::Replay

Request replay session management.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.sessions` | `first`, `after?` | Get replay sessions |
| `.session_by_id` | `id` | Get session details |
| `.collections` | `first`, `after?` | Get session collections |

## CaidoQueries::Automate

Automated attack session queries.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.sessions` | `first`, `after?` | Get automate sessions |
| `.session_by_id` | `id` | Get session details |
| `.tasks` | `first`, `after?` | Get automate tasks |

## CaidoQueries::Viewer

Current user information.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.info` | -- | Get logged-in user details and settings |

## CaidoQueries::Runtime

Caido runtime information.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.info` | -- | Get version, platform, and update info |

## CaidoQueries::InstanceSettings

Instance configuration.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.get` | -- | Get theme, language, license, AI settings |

## CaidoQueries::DNS

DNS configuration queries.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.rewrites` | -- | Get DNS rewrite rules |
| `.upstreams` | -- | Get DNS upstream servers |

## CaidoQueries::UpstreamProxies

Proxy chaining configuration.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.http` | -- | Get HTTP upstream proxies |
| `.socks` | -- | Get SOCKS upstream proxies |

## CaidoQueries::Tamper

Request/response tampering rules.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.rules` | -- | Get all tamper rules |
| `.rule_by_id` | `id` | Get a single tamper rule |

## CaidoQueries::Assistant

AI assistant (cloud feature).

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.sessions` | -- | Get assistant sessions |
| `.models` | -- | Get available AI models |

## CaidoQueries::Environments

Environment variables (cloud feature).

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.all` | -- | Get all environments |
| `.context` | -- | Get current environment context |

## CaidoQueries::Plugins

Plugin management.

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.packages` | -- | Get installed plugin packages |
