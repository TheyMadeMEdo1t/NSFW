#!/bin/bash

# macOS Advanced Hardening Script (Offline Edition)
# Source: Expanded from https://gist.github.com/jjnilton/add1eeeb3a9616f53e4c

# Exit on error
set -e

#-------------------------#
# Utility / Information   #
#-------------------------#

log() {
    echo "[+] $1"
}

warn() {
    echo "[!] $1"
}

#-----------------------------#
# Root Privilege Verification #
#-----------------------------#
require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run with sudo/root privileges."
        exit 1
    fi
}

#----------------------------#
#  Core Hardening Functions #
#----------------------------#

disable_services() {
    log "Disabling unnecessary remote services..."
    systemsetup -setremoteappleevents off
    systemsetup -f -setremotelogin off
    systemsetup -setwakeonnetworkaccess off
    defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
    defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false
}

enable_firewall_and_stealth() {
    log "Enabling firewall and stealth mode..."
    /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
    /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
}

configure_updates() {
    log "Configuring automatic security updates..."
    defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
    defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -int 1
    defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
    defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true
}

disable_siri_and_bluetooth() {
    log "Disabling Siri..."
    defaults write com.apple.assistant.support "Assistant Enabled" -bool false
    launchctl disable "gui/${UID}/com.apple.assistantd"

    log "Disabling Bluetooth..."
    defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
    killall -HUP blued || true
}

require_password_on_wake() {
    log "Requiring password immediately after screen saver or sleep..."
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
}

disable_captive_portal() {
    log "Disabling captive portal assistant..."
    defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
}

disable_diagnostics() {
    log "Disabling Apple diagnostic & usage data sharing..."
    defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool false
    defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist ThirdPartyDataSubmit -bool false
}

#----------------------------#
# Advanced Hardening        #
#----------------------------#

check_filevault() {
    log "Checking FileVault status..."
    local status
    status=$(fdesetup status)
    if [[ "$status" == *"FileVault is On."* ]]; then
        log "FileVault is ENABLED ✅"
    else
        warn "FileVault is DISABLED ❌"
        echo "Consider enabling FileVault via System Preferences > Security & Privacy > FileVault"
    fi
}

check_sip_status() {
    log "Checking System Integrity Protection (SIP)..."
    if csrutil status | grep -q 'enabled'; then
        log "SIP is ENABLED ✅"
    else
        warn "SIP is DISABLED ❌"
        echo "Consider re-enabling SIP via Recovery Mode: csrutil enable"
    fi
}

review_launchdaemons() {
    log "Reviewing Launch Daemons and Agents for suspicious entries..."
    find /Library/LaunchDaemons /Library/LaunchAgents ~/Library/LaunchAgents -name "*.plist" 2>/dev/null | while read -r plist; do
        echo "Found: $plist"
    done
}

list_tcc_permissions() {
    log "Listing TCC (Transparency, Consent, and Control) permissions (partial)..."
    db="/Library/Application Support/com.apple.TCC/TCC.db"
    if [ -f "$db" ]; then
        sqlite3 "$db" "SELECT client, service, allowed FROM access;" 2>/dev/null | column -t
    else
        warn "TCC.db not found or inaccessible."
    fi
}

audit_users() {
    log "Auditing user accounts..."
    dscl . list /Users | while read -r user; do
        id "$user" &>/dev/null && echo "User: $user - UID: $(id -u "$user")"
    done
}

#----------------------------#
# Run All Functions          #
#----------------------------#

main() {
    require_root

    log "Starting macOS advanced hardening..."

    disable_services
    enable_firewall_and_stealth
    configure_updates
    disable_siri_and_bluetooth
    require_password_on_wake
    disable_captive_portal
    disable_diagnostics

    # Advanced
    check_filevault
    check_sip_status
    review_launchdaemons
    list_tcc_permissions
    audit_users

    log "✅ All hardening steps completed."
}

main
