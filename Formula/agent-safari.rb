class AgentSafari < Formula
  desc "Native macOS Safari/WebKit agentic browser CLI and daemon"
  homepage "https://github.com/handlecusion/agent-safari"
  url "https://github.com/handlecusion/agent-safari/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "264983d8768e45c471b13f83ea20a4a662ff5a762a8ca1c90f9485ab21c24750"
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
