#!/bin/sh

#-----------------------------------------------------------------------
# Raspberry Pi 4B
#
# install-conky.sh - Install and Setup conky on Raspberry Pi
#
# usage: install-conky.sh
#
# Copyright (c) 2022 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

logmsg "Install conky"
sudo apt update
sudo apt install -y conky

cd $HOME/.config

if [ !f .conkyrc-1024x699 ]; then
  logmsg "Create .conkyrc-1024x600 file"
  cat <<EOF >.conkyrc-1024x600
conky.config = {
  background = true,
  use_xft = true,
  font = 'Arial:size=10',
  xftalpha = 0.1,
  update_interval = 0.5,
  total_run_times = 0,
  own_window = true,
  own_window_type = 'normal',
  own_window_transparent = true,
  own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
  double_buffer = true,
  minimum_height = '250 5',
  maximum_width = 400,
  draw_shades = false,
  draw_outline = false,
  draw_borders = false,
  draw_graph_borders = false,
  default_color = 'gray',
  default_shade_color = 'red',
  default_outline_color = 'green',
  alignment = 'top_right',
  gap_x = 10,
  gap_y = 10,
  no_buffers = true,
  uppercase = false,
  cpu_avg_samples = 2,
  net_avg_samples = 1,
  override_utf8_locale = false,
  use_spacer = 'right',
}
conky.text = [[
  ${voffset 12}
  ${font Arial:size=14}${color Red}Raspberry Pi${color White} OS ($nodename)
  ${font Arial:bold:size=11}${color Green}SYSTEM ${color Green} ${hr 2}
  ${font Arial:size=10}${color White}$sysname $kernel $alignr $machine
  Frequency $alignr${freq_g cpu0}Ghz
  Uptime $alignr${uptime}
  File System $alignr${fs_type}
  ${font Arial:bold:size=11}${color Green}CPU ${color Green}${hr 2}
  ${font Arial:size=10}${color White}Temp: $alignr ${exec /usr/bin/vcgencmd measure_temp | cut -c6-9} C
  CPU1  ${cpu cpu1}% ${cpubar cpu1}
  CPU2  ${cpu cpu2}% ${cpubar cpu2}
  CPU3  ${cpu cpu3}% ${cpubar cpu3}
  CPU4  ${cpu cpu4}% ${cpubar cpu4}
  ${cpugraph 20,248 White White} $color
  ${font Arial:bold:size=11}${color Green}MEMORY ${color Green}${hr 2}
  ${font Arial:size=10}${color White}MEM $alignc $mem / $memmax $alignr $memperc%
  $membar
  SWAP $alignc $swap / $swapmax $alignr $swapperc%
  $swapbar
  ${font Arial:bold:size=11}${color Green}HDD ${color Green}${hr 2}
  ${font Arial:size=10}${color White}/home $alignc ${fs_used /home} / ${fs_size /home} $alignr ${fs_free_perc /home}%
  ${fs_bar /home}
  ${font Arial:bold:size=11}${color Green}TOP PROCESSES ${color Green}${hr 2}
  ${font Arial:size=10}${color White}${top_mem name 2}${alignr}${top mem 2} %
  ${top_mem name 3}${alignr}${top mem 3} %
  ${top_mem name 4}${alignr}${top mem 4} %
  ${top_mem name 5}${alignr}${top mem 5} %
  ${font Arial:bold:size=11}${color Green}NETWORK ${color Green}${hr 2}
  ${font Arial:size=10}${color White}IP on wlan0 $alignr ${addr wlan0}
  Down $alignr ${downspeed wlan0} kb/s
  Up $alignr ${upspeed wlan0} kb/s
  Downloaded: $alignr  ${totaldown wlan0}
  Uploaded: $alignr  ${totalup wlan0}
]]
EOF
fi

if [ ! -f .conkyrc-1920x1080 ]; then
  logmsg "Create .conkyrc-1920x1080 file"
  cat <<EOF >.conkyrc-1920x1080
