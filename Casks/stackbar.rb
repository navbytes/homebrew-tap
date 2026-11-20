cask "stackbar" do
  version "0.42.0"
  sha256 "dba3f51404ac2877e041c531ce140cec0cfe7990b412ee6726a5e822c6e8e58c"

  url "https://github.com/navbytes/stackbar/releases/download/v#{version}/Stackbar-#{version}.zip",
      verified: "github.com/navbytes/stackbar/"
  name "Stackbar"
  desc "Launcher, menu bar and widgets you extend in Swift"
  homepage "https://stackbar.app/"

  livecheck do
    url :url
    strategy :github_releases
  end

  # Stackbar updates itself (Sparkle).
  auto_updates true

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
