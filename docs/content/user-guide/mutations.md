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
# Update metadata (color)
mutation = CaidoMutations::Requests.update_metadata(
  request_id: "request-id",
  color: "red"
)
response = client.query(mutation)

# Render a request
mutation = CaidoMutations::Requests.render(request_id: "request-id")
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
  message_id: "message-id",
  request: "GET / HTTP/1.1\r\nHost: example.com\r\n\r\n",
  response: ""
)
response = client.query(mutation)

# Drop an intercepted message
mutation = CaidoMutations::Intercept.drop_message(message_id: "message-id")
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
  scope_id: "scope-id",
  name: "Updated Target",
  allowlist: ["*.example.com"],
  denylist: [] of String
)
response = client.query(mutation)

# Delete a scope
mutation = CaidoMutations::Scopes.delete(scope_id: "scope-id")
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
  finding_id: "finding-id",
  title: "SQL Injection (Confirmed)",
  description: "Confirmed blind SQL injection"
)
response = client.query(mutation)

# Delete findings
mutation = CaidoMutations::Findings.delete(finding_ids: ["finding-1", "finding-2"])
response = client.query(mutation)

# Export findings
mutation = CaidoMutations::Findings.export(finding_ids: ["finding-1"])
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
mutation = CaidoMutations::Workflows.toggle(workflow_id: "workflow-id", enabled: true)
response = client.query(mutation)

# Run workflow on a request
mutation = CaidoMutations::Workflows.run_active(
  workflow_id: "workflow-id",
  request_id: "request-id"
)
response = client.query(mutation)

# Delete workflow
mutation = CaidoMutations::Workflows.delete(workflow_id: "workflow-id")
response = client.query(mutation)
```

## Replay

Manage request replay sessions:

```crystal
# Create a replay session
mutation = CaidoMutations::Replay.create_session(
  name: "Test Session",
  request_id: "request-id",
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
mutation = CaidoMutations::Automate.pause_task(task_id: "task-id")
mutation = CaidoMutations::Automate.resume_task(task_id: "task-id")
mutation = CaidoMutations::Automate.cancel_task(task_id: "task-id")
```

## Match & Replace Rules

Manage request/response match & replace rules:

```crystal
# Create a rule
mutation = CaidoMutations::MatchReplace.create_rule(
  name: "Add Header",
  condition: "request.host == 'example.com'",
  strategy: "add-header-strategy"
)
response = client.query(mutation)

# Toggle a rule
mutation = CaidoMutations::MatchReplace.toggle_rule(rule_id: "rule-id", enabled: true)
response = client.query(mutation)

# Manage collections
mutation = CaidoMutations::MatchReplace.create_collection(name: "My Rules")
mutation = CaidoMutations::MatchReplace.delete_collection(collection_id: "collection-id")
```

## DNS & Proxies

Configure DNS and upstream proxies:

```crystal
# Create calls take the arguments listed in the API reference
# (e.g. DNS.create_rewrite(name, strategy, source, destination)).

# DNS rewrites
mutation = CaidoMutations::DNS.toggle_rewrite(rewrite_id: "rewrite-id", enabled: false)
mutation = CaidoMutations::DNS.delete_rewrite(rewrite_id: "rewrite-id")

# DNS upstreams
mutation = CaidoMutations::DNS.delete_upstream(upstream_id: "upstream-id")

# HTTP upstream proxies
mutation = CaidoMutations::UpstreamProxies.toggle_http(proxy_id: "proxy-id", enabled: true)
mutation = CaidoMutations::UpstreamProxies.delete_http(proxy_id: "proxy-id")

# SOCKS upstream proxies
mutation = CaidoMutations::UpstreamProxies.delete_socks(proxy_id: "proxy-id")
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
