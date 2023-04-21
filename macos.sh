#!/bin/bash

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `set-defaults.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo ""
echo "› System:"
echo "  › Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

echo " > Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo " > Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo " > Disable hibernation (speeds up entering sleep mode) "
sudo pmset -a hibernatemode 0

echo " > Remove the sleep image file to save disk space"
sudo rm /private/var/vm/sleepimage
echo " > Create a zero-byte file instead… "
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage

echo "> Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0


echo "  › Show the ~/Library folder"
chflags nohidden ~/Library

echo "  › Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 12

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "  › Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "  › Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "  › Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "  › Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  › Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "  › Set up trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 1.5
defaults write -g com.apple.mouse.scaling 1.5

echo "  › Avoid the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "  › Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Set graphite appearance"
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

echo "  › Set graphite highlight color"
defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745"

echo "  > Show battery percent"
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "  > Disable Notification Center and remove the menu bar icon"
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

echo " > Disable automatic capitalization as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

echo " > Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


echo " > Disable automatic period substitution as it’s annoying when typing code"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo " > Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo ""
echo "> Trackpad, keyboard and others"
echo " > Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

echo " > Increase sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

echo " > Enable full keyboard access for all controls"
echo " (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo " > Show language menu in the top right corner of the boot screen"
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true


echo ""
echo "› Finder:"
echo "  › Always open everything in Finder's list view"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv


echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "  › Set sidebar icon size to small"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo "  › Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Save to disk by default, instead of iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "  › Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false



echo ""
echo "› Photos:"
echo "  › Disable it from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


echo ""
echo "› Dock"
echo "  › Setting the icon size of Dock items to 45 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 45

echo "  › Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "  › Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0
echo "  › Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0

echo "  › Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "  › Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false


echo ""
echo "› Transmission:"
echo "  › Use ~/Downloads/Incomplete to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Downloads/Incomplete"

echo "  › Don't prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

echo "  › Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

echo "  › Hide the donate message"
defaults write org.m0k.transmission WarningDonate -bool false

echo "  › Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

echo "  › Auto-add .torrent files in ~/Downloads"
defaults write org.m0k.transmission AutoImportDirectory -string "$HOME/Downloads"

echo "  › Auto-resize the window to fit transfers"
defaults write org.m0k.transmission AutoSize -bool true

echo "  › Auto update to betas"
defaults write org.m0k.transmission AutoUpdateBeta -bool true

echo "  › Set up the best block list"
defaults write org.m0k.transmission EncryptionRequire -bool true
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"


echo ""
echo "› Time Machine:"
echo "  › Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo ""
echo "> Spotlight:"
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
killall mds > /dev/null 2>&1
sudo mdutil -i on / > /dev/null
sudo mdutil -E / > /dev/null

echo ""
echo "> Activity Monitor"
echo " > Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo " > Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo " > Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo " > # Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

echo ""
echo "> Mac App Store"
echo " > Enable the automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo " > Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo " > Download newly available updates in background"
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

echo " > Install System data files & security updates"
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

echo " > Turn on app auto-update"
defaults write com.apple.commerce AutoUpdate -bool true

echo " > Change Screenshots folder"
defaults write com.apple.screencapture location ~/Desktop/Screenshots/

echo " > massively increase virtualized macOS by disabling spotlight."
sudo mdutil -i off -a

echo " > Disable heavy login screen wallpaper"
defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""

echo " > Reduce Motion & Transparency"
defaults write com.apple.Accessibility DifferentiateWithoutColor -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write com.apple.universalaccess reduceMotion -int 1
defaults write com.apple.universalaccess reduceTransparency -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1


set +e
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal"; do
killall "${app}" > /dev/null 2>&1
done
set -e

# Remove duplicates in the "Open With" menu
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -kill -r -domain local -domain system -domain user

echo "Done. Note that some of these changes require a logout/restart to take effect."

