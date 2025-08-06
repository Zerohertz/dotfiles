#!/bin/bash

if pgrep -x "yabai" >/dev/null; then
	yabai --stop-service
else
	yabai --start-service
fi
