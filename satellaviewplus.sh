#!/bin/bash
# Where are we? Find out.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Check for Satellaview+
if [ -e "$SCRIPT_DIR"/Satellaview+*.appimage ]
then
    echo "Satellaview+.appimage exists. Continuing."
else
    echo "Satellaview+.appimage does NOT exist. Grabbing... (A password may be prompted.)"
    # TODO: Is there a way to automate this? It'll get tedious real fast if they ever update the client...
    curl "https://satellaview-plus.com/client/linux-x64/Satellaview+_V5.AppImage" --output "$SCRIPT_DIR"/Satellaview+.appimage
    echo "Marking appimage as executable (chmod +x Satellaview+.appimage)"
    chmod +x Satellaview+.appimage
fi
sleep 5
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
sleep 5
# Satellaview+ - Needs a few moments to download satdata
echo "Booting up Satellaview+..."
# Original boot, use if launching directly as opposed to a terminal or 3rd party launcher
# ./Satellaview+_V5.appimage
"$SCRIPT_DIR"/Satellaview+_V5.appimage &
sleep 10
# Boot BS-X - Much more simpler.
echo "Beginning boot up for BS-X..."
# Check to see if BS-X is in satdata, this is because Satellaview+ tends to delete bs-x.sfc for some unknown reason...
if [ -e "$SCRIPT_DIR"/satdata/BS-X.sfc ]
then
    echo "BS-X.sfc exists. Launching SuperSNES9x"
else
    echo "BS-X.sfc does not exist. Copying..."
    cp "$SCRIPT_DIR"/BS-X.sfc "$SCRIPT_DIR"/satdata/BS-X.sfc
fi
# ./supersnes9x.appimage "./satdata/BS-X.sfc"
"$SCRIPT_DIR"/SuperSNES9x.appimage ./satdata/BS-X.sfc
