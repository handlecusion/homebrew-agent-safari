class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "https://github.com/handlecusion/agent-safari/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "6a7fabb1849898a513b8171e66e260694b03c1efe27a2445cce5b97b3998d9a0"
  license "MIT"
  head "https://github.com/handlecusion/agent-safari.git", branch: "main"

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
