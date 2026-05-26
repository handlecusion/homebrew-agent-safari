class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "https://github.com/handlecusion/agent-safari/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "48a07333010e57198e2b31f1905dab5ffdc6d46480a146de0d4beb2284d632b8"
  license "MIT"
  head "https://github.com/handlecusion/agent-safari.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

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
