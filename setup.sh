#!/usr/bin/env bash
# Based heavily on — http://mths.be/osx
# This is dirtier than York Road brass, but it works, so fucks given === 0
#
# I probably should have commented most of the OSX defaults, as I will most likely not remember wtf half of these settings mean when I come back to this
# but its a bit late now
declare -a DOTFILES=('bash_profile' 'curlrc' 'gitattributes' 'gitignore' 'vimrc' 'wgetrc');

install_dotfiles() {
    echo "Installing dotfiles..."
    for dotshizzle in ${DOTFILES[@]}
    do
        cp -fv ./${dotshizzle} ~/.${dotshizzle}
    done

    # Clearly every terminal should open with darth vader
    sudo cp -fv motd /etc/motd
}

setup_vim() {
    echo "Adding pathogen to vim..."
    # Install some stuffs - probably should check return values here. But meh, whatevs.
    mkdir -p ~/.vim/autoload ~/.vim/bundle;
    curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim;
}

install_most_hated_language() {
    echo "Installing the devils programming language..."
    # As much as I love to hate ruby, I need it for some things.
    curl -L https://get.rvm.io | bash
    rvm install 2.0.0
}

install_homebrew() {
    echo "Installing homebrew..."
    # Brew
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    # Install cask for app goodness
    brew tap phinze/homebrew-cask
}

git_config() {
    echo "Setting global git config..."
    git config --global core.excludesfile '~/.gitignore'
    git config --global user.name "Nick Pack"
    git config --global user.email "nick@nickpack.com"
}

osx_general_settings() {
    echo "Adding some general sanity to OSX..."

    sudo pmset -a standbydelay 86400

    defaults write com.apple.menuextra.battery ShowPercent -string "NO"
    defaults write com.apple.menuextra.battery ShowTime -string "YES"
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
    defaults write com.apple.LaunchServices LSQuarantine -bool false
    defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
    defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
    defaults write com.apple.CrashReporter DialogType -string "none"
    defaults write com.apple.helpviewer DevMode -bool true
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
    systemsetup -setrestartfreeze on
    systemsetup -setcomputersleep Off > /dev/null
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
    defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1

    sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

    defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
    defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
    defaults write NSGlobalDomain KeyRepeat -int 0
    defaults write com.apple.BezelServices kDim -bool true
    defaults write com.apple.BezelServices kDimTime -int 300
    defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true
    systemsetup -settimezone "Europe/London" > /dev/null
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    defaults write com.apple.screencapture location -string "$HOME/Desktop"
    defaults write com.apple.screencapture type -string "png"
    defaults write NSGlobalDomain AppleFontSmoothing -int 2
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
    defaults write com.apple.finder QuitMenuItem -bool true
    defaults write com.apple.finder DisableAllAnimations -bool true
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder QLEnableTextSelection -bool true
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    defaults write NSGlobalDomain com.apple.springing.enabled -bool true
    defaults write NSGlobalDomain com.apple.springing.delay -float 0
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write com.apple.finder WarnOnEmptyTrash -bool false
    defaults write com.apple.finder EmptyTrashSecurely -bool true
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    sudo nvram boot-args="mbasd=1"

    chflags nohidden ~/Library

    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    hash tmutil &> /dev/null && sudo tmutil disablelocal
}

osx_dock_settings() {
    echo "Setting up the OSX dock properly..."
    defaults write com.apple.dock mouse-over-hilite-stack -bool true
    defaults write com.apple.dock tilesize -int 36
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
    defaults write com.apple.dock show-process-indicators -bool true
    defaults write com.apple.dock launchanim -bool false
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock showhidden -bool true
    find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
    sudo ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app
    defaults write com.apple.dock wvous-tl-corner -int 2
    defaults write com.apple.dock wvous-tl-modifier -int 0
    defaults write com.apple.dock wvous-tr-corner -int 4
    defaults write com.apple.dock wvous-tr-modifier -int 0
    defaults write com.apple.dock wvous-bl-corner -int 5
    defaults write com.apple.dock wvous-bl-modifier -int 0
}

