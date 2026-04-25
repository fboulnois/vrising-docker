#!/bin/bash

set -eu

xvfb_wine() {
  sleep 1
  xvfb-run -e /dev/stdout -s "-screen 0 1024x768x16 -nolisten tcp -nolisten unix" wine "$@" || true
}

VRISING_DATA_DIR="/home/vrising/.wine/drive_c/VRisingData"
mkdir -p "$VRISING_DATA_DIR/Settings"
if [ -f settings/ServerGameSettings.json ]; then
  cp settings/ServerGameSettings.json "$VRISING_DATA_DIR/Settings/ServerGameSettings.json"
fi
if [ -f settings/ServerHostSettings.json ]; then
  cp settings/ServerHostSettings.json "$VRISING_DATA_DIR/Settings/ServerHostSettings.json"
fi
if [ -f settings/adminlist.txt ]; then
  cp settings/adminlist.txt "$VRISING_DATA_DIR/Settings/adminlist.txt"
fi
if [ -f settings/banlist.txt ]; then
  cp settings/banlist.txt "$VRISING_DATA_DIR/Settings/banlist.txt"
fi

xvfb_wine winecfg -v win10
xvfb_wine steamcmd.exe +force_install_dir 'C:\VRisingServer' +login anonymous +app_update 1829350 validate +quit
xvfb_wine VRisingServer.exe -persistentDataPath 'C:\VRisingData'
