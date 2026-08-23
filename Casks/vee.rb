cask "vee" do
  version "0.2.0"
  sha256 "80b1da57aedb4d76f62c455be33a8326447d1c27714e901b6ae4fdc6012d4104"

  url "https://github.com/navbytes/vee/releases/download/v#{version}/Vee.zip",
      verified: "github.com/navbytes/vee/"
  name "Vee"
  desc "Native macOS menu-bar script runner, compatible with xbar and SwiftBar plugins"
  homepage "https://github.com/navbytes/vee"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple Silicon + macOS 26 (Tahoe) or later, matching the app's requirements.
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Vee.app"
  # The app bundle's executable is also the `vee` CLI, so one cask delivers
  # both. Homebrew removes the symlink on uninstall.
  binary "#{appdir}/Vee.app/Contents/MacOS/Vee", target: "vee"

  zap trash: [
    "~/Library/Application Support/Vee",
    "~/Library/Preferences/com.vee.app.plist",
  ]
end
