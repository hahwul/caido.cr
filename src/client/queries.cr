require "./utils"

module CaidoQueries
  # Query templates for common Caido GraphQL operations

  module Requests
    # Get all requests with pagination
    def self.all(after : String? = nil, first : Int32 = 50, filter : String? = nil)
      filter_clause = CaidoUtils.build_filter_clause(filter)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetRequests {
          requests(#{after_clause} first: #{first} #{filter_clause}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              host
              port
              path
              query
              method
              edited
              isTls
              length
              alteration
              metadata {
                id
                color
                label
              }
              fileExtension
              source
              createdAt
              response {
                id
                statusCode
                roundtripTime
                length
                createdAt
                alteration
                edited
              }
            }
          }
        }
      )
    end

    # Get a single request by ID
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetRequest {
          request(id: "#{escaped_id}") {
            id
            host
            port
            path
            query
            method
            edited
            isTls
            length
            alteration
            metadata {
              id
              color
              label
            }
            fileExtension
            source
            createdAt
            raw
            response {
              id
              statusCode
              roundtripTime
              length
              createdAt
              alteration
              edited
              raw
            }
          }
        }
      )
    end

    # Get requests by offset (alternative pagination)
    def self.by_offset(offset : Int32 = 0, limit : Int32 = 50, filter : String? = nil)
      filter_clause = CaidoUtils.build_filter_clause(filter)

      %Q(
        query GetRequestsByOffset {
          requestsByOffset(offset: #{offset} limit: #{limit} #{filter_clause}) {
            nodes {
              id
              host
              port
              path
              query
              method
              edited
              isTls
              length
              alteration
              metadata {
                id
                color
                label
              }
              fileExtension
              source
              createdAt
            }
          }
        }
      )
    end

    # Get the offset of a specific request
    def self.request_offset(id : String, filter : String? = nil)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      filter_clause = CaidoUtils.build_filter_clause(filter)

      %Q(
        query GetRequestOffset {
          requestOffset(id: "#{escaped_id}" #{filter_clause}) {
            offset
          }
        }
      )
    end

    # Get a single response by ID
    def self.response_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetResponse {
          response(id: "#{escaped_id}") {
            id
            statusCode
            roundtripTime
            length
            createdAt
            alteration
            edited
            raw
          }
        }
      )
    end
  end

  module Sitemap
    # Get root sitemap entries
    def self.root_entries(scope_id : String? = nil)
      scope_clause = scope_id ? %Q(scopeId: "#{CaidoUtils.escape_graphql_string(scope_id)}") : ""

      %Q(
        query GetSitemapRootEntries {
          sitemapRootEntries(#{scope_clause}) {
            nodes {
              id
              label
              kind
              parentId
              hasDescendants
              metadata {
                id
                color
                label
              }
            }
          }
        }
      )
    end

    # Get descendant entries of a parent
    def self.descendant_entries(parent_id : String, depth : String = "DIRECT")
      escaped_parent_id = CaidoUtils.escape_graphql_string(parent_id)
      %Q(
        query GetSitemapDescendantEntries {
          sitemapDescendantEntries(parentId: "#{escaped_parent_id}", depth: #{depth}) {
            nodes {
              id
              label
              kind
              parentId
              hasDescendants
              metadata {
                id
                color
                label
              }
            }
          }
        }
      )
    end

    # Get a single sitemap entry
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetSitemapEntry {
          sitemapEntry(id: "#{escaped_id}") {
            id
            label
            kind
            parentId
            hasDescendants
            metadata {
              id
              color
              label
            }
          }
        }
      )
    end
  end

  module Intercept
    # Get intercept entries
    def self.entries(after : String? = nil, first : Int32 = 50, filter : String? = nil)
      filter_clause = CaidoUtils.build_filter_clause(filter)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetInterceptEntries {
          interceptEntries(#{after_clause} first: #{first} #{filter_clause}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              kind
              request {
                id
                host
                port
                path
                query
                method
                isTls
              }
            }
          }
        }
      )
    end

    # Get intercept status
    def self.status
      %Q(
        query GetInterceptStatus {
          interceptStatus {
            isEnabled
            inScopeOnly
          }
        }
      )
    end

    # Get intercept options
    def self.options
      %Q(
        query GetInterceptOptions {
          interceptOptions {
            request {
              enabled
              internal
              inScopeOnly
              query
            }
            response {
              enabled
              inScopeOnly
              statusCode {
                enabled
                value
              }
            }
          }
        }
      )
    end

    # Get intercept entries by offset
    def self.entries_by_offset(offset : Int32 = 0, limit : Int32 = 50, filter : String? = nil)
      filter_clause = CaidoUtils.build_filter_clause(filter)

      %Q(
        query GetInterceptEntriesByOffset {
          interceptEntriesByOffset(offset: #{offset} limit: #{limit} #{filter_clause}) {
            nodes {
              id
              kind
              request {
                id
                host
                port
                path
                query
                method
                isTls
              }
            }
          }
        }
      )
    end

    # Get a single intercept entry by ID
    def self.entry_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetInterceptEntry {
          interceptEntry(id: "#{escaped_id}") {
            id
            kind
            request {
              id
              host
              port
              path
              query
              method
              isTls
              raw
            }
          }
        }
      )
    end

    # Get the offset of a specific intercept entry
    def self.entry_offset(id : String, filter : String? = nil)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      filter_clause = CaidoUtils.build_filter_clause(filter)

      %Q(
        query GetInterceptEntryOffset {
          interceptEntryOffset(id: "#{escaped_id}" #{filter_clause}) {
            offset
          }
        }
      )
    end

    # Get intercept messages
    def self.messages(after : String? = nil, first : Int32 = 50, kind : String? = nil)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""
      kind_clause = kind ? %Q(kind: #{kind}) : ""

      %Q(
        query GetInterceptMessages {
          interceptMessages(#{after_clause} first: #{first} #{kind_clause}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              kind
              request {
                id
                host
                path
                method
              }
            }
          }
        }
      )
    end
  end

  module Scopes
    # Get all scopes
    def self.all
      %Q(
        query GetScopes {
          scopes {
            id
            name
            allowlist
            denylist
          }
        }
      )
    end

    # Get a single scope
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetScope {
          scope(id: "#{escaped_id}") {
            id
            name
            allowlist
            denylist
          }
        }
      )
    end
  end

  module Findings
    # Get findings with pagination
    def self.all(after : String? = nil, first : Int32 = 50)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetFindings {
          findings(#{after_clause} first: #{first}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              title
              description
              reporter
              dedupeKey
              createdAt
              request {
                id
                host
                path
                method
              }
            }
          }
        }
      )
    end

    # Get a single finding
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetFinding {
          finding(id: "#{escaped_id}") {
            id
            title
            description
            reporter
            dedupeKey
            createdAt
            request {
              id
              host
              path
              query
              method
              raw
            }
          }
        }
      )
    end

    # Get finding reporters
    def self.reporters
      %Q(
        query GetFindingReporters {
          findingReporters
        }
      )
    end

    # Get findings by offset
    def self.by_offset(offset : Int32 = 0, limit : Int32 = 50, filter : String? = nil)
      filter_clause = CaidoUtils.build_filter_clause(filter)

      %Q(
        query GetFindingsByOffset {
          findingsByOffset(offset: #{offset} limit: #{limit} #{filter_clause}) {
            nodes {
              id
              title
              description
              reporter
              dedupeKey
              createdAt
              request {
                id
                host
                path
                method
              }
            }
          }
        }
      )
    end
  end

  module Projects
    # Get current project
    def self.current
      %Q(
        query GetCurrentProject {
          currentProject {
            id
            name
            path
            version
            status
            size
            backups {
              id
              name
              path
              size
              createdAt
            }
          }
        }
      )
    end

    # Get all projects (requires cloud)
    def self.all
      %Q(
        query GetProjects {
          projects {
            id
            name
            path
            version
            status
            createdAt
          }
        }
      )
    end
  end

  module Workflows
    # Get all workflows
    def self.all
      %Q(
        query GetWorkflows {
          workflows {
            id
            name
            kind
            enabled
            global
            definition
          }
        }
      )
    end

    # Get a single workflow
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetWorkflow {
          workflow(id: "#{escaped_id}") {
            id
            name
            kind
            enabled
            global
            definition
          }
        }
      )
    end

    # Get workflow node definitions
    def self.node_definitions
      %Q(
        query GetWorkflowNodeDefinitions {
          workflowNodeDefinitions {
            id
            name
            kind
            body
          }
        }
      )
    end
  end

  module Replay
    # Get replay sessions
    def self.sessions(after : String? = nil, first : Int32 = 50)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetReplaySessions {
          replaySessions(#{after_clause} first: #{first}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              name
              activeEntry {
                id
              }
              collection {
                id
                name
              }
            }
          }
        }
      )
    end

    # Get a single replay session
    def self.session_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetReplaySession {
          replaySession(id: "#{escaped_id}") {
            id
            name
            activeEntry {
              id
              error
              request {
                id
                raw
              }
              response {
                id
                raw
              }
            }
            collection {
              id
              name
            }
          }
        }
      )
    end

    # Get replay session collections
    def self.collections(after : String? = nil, first : Int32 = 50)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetReplaySessionCollections {
          replaySessionCollections(#{after_clause} first: #{first}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              name
            }
          }
        }
      )
    end

    # Get a single replay entry by ID
    def self.entry_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetReplayEntry {
          replayEntry(id: "#{escaped_id}") {
            id
            error
            request {
              id
              host
              port
              path
              method
              raw
            }
            response {
              id
              statusCode
              roundtripTime
              length
              raw
            }
          }
        }
      )
    end
  end

  module Automate
    # Get automate sessions
    def self.sessions(after : String? = nil, first : Int32 = 50)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetAutomateSessions {
          automateSessions(#{after_clause} first: #{first}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              name
              connection {
                host
                port
                isTls
              }
              createdAt
            }
          }
        }
      )
    end

    # Get a single automate session
    def self.session_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetAutomateSession {
          automateSession(id: "#{escaped_id}") {
            id
            name
            connection {
              host
              port
              isTls
            }
            settings {
              updateContentLength
              updateHostHeader
              followRedirects
              maxRedirects
            }
            createdAt
          }
        }
      )
    end

    # Get automate tasks
    def self.tasks(after : String? = nil, first : Int32 = 50)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetAutomateTasks {
          automateTasks(#{after_clause} first: #{first}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              paused
              createdAt
            }
          }
        }
      )
    end

    # Get a single automate entry
    def self.entry_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetAutomateEntry {
          automateEntry(id: "#{escaped_id}") {
            id
            createdAt
            request {
              id
              host
              port
              path
              method
              isTls
            }
            response {
              id
              statusCode
              roundtripTime
              length
            }
          }
        }
      )
    end
  end

  module Viewer
    # Get current user information
    def self.info
      %Q(
        query GetViewer {
          viewer {
            id
            username
            settings {
              data
            }
          }
        }
      )
    end
  end

  module Runtime
    # Get runtime information
    def self.info
      %Q(
        query GetRuntime {
          runtime {
            version
            platform
            availableUpdate
            supportedQueries
          }
        }
      )
    end
  end

  module InstanceSettings
    # Get instance settings
    def self.get
      %Q(
        query GetInstanceSettings {
          instanceSettings {
            theme
            language
            license {
              name
              expiry
            }
            ai {
              providers {
                anthropic {
                  apiKey
                }
                openai {
                  apiKey
                  url
                }
                google {
                  apiKey
                }
                openrouter {
                  apiKey
                }
              }
              model
            }
          }
        }
      )
    end
  end

  module DNS
    # Get DNS rewrites
    def self.rewrites
      %Q(
        query GetDNSRewrites {
          dnsRewrites {
            id
            enabled
            rank
            name
            strategy
            source
            destination
          }
        }
      )
    end

    # Get DNS upstreams
    def self.upstreams
      %Q(
        query GetDNSUpstreams {
          dnsUpstreams {
            id
            name
            kind
            address
          }
        }
      )
    end
  end

  module UpstreamProxies
    # Get HTTP upstream proxies
    def self.http
      %Q(
        query GetUpstreamProxiesHttp {
          upstreamProxiesHttp {
            id
            enabled
            rank
            allowlist
            denylist
            kind
            address
            authentication {
              username
              password
            }
          }
        }
      )
    end

    # Get SOCKS upstream proxies
    def self.socks
      %Q(
        query GetUpstreamProxiesSocks {
          upstreamProxiesSocks {
            id
            enabled
            rank
            allowlist
            denylist
            kind
            address
            authentication {
              username
              password
            }
          }
        }
      )
    end
  end

  module Tamper
    # Get all tamper rules
    def self.rules
      %Q(
        query GetTamperRules {
          tamperRuleCollections {
            id
            name
            rules {
              id
              name
              enabled
              rank
              condition
              strategy
            }
          }
        }
      )
    end

    # Get a single tamper rule
    def self.rule_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetTamperRule {
          tamperRule(id: "#{escaped_id}") {
            id
            name
            enabled
            rank
            condition
            strategy
            collection {
              id
              name
            }
          }
        }
      )
    end

    # Get a single tamper rule collection by ID
    def self.collection_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetTamperRuleCollection {
          tamperRuleCollection(id: "#{escaped_id}") {
            id
            name
            rules {
              id
              name
              enabled
              rank
              condition
              strategy
            }
          }
        }
      )
    end
  end

  module Assistant
    # Get assistant sessions (requires cloud)
    def self.sessions
      %Q(
        query GetAssistantSessions {
          assistantSessions {
            id
            name
            modelId
            createdAt
          }
        }
      )
    end

    # Get assistant models (requires cloud)
    def self.models
      %Q(
        query GetAssistantModels {
          assistantModels {
            id
            name
            provider
          }
        }
      )
    end

    # Get a single assistant session by ID
    def self.session_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetAssistantSession {
          assistantSession(id: "#{escaped_id}") {
            id
            name
            modelId
            createdAt
            messages {
              id
              content
              role
              createdAt
            }
          }
        }
      )
    end
  end

  module Environments
    # Get all environments (requires cloud)
    def self.all
      %Q(
        query GetEnvironments {
          environments {
            id
            name
            data
          }
        }
      )
    end

    # Get environment context
    def self.context
      %Q(
        query GetEnvironmentContext {
          environmentContext {
            selectedId
          }
        }
      )
    end

    # Get a single environment by ID
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetEnvironment {
          environment(id: "#{escaped_id}") {
            id
            name
            data
          }
        }
      )
    end
  end

  module Plugins
    # Get all plugin packages
    def self.packages
      %Q(
        query GetPluginPackages {
          pluginPackages {
            id
            name
            version
            author
            description
            enabled
          }
        }
      )
    end
  end

  module Streams
    # Get a single stream by ID
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetStream {
          stream(id: "#{escaped_id}") {
            id
            host
            port
            isTls
            protocol
            createdAt
            request {
              id
            }
          }
        }
      )
    end

    # Get all streams with cursor pagination
    def self.all(after : String? = nil, first : Int32 = 50, protocol : String? = nil, scope_id : String? = nil)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""
      protocol_clause = protocol ? %Q(protocol: #{protocol}) : ""
      scope_clause = scope_id ? %Q(scopeId: "#{CaidoUtils.escape_graphql_string(scope_id)}") : ""

      %Q(
        query GetStreams {
          streams(#{after_clause} first: #{first} #{protocol_clause} #{scope_clause}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              host
              port
              isTls
              protocol
              createdAt
            }
          }
        }
      )
    end

    # Get streams by offset
    def self.by_offset(offset : Int32 = 0, limit : Int32 = 50, protocol : String? = nil, scope_id : String? = nil)
      protocol_clause = protocol ? %Q(protocol: #{protocol}) : ""
      scope_clause = scope_id ? %Q(scopeId: "#{CaidoUtils.escape_graphql_string(scope_id)}") : ""

      %Q(
        query GetStreamsByOffset {
          streamsByOffset(offset: #{offset} limit: #{limit} #{protocol_clause} #{scope_clause}) {
            nodes {
              id
              host
              port
              isTls
              protocol
              createdAt
            }
          }
        }
      )
    end

    # Get a single WebSocket message
    def self.ws_message_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetStreamWsMessage {
          streamWsMessage(id: "#{escaped_id}") {
            id
            length
            direction
            createdAt
            streamId
            raw
          }
        }
      )
    end

    # Get WebSocket messages with cursor pagination
    def self.ws_messages(stream_id : String, after : String? = nil, first : Int32 = 50)
      escaped_stream_id = CaidoUtils.escape_graphql_string(stream_id)
      after_clause = after ? %Q(after: "#{CaidoUtils.escape_graphql_string(after)}") : ""

      %Q(
        query GetStreamWsMessages {
          streamWsMessages(streamId: "#{escaped_stream_id}" #{after_clause} first: #{first}) {
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            nodes {
              id
              length
              direction
              createdAt
              streamId
              raw
            }
          }
        }
      )
    end

    # Get WebSocket messages by offset
    def self.ws_messages_by_offset(stream_id : String, offset : Int32 = 0, limit : Int32 = 50)
      escaped_stream_id = CaidoUtils.escape_graphql_string(stream_id)

      %Q(
        query GetStreamWsMessagesByOffset {
          streamWsMessagesByOffset(streamId: "#{escaped_stream_id}" offset: #{offset} limit: #{limit}) {
            nodes {
              id
              length
              direction
              createdAt
              streamId
              raw
            }
          }
        }
      )
    end

    # Get a WebSocket message edit
    def self.ws_message_edit_by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetStreamWsMessageEdit {
          streamWsMessageEdit(id: "#{escaped_id}") {
            id
            raw
          }
        }
      )
    end
  end

  module FilterPresets
    # Get all filter presets
    def self.all
      %Q(
        query GetFilterPresets {
          filterPresets {
            id
            alias
            name
            clause
          }
        }
      )
    end

    # Get a single filter preset by ID
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetFilterPreset {
          filterPreset(id: "#{escaped_id}") {
            id
            alias
            name
            clause
          }
        }
      )
    end
  end

  module Backups
    # Get all backups
    def self.all
      %Q(
        query GetBackups {
          backups {
            id
            name
            path
            size
            status
            createdAt
            project {
              id
              name
            }
          }
        }
      )
    end

    # Get a single backup by ID
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetBackup {
          backup(id: "#{escaped_id}") {
            id
            name
            path
            size
            status
            createdAt
            project {
              id
              name
            }
          }
        }
      )
    end

    # Get backup tasks
    def self.tasks
      %Q(
        query GetBackupTasks {
          backupTasks {
            id
            backup {
              id
              name
            }
          }
        }
      )
    end

    # Get restore backup tasks
    def self.restore_tasks
      %Q(
        query GetRestoreBackupTasks {
          restoreBackupTasks {
            id
            backup {
              id
              name
            }
          }
        }
      )
    end
  end

  module DataExports
    # Get all data exports
    def self.all
      %Q(
        query GetDataExports {
          dataExports {
            id
            name
            path
            size
            status
            format
            error
            createdAt
          }
        }
      )
    end

    # Get a single data export by ID
    def self.by_id(id : String)
      escaped_id = CaidoUtils.escape_graphql_string(id)
      %Q(
        query GetDataExport {
          dataExport(id: "#{escaped_id}") {
            id
            name
            path
            size
            status
            format
            error
            createdAt
          }
        }
      )
    end
  end

  module HostedFiles
    # Get all hosted files
    def self.all
      %Q(
        query GetHostedFiles {
          hostedFiles {
            id
            name
            path
            size
            updatedAt
            createdAt
          }
        }
      )
    end
  end

  module BrowserInfo
    # Get browser information
    def self.info
      %Q(
        query GetBrowser {
          browser {
            id
            installedBrowser {
              path
              version
            }
            latestBrowser {
              version
            }
          }
        }
      )
    end
  end

  module UpstreamPluginsList
    # Get all upstream plugins
    def self.all
      %Q(
        query GetUpstreamPlugins {
          upstreamPlugins {
            id
            enabled
            rank
            pluginId
          }
        }
      )
    end
  end

  module GlobalConfigQuery
    # Get global configuration
    def self.get
      %Q(
        query GetGlobalConfig {
          globalConfig {
            address
          }
        }
      )
    end
  end

  module TasksQuery
    # Get all tasks
    def self.all
      %Q(
        query GetTasks {
          tasks {
            id
            kind
          }
        }
      )
    end
  end

  module Store
    # Get plugin store info
    def self.info
      %Q(
        query GetStore {
          store {
            pluginPackages {
              id
              name
              version
              description
              author
            }
          }
        }
      )
    end
  end

  module AuthenticationQuery
    # Get authentication state
    def self.state
      %Q(
        query GetAuthenticationState {
          authenticationState {
            isAuthenticated
          }
        }
      )
    end
  end
end
