#!/bin/bash

set -eu

xvfb_wine() {
  sleep 1 && xvfb-run -e /dev/stdout -s "-screen 0 1024x768x16 -nolisten tcp -nolisten unix" wine "$@" || true
}

mkdir -p /home/vrising/.wine/drive_c/VRisingData/Settings
if [ -f ServerGameSettings.json ]; then
  cp ServerGameSettings.json /home/vrising/.wine/drive_c/VRisingData/Settings/ServerGameSettings.json
fi
if [ -f ServerHostSettings.json ]; then
  cp ServerHostSettings.json /home/vrising/.wine/drive_c/VRisingData/Settings/ServerHostSettings.json
fi

xvfb_wine steamcmd.exe +force_install_dir 'C:\VRisingServer' +login anonymous +app_update 1829350 validate +quit
xvfb_wine VRisingServer.exe -persistentDataPath 'C:\VRisingData'
