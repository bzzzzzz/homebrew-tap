cask "upheap" do
  version "0.8.0"
  sha256 "4b2ed6225cad8f65ec5b853f4ab43e7d6dcd829ea2e6b885b1df461c68d896fa"

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
