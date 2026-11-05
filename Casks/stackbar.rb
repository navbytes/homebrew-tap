cask "stackbar" do
  version "0.21.0"
  sha256 "924135295ee6d9e521a48aa058190b233c81e76b1ec4c888ac87090a0e688b3a"

  url "https://github.com/navbytes/stackbar/releases/download/v#{version}/Stackbar-#{version}.zip",
      verified: "github.com/navbytes/stackbar/"
  name "Stackbar"
  desc "Menu-bar host for live plugins written in Swift"
  homepage "https://stackbar.app/"

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
    Store plugins come prebuilt. To write your own plugins, install Xcode
    or the Command Line Tools:
      xcode-select --install
  CAVEATS
end
