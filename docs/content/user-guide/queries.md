+++
title = "Queries"
description = "Working with query helpers for reading data"
weight = 3
+++

## Overview

The `CaidoQueries` module provides pre-built GraphQL query strings for all Caido resources. Each sub-module corresponds to a Caido feature area.

## Requests

Query HTTP request and response history:

```crystal
# Get paginated requests
query = CaidoQueries::Requests.all(first: 20)
response = client.query(query)

# With filter
query = CaidoQueries::Requests.all(first: 10, filter: "host:example.com")
response = client.query(query)

# With pagination cursor
query = CaidoQueries::Requests.all(first: 10, after: "cursor-string")
response = client.query(query)

# Get by ID (includes full request/response details)
query = CaidoQueries::Requests.by_id("request-id")
response = client.query(query)

# Get by offset
query = CaidoQueries::Requests.by_offset(offset: 0, limit: 20, filter: "")
response = client.query(query)
```

## Sitemap

Explore target site structure:

```crystal
# Get root sitemap entries for a scope
query = CaidoQueries::Sitemap.root_entries(scope_id: "scope-id")
response = client.query(query)

# Get descendant entries (DIRECT children or ALL descendants)
query = CaidoQueries::Sitemap.descendant_entries(
  parent_id: "entry-id",
  depth: "DIRECT"
)
response = client.query(query)

# Get single entry
query = CaidoQueries::Sitemap.by_id("entry-id")
response = client.query(query)
```

## Intercept

Query the proxy intercept queue:

```crystal
# Get intercepted messages
query = CaidoQueries::Intercept.entries(first: 10)
response = client.query(query)

# Check intercept status
query = CaidoQueries::Intercept.status
response = client.query(query)

# Get intercept options
query = CaidoQueries::Intercept.options
response = client.query(query)
```

## Scopes

Manage target scope definitions:

```crystal
# List all scopes
query = CaidoQueries::Scopes.all
response = client.query(query)

# Get specific scope
query = CaidoQueries::Scopes.by_id("scope-id")
response = client.query(query)
```

## Findings

Query security findings:

```crystal
# List findings
query = CaidoQueries::Findings.all(first: 20)
response = client.query(query)

# Get specific finding
query = CaidoQueries::Findings.by_id("finding-id")
response = client.query(query)

# Get available reporters
query = CaidoQueries::Findings.reporters
response = client.query(query)
```

## Replay & Automate

Work with replay and automated attack sessions:

```crystal
# Replay sessions
query = CaidoQueries::Replay.sessions(first: 10)
response = client.query(query)

query = CaidoQueries::Replay.session_by_id("session-id")
response = client.query(query)

query = CaidoQueries::Replay.collections(first: 10)
response = client.query(query)

# Automate sessions
query = CaidoQueries::Automate.sessions(first: 10)
response = client.query(query)

query = CaidoQueries::Automate.session_by_id("session-id")
response = client.query(query)

query = CaidoQueries::Automate.tasks(first: 10)
response = client.query(query)
```

## System Queries

Query system-level information:

```crystal
# Current user info
query = CaidoQueries::Viewer.info
response = client.query(query)

# Runtime info (version, platform)
query = CaidoQueries::Runtime.info
response = client.query(query)

# Instance settings
query = CaidoQueries::InstanceSettings.get
response = client.query(query)

# DNS configuration
query = CaidoQueries::DNS.rewrites
query = CaidoQueries::DNS.upstreams

# Upstream proxies
query = CaidoQueries::UpstreamProxies.http
query = CaidoQueries::UpstreamProxies.socks

# Tamper rules
query = CaidoQueries::Tamper.rules
query = CaidoQueries::Tamper.rule_by_id("rule-id")

# Workflows
query = CaidoQueries::Workflows.all
query = CaidoQueries::Workflows.by_id("workflow-id")
query = CaidoQueries::Workflows.node_definitions

# Projects
query = CaidoQueries::Projects.current
query = CaidoQueries::Projects.all

# AI Assistant
query = CaidoQueries::Assistant.sessions
query = CaidoQueries::Assistant.models

# Environments
query = CaidoQueries::Environments.all
query = CaidoQueries::Environments.context

# Plugins
query = CaidoQueries::Plugins.packages
```
