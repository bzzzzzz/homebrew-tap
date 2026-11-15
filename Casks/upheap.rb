cask "upheap" do
  version "0.5.0"
  sha256 "1dd0bef550cd9baa2f0808fdc5972336b61454674628d27bb247b996d0605863"

  url "https://github.com/bzzzzzz/upheap/releases/download/v#{version}/upheap-aarch64-apple-darwin.tar.gz"
  name "upheap"
  desc "Command-line client for Upheap, a ranked todo list for teams"
  homepage "https://github.com/bzzzzzz/upheap"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  binary "upheap"

  # The binary isn't notarized, so Gatekeeper would refuse to run it while it carries the quarantine flag Homebrew
  # sets on downloads (design/decisions.md, decision 30).
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/upheap"]
  end

  zap trash: "~/Library/Application Support/upheap"
end
