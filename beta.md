# NOTE - This is a beta script and will probably break stuff!!!!
#   use this file as a readme, until this message is removed!

sudo asl-menu - setup node

[XXXXX](node-main) *** Listed with YOUR node number ***
statpost_url = http://stats.allstarlink.org/uhandler
duplex = 1
idrecording = |iZS6XXX (*** need to comment out in the main section also ***)
;;;;;;;;;;;;;;;;;;; Your node settings here ;;;;;;;;;;;;;;;;;;;
rxchannel = SimpleUSB/XXXXX                     ; SimpleUSB (*** XXXX = your node number ***)
startup_macro = *55
startup_macro_delay=20
wait_times = wait_times_hd
hangtime = 100
nounkeyct = 1
remote_timeout = 7200000
totime = 7200000

*** edit [macro] stanza at the bottom of rpt.conf
5 = *908 P P P *813617050

*** comment out linkunkeyct = ct8 in main section

*** Enable 811, 812, 813 in ilink commands
*** Enable 907, 908 in cop functions

Add under mandatory command codes
76 = ilink,6		;Disconnect all nodes

*** SIMPLEUSB TUNE MENU ***
Active Simple USB Radio device is [XXXXXX].
1) Select active USB device
2) Set Rx Voice Level (using display)
3) Set Transmit A Level (currently '850')
4) Set Transmit B Level (currently '850')
B) Toggle RX Boost (currently 'disabled')
C) Toggle Pre-emphasis (currently 'disabled')
D) Toggle De-emphasis (currently 'disabled')
E) Toggle Echo Mode (currently 'disabled')
F) Flash (Toggle PTT and Tone output several times)
G) Toggle PL Filter (currently 'enabled')
H) Toggle PTT mode (currently 'open')
I) Change Carrier From (currently 'usb')
J) Change CTCSS From (currently 'no')
K) Change RX On Delay (currently '0')
L) Change TX Off Delay (currently '0')
P) Print Current Parameter Values
S) Swap Current USB device with another USB device
T) Toggle Transmit Test Tone/Keying (currently 'disabled')
V) View COS, CTCSS and PTT Status
W) Write (Save) Current Parameter Values
0) Exit Menu


*** Allmon3 Setup ***
sudo allmon3-passwd --delete allmon3 to remove the default login
sudo allmon3-passwd <new user login> to set the new user login. Type the new password when prompted.
sudo systemctl restart allmon3 to load the new login.

*** Supermon 7.4+ Install ***
###cd /usr/local/sbin
cd ~     # you want to cd the user home dir,not the sbin folder
sudo wget "http://2577.asnode.org:43856/supermonASL_fresh_install" -O supermonASL_fresh_install
sudo chmod +x supermonASL_fresh_install
hash
sudo supermonASL_fresh_install (*** !! Hit enter (N) when prompted to overwrite allmon.ini !! ***)

cd /var/www/html/supermon/
sudo nano allmon.ini
sudo htpasswd -cB .htpasswd admin


*** Fix Allmon3 ***
sudo nano /etc/allmon3/allmon3.ini
# Update password

Add WiFi Network (Rather use “sudo nmtui”)

*** Enable Auto Connect for Wi-Fi ***
sudo nmcli device set wlan0 autoconnect yes
nmcli connection modify CONNECTION_NAME connection.autoconnect yes

sudo nmcli conn add type wifi con-name "37 Alphen Close" ifname wlan0 ssid M@tthe3s
sudo nmcli conn modify "37 Alphen Close" wifi-sec.key-mgmt wpa-psk wifi-sec.psk M@tthe3s

# Check Auto Connection Status
nmcli -f name,autoconnect connection 

# Set Auto Connect for Device
sudo nmcli con mod wlan0 connection.autoconnect yes

# Set Auto Connect for Connection

#GUI for setting up Wi-Fi connections, where you can select Auto Connect
sudo nmtui




FRESH DEBIAN
sudo apt-get update && sudo apt-get install linux-headers-`uname -r`
https://support.digium.com/s/article/Installing-DAHDI


REPEATER DISABLE TELEMETRY 

ASL 3 has a bug that if nothing is announced after bootup, then TX will stay keyed. 
So announce the timeout disable then turn off telemetry.  

For the repeaters:
To turn off telemetry announce
1.	Enable 934 = cop,34		(Local telem output disable)
2. 	Change start macro: *908 P *934 P P *813617050 (Announce TOT then disable telem before connecting to masternode.



### Backups
For backups via asl-menu
edited /var/asl-backups/asl-backup-files

added:

# Custom
/etc/wireguard
/etc/apache2
/home/hubzanet
/var/www/html/supermon
# to back
sudo asl-menu
Select Backup and Restor Menu
1 Create Node Backup
# Logout from ssh
# from command line, instead of ssh sarc-allstar do 
 scp sarc-allstar:/var/asl-backups/ASL_2024-08-18_2024.tgz .

