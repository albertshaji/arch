# ~/.xinitrc xorg-xinit

nitrogen --set-zoom-fill $HOME/pic/.wallpaper
xbacklight -set 7
amixer set 'Master' 100%
redshift -P -O 5000 >/dev/null
xrdb .Xresources

# vim like hjkl with capslock
xmodmap -e "keycode 66 = Mode_switch"
xmodmap -e "add mod1 = Menu"
xmodmap -e "keysym h = h H Left"
xmodmap -e "keysym l = l L Right"
xmodmap -e "keysym k = k K Up"
xmodmap -e "keysym j = j J Down"
xset m 4 0
xset r rate 300 50

# status & notification script
status
battery
weather

# turn off wifi if inactive
{
    sleep 120
    nmcli -f active dev wifi | grep -q 'yes' ||
    sudo rfkill block wlan
} &

sxhkd &
xautolock -time 10 -locker slock &
exec dbus-launch dwm
