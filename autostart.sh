#! /bin/bash
# DWM自启动脚本 仅作参考 
# 搭配 https://github.com/yaocccc/scripts 仓库使用 目录位置 ~/scripts
# 部分配置文件在 ~/scripts/config 目录下

_thisdir=$(cd $(dirname $0);pwd)

settings() {
    [ $1 ] && sleep $1
    xset -b                                   # 关闭蜂鸣器
    fcitx5 -r &                                  # 开启输入法
}

daemons() {
    [ $1 ] && sleep $1
    $_thisdir/statusbar/statusbar.sh cron &   # 开启状态栏定时更新
    #xss-lock -- ~/scripts/blurlock.sh &       # 开启自动锁屏程序
    flameshot &                               # 截图要跑一个程序在后台 不然无法将截图保存到剪贴板
    #feh --randomize --bg-fill  ~/dotfiles/wallpapers/*.*
    xwinwrap -ni -fs -ov -s -st -sp -a -b -nf -- mplayer -wid WID -quiet ~/dotfiles/wallpapers/无标题视频——使用Clipchamp制作.mp4 -loop 0 &
    /usr/lib/polkit-kde-authentication-agent-1 &
    dunst &
    picom --experimental-backends --config ~/.config/picom/picom.conf >> /dev/null 2>&1 & # 开启picom
}

cron() {
    [ $1 ] && sleep $1
    let i=10
    while true; do
        [ $((i % 300)) -eq 0 ] && feh --randomize --bg-fill ~/dotfiles/wallpapers/*.* # 每300秒更新壁纸
        sleep 10; let i+=10
    done
}

settings 1 &                                  # 初始化设置项
daemons 3 &                                   # 后台程序项
#cron 5 &                                      # 定时任务项
