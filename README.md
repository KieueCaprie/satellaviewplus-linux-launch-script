# satellaview--linux-launch-script
A launch script created specifically for launching Satellaview + (https://satellaview-plus.com) and BS-X in SuperSNES9x.

# Currently supports
- Linux - ArchLinux (tested on EndeavourOS), SteamOS

# How to use
1. Download the repository by using ```git clone https://github.com/KieueCaprie/satellaview--linux-launch-script.git``` or by clicking on Code in the main Github page and clicking "Download ZIP".
2. If you've downloaded the zip, remember to place it in an easily accessible spot.
3. Navigate to the folder containing the launch script.
4. Make "satellaviewplus.sh" executable by either using ```chmod +x satellaviewplus.sh``` or by right-clicking, going to properties, going to the Permissions tab, and checking "Allow executing file as program".
5. Execute the script.

## Satellaview+ Instructions
1. Once the app has been launched, click on the button in the bottom left (It has a pencil with a cog wheel next to it) labelled "Configure Satellaview+".
2. In the Configure Satellaview+ window, do the following:
   - Change target emulator from BSNES+ to SNES9X
   - (Optional but good QoL for handheld devices) Check "Exit on Close".
3. Navigate to Download SatData, then click Download Data. Note that it may take a while to receive SatData the first time.
4. Keep the window open while using BS-X to receive up-to-date satdata.

**Note**: Satellaview+ will delete any foreign objects on initial setup. I do not know why it does this but it seems to not do this with every download from then on.

TODO:
- Figure out how to get the most up-to-date Linux client for Satellaview+ in case of future updates. Current script downloads V5.
