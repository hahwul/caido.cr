+++
title = "caido.cr"
description = "Crystal client library for Caido's GraphQL API"
+++

Crystal client library for [Caido](https://caido.io/)'s GraphQL API. Interact with Caido's web security auditing toolkit programmatically from Crystal.

> Requires **Crystal 1.8.1+** and a running Caido instance.

## Overview

caido.cr provides a Crystal interface to Caido's GraphQL API with pre-built query and mutation helpers. It covers HTTP request management, proxy interception, replay sessions, automated attacks, security findings, workflow automation, and more -- all through a simple, consistent API.

## Quick Links

- **[Getting Started](/user-guide/getting-started/)** -- Installation, prerequisites, and your first program
- **[Basic Usage](/user-guide/basic-usage/)** -- Client setup, queries, and mutations
- **[API Reference](/api-reference/client/)** -- Complete API documentation

## Features

- **Query Helpers** -- Pre-built GraphQL queries for all Caido resources
- **Mutation Helpers** -- Create, update, and delete operations for every module
- **Pagination & Filtering** -- Built-in utilities for paginated and filtered queries
- **GraphQL Injection Protection** -- Automatic escaping of user-supplied strings
- **Authentication** -- Automatic token management via environment variables
- **Comprehensive Coverage** -- Requests, Intercept, Replay, Automate, Findings, Scopes, Workflows, DNS, Tamper, and more

## Installation

Add caido.cr to your `shard.yml`:

```yaml
dependencies:
  caido:
    github: hahwul/caido.cr
```

Then run:

```bash
shards install
```
