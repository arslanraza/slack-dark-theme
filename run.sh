#!/bin/bash

SLACK_DIR="/Applications/Slack.app/Contents"
JS_FILE="$SLACK_DIR/Resources/app.asar.unpacked/src/static/ssb-interop.js"
JS_FILE_BACKUP=$JS_FILE"_bk"

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

show_menus() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo " M A I N - M E N U"
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo "1. Apply Dark theme"
  echo "2. Restore Light theme"
  echo "3. Exit"
}

close_slack() {
  #Check if slack is running and close it
  echo "Closing Slack if its running..."
  kill -9 $(ps -e | grep "$SLACK_DIR/MacOS/Slack" | awk '{print $1}' | head -n 1)
}

apply_dark_theme() {
  close_slack

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
}

restore_light_theme() {
  close_slack
  #make a backup of the original file if its not created already
  if [ -f $JS_FILE_BACKUP ]
  then
    # if backup exists then we restore it so that we have a clean state to make the style changes
    cp $JS_FILE_BACKUP $JS_FILE
  else
    echo "Slack already has a light theme set."
  fi

  echo "Slack has been reset to Light theme."
}

read_options(){
  local choice
  read -p "Enter choice [ 1 - 3] " choice
  case $choice in
    1) apply_dark_theme && exit 0 ;;
    2) restore_light_theme && exit 0 ;;
    3) exit 0 ;;
    *) echo -e "Incorrect Input..." && sleep 1
  esac
}

while true
do
  show_menus
  read_options
  pause
done
