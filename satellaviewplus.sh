#!/bin/bash
# Get script directory.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Check for Satellaview+
if [ -e "$SCRIPT_DIR"/Satellaview+*.appimage ]
then
    echo "Satellaview+.appimage exists. Continuing."
else
    echo "Satellaview+.appimage does NOT exist. Grabbing..."
    # TODO: Is there a way to automate this? It'll get tedious real fast if they ever update the client...
    curl "https://satellaview-plus.com/client/linux-x64/Satellaview+_V5.AppImage" --output "$SCRIPT_DIR"/Satellaview+.appimage
    echo "Marking appimage as executable (chmod +x Satellaview+.appimage)"
    chmod +x Satellaview+.appimage
fi

# Check for SuperSNES9x
if [ -e "$SCRIPT_DIR"/SuperSNES9x.appimage ]
then
    echo "SuperSNES9x AppImage exists. Continuing."
else
    echo "SuperSNES9x AppImage does NOT exist. Grabbing..."
    curl -L "https://github.com/shanytc/snes9x/releases/latest/download/super-snes9x-qt-x86_64.AppImage" --output "$SCRIPT_DIR"/SuperSNES9x.appimage
    echo "Marking appimage as executable (chmod +x SuperSNES9x.appimage)"
    chmod +x SuperSNES9x.appimage
fi

# Check for config for Satellaview+, automate building one if there is none to be found.
# This is to ensure the least amount of pain from setup as humanly possible.
if [ -e "$SCRIPT_DIR"/config.json ]
then
    echo "Satellaview+ Config exists. Continuing."
else
    echo "Satellaview+ Config does not exist. Creating."
    jq -n --arg dl ""$SCRIPT_DIR"" --arg emu ""RetroArch"" --argjson strtmin false --argjson quitonclose true '{DownloadLocation: $dl, Emulator: $emu, StartMinimized: $strtmin, ExitOnClose: $quitonclose}' > config.json
fi

# Satellaview+ - Needs a few moments to download satdata
echo "Booting up Satellaview+..."
# Original boot, use if launching directly as opposed to a terminal or 3rd party launcher
# ./Satellaview+.appimage
"$SCRIPT_DIR"/Satellaview+.appimage &

# Wait until bs-x.sfc is available.
# If setup went correctly, Satellaview+ will download the RetroArch version, which includes the vaunted bs-x.sfc that's included into the satdata.
# Using any other method will cause the program to delete BS-X.sfc everytime and allows us to not use RetroArch.
until [ -e "$SCRIPT_DIR"/roms/bs-x/bs-x.sfc ]; do
    sleep 1
done
# Boot BS-X - Much more simpler.
echo "Beginning boot up for BS-X..."
"$SCRIPT_DIR"/SuperSNES9x.appimage ./roms/bs-x/bs-x.sfc
