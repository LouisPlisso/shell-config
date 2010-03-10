#!/bin/sh
 
# Load resources
  
# xrdb -merge .Xresources
xpmroot $MY_CONFIG_DIR/xmonad/desktop-background.png
   
# Set up an icon tray
    
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
           --expand true --width 10 --transparent true --tint 0x191970 --height 12 &
      
# Set the background color
# xsetroot -solid midnightblue
        
# Fire up apps
         
# gajim &
          
xscreensaver -no-splash &

# keymaps and key config
setxkbmap fr -variant dvorak_prog

# warning: xkbmap resets xmodmap
xmodmap $MY_CONFIG_DIR/xmodmaprc
