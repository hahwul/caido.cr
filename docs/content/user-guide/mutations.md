+++
title = "Mutations"
description = "Working with mutation helpers for write operations"
weight = 4
+++

## Overview

The `CaidoMutations` module provides pre-built GraphQL mutation strings for creating, updating, and deleting Caido resources.

## Requests

Update request metadata:

```crystal
# Update metadata (color and label)
mutation = CaidoMutations::Requests.update_metadata(
  id: "request-id",
  color: "red",
  label: "interesting"
)
response = client.query(mutation)

# Render a request
mutation = CaidoMutations::Requests.render(id: "request-id")
response = client.query(mutation)
```

## Intercept

Control the proxy intercept:

```crystal
# Pause/resume interception
mutation = CaidoMutations::Intercept.pause
mutation = CaidoMutations::Intercept.resume

# Forward an intercepted message
mutation = CaidoMutations::Intercept.forward_message(
  id: "message-id",
  request: "GET / HTTP/1.1\r\nHost: example.com\r\n\r\n",
  response: ""
)
response = client.query(mutation)

# Drop an intercepted message
mutation = CaidoMutations::Intercept.drop_message(id: "message-id")
response = client.query(mutation)
```

## Scopes

Manage target scopes:

```crystal
# Create a scope
mutation = CaidoMutations::Scopes.create(
  name: "My Target",
  allowlist: ["*.example.com", "api.example.com"],
  denylist: ["admin.example.com"]
)
response = client.query(mutation)

# Update a scope
mutation = CaidoMutations::Scopes.update(
  id: "scope-id",
  name: "Updated Target",
  allowlist: ["*.example.com"],
  denylist: []
)
response = client.query(mutation)

# Delete a scope
mutation = CaidoMutations::Scopes.delete(id: "scope-id")
response = client.query(mutation)
```

## Findings

Manage security findings:

```crystal
# Create a finding
mutation = CaidoMutations::Findings.create(
  request_id: "req-123",
  title: "SQL Injection",
  description: "Found in login form parameter",
  reporter: "manual-testing"
)
response = client.query(mutation)

# Update a finding
mutation = CaidoMutations::Findings.update(
  id: "finding-id",
  title: "SQL Injection (Confirmed)",
  description: "Confirmed blind SQL injection"
)
response = client.query(mutation)

# Delete findings
mutation = CaidoMutations::Findings.delete(ids: ["finding-1", "finding-2"])
response = client.query(mutation)

# Export findings
mutation = CaidoMutations::Findings.export(ids: ["finding-1"])
response = client.query(mutation)
```

## Workflows

Manage automation workflows:

```crystal
# Create a workflow
mutation = CaidoMutations::Workflows.create(
  name: "My Workflow",
  kind: "active",
  definition: "{}"
)
response = client.query(mutation)

# Toggle workflow
mutation = CaidoMutations::Workflows.toggle(id: "workflow-id", enabled: true)
response = client.query(mutation)

# Run workflow on a request
mutation = CaidoMutations::Workflows.run_active(
  id: "workflow-id",
  request_id: "request-id"
)
response = client.query(mutation)

# Delete workflow
mutation = CaidoMutations::Workflows.delete(id: "workflow-id")
response = client.query(mutation)
```

## Replay

Manage request replay sessions:

```crystal
# Create a replay session
mutation = CaidoMutations::Replay.create_session(
  name: "Test Session",
  source: "request-source",
  collection_id: "collection-id"
)
response = client.query(mutation)

# Start a replay task
mutation = CaidoMutations::Replay.start_task(session_id: "session-id")
response = client.query(mutation)

# Create a collection
mutation = CaidoMutations::Replay.create_collection(name: "My Collection")
response = client.query(mutation)
```

## Automate

Control automated attack sessions:

```crystal
# Create a session
mutation = CaidoMutations::Automate.create_session(
  name: "Brute Force",
  host: "example.com",
  port: 443,
  is_tls: true
)
response = client.query(mutation)

# Start/pause/resume/cancel tasks
mutation = CaidoMutations::Automate.start_task(session_id: "session-id")
mutation = CaidoMutations::Automate.pause_task(id: "task-id")
mutation = CaidoMutations::Automate.resume_task(id: "task-id")
mutation = CaidoMutations::Automate.cancel_task(id: "task-id")
```

## Tamper Rules

Manage request/response tampering:

```crystal
# Create a tamper rule
mutation = CaidoMutations::Tamper.create_rule
response = client.query(mutation)

# Toggle a rule
mutation = CaidoMutations::Tamper.toggle_rule(id: "rule-id", enabled: true)
response = client.query(mutation)

# Manage collections
mutation = CaidoMutations::Tamper.create_collection
mutation = CaidoMutations::Tamper.delete_collection(id: "collection-id")
```

## DNS & Proxies

Configure DNS and upstream proxies:

```crystal
# DNS rewrites
mutation = CaidoMutations::DNS.create_rewrite
mutation = CaidoMutations::DNS.delete_rewrite(id: "rewrite-id")

# DNS upstreams
mutation = CaidoMutations::DNS.create_upstream
mutation = CaidoMutations::DNS.delete_upstream(id: "upstream-id")

# HTTP upstream proxies
mutation = CaidoMutations::UpstreamProxies.create_http
mutation = CaidoMutations::UpstreamProxies.delete_http(id: "proxy-id")

# SOCKS upstream proxies
mutation = CaidoMutations::UpstreamProxies.create_socks
mutation = CaidoMutations::UpstreamProxies.delete_socks(id: "proxy-id")
```

## Authentication

Handle authentication flows:

```crystal
# Start auth flow
mutation = CaidoMutations::Authentication.start_flow
response = client.query(mutation)

# Login as guest
mutation = CaidoMutations::Authentication.login_guest
response = client.query(mutation)

# Logout
mutation = CaidoMutations::Authentication.logout
response = client.query(mutation)
```
