#.xinitrc

# wallpaper
feh -z --bg-fill ~/pic/best

# brightness
xbacklight -set 7

# toggle
touch .ct .tt

# volume
amixer set 'Master' 100%

# vim like hjkl with capslock
xmodmap -e "keycode 66 = Mode_switch"
xmodmap -e "add mod1 = Menu"
xmodmap -e "keysym h = h H Left"
xmodmap -e "keysym l = l L Right"
xmodmap -e "keysym k = k K Up"
xmodmap -e "keysym j = j J Down"
xset m 4 0
xset r rate 300 50

# double capslock as escape
xcape -e 'Mode_switch=Escape'

# status & notification script
dog.sh + &

# turn off wifi if not connected
{
    sleep 60
    nmcli -f active dev wifi | grep -q 'yes' ||
    sudo rfkill block wlan
} &

ln -s tem .tem
redshift -P -O 5000 >/dev/null

exec dbus-launch dwm
