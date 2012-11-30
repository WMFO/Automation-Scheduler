#!/bin/bash

base="/opt/wmfo/scheduler"
cd $base/logs
$base/scheduler > `date --date=2days +"%Y_%m_%d.log"`
export XAUTHORITY=/home/wmfo-dj/.Xauthority
export DISPLAY=:0
/usr/local/bin/rdlogmanager -g -m -s Automation -d 2