osx_safailri_settings() {
    echo "Setting up Safari..."
    defaults write com.apple.Safari HomePage -string "about:blank"
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
    defaults write com.apple.Safari ShowFavoritesBar -bool false
    defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
    defaults write com.apple.Safari ProxiesInBookmarksBar "()"
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
}

osx_itunes_settings() {
    echo "Setting up iTunes..."
    defaults write com.apple.iTunes show-store-link-arrows -bool false
    defaults write com.apple.iTunes disableGeniusSidebar -bool true
    defaults write com.apple.iTunes disableRadio -bool true
    defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"
    defaults write com.apple.mail DisableReplyAnimations -bool true
    defaults write com.apple.mail DisableSendAnimations -bool true
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
    defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"
}

osx_spotlight_settings() {
    echo "Setting up Spotlight..."
    sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

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
        '{"enabled" = 0;"name" = "SOURCE";}'
    killall mds

    sudo mdutil -i on /
    sudo mdutil -E /
}

osx_general_app_settings() {
    echo "Setting up general app preferences..."
    defaults write com.apple.terminal StringEncodings -array 4
    defaults write com.apple.addressbook ABShowDebugMenu -bool true
    defaults write com.apple.dashboard devmode -bool true
    defaults write com.apple.iCal IncludeDebugMenu -bool true
    defaults write com.apple.TextEdit RichText -int 0
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
    defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
    defaults write com.apple.DiskUtility advanced-image-options -bool true
    defaults write com.apple.appstore WebKitDeveloperExtras -bool true
    defaults write com.apple.appstore ShowDebugMenu -bool true
    defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
    defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
    defaults write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false
    defaults write com.twitter.twitter-mac ShowDevelopMenu -bool true
    defaults write com.twitter.twitter-mac ESCClosesComposeWindow -bool true
    defaults write com.twitter.twitter-mac ShowFullNames -bool true
    defaults write com.twitter.twitter-mac HideInBackground -bool true
}

restart_osx_shizzle() {
    echo "Restarting affected OSX apps..."
    for app in "Address Book" "Calendar" "Contacts" "Dashboard" "Dock" "Finder" \
        "Mail" "Safari" "SizeUp" "SystemUIServer" "Terminal" "Transmission" \
        "Twitter" "iCal" "iTunes"; do
        killall "$app" > /dev/null 2>&1;
    done
}

install_packages_from_manifest() {
    # todo - this is messy as, sort it out.
    echo "Installing ${1} packages from ${2}..."
    while read line
    do
        if [[ "$1" == "npm" ]]; then
            $1 install -g  "$line";
        elif [[ "$1" == "cask" ]]; then
            brew cask install $line;
        elif [[ "$1" == "cpan" ]]; then
            sudo $1 install "$line"
        else
            $1 install  "$line";
        fi
    done < $2;
    echo "Done installing ${1} packages...";
}

shopt -s dotglob;

echo "Some of this stuff requires elevated rights - enter your password NAO..."
sudo -v;

while true; do sudo -n true; sleep 240; kill -0 "$$" || exit; done 2>/dev/null &

install_dotfiles;

setup_vim;

install_most_hated_language;

git_config;

if [[ "$OSTYPE" =~ ^darwin ]]; then
    echo "I sense something fruity...";
    install_homebrew;
    osx_general_settings;
    osx_dock_settings;
    osx_safailri_settings;
    osx_itunes_settings;
    osx_general_app_settings;
    restart_osx_shizzle;
    install_packages_from_manifest "brew" "brewpackages";
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    install_packages_from_manifest "cask" "caskapps";
    echo "Finished fruity packages and settings...";
fi

echo "Installing ruby, perl and node packages...";
install_packages_from_manifest "gem" "rubygems";
install_packages_from_manifest "npm" "nodeglobpackages";
install_packages_from_manifest "cpan" "cpanpackages";

echo "[DONE] Shizzle is set up. Some of this requires a logout/restart to take effect.";
