class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "https://github.com/handlecusion/agent-safari/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "ebc37179426f2f8a1429fc572be7bee65773a77566f6fa802bb84ee309a088ba"
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
