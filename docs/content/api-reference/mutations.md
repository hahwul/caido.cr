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
| `.update_metadata` | `request_id`, `color?` | Update request metadata |
| `.render` | `request_id` | Render request with variables |

## CaidoMutations::Sitemap

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_entries` | `request_id` | Create sitemap entries from request |
| `.delete_entries` | `entry_ids` | Delete multiple entries |
| `.clear_all` | -- | Clear all sitemap entries |

## CaidoMutations::Intercept

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.pause` | -- | Pause interception |
| `.resume` | -- | Resume interception |
| `.forward_message` | `message_id`, `request?`, `response?` | Forward intercepted message |
| `.drop_message` | `message_id` | Drop intercepted message |
| `.set_options` | `request_enabled?`, `response_enabled?`, `in_scope_only?` | Configure intercept behavior |
| `.delete_entries` | `filter?` | Delete intercept queue |

## CaidoMutations::Scopes

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `name`, `allowlist`, `denylist?` | Create a scope |
| `.update` | `scope_id`, `name?`, `allowlist?`, `denylist?` | Update a scope |
| `.delete` | `scope_id` | Delete a scope |
| `.rename` | `scope_id`, `name` | Rename a scope |

## CaidoMutations::Findings

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `request_id`, `title`, `description?`, `reporter?`, `dedupe_key?` | Create a finding |
| `.update` | `finding_id`, `title?`, `description?`, `hidden?` | Update a finding |
| `.delete` | `finding_ids?` | Delete findings |
| `.hide` | `finding_ids` | Hide findings |
| `.export` | `finding_ids?` | Export findings |

## CaidoMutations::Projects

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.select` | `project_id` | Select active project |
| `.create` | `name`, `path?`, `temporary?` | Create a project |
| `.delete` | `project_id` | Delete a project |
| `.rename` | `project_id`, `name` | Rename a project |

## CaidoMutations::Workflows

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `name`, `kind`, `definition`, `global?` | Create a workflow |
| `.update` | `workflow_id`, `name?`, `definition?` | Update a workflow |
| `.delete` | `workflow_id` | Delete a workflow |
| `.rename` | `workflow_id`, `name` | Rename a workflow |
| `.toggle` | `workflow_id`, `enabled` | Enable/disable a workflow |
| `.run_active` | `workflow_id`, `request_id` | Execute workflow on a request |

## CaidoMutations::Replay

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_session` | `name`, `request_id?`, `connection_info?`, `raw?`, `collection_id?` | Create replay session |
| `.create_collection` | `name` | Create session collection |
| `.delete_sessions` | `session_ids` | Delete sessions |
| `.delete_collection` | `collection_id` | Delete collection |
| `.rename_session` | `session_id`, `name` | Rename session |
| `.rename_collection` | `collection_id`, `name` | Rename collection |
| `.move_session` | `session_id`, `collection_id` | Move session to collection |
| `.start_task` | `session_id`, `connection_info?`, `raw?`, `settings?` | Start replay task |
| `.set_active_entry` | `session_id`, `entry_id` | Set active replay session entry |

## CaidoMutations::Automate

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_session` | `name`, `host`, `port`, `is_tls?` | Create attack session |
| `.delete_session` | `session_id` | Delete session |
| `.rename_session` | `session_id`, `name` | Rename session |
| `.duplicate_session` | `session_id` | Duplicate session |
| `.start_task` | `session_id` | Start attack task |
| `.pause_task` | `task_id` | Pause task |
| `.resume_task` | `task_id` | Resume task |
| `.cancel_task` | `task_id` | Cancel task |
| `.delete_entries` | `entry_ids` | Delete automate entries |

## CaidoMutations::MatchReplace

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_rule` | `name`, `condition`, `strategy`, `collection_id?` | Create a match & replace rule |
| `.update_rule` | `rule_id`, `name?`, `condition?`, `strategy?` | Update a match & replace rule |
| `.delete_rule` | `rule_id` | Delete a match & replace rule |
| `.toggle_rule` | `rule_id`, `enabled` | Enable/disable a rule |
| `.rename_rule` | `rule_id`, `name` | Rename a rule |
| `.create_collection` | `name` | Create a match & replace collection |
| `.delete_collection` | `collection_id` | Delete a match & replace collection |
| `.rename_collection` | `collection_id`, `name` | Rename a match & replace collection |
| `.move_rule` | `rule_id`, `collection_id` | Move rule to collection |

## CaidoMutations::DNS

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_rewrite` | `name`, `strategy`, `source`, `destination` | Create a DNS rewrite rule |
| `.update_rewrite` | `rewrite_id`, `name?`, `strategy?`, `source?`, `destination?` | Update a DNS rewrite rule |
| `.delete_rewrite` | `rewrite_id` | Delete a DNS rewrite rule |
| `.toggle_rewrite` | `rewrite_id`, `enabled` | Enable/disable a rewrite rule |
| `.create_upstream` | `name`, `kind`, `address` | Create a DNS upstream |
| `.update_upstream` | `upstream_id`, `name?`, `kind?`, `address?` | Update a DNS upstream |
| `.delete_upstream` | `upstream_id` | Delete a DNS upstream |

## CaidoMutations::UpstreamProxies

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_http` | `kind`, `address`, `allowlist?`, `denylist?` | Create HTTP upstream proxy |
| `.delete_http` | `proxy_id` | Delete HTTP upstream proxy |
| `.toggle_http` | `proxy_id`, `enabled` | Enable/disable HTTP proxy |
| `.create_socks` | `kind`, `address`, `allowlist?`, `denylist?` | Create SOCKS upstream proxy |
| `.delete_socks` | `proxy_id` | Delete SOCKS upstream proxy |
| `.toggle_socks` | `proxy_id`, `enabled` | Enable/disable SOCKS proxy |

## CaidoMutations::Assistant

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create_session` | `model_id`, `name?` | Create AI session |
| `.delete_session` | `session_id` | Delete AI session |
| `.rename_session` | `session_id`, `name` | Rename AI session |
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
| `.cancel` | `task_id` | Cancel a running task |

## CaidoMutations::Environments

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `name` | Create an environment |
| `.update` | `environment_id`, `name?`, `version?` | Update an environment |
| `.delete` | `environment_id` | Delete an environment |
| `.select` | `environment_id?` | Select an active environment |

## CaidoMutations::FilterPresets

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.create` | `name`, `clause`, `filter_alias?` | Create a filter preset |
| `.update` | `filter_id`, `name?`, `clause?`, `filter_alias?` | Update a filter preset |
| `.delete` | `filter_id` | Delete a filter preset |

## CaidoMutations::HostedFiles

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.upload` | `name`, `path` | Upload a hosted file |
| `.rename` | `file_id`, `name` | Rename a hosted file |
| `.delete` | `file_id` | Delete a hosted file |

## CaidoMutations::InstanceSettings

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.set` | `input` | Set instance settings. Pass a `Hash` (serialized safely via `CaidoUtils.to_graphql_value`); the `String` overload is interpolated verbatim and is for trusted input only |

## CaidoMutations::Plugins

| Method | Parameters | Description |
|--------|-----------|-------------|
| `.install` | `manifest_id`, `force?` | Install a plugin package |
