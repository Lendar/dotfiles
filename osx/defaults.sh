defaults write -g NSUserKeyEquivalents -dict-add "Paste and Match Style" @v

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate. N.B.: KeyRemap4MacBook overrides both.
# 1 = 15 ms, minimal value is 1
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Add English + Russian Keyboard Layout
defaults write com.apple.HIToolbox AppleEnabledInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>' '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19967</integer><key>KeyboardLayout Name</key><string>Russian-BG46</string></dict>'

# Enable tap to click on a Magic Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable tap to click for the active user
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable tap to click on the login screen (broken?)
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Always open everything in Finder's list view. This is important.
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Change new window path to ~
# Set this to open to the home directory, not "All My Files", if you want All My Files though it's PfAF
defaults write com.apple.finder NewWindowTarget PfHm

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use current directory as default search scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Show library
chflags nohidden ~/Library

# Date format
# EEE d MMM  HH:mm = Sun 20 Jul  13:15
# Reference http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns
defaults write com.apple.menuextra.clock DateFormat "EEE d MMM  HH:mm"

# ISO8601 for short date format
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "yyyy-MM-dd"

# Show fast user switching menu as: Account Name
defaults write -g userMenuExtraStyle -int 1

{% if not grains.get('keep_original_menu_extras', False) %}
# Hide Bluetooth menu
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu"
# Hidden:
#   "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
{% endif %}

# Turn off autosave for Sketch
defaults write $(osascript -e 'id of application "Sketch"') ApplePersistence -bool no

# Apply changes
killall SystemUIServer -HUP
