#!/bin/bash

# System-wide Preferences
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.25

# Trackpad and Keyboard
defaults write -g com.apple.mouse.scaling 3
defaults write -g com.apple.trackpad.scaling 2

# Terminal
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"
defaults write com.apple.TextEdit RichText -int 0

# Energy Saver
sudo systemsetup -setcomputersleep Off > /dev/null

# Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Miscellaneous
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Restart affected apps
killall Finder
killall Dock
