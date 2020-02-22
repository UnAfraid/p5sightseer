#!/bin/bash

if [[ ! -f /home/steam/Games/Sightseer/P5SServer.exe ]]; then
	echo "P5SServer.exe is missing!"
	exit 1
fi

if [[ -z $P5_SERVER_WORLD ]]; then
	echo "P5_SERVER_WORLD is not defined"
	exit 1
fi

P5_SERVER_OPTIONS=""
if [[ $P5_SERVER_PRIVATE ]]; then
	P5_SERVER_OPTIONS="${P5_SERVER_OPTIONS} -private"
	echo "Enabling private mode"
fi

if [[ $P5_SERVER_HTTP ]]; then
	P5_SERVER_OPTIONS="${P5_SERVER_OPTIONS} -http"
	echo "Enabling http server"
fi

echo "Starting the P5SServer..."
mkdir -p /home/steam/Games/Sightseer/Worlds/$P5_SERVER_WORLD
cd /home/steam/Games/Sightseer/Worlds/$P5_SERVER_WORLD
mono /home/steam/Games/Sightseer/P5SServer.exe -name "$P5_SERVER_NAME|$P5_SERVER_NOTE" -world "$P5_SERVER_WORLD" -tcp 5180 "$P5_SERVER_OPTIONS"
