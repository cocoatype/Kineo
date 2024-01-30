#!/bin/zsh

if [[ $CI_BRANCH =~ release\/(.*) ]]; then
  /usr/libexec/PlistBuddy ../Vision/App/Info.plist -c "Set :CFBundleShortVersionString $match[1]"
fi
