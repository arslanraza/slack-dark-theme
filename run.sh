#!/bin/bash

SLACK_DIR="/Applications/Slack.app/Contents"
JS_FILE="$SLACK_DIR/Resources/app.asar.unpacked/src/static/ssb-interop.js"
JS_FILE_BACKUP=$JS_FILE"_bk"

#Check if slack is running and close it
echo "Closing Slack if its running..."
kill -9 $(ps -e | grep "$SLACK_DIR/MacOS/Slack" | awk '{print $1}' | head -n 1)

#make a backup of the original file if its not created already
if [ -f $JS_FILE_BACKUP ]
then
  # if backup exists then we restore it so that we have a clean state to make the style changes
  cp $JS_FILE_BACKUP $JS_FILE
else
  echo "Creating backup of the file at $JS_FILE_BACKUP"
  cp $JS_FILE $JS_FILE_BACKUP
fi

cat one-dark >> $JS_FILE

echo "Done..."
