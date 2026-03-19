require "./spec_helper"

describe Caido do
  it "has a version" do
    Caido::VERSION.should eq("0.1.0")
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

  describe ".build_optional_fields" do
    it "returns empty array when all values are nil" do
      fields = [{"name", nil}, {"desc", nil}] of Tuple(String, String?)
      CaidoUtils.build_optional_fields(fields).should eq([] of String)
    end

    it "builds fields for non-nil values only" do
      fields = [{"name", "test"}, {"desc", nil}] of Tuple(String, String?)
      result = CaidoUtils.build_optional_fields(fields)
      result.size.should eq(1)
      result[0].should eq(%Q(name: "test"))
    end

    it "escapes special characters in values" do
      fields = [{"name", %q(test"value)}] of Tuple(String, String?)
      result = CaidoUtils.build_optional_fields(fields)
      result[0].should eq(%Q(name: "test\\"value"))
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

# New modules: FilterPresets
describe CaidoQueries::FilterPresets do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::FilterPresets.all
      query.should contain("query GetFilterPresets")
      query.should contain("filterPresets")
      query.should contain("alias")
      query.should contain("clause")
    end
  end

  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::FilterPresets.by_id("filter123")
      query.should contain("query GetFilterPreset")
      query.should contain(%Q(id: "filter123"))
    end
  end
end

describe CaidoMutations::FilterPresets do
  describe ".create" do
    it "generates valid mutation" do
      mutation = CaidoMutations::FilterPresets.create("My Filter", "host:example.com")
      mutation.should contain("mutation CreateFilterPreset")
      mutation.should contain(%Q(name: "My Filter"))
      mutation.should contain(%Q(clause: "host:example.com"))
    end

    it "includes alias when provided" do
      mutation = CaidoMutations::FilterPresets.create("My Filter", "host:example.com", filter_alias: "mf")
      mutation.should contain(%Q(alias: "mf"))
    end
  end

  describe ".update" do
    it "generates valid mutation" do
      mutation = CaidoMutations::FilterPresets.update("filter123", name: "Updated Filter")
      mutation.should contain("mutation UpdateFilterPreset")
      mutation.should contain(%Q(id: "filter123"))
      mutation.should contain(%Q(name: "Updated Filter"))
    end
  end

  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::FilterPresets.delete("filter123")
      mutation.should contain("mutation DeleteFilterPreset")
      mutation.should contain(%Q(id: "filter123"))
      mutation.should contain("deletedId")
    end
  end
end

# New modules: HostedFiles
describe CaidoQueries::HostedFiles do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::HostedFiles.all
      query.should contain("query GetHostedFiles")
      query.should contain("hostedFiles")
      query.should contain("size")
      query.should contain("status")
    end
  end
end

describe CaidoMutations::HostedFiles do
  describe ".upload" do
    it "generates valid mutation" do
      mutation = CaidoMutations::HostedFiles.upload("test.txt", "/tmp/test.txt")
      mutation.should contain("mutation UploadHostedFile")
      mutation.should contain(%Q(name: "test.txt"))
      mutation.should contain(%Q(path: "/tmp/test.txt"))
    end
  end

  describe ".rename" do
    it "generates valid mutation" do
      mutation = CaidoMutations::HostedFiles.rename("file123", "new_name.txt")
      mutation.should contain("mutation RenameHostedFile")
      mutation.should contain(%Q(id: "file123"))
      mutation.should contain(%Q(name: "new_name.txt"))
    end
  end

  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::HostedFiles.delete("file123")
      mutation.should contain("mutation DeleteHostedFile")
      mutation.should contain(%Q(id: "file123"))
      mutation.should contain("deletedId")
    end
  end
end

# New modules: Environment mutations
describe CaidoQueries::Environments do
  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::Environments.by_id("env123")
      query.should contain("query GetEnvironment")
      query.should contain(%Q(id: "env123"))
      query.should contain("variables")
      query.should contain("version")
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

  describe ".delete" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Environments.delete("env123")
      mutation.should contain("mutation DeleteEnvironment")
      mutation.should contain(%Q(id: "env123"))
      mutation.should contain("deletedId")
    end
  end

  describe ".select" do
    it "generates valid mutation with id" do
      mutation = CaidoMutations::Environments.select("env123")
      mutation.should contain("mutation SelectEnvironment")
      mutation.should contain(%Q(id: "env123"))
    end

    it "generates valid mutation without id" do
      mutation = CaidoMutations::Environments.select
      mutation.should contain("mutation SelectEnvironment")
      mutation.should contain("selectEnvironment")
    end
  end
end

# New: Plugin install mutation
describe CaidoMutations::Plugins do
  describe ".install" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Plugins.install("my-plugin")
      mutation.should contain("mutation InstallPluginPackage")
      mutation.should contain(%Q(manifestId: "my-plugin"))
    end
  end
end

# New: Tasks query
describe CaidoQueries::Tasks do
  describe ".all" do
    it "generates valid query" do
      query = CaidoQueries::Tasks.all
      query.should contain("query GetTasks")
      query.should contain("tasks")
      query.should contain("__typename")
      query.should contain("ReplayTask")
    end
  end
end

# New: Response query
describe CaidoQueries::Responses do
  describe ".by_id" do
    it "generates valid query" do
      query = CaidoQueries::Responses.by_id("resp123")
      query.should contain("query GetResponse")
      query.should contain(%Q(id: "resp123"))
      query.should contain("statusCode")
      query.should contain("raw")
    end
  end
end

# New: Replay entry and session entries
describe CaidoQueries::Replay do
  describe ".entry_by_id" do
    it "generates valid query" do
      query = CaidoQueries::Replay.entry_by_id("entry123")
      query.should contain("query GetReplayEntry")
      query.should contain(%Q(id: "entry123"))
      query.should contain("connection")
      query.should contain("session")
    end
  end

  describe ".session_entries" do
    it "generates valid query" do
      query = CaidoQueries::Replay.session_entries("session123")
      query.should contain("query GetReplaySessionEntries")
      query.should contain(%Q(id: "session123"))
      query.should contain("entries")
    end
  end
end

# New: Replay set_active_entry mutation
describe CaidoMutations::Replay do
  describe ".set_active_entry" do
    it "generates valid mutation" do
      mutation = CaidoMutations::Replay.set_active_entry("session123", "entry456")
      mutation.should contain("mutation SetActiveReplaySessionEntry")
      mutation.should contain(%Q(id: "session123"))
      mutation.should contain(%Q(entryId: "entry456"))
    end
  end
end

# Updated fields tests
describe CaidoQueries::Scopes do
  describe ".all" do
    it "includes indexed field" do
      query = CaidoQueries::Scopes.all
      query.should contain("indexed")
    end
  end
end

describe CaidoQueries::Findings do
  describe ".by_id" do
    it "includes host, path, hidden fields" do
      query = CaidoQueries::Findings.by_id("finding123")
      query.should contain("host")
      query.should contain("path")
      query.should contain("hidden")
    end
  end
end

describe CaidoQueries::Projects do
  describe ".all" do
    it "includes new fields from JS SDK" do
      query = CaidoQueries::Projects.all
      query.should contain("temporary")
      query.should contain("readOnly")
      query.should contain("updatedAt")
    end
  end
end

describe CaidoQueries::Workflows do
  describe ".all" do
    it "includes new fields from JS SDK" do
      query = CaidoQueries::Workflows.all
      query.should contain("readOnly")
      query.should contain("createdAt")
      query.should contain("updatedAt")
    end
  end
end

describe CaidoQueries::Viewer do
  describe ".info" do
    it "includes union types" do
      query = CaidoQueries::Viewer.info
      query.should contain("CloudUser")
      query.should contain("GuestUser")
      query.should contain("ScriptUser")
      query.should contain("__typename")
    end
  end
end
