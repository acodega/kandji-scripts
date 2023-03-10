#!/bin/zsh
autoload is-at-least
installedOSversion=$(sw_vers -productVersion)
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")
echo "$currentUser and $uid"

if is-at-least 13 "$installedOSversion"; then
  settingsPath=/System/Applications/System\ Settings.app
  else
    settingsPath=/System/Applications/System\ Preferences.app
fi

runAsUser() {  
  if [ "$currentUser" != "loginwindow" ]; then
    launchctl asuser "$uid" sudo -u "$currentUser" "$@"
  else
    echo "no user logged in"
  fi
}

dock_item() {
  printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

# Clear existing dock
runAsUser defaults delete com.apple.dock persistent-apps

# Uncomment next line if you want to not show recent apps on the dock
# runAsUser defaults write com.apple.dock "show-recents" -bool "false"

runAsUser defaults write com.apple.dock persistent-apps -array \
  "$(dock_item /System/Applications/Launchpad.app)" \
  "$(dock_item /Applications/Google\ Chrome.app)" \
  "$(dock_item /Applications/Slack.app)" \
  "$(dock_item /Applications/zoom.us.app)" \
  "$(dock_item /Applications/Self Service.app)" \
  "$(dock_item "$settingsPath")"

killall Dock

exit 0
