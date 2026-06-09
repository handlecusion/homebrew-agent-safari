class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "https://github.com/handlecusion/agent-safari/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "03122004f4ef42c15399b101b8de60ec17943031a914999f6a15fb5e9e8dba14"
  license "MIT"
  head "https://github.com/handlecusion/agent-safari.git", branch: "main"

  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/agent-safari"
    bin.install "scripts/agent_safari_mcp_setup.py" => "agent-safari-mcp-setup"
    prefix.install "mcp"
  end

  def caveats
    <<~EOS
      To connect agent-safari to detected MCP clients, run:
        agent-safari-mcp-setup

      The setup helper detects Claude Desktop, Cursor, Windsurf, VS Code, and
      Hermes Agent config locations, then asks before writing each config file.
      For non-interactive installs, inspect first:
        agent-safari-mcp-setup --dry-run
    EOS
  end

  test do
    assert_match "agent-safari", shell_output("#{bin}/agent-safari 2>&1", 1)
  end
end
