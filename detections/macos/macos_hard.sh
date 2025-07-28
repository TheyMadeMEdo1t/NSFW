#!/bin/bash

# macOS Hardening Script - Based on https://gist.github.com/jjnilton/add1eeeb3a9616f53e4c
# Run with: sudo ./macos_hardening.sh

echo "Starting macOS hardening..."

# Ask for administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## System Settings

# Disable remote Apple Events
echo "Disabling remote Apple Events..."
sudo systemsetup -setremoteappleevents off

# Disable remote login (SSH)
echo "Disabling remote login (SSH)..."
sudo systemsetup -f -setremotelogin off

# Disable guest account
echo "Disabling guest account..."
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Disable guest access to shared folders
echo "Disabling guest access to shared folders..."
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false

# Disable Wake for network access
echo "Disabling Wake for network access..."
sudo systemsetup -setwakeonnetworkaccess off

# Firewall enabled
echo "Enabling Firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable stealth mode
echo "Enabling stealth mode..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Turn on automatic security updates
echo "Enabling automatic security updates..."
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -int 1
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

# Turn off Bluetooth if not needed
echo "Turning off Bluetooth..."
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
sudo killall -HUP blued

# Disable Captive Portal Assistant
echo "Disabling Captive Portal Assistant..."
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

# Disable Siri
echo "Disabling Siri..."
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
launchctl disable "gui/${UID}/com.apple.assistantd"

# Require password immediately after sleep or screen saver begins
echo "Setting password requirement after sleep/screensaver..."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable FileVault (prompt if not enabled)
echo "Checking FileVault status..."
fdesetup status | grep -q "FileVault is On"
if [ $? -ne 0 ]; then
    echo "⚠️ FileVault is not enabled. You can enable it via: System Preferences > Security & Privacy > FileVault"
fi

# Disable sending diagnostic & usage data to Apple
echo "Disabling diagnostics & usage data sharing..."
sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool false
sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist ThirdPartyDataSubmit -bool false

echo "✅ macOS hardening complete!"