conky.config = {
  background = true,
  use_xft = true,
  font = 'Arial:size=12',
  xftalpha = 0.1,
  update_interval = 0.5,
  total_run_times = 0,
  own_window = true,
  own_window_type = 'normal',
  own_window_transparent = true,
  own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
  double_buffer = true,
  minimum_height = '250 5',
  maximum_width = 400,
  draw_shades = false,
  draw_outline = false,
  draw_borders = false,
  draw_graph_borders = false,
  default_color = 'gray',
  default_shade_color = 'red',
  default_outline_color = 'green',
  alignment = 'top_right',
  gap_x = 10,
  gap_y = 10,
  no_buffers = true,
  uppercase = false,
  cpu_avg_samples = 2,
  net_avg_samples = 1,
  override_utf8_locale = false,
  use_spacer = 'right',
}
conky.text = [[
  ${voffset 12}
  ${font Arial:bold:size=16}${color Red}Raspberry Pi${color White} OS
  ${font Arial:bold:size=14}${color Green}SYSTEM ${color Green}${hr 2}
  ${font Arial:size=12}${color White}Nodename $alignr $nodename
  ${font Arial:size=12}${color White}$sysname $kernel $alignr $machine
  Frequency $alignr${freq_g cpu0}Ghz
  Uptime $alignr${uptime}
  File System $alignr${fs_type}
  ${font Arial:bold:size=14}${color Green}CPU ${color Green}${hr 2}
  ${font Arial:size=12}${color White}Temp: $alignr ${exec /usr/bin/vcgencmd measure_temp | cut -c6-9} C
  CPU1  ${cpu cpu1}% ${cpubar cpu1}
  CPU2  ${cpu cpu2}% ${cpubar cpu2}
  CPU3  ${cpu cpu3}% ${cpubar cpu3}
  CPU4  ${cpu cpu4}% ${cpubar cpu4}
  ${cpugraph 30,248 White White} $color
  ${font Arial:bold:size=14}${color Green}MEMORY ${color Green}${hr 2}
  ${font Arial:size=12}${color White}MEM $alignc $mem / $memmax $alignr $memperc%
  $membar
  SWAP $alignc $swap / $swapmax $alignr $swapperc%
  $swapbar
  ${font Arial:bold:size=14}${color Green}HDD ${color Green}${hr 2}
  ${font Arial:size=12}${color White}/home $alignc ${fs_used /home} / ${fs_size /home} $alignr ${fs_free_perc /home}%
  ${fs_bar /home}
  ${font Arial:bold:size=14}${color Green}TOP PROCESSES ${color Green}${hr 2}
  ${font Arial:size=12}${color White}${top_mem name 2}${alignr}${top mem 2} %
  ${top_mem name 3}${alignr}${top mem 3} %
  ${top_mem name 4}${alignr}${top mem 4} %
  ${top_mem name 5}${alignr}${top mem 5} %
  ${top_mem name 6}${alignr}${top mem 6} %
  ${font Arial:bold:size=14}${color Green}NETWORK ${color Green}${hr 2}
  ${font Arial:size=12}${color White}IP on wlan0 $alignr ${addr wlan0}
  Down $alignr ${downspeed wlan0} kb/s
  Up $alignr ${upspeed wlan0} kb/s
  Downloaded: $alignr  ${totaldown wlan0}
  Uploaded: $alignr  ${totalup wlan0}
]]
EOF
fi

if [ ! -h .conkyrc ]; then
  logmsg "Create symbolic link .conkyrc-1920x1080"
  ln -s .conkyrc-1024x600 .conkyrc
fi

if [ ! -d lxsession ]; then
  mkdir lxsession
fi

cd lxsession
if [ ! -d LXDE-pi ]; then
  mkdir LXDE-pi
fi

cd LXDE-pi
if [ ! -f autostart ]; then
  logmsg "Create autostart file"
  cat <<EOF >autostart
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@conky -c /home/pi/.config/.conkyrc -p 5
EOF
fi

logmsg "Please log in again to start conky."

exit 0
