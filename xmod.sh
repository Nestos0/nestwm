if [ $(xmodmap -pke | grep 'keycode  57' | awk '{print $4}') == 'k' ]; then
    notify-send '(A) 切换到QWERTYUI'
    xmodmap ~/.Xmodmap-cn
else
    notify-send '(A) 切换到Colemak'
    xmodmap ~/.Xmodmap
fi
