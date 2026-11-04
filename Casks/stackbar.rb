cask "stackbar" do
  version "0.18.0"
  sha256 "af319853f956cba66c68ba81175406588076524c0b51b95b89780630773b48d3"

  url "https://github.com/navbytes/stackbar/releases/download/v#{version}/Stackbar-#{version}.zip",
      verified: "github.com/navbytes/stackbar/"
  name "Stackbar"
  desc "Menu-bar host for live plugins written in Swift"
  homepage "https://stackbar.navbytes.io/"

  livecheck do
    url :url
    strategy :github_releases
  end

  # Apple Silicon + macOS 26 (Tahoe) or later, matching the app.
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Stackbar.app"
  # stackbarctl ships inside the app, so one cask delivers both.
  binary "#{appdir}/Stackbar.app/Contents/MacOS/stackbarctl"

  uninstall quit: "io.navbytes.stackbar"

  zap trash: [
    "~/Library/Application Support/Stackbar",
    "~/Library/Caches/io.navbytes.stackbar",
    "~/Library/Preferences/io.navbytes.stackbar.plist",
  ]

  caveats <<~CAVEATS
    Stackbar compiles plugins on your Mac with Swift. If you have neither
    Xcode nor the Command Line Tools, install them:
      xcode-select --install
  CAVEATS
end
