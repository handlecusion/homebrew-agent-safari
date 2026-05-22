class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "ssh://git@github.com/handlecusion/agent-safari.git",
      tag: "v0.0.1",
      revision: "a84a003f5fd45b261c75947c1df2dfc946b198d6"
  license "MIT"
  head "ssh://git@github.com/handlecusion/agent-safari.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/agent-safari"
    prefix.install "mcp"
  end

  test do
    assert_match "agent-safari", shell_output("#{bin}/agent-safari 2>&1", 1)
  end
end
