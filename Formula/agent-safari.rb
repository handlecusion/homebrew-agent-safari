class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "https://github.com/handlecusion/agent-safari/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "43273ee2d2804823532ed72a270dcaf71edc57e99dd77d49b501bebbb7ce5722"
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
