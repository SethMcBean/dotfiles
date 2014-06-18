# Run the system-wide support stuff
. $GLOBALAUTOSTART

# Programs to launch at startup
# =============================

# Start session manager
lxsession &

# Enable power management
gnome-power-manager &

# Set keyboard map if different than UK
# Uncomment one to enable, or define your own.
 setxkbmap us & # United States
# setxkbmap ca & # Canada
# setxkbmap fr & # Francais
# setxkbmap br & # Brazil
# setxkbmap de & # Germany
# setxkbmap cz & # Czech Republic
# setxkbmap it & # Italy
# setxkbmap pl & # Poland
# setxkbmap nl & # Netherlands
# etc.

# Force openoffice.org to use GTK theme
# enable this if you install openoffice
#export OOO_FORCE_DESKTOP=gnome

# Set-up automounting
## pcmanfm SUCKS, dont ever use it!!!
#pcmanfm --daemon-mode &


# Set desktop wallpaper
nitrogen --restore &

# Enable Eyecandy - off by default
# see "/usr/bin/crunchbang/xcompmgr-crunchbang" for more info
#xcompmgr-crunchbang --startstop &

# Start screensaver deamon
gnome-screensaver &

# Launch panel
(sleep 2s && lxpanel) &

# Launch network manager applet
(sleep 1s && nm-applet) &

# Launch clipboard manager
(sleep 1s && parcellite) &

# Uncomment to enable system updates at boot
#(sleep 180s && system-update) &

# Check for restricted hardware
(sleep 5s && jockey-gtk --check) &

# Launch Conky
conky -q &

# Just in case some random app calls on Nautilus, lets set some safeguards to minimise the impact:
# Disable Nautilus desktop, because we really really do not want it!
gconftool-2 -s -t bool /apps/nautilus/preferences/show_desktop false &
# Do not let Nautilus set the background, because we really really do not want this either.
gconftool-2 -s -t bool /desktop/gnome/background/draw_background false &
# Make Nautilus use spatial mode, should start-up quicker.
gconftool-2 -s -t bool /apps/nautilus/preferences/always_use_browser false &
# Make Nautilus show the advanced permissions dialog -- if it has to start, lets at least make it usable :) 
gconftool-2 -s -t bool /apps/nautilus/preferences/show_advanced_permissions true &
# And finally...
# ...start dropbox daemon, but give it a minute so we can establish a net connection.
(sleep 60s && ~/.dropbox-dist/dropboxd) &
