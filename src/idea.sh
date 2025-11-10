#!/bin/bash
if [ -z "$1" ]; then
  TARGET="$PWD"
else
  TARGET="$1"
fi

WIN_PATH=$(wslpath -w "$TARGET")

cmd.exe /c start "" "C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2024.3.3\bin\idea64.exe" "$WIN_PATH"
