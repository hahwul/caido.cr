require "./spec_helper"

describe Caido::Crystal do
  it "has a version" do
    Caido::Crystal::VERSION.should eq("0.1.0")
  end
end

describe CaidoUtils do
  describe ".escape_graphql_string" do
    it "escapes backslashes" do
      CaidoUtils.escape_graphql_string("test\\path").should eq("test\\\\path")
    end

    it "escapes double quotes" do
      CaidoUtils.escape_graphql_string(%q(test"value)).should eq(%q(test\"value))
    end

    it "escapes newlines" do
      CaidoUtils.escape_graphql_string("test\nvalue").should eq("test\\nvalue")
    end

    it "escapes carriage returns" do
      CaidoUtils.escape_graphql_string("test\rvalue").should eq("test\\rvalue")
    end

    it "escapes tabs" do
      CaidoUtils.escape_graphql_string("test\tvalue").should eq("test\\tvalue")
    end

    it "escapes backspace" do
      CaidoUtils.escape_graphql_string("test\bvalue").should eq("test\\bvalue")
    end

    it "escapes form feed" do
      CaidoUtils.escape_graphql_string("test\fvalue").should eq("test\\fvalue")
    end

    it "handles multiple special characters" do
      input = %q(test"with\nnewline)
      expected = %q(test\"with\\nnewline)
      CaidoUtils.escape_graphql_string(input).should eq(expected)
    end

    it "returns empty string unchanged" do
      CaidoUtils.escape_graphql_string("").should eq("")
    end

    it "returns normal string unchanged" do
      CaidoUtils.escape_graphql_string("normal string").should eq("normal string")
    end
  end

  describe ".build_filter_clause" do
    it "returns empty string for nil filter" do
      CaidoUtils.build_filter_clause(nil).should eq("")
    end

    it "builds filter clause with escaped value" do
      CaidoUtils.build_filter_clause("host:example.com").should eq(%Q(filter: "host:example.com"))
    end

    it "escapes special characters in filter" do
      CaidoUtils.build_filter_clause(%q(path:"test")).should eq(%Q(filter: "path:\\"test\\""))
    end
  end

  describe ".build_string_array" do
    it "returns empty string for empty array" do
      CaidoUtils.build_string_array([] of String).should eq("")
    end

    it "builds array with single item" do
      CaidoUtils.build_string_array(["item1"]).should eq(%Q("item1"))
    end

    it "builds array with multiple items" do
      CaidoUtils.build_string_array(["item1", "item2"]).should eq(%Q("item1", "item2"))
    end

    it "escapes special characters in items" do
      CaidoUtils.build_string_array([%q(test"value)]).should eq(%Q("test\\"value"))
    end
  end

  describe ".build_pagination" do
    it "returns empty string when no pagination" do
      CaidoUtils.build_pagination.should eq("")
    end

    it "builds after clause only" do
      CaidoUtils.build_pagination(after: "cursor123").should eq(%Q(after: "cursor123"))
    end

    it "builds first clause only" do
      CaidoUtils.build_pagination(first: 50).should eq("first: 50")
    end

    it "builds both after and first clauses" do
      CaidoUtils.build_pagination(after: "cursor123", first: 50).should eq(%Q(after: "cursor123" first: 50))
    end
  end
end

describe CaidoQueries::Requests do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::Requests.all
      query.should contain("query GetRequests")
      query.should contain("first: 50")
    end

    it "includes filter when provided" do
      query = CaidoQueries::Requests.all(filter: "host:example.com")
      query.should contain(%Q(filter: "host:example.com"))
    end

    it "escapes filter value" do
      query = CaidoQueries::Requests.all(filter: %q(path:"test"))
      query.should contain(%Q(filter: "path:\\"test\\""))
    end
  end

  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::Requests.by_id("123")
      query.should contain("query GetRequest")
      query.should contain(%Q(id: "123"))
    end

    it "escapes id value" do
      query = CaidoQueries::Requests.by_id(%q(123"456))
      query.should contain(%Q(id: "123\\"456"))
    end
  end
end

describe CaidoMutations::Scopes do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Scopes.create("Test Scope", ["*.example.com"])
      mutation.should contain("mutation CreateScope")
      mutation.should contain(%Q(name: "Test Scope"))
      mutation.should contain(%Q("*.example.com"))
    end

    it "escapes name value" do
      mutation = CaidoMutations::Scopes.create(%q(Test"Scope), ["*.example.com"])
      mutation.should contain(%Q(name: "Test\\"Scope"))
    end
  end

  describe ".rename" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Scopes.rename("scope123", "New Name")
      mutation.should contain("mutation RenameScope")
      mutation.should contain(%Q(id: "scope123"))
      mutation.should contain(%Q(name: "New Name"))
    end

    it "escapes both id and name" do
      mutation = CaidoMutations::Scopes.rename(%q(id"123), %q(name"test))
      mutation.should contain(%Q(id: "id\\"123"))
      mutation.should contain(%Q(name: "name\\"test"))
    end
  end
end

describe CaidoMutations::Findings do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Findings.create("req123", "XSS Found", "Description")
      mutation.should contain("mutation CreateFinding")
      mutation.should contain(%Q(requestId: "req123"))
      mutation.should contain(%Q(title: "XSS Found"))
    end

    it "escapes title and description" do
      mutation = CaidoMutations::Findings.create("req123", %q(XSS "vulnerability"), %q(Found in "path"))
      mutation.should contain(%Q(title: "XSS \\"vulnerability\\""))
      mutation.should contain(%Q(description: "Found in \\"path\\""))
    end
  end
end

describe CaidoMutations::Assistant do
  describe ".send_message" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Assistant.send_message("session123", "Hello")
      mutation.should contain("mutation SendAssistantMessage")
      mutation.should contain(%Q(sessionId: "session123"))
      mutation.should contain(%Q(message: "Hello"))
    end

    it "escapes message content" do
      mutation = CaidoMutations::Assistant.send_message("session123", %q(Say "hello"))
      mutation.should contain(%Q(message: "Say \\"hello\\""))
    end
  end
end

# ===== New Query Module Tests =====

describe CaidoQueries::Requests do
  describe ".request_offset" do
    it "generates valid query" do
      query = CaidoQueries::Requests.request_offset("123")
      query.should contain("query GetRequestOffset")
      query.should contain(%Q(id: "123"))
    end
  end

  describe ".response_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Requests.response_by_id("resp123")
      query.should contain("query GetResponse")
      query.should contain(%Q(id: "resp123"))
      query.should contain("statusCode")
      query.should contain("raw")
    end
  end
end

describe CaidoQueries::Intercept do
  describe ".entries_by_offset" do
    it "generates valid query" do
      query = CaidoQueries::Intercept.entries_by_offset
      query.should contain("query GetInterceptEntriesByOffset")
      query.should contain("offset: 0")
      query.should contain("limit: 50")
    end

    it "includes filter when provided" do
      query = CaidoQueries::Intercept.entries_by_offset(filter: "host:example.com")
      query.should contain(%Q(filter: "host:example.com"))
    end
  end

  describe ".entry_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Intercept.entry_by_id("entry123")
      query.should contain("query GetInterceptEntry")
      query.should contain(%Q(id: "entry123"))
    end

    it "escapes id value" do
      query = CaidoQueries::Intercept.entry_by_id(%q(id"123))
      query.should contain(%Q(id: "id\\"123"))
    end
  end

  describe ".entry_offset" do
    it "generates valid query" do
      query = CaidoQueries::Intercept.entry_offset("entry123")
      query.should contain("query GetInterceptEntryOffset")
      query.should contain(%Q(id: "entry123"))
    end
  end

  describe ".messages" do
    it "generates valid query" do
      query = CaidoQueries::Intercept.messages
      query.should contain("query GetInterceptMessages")
      query.should contain("first: 50")
    end
  end
end

describe CaidoQueries::Findings do
  describe ".by_offset" do
    it "generates valid query" do
      query = CaidoQueries::Findings.by_offset
      query.should contain("query GetFindingsByOffset")
      query.should contain("offset: 0")
      query.should contain("limit: 50")
    end
  end
end

describe CaidoQueries::Replay do
  describe ".entry_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Replay.entry_by_id("entry123")
      query.should contain("query GetReplayEntry")
      query.should contain(%Q(id: "entry123"))
    end
  end
end

describe CaidoQueries::Automate do
  describe ".entry_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Automate.entry_by_id("entry123")
      query.should contain("query GetAutomateEntry")
      query.should contain(%Q(id: "entry123"))
    end
  end
end

describe CaidoQueries::Tamper do
  describe ".collection_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Tamper.collection_by_id("col123")
      query.should contain("query GetTamperRuleCollection")
      query.should contain(%Q(id: "col123"))
    end
  end
end

describe CaidoQueries::Assistant do
  describe ".session_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Assistant.session_by_id("session123")
      query.should contain("query GetAssistantSession")
      query.should contain(%Q(id: "session123"))
      query.should contain("messages")
    end
  end
end

describe CaidoQueries::Environments do
  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::Environments.by_id("env123")
      query.should contain("query GetEnvironment")
      query.should contain(%Q(id: "env123"))
    end
  end
end

describe CaidoQueries::Streams do
  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::Streams.by_id("stream123")
      query.should contain("query GetStream")
      query.should contain(%Q(id: "stream123"))
    end
  end

  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::Streams.all
      query.should contain("query GetStreams")
      query.should contain("first: 50")
    end
  end

  describe ".by_offset" do
    it "generates valid query" do
      query = CaidoQueries::Streams.by_offset
      query.should contain("query GetStreamsByOffset")
      query.should contain("offset: 0")
    end
  end

  describe ".ws_message_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Streams.ws_message_by_id("msg123")
      query.should contain("query GetStreamWsMessage")
      query.should contain(%Q(id: "msg123"))
    end
  end

  describe ".ws_messages" do
    it "generates valid query" do
      query = CaidoQueries::Streams.ws_messages("stream123")
      query.should contain("query GetStreamWsMessages")
      query.should contain(%Q(streamId: "stream123"))
    end
  end

  describe ".ws_messages_by_offset" do
    it "generates valid query" do
      query = CaidoQueries::Streams.ws_messages_by_offset("stream123")
      query.should contain("query GetStreamWsMessagesByOffset")
      query.should contain(%Q(streamId: "stream123"))
    end
  end

  describe ".ws_message_edit_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Streams.ws_message_edit_by_id("edit123")
      query.should contain("query GetStreamWsMessageEdit")
      query.should contain(%Q(id: "edit123"))
    end
  end
end

describe CaidoQueries::FilterPresets do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::FilterPresets.all
      query.should contain("query GetFilterPresets")
      query.should contain("filterPresets")
    end
  end

  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::FilterPresets.by_id("preset123")
      query.should contain("query GetFilterPreset")
      query.should contain(%Q(id: "preset123"))
    end
  end
end

describe CaidoQueries::Backups do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::Backups.all
      query.should contain("query GetBackups")
      query.should contain("backups")
    end
  end

  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::Backups.by_id("backup123")
      query.should contain("query GetBackup")
      query.should contain(%Q(id: "backup123"))
    end
  end

  describe ".tasks" do
    it "generates valid query" do
      query = CaidoQueries::Backups.tasks
      query.should contain("query GetBackupTasks")
    end
  end

  describe ".restore_tasks" do
    it "generates valid query" do
      query = CaidoQueries::Backups.restore_tasks
      query.should contain("query GetRestoreBackupTasks")
    end
  end
end

describe CaidoQueries::DataExports do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::DataExports.all
      query.should contain("query GetDataExports")
    end
  end

  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::DataExports.by_id("export123")
      query.should contain("query GetDataExport")
      query.should contain(%Q(id: "export123"))
    end
  end
end

describe CaidoQueries::HostedFiles do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::HostedFiles.all
      query.should contain("query GetHostedFiles")
    end
  end
end

describe CaidoQueries::BrowserInfo do
  describe ".info" do
    it "generates valid query" do
      query = CaidoQueries::BrowserInfo.info
      query.should contain("query GetBrowser")
      query.should contain("browser")
    end
  end
end

describe CaidoQueries::UpstreamPluginsList do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::UpstreamPluginsList.all
      query.should contain("query GetUpstreamPlugins")
    end
  end
end

describe CaidoQueries::GlobalConfigQuery do
  describe ".get" do
    it "generates valid query" do
      query = CaidoQueries::GlobalConfigQuery.get
      query.should contain("query GetGlobalConfig")
      query.should contain("address")
    end
  end
end

describe CaidoQueries::TasksQuery do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::TasksQuery.all
      query.should contain("query GetTasks")
    end
  end
end

describe CaidoQueries::Store do
  describe ".info" do
    it "generates valid query" do
      query = CaidoQueries::Store.info
      query.should contain("query GetStore")
    end
  end
end

describe CaidoQueries::AuthenticationQuery do
  describe ".state" do
    it "generates valid query" do
      query = CaidoQueries::AuthenticationQuery.state
      query.should contain("query GetAuthenticationState")
      query.should contain("isAuthenticated")
    end
  end
end

# ===== New Mutation Module Tests =====

describe CaidoMutations::Intercept do
  describe ".delete_entry" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Intercept.delete_entry("entry123")
      mutation.should contain("mutation DeleteInterceptEntry")
      mutation.should contain(%Q(id: "entry123"))
    end
  end
end

describe CaidoMutations::Projects do
  describe ".persist" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Projects.persist
      mutation.should contain("mutation PersistProject")
    end
  end
end

describe CaidoMutations::Workflows do
  describe ".globalize" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Workflows.globalize("wf123")
      mutation.should contain("mutation GlobalizeWorkflow")
      mutation.should contain(%Q(id: "wf123"))
    end
  end

  describe ".localize" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Workflows.localize("wf123")
      mutation.should contain("mutation LocalizeWorkflow")
      mutation.should contain(%Q(id: "wf123"))
    end
  end

  describe ".run_convert" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Workflows.run_convert("wf123", "raw data")
      mutation.should contain("mutation RunConvertWorkflow")
      mutation.should contain(%Q(id: "wf123"))
    end
  end

  describe ".test_active" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Workflows.test_active("wf123", "req123")
      mutation.should contain("mutation TestWorkflowActive")
      mutation.should contain(%Q(id: "wf123"))
      mutation.should contain(%Q(requestId: "req123"))
    end
  end

  describe ".test_passive" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Workflows.test_passive("wf123", "req123")
      mutation.should contain("mutation TestWorkflowPassive")
      mutation.should contain(%Q(id: "wf123"))
    end
  end
end

describe CaidoMutations::Automate do
  describe ".rename_entry" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Automate.rename_entry("entry123", "New Name")
      mutation.should contain("mutation RenameAutomateEntry")
      mutation.should contain(%Q(id: "entry123"))
      mutation.should contain(%Q(name: "New Name"))
    end

    it "escapes name value" do
      mutation = CaidoMutations::Automate.rename_entry("entry123", %q(Name"test))
      mutation.should contain(%Q(name: "Name\\"test"))
    end
  end

  describe ".update_session" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Automate.update_session("session123", name: "Updated")
      mutation.should contain("mutation UpdateAutomateSession")
      mutation.should contain(%Q(name: "Updated"))
    end
  end
end

describe CaidoMutations::Tamper do
  describe ".rank_rule" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Tamper.rank_rule("rule123")
      mutation.should contain("mutation RankTamperRule")
      mutation.should contain(%Q(id: "rule123"))
    end
  end

  describe ".export" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Tamper.export
      mutation.should contain("mutation ExportTamper")
    end
  end

  describe ".test_rule" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Tamper.test_rule("rule123", "GET / HTTP/1.1")
      mutation.should contain("mutation TestTamperRule")
      mutation.should contain(%Q(id: "rule123"))
    end
  end
end

describe CaidoMutations::DNS do
  describe ".rank_rewrite" do
    it "generates valid mutation" do
      mutation = CaidoMutations::DNS.rank_rewrite("rewrite123")
      mutation.should contain("mutation RankDNSRewrite")
      mutation.should contain(%Q(id: "rewrite123"))
    end
  end
end

describe CaidoMutations::UpstreamProxies do
  describe ".update_http" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamProxies.update_http("proxy123", address: "http://proxy:8080")
      mutation.should contain("mutation UpdateUpstreamProxyHttp")
      mutation.should contain(%Q(id: "proxy123"))
      mutation.should contain(%Q(address: "http://proxy:8080"))
    end
  end

  describe ".rank_http" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamProxies.rank_http("proxy123")
      mutation.should contain("mutation RankUpstreamProxyHttp")
      mutation.should contain(%Q(id: "proxy123"))
    end
  end

  describe ".test_http" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamProxies.test_http("proxy123")
      mutation.should contain("mutation TestUpstreamProxyHttp")
      mutation.should contain(%Q(id: "proxy123"))
    end
  end

  describe ".test_socks" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamProxies.test_socks("proxy123")
      mutation.should contain("mutation TestUpstreamProxySocks")
      mutation.should contain(%Q(id: "proxy123"))
    end
  end
end

describe CaidoMutations::Authentication do
  describe ".refresh_token" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Authentication.refresh_token("token123")
      mutation.should contain("mutation RefreshAuthenticationToken")
      mutation.should contain(%Q(refreshToken: "token123"))
    end

    it "escapes token value" do
      mutation = CaidoMutations::Authentication.refresh_token(%q(token"123))
      mutation.should contain(%Q(refreshToken: "token\\"123"))
    end
  end
end

describe CaidoMutations::Environments do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Environments.create("Production")
      mutation.should contain("mutation CreateEnvironment")
      mutation.should contain(%Q(name: "Production"))
    end
  end

  describe ".update" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Environments.update("env123", name: "Staging")
      mutation.should contain("mutation UpdateEnvironment")
      mutation.should contain(%Q(id: "env123"))
      mutation.should contain(%Q(name: "Staging"))
    end
  end

  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Environments.delete("env123")
      mutation.should contain("mutation DeleteEnvironment")
      mutation.should contain(%Q(id: "env123"))
    end
  end

  describe ".select" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Environments.select("env123")
      mutation.should contain("mutation SelectEnvironment")
      mutation.should contain(%Q(id: "env123"))
    end
  end
end

describe CaidoMutations::PluginsMutations do
  describe ".install" do
    it "generates valid mutation" do
      mutation = CaidoMutations::PluginsMutations.install("plugin123")
      mutation.should contain("mutation InstallPluginPackage")
      mutation.should contain(%Q(id: "plugin123"))
    end
  end

  describe ".uninstall" do
    it "generates valid mutation" do
      mutation = CaidoMutations::PluginsMutations.uninstall("plugin123")
      mutation.should contain("mutation UninstallPluginPackage")
      mutation.should contain(%Q(id: "plugin123"))
    end
  end

  describe ".toggle" do
    it "generates valid mutation" do
      mutation = CaidoMutations::PluginsMutations.toggle("plugin123", true)
      mutation.should contain("mutation TogglePlugin")
      mutation.should contain(%Q(id: "plugin123"))
      mutation.should contain("enabled: true")
    end
  end
end

describe CaidoMutations::FilterPresetsMutations do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::FilterPresetsMutations.create("My Filter", "host:example.com")
      mutation.should contain("mutation CreateFilterPreset")
      mutation.should contain(%Q(name: "My Filter"))
      mutation.should contain(%Q(clause: "host:example.com"))
    end
  end

  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::FilterPresetsMutations.delete("preset123")
      mutation.should contain("mutation DeleteFilterPreset")
      mutation.should contain(%Q(id: "preset123"))
    end
  end
end

describe CaidoMutations::BackupsMutations do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::BackupsMutations.create("project123")
      mutation.should contain("mutation CreateBackup")
      mutation.should contain(%Q(projectId: "project123"))
    end
  end

  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::BackupsMutations.delete("backup123")
      mutation.should contain("mutation DeleteBackup")
      mutation.should contain(%Q(id: "backup123"))
    end
  end

  describe ".rename" do
    it "generates valid mutation" do
      mutation = CaidoMutations::BackupsMutations.rename("backup123", "New Name")
      mutation.should contain("mutation RenameBackup")
      mutation.should contain(%Q(name: "New Name"))
    end
  end

  describe ".restore" do
    it "generates valid mutation" do
      mutation = CaidoMutations::BackupsMutations.restore("backup123")
      mutation.should contain("mutation RestoreBackup")
      mutation.should contain(%Q(id: "backup123"))
    end
  end
end

describe CaidoMutations::DataExportsMutations do
  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::DataExportsMutations.delete("export123")
      mutation.should contain("mutation DeleteDataExport")
      mutation.should contain(%Q(id: "export123"))
    end
  end

  describe ".start_export_requests" do
    it "generates valid mutation" do
      mutation = CaidoMutations::DataExportsMutations.start_export_requests
      mutation.should contain("mutation StartExportRequestsTask")
    end
  end
end

describe CaidoMutations::HostedFilesMutations do
  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::HostedFilesMutations.delete("file123")
      mutation.should contain("mutation DeleteHostedFile")
      mutation.should contain(%Q(id: "file123"))
    end
  end

  describe ".rename" do
    it "generates valid mutation" do
      mutation = CaidoMutations::HostedFilesMutations.rename("file123", "new_name.txt")
      mutation.should contain("mutation RenameHostedFile")
      mutation.should contain(%Q(name: "new_name.txt"))
    end
  end
end

describe CaidoMutations::BrowserMutations do
  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::BrowserMutations.delete
      mutation.should contain("mutation DeleteBrowser")
    end
  end

  describe ".install" do
    it "generates valid mutation" do
      mutation = CaidoMutations::BrowserMutations.install
      mutation.should contain("mutation InstallBrowser")
    end
  end
end

describe CaidoMutations::UpstreamPluginsMutations do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamPluginsMutations.create("plugin123")
      mutation.should contain("mutation CreateUpstreamPlugin")
      mutation.should contain(%Q(pluginId: "plugin123"))
    end
  end

  describe ".toggle" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamPluginsMutations.toggle("up123", false)
      mutation.should contain("mutation ToggleUpstreamPlugin")
      mutation.should contain("enabled: false")
    end
  end

  describe ".rank" do
    it "generates valid mutation" do
      mutation = CaidoMutations::UpstreamPluginsMutations.rank("up123")
      mutation.should contain("mutation RankUpstreamPlugin")
      mutation.should contain(%Q(id: "up123"))
    end
  end
end

describe CaidoMutations::CertificateMutations do
  describe ".import" do
    it "generates valid mutation" do
      mutation = CaidoMutations::CertificateMutations.import("cert-data", "key-data")
      mutation.should contain("mutation ImportCertificate")
      mutation.should contain(%Q(certificate: "cert-data"))
      mutation.should contain(%Q(key: "key-data"))
    end
  end

  describe ".regenerate" do
    it "generates valid mutation" do
      mutation = CaidoMutations::CertificateMutations.regenerate
      mutation.should contain("mutation RegenerateCertificate")
    end
  end
end

describe CaidoMutations::SettingsMutations do
  describe ".set_port" do
    it "generates valid mutation" do
      mutation = CaidoMutations::SettingsMutations.set_port(8080)
      mutation.should contain("mutation SetGlobalConfigPort")
      mutation.should contain("port: 8080")
    end
  end

  describe ".set_instance" do
    it "generates valid mutation" do
      mutation = CaidoMutations::SettingsMutations.set_instance(theme: "dark")
      mutation.should contain("mutation SetInstanceSettings")
      mutation.should contain(%Q(theme: "dark"))
    end
  end

  describe ".update_viewer" do
    it "generates valid mutation" do
      mutation = CaidoMutations::SettingsMutations.update_viewer("{}")
      mutation.should contain("mutation UpdateViewerSettings")
      mutation.should contain(%Q(data: "{}"))
    end
  end
end
