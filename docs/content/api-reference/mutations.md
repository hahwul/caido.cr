+++
title = "Mutations"
description = "Complete mutation module reference"
weight = 3
+++

## Overview

The `CaidoMutations` module contains sub-modules that return pre-built GraphQL mutation strings. Each method returns a `String` that can be passed to `CaidoClient#query`.

## CaidoMutations::Requests

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.update_metadata` | `id`, `color`, `label` | Update request metadata |
| `.render` | `id` | Render request with variables |

## CaidoMutations::Sitemap

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_entries` | `request_id` | Create sitemap entries from request |
| `.delete_entries` | `ids` | Delete multiple entries |
| `.clear_all` | -- | Clear all sitemap entries |

## CaidoMutations::Intercept

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.pause` | -- | Pause interception |
| `.resume` | -- | Resume interception |
| `.forward_message` | `id`, `request`, `response` | Forward intercepted message |
| `.drop_message` | `id` | Drop intercepted message |
| `.set_options` | -- | Configure intercept behavior |
| `.delete_entries` | `filter` | Delete intercept queue |

## CaidoMutations::Scopes

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `name`, `allowlist`, `denylist` | Create a scope |
| `.update` | `id`, `name`, `allowlist`, `denylist` | Update a scope |
| `.delete` | `id` | Delete a scope |
| `.rename` | `id`, `name` | Rename a scope |

## CaidoMutations::Findings

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `request_id`, `title`, `description`, `reporter` | Create a finding |
| `.update` | `id`, `title`, `description` | Update a finding |
| `.delete` | `ids` | Delete findings |
| `.hide` | `ids` | Hide findings |
| `.export` | `ids` | Export findings |

## CaidoMutations::Projects

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.select` | `id` | Select active project |
| `.create` | `name`, `path` | Create a project |
| `.delete` | `id` | Delete a project |
| `.rename` | `id`, `name` | Rename a project |

## CaidoMutations::Workflows

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `name`, `kind`, `definition` | Create a workflow |
| `.update` | `id`, `name`, `definition` | Update a workflow |
| `.delete` | `id` | Delete a workflow |
| `.rename` | `id`, `name` | Rename a workflow |
| `.toggle` | `id`, `enabled` | Enable/disable a workflow |
| `.run_active` | `id`, `request_id` | Execute workflow on a request |

## CaidoMutations::Replay

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_session` | `name`, `source`, `collection_id` | Create replay session |
| `.create_collection` | `name` | Create session collection |
| `.delete_sessions` | `ids` | Delete sessions |
| `.delete_collection` | `id` | Delete collection |
| `.rename_session` | `id`, `name` | Rename session |
| `.rename_collection` | `id`, `name` | Rename collection |
| `.move_session` | `id`, `collection_id` | Move session to collection |
| `.start_task` | `session_id` | Start replay task |

## CaidoMutations::Automate

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_session` | `name`, `host`, `port`, `is_tls` | Create attack session |
| `.delete_session` | `id` | Delete session |
| `.rename_session` | `id`, `name` | Rename session |
| `.duplicate_session` | `id` | Duplicate session |
| `.start_task` | `session_id` | Start attack task |
| `.pause_task` | `id` | Pause task |
| `.resume_task` | `id` | Resume task |
| `.cancel_task` | `id` | Cancel task |
| `.delete_entries` | `ids` | Delete automate entries |

## CaidoMutations::Tamper

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_rule` | -- | Create a tamper rule |
| `.update_rule` | -- | Update a tamper rule |
| `.delete_rule` | -- | Delete a tamper rule |
| `.toggle_rule` | `id`, `enabled` | Enable/disable a rule |
| `.rename_rule` | -- | Rename a rule |
| `.create_collection` | -- | Create a tamper collection |
| `.delete_collection` | -- | Delete a tamper collection |
| `.rename_collection` | -- | Rename a tamper collection |
| `.move_rule` | -- | Move rule to collection |

## CaidoMutations::DNS

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_rewrite` | -- | Create a DNS rewrite rule |
| `.update_rewrite` | -- | Update a DNS rewrite rule |
| `.delete_rewrite` | -- | Delete a DNS rewrite rule |
| `.toggle_rewrite` | -- | Enable/disable a rewrite rule |
| `.create_upstream` | -- | Create a DNS upstream |
| `.update_upstream` | -- | Update a DNS upstream |
| `.delete_upstream` | -- | Delete a DNS upstream |

## CaidoMutations::UpstreamProxies

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_http` | -- | Create HTTP upstream proxy |
| `.delete_http` | `id` | Delete HTTP upstream proxy |
| `.toggle_http` | -- | Enable/disable HTTP proxy |
| `.create_socks` | -- | Create SOCKS upstream proxy |
| `.delete_socks` | `id` | Delete SOCKS upstream proxy |
| `.toggle_socks` | -- | Enable/disable SOCKS proxy |

## CaidoMutations::Assistant

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_session` | `model_id`, `name` | Create AI session |
| `.delete_session` | `id` | Delete AI session |
| `.rename_session` | `id`, `name` | Rename AI session |
| `.send_message` | `session_id`, `message` | Send message to AI |

## CaidoMutations::Authentication

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.start_flow` | -- | Begin authentication flow |
| `.login_guest` | -- | Login as guest |
| `.logout` | -- | Logout |

## CaidoMutations::Tasks

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.cancel` | `id` | Cancel a running task |
