cask "stackbar" do
  version "0.20.1"
  sha256 "7b9181ede2d68dbeacfb68cbc419e5c91384e7383b608a3c36f6bfe05001e71d"

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
