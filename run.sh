#!/bin/bash

#make a backup of the original file
cp /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js_bk
cat one-dark >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
