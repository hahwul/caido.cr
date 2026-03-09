# GraphQL Endpoint Coverage

This document lists the GraphQL endpoints from the [Caido GraphQL schema](https://github.com/caido/graphql-explorer/blob/main/src/assets/schema.graphql) and their implementation status in caido-crystal.

## Query Endpoints (QueryRoot)

| Endpoint | Module | Method | Status |
|----------|--------|--------|--------|
| assistantModels | CaidoQueries::Assistant | models | ✅ |
| assistantSession | CaidoQueries::Assistant | session_by_id | ✅ |
| assistantSessions | CaidoQueries::Assistant | sessions | ✅ |
| authenticationState | CaidoQueries::AuthenticationQuery | state | ✅ |
| automateEntry | CaidoQueries::Automate | entry_by_id | ✅ |
| automateSession | CaidoQueries::Automate | session_by_id | ✅ |
| automateSessions | CaidoQueries::Automate | sessions | ✅ |
| automateTasks | CaidoQueries::Automate | tasks | ✅ |
| backup | CaidoQueries::Backups | by_id | ✅ |
| backupTasks | CaidoQueries::Backups | tasks | ✅ |
| backups | CaidoQueries::Backups | all | ✅ |
| browser | CaidoQueries::BrowserInfo | info | ✅ |
| currentProject | CaidoQueries::Projects | current | ✅ |
| dataExport | CaidoQueries::DataExports | by_id | ✅ |
| dataExports | CaidoQueries::DataExports | all | ✅ |
| dnsRewrites | CaidoQueries::DNS | rewrites | ✅ |
| dnsUpstreams | CaidoQueries::DNS | upstreams | ✅ |
| environment | CaidoQueries::Environments | by_id | ✅ |
| environmentContext | CaidoQueries::Environments | context | ✅ |
| environments | CaidoQueries::Environments | all | ✅ |
| filterPreset | CaidoQueries::FilterPresets | by_id | ✅ |
| filterPresets | CaidoQueries::FilterPresets | all | ✅ |
| finding | CaidoQueries::Findings | by_id | ✅ |
| findingReporters | CaidoQueries::Findings | reporters | ✅ |
| findings | CaidoQueries::Findings | all | ✅ |
| findingsByOffset | CaidoQueries::Findings | by_offset | ✅ |
| globalConfig | CaidoQueries::GlobalConfigQuery | get | ✅ |
| hostedFiles | CaidoQueries::HostedFiles | all | ✅ |
| instanceSettings | CaidoQueries::InstanceSettings | get | ✅ |
| interceptEntries | CaidoQueries::Intercept | entries | ✅ |
| interceptEntriesByOffset | CaidoQueries::Intercept | entries_by_offset | ✅ |
| interceptEntry | CaidoQueries::Intercept | entry_by_id | ✅ |
| interceptEntryOffset | CaidoQueries::Intercept | entry_offset | ✅ |
| interceptMessages | CaidoQueries::Intercept | messages | ✅ |
| interceptOptions | CaidoQueries::Intercept | options | ✅ |
| interceptStatus | CaidoQueries::Intercept | status | ✅ |
| pluginPackages | CaidoQueries::Plugins | packages | ✅ |
| projects | CaidoQueries::Projects | all | ✅ |
| replayEntry | CaidoQueries::Replay | entry_by_id | ✅ |
| replaySession | CaidoQueries::Replay | session_by_id | ✅ |
| replaySessionCollections | CaidoQueries::Replay | collections | ✅ |
| replaySessions | CaidoQueries::Replay | sessions | ✅ |
| request | CaidoQueries::Requests | by_id | ✅ |
| requestOffset | CaidoQueries::Requests | request_offset | ✅ |
| requests | CaidoQueries::Requests | all | ✅ |
| requestsByOffset | CaidoQueries::Requests | by_offset | ✅ |
| response | CaidoQueries::Requests | response_by_id | ✅ |
| restoreBackupTasks | CaidoQueries::Backups | restore_tasks | ✅ |
| runtime | CaidoQueries::Runtime | info | ✅ |
| scope | CaidoQueries::Scopes | by_id | ✅ |
| scopes | CaidoQueries::Scopes | all | ✅ |
| sitemapDescendantEntries | CaidoQueries::Sitemap | descendant_entries | ✅ |
| sitemapEntry | CaidoQueries::Sitemap | by_id | ✅ |
| sitemapRootEntries | CaidoQueries::Sitemap | root_entries | ✅ |
| store | CaidoQueries::Store | info | ✅ |
| stream | CaidoQueries::Streams | by_id | ✅ |
| streamWsMessage | CaidoQueries::Streams | ws_message_by_id | ✅ |
| streamWsMessageEdit | CaidoQueries::Streams | ws_message_edit_by_id | ✅ |
| streamWsMessages | CaidoQueries::Streams | ws_messages | ✅ |
| streamWsMessagesByOffset | CaidoQueries::Streams | ws_messages_by_offset | ✅ |
| streams | CaidoQueries::Streams | all | ✅ |
| streamsByOffset | CaidoQueries::Streams | by_offset | ✅ |
| tamperRule | CaidoQueries::Tamper | rule_by_id | ✅ |
| tamperRuleCollection | CaidoQueries::Tamper | collection_by_id | ✅ |
| tamperRuleCollections | CaidoQueries::Tamper | rules | ✅ |
| tasks | CaidoQueries::TasksQuery | all | ✅ |
| upstreamPlugins | CaidoQueries::UpstreamPluginsList | all | ✅ |
| upstreamProxiesHttp | CaidoQueries::UpstreamProxies | http | ✅ |
| upstreamProxiesSocks | CaidoQueries::UpstreamProxies | socks | ✅ |
| viewer | CaidoQueries::Viewer | info | ✅ |
| workflow | CaidoQueries::Workflows | by_id | ✅ |
| workflowNodeDefinitions | CaidoQueries::Workflows | node_definitions | ✅ |
| workflows | CaidoQueries::Workflows | all | ✅ |

## Mutation Endpoints (MutationRoot)

| Mutation | Module | Method | Status |
|----------|--------|--------|--------|
| cancelAutomateTask | CaidoMutations::Automate | cancel_task | ✅ |
| cancelBackupTask | CaidoMutations::BackupsMutations | cancel_task | ✅ |
| cancelRestoreBackupTask | CaidoMutations::BackupsMutations | cancel_restore_task | ✅ |
| cancelTask | CaidoMutations::Tasks | cancel | ✅ |
| clearSitemapEntries | CaidoMutations::Sitemap | clear_all | ✅ |
| createAssistantSession | CaidoMutations::Assistant | create_session | ✅ |
| createAutomateSession | CaidoMutations::Automate | create_session | ✅ |
| createBackup | CaidoMutations::BackupsMutations | create | ✅ |
| createDnsRewrite | CaidoMutations::DNS | create_rewrite | ✅ |
| createDnsUpstream | CaidoMutations::DNS | create_upstream | ✅ |
| createEnvironment | CaidoMutations::Environments | create | ✅ |
| createFilterPreset | CaidoMutations::FilterPresetsMutations | create | ✅ |
| createFinding | CaidoMutations::Findings | create | ✅ |
| createProject | CaidoMutations::Projects | create | ✅ |
| createReplaySession | CaidoMutations::Replay | create_session | ✅ |
| createReplaySessionCollection | CaidoMutations::Replay | create_collection | ✅ |
| createScope | CaidoMutations::Scopes | create | ✅ |
| createSitemapEntries | CaidoMutations::Sitemap | create_entries | ✅ |
| createTamperRule | CaidoMutations::Tamper | create_rule | ✅ |
| createTamperRuleCollection | CaidoMutations::Tamper | create_collection | ✅ |
| createUpstreamPlugin | CaidoMutations::UpstreamPluginsMutations | create | ✅ |
| createUpstreamProxyHttp | CaidoMutations::UpstreamProxies | create_http | ✅ |
| createUpstreamProxySocks | CaidoMutations::UpstreamProxies | create_socks | ✅ |
| createWorkflow | CaidoMutations::Workflows | create | ✅ |
| deleteAssistantSession | CaidoMutations::Assistant | delete_session | ✅ |
| deleteAutomateEntries | CaidoMutations::Automate | delete_entries | ✅ |
| deleteAutomateSession | CaidoMutations::Automate | delete_session | ✅ |
| deleteBackup | CaidoMutations::BackupsMutations | delete | ✅ |
| deleteBrowser | CaidoMutations::BrowserMutations | delete | ✅ |
| deleteDataExport | CaidoMutations::DataExportsMutations | delete | ✅ |
| deleteDnsRewrite | CaidoMutations::DNS | delete_rewrite | ✅ |
| deleteDnsUpstream | CaidoMutations::DNS | delete_upstream | ✅ |
| deleteEnvironment | CaidoMutations::Environments | delete | ✅ |
| deleteFilterPreset | CaidoMutations::FilterPresetsMutations | delete | ✅ |
| deleteFindings | CaidoMutations::Findings | delete | ✅ |
| deleteHostedFile | CaidoMutations::HostedFilesMutations | delete | ✅ |
| deleteInterceptEntries | CaidoMutations::Intercept | delete_entries | ✅ |
| deleteInterceptEntry | CaidoMutations::Intercept | delete_entry | ✅ |
| deleteProject | CaidoMutations::Projects | delete | ✅ |
| deleteReplaySessionCollection | CaidoMutations::Replay | delete_collection | ✅ |
| deleteReplaySessions | CaidoMutations::Replay | delete_sessions | ✅ |
| deleteScope | CaidoMutations::Scopes | delete | ✅ |
| deleteSitemapEntries | CaidoMutations::Sitemap | delete_entries | ✅ |
| deleteTamperRule | CaidoMutations::Tamper | delete_rule | ✅ |
| deleteTamperRuleCollection | CaidoMutations::Tamper | delete_collection | ✅ |
| deleteUpstreamPlugin | CaidoMutations::UpstreamPluginsMutations | delete | ✅ |
| deleteUpstreamProxyHttp | CaidoMutations::UpstreamProxies | delete_http | ✅ |
| deleteUpstreamProxySocks | CaidoMutations::UpstreamProxies | delete_socks | ✅ |
| deleteWorkflow | CaidoMutations::Workflows | delete | ✅ |
| dropInterceptMessage | CaidoMutations::Intercept | drop_message | ✅ |
| duplicateAutomateSession | CaidoMutations::Automate | duplicate_session | ✅ |
| exportFindings | CaidoMutations::Findings | export | ✅ |
| exportTamper | CaidoMutations::Tamper | export | ✅ |
| forwardInterceptMessage | CaidoMutations::Intercept | forward_message | ✅ |
| globalizeWorkflow | CaidoMutations::Workflows | globalize | ✅ |
| hideFindings | CaidoMutations::Findings | hide | ✅ |
| importCertificate | CaidoMutations::CertificateMutations | import | ✅ |
| installBrowser | CaidoMutations::BrowserMutations | install | ✅ |
| installPluginPackage | CaidoMutations::PluginsMutations | install | ✅ |
| localizeWorkflow | CaidoMutations::Workflows | localize | ✅ |
| loginAsGuest | CaidoMutations::Authentication | login_guest | ✅ |
| logout | CaidoMutations::Authentication | logout | ✅ |
| moveReplaySession | CaidoMutations::Replay | move_session | ✅ |
| moveTamperRule | CaidoMutations::Tamper | move_rule | ✅ |
| pauseAutomateTask | CaidoMutations::Automate | pause_task | ✅ |
| pauseIntercept | CaidoMutations::Intercept | pause | ✅ |
| persistProject | CaidoMutations::Projects | persist | ✅ |
| rankDnsRewrite | CaidoMutations::DNS | rank_rewrite | ✅ |
| rankTamperRule | CaidoMutations::Tamper | rank_rule | ✅ |
| rankUpstreamPlugin | CaidoMutations::UpstreamPluginsMutations | rank | ✅ |
| rankUpstreamProxyHttp | CaidoMutations::UpstreamProxies | rank_http | ✅ |
| rankUpstreamProxySocks | CaidoMutations::UpstreamProxies | rank_socks | ✅ |
| refreshAuthenticationToken | CaidoMutations::Authentication | refresh_token | ✅ |
| regenerateCertificate | CaidoMutations::CertificateMutations | regenerate | ✅ |
| renameAssistantSession | CaidoMutations::Assistant | rename_session | ✅ |
| renameAutomateEntry | CaidoMutations::Automate | rename_entry | ✅ |
| renameAutomateSession | CaidoMutations::Automate | rename_session | ✅ |
| renameBackup | CaidoMutations::BackupsMutations | rename | ✅ |
| renameDataExport | CaidoMutations::DataExportsMutations | rename | ✅ |
| renameHostedFile | CaidoMutations::HostedFilesMutations | rename | ✅ |
| renameProject | CaidoMutations::Projects | rename | ✅ |
| renameReplaySession | CaidoMutations::Replay | rename_session | ✅ |
| renameReplaySessionCollection | CaidoMutations::Replay | rename_collection | ✅ |
| renameScope | CaidoMutations::Scopes | rename | ✅ |
| renameTamperRule | CaidoMutations::Tamper | rename_rule | ✅ |
| renameTamperRuleCollection | CaidoMutations::Tamper | rename_collection | ✅ |
| renameWorkflow | CaidoMutations::Workflows | rename | ✅ |
| renderRequest | CaidoMutations::Requests | render | ✅ |
| restoreBackup | CaidoMutations::BackupsMutations | restore | ✅ |
| resumeAutomateTask | CaidoMutations::Automate | resume_task | ✅ |
| resumeIntercept | CaidoMutations::Intercept | resume | ✅ |
| runActiveWorkflow | CaidoMutations::Workflows | run_active | ✅ |
| runConvertWorkflow | CaidoMutations::Workflows | run_convert | ✅ |
| selectEnvironment | CaidoMutations::Environments | select | ✅ |
| selectProject | CaidoMutations::Projects | select | ✅ |
| sendAssistantMessage | CaidoMutations::Assistant | send_message | ✅ |
| setGlobalConfigPort | CaidoMutations::SettingsMutations | set_port | ✅ |
| setInstanceSettings | CaidoMutations::SettingsMutations | set_instance | ✅ |
| setInterceptOptions | CaidoMutations::Intercept | set_options | ✅ |
| setPluginData | CaidoMutations::PluginsMutations | set_data | ✅ |
| startAuthenticationFlow | CaidoMutations::Authentication | start_flow | ✅ |
| startAutomateTask | CaidoMutations::Automate | start_task | ✅ |
| startExportRequestsTask | CaidoMutations::DataExportsMutations | start_export_requests | ✅ |
| startReplayTask | CaidoMutations::Replay | start_task | ✅ |
| testTamperRule | CaidoMutations::Tamper | test_rule | ✅ |
| testUpstreamProxyHttp | CaidoMutations::UpstreamProxies | test_http | ✅ |
| testUpstreamProxySocks | CaidoMutations::UpstreamProxies | test_socks | ✅ |
| testWorkflowActive | CaidoMutations::Workflows | test_active | ✅ |
| testWorkflowConvert | CaidoMutations::Workflows | test_convert | ✅ |
| testWorkflowPassive | CaidoMutations::Workflows | test_passive | ✅ |
| toggleDnsRewrite | CaidoMutations::DNS | toggle_rewrite | ✅ |
| togglePlugin | CaidoMutations::PluginsMutations | toggle | ✅ |
| toggleTamperRule | CaidoMutations::Tamper | toggle_rule | ✅ |
| toggleUpstreamPlugin | CaidoMutations::UpstreamPluginsMutations | toggle | ✅ |
| toggleUpstreamProxyHttp | CaidoMutations::UpstreamProxies | toggle_http | ✅ |
| toggleUpstreamProxySocks | CaidoMutations::UpstreamProxies | toggle_socks | ✅ |
| toggleWorkflow | CaidoMutations::Workflows | toggle | ✅ |
| uninstallPluginPackage | CaidoMutations::PluginsMutations | uninstall | ✅ |
| updateAutomateSession | CaidoMutations::Automate | update_session | ✅ |
| updateBrowser | CaidoMutations::BrowserMutations | update | ✅ |
| updateDnsRewrite | CaidoMutations::DNS | update_rewrite | ✅ |
| updateDnsUpstream | CaidoMutations::DNS | update_upstream | ✅ |
| updateEnvironment | CaidoMutations::Environments | update | ✅ |
| updateFilterPreset | CaidoMutations::FilterPresetsMutations | update | ✅ |
| updateFinding | CaidoMutations::Findings | update | ✅ |
| updateRequestMetadata | CaidoMutations::Requests | update_metadata | ✅ |
| updateScope | CaidoMutations::Scopes | update | ✅ |
| updateTamperRule | CaidoMutations::Tamper | update_rule | ✅ |
| updateUpstreamPlugin | CaidoMutations::UpstreamPluginsMutations | update | ✅ |
| updateUpstreamProxyHttp | CaidoMutations::UpstreamProxies | update_http | ✅ |
| updateUpstreamProxySocks | CaidoMutations::UpstreamProxies | update_socks | ✅ |
| updateViewerSettings | CaidoMutations::SettingsMutations | update_viewer | ✅ |
| updateWorkflow | CaidoMutations::Workflows | update | ✅ |

## Coverage Summary

- **Query Endpoints**: 73/73 ✅ (100%)
- **Mutation Endpoints**: 126/140 ✅ (90%)
- **Total Helper Methods**: 190+

### Remaining Mutations (low-priority / special cases)

These mutations are intentionally not covered as they involve special handling (file uploads, analytics tracking, etc.):

| Mutation | Reason |
|----------|--------|
| importData | Requires file upload handling |
| uploadHostedFile | Requires file upload handling |
| setActiveReplaySessionEntry | Deprecated |
| setGlobalConfigProject | Rarely used directly |
| setProjectConfigStream | Requires complex config object |
| testAiProvider | Requires AI provider config object |
| track | Internal analytics, not user-facing |

## Legend

- ✅ = Implemented

## Adding New Endpoints

To add a new endpoint helper:

1. **For queries**: Add a new method in the appropriate module under `CaidoQueries`
2. **For mutations**: Add a new method in the appropriate module under `CaidoMutations`
3. Follow the existing pattern of using heredoc strings with parameterized values
4. Update this coverage document
5. Add examples to ENDPOINTS.md

Example:
```crystal
module CaidoQueries
  module MyFeature
    def self.my_method(param : String)
      escaped_param = CaidoUtils.escape_graphql_string(param)
      %Q(
        query MyQuery {
          myEndpoint(id: "#{escaped_param}") {
            id
            name
          }
        }
      )
    end
  end
end
```
