#!/bin/zsh

# If the Mac app is preinstalled, we'll install it from VPP
# so the app can be updated and used without an Apple ID
#
# In Kandji, configure the VPP app library item installation
# as "Install on-demand from Self Service"
#
# The library items must be assigned to the Mac
#
# Name your library item so that it matches the names below

apps=(
  "Pages"
  "Numbers"
  "Keynote"
  "iMovie"
  "GarageBand"
)

(for app in "${apps[@]}"; do
  if [ -e /Applications/$app.app ]; then
    kandji library --item $app -F
fi
done