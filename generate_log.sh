#!/bin/bash

base="/opt/wmfo/scheduler"
expected_size=12960
log_file=$base/generate_log.log
scheduler_file=$base/logs/`date --date=1days +"%Y_%m_%d.log"`


cd $base/logs
$base/scheduler > $scheduler_file

date >> $log_file
# we don't have error handling in the scheduler C file, so chck here:
scheduler_file_size=$(wc -c < "$scheduler_file")
if [ $scheduler_file_size -ne $expected_size ]; then
	echo "Warning!!! Log file size $scheduler_file_size which doesn't match expected $expected_size. This may indicate a problem with log file generation and should be investigated. See $log_file on `hostname`."
fi 

echo "Log size $scheduler_file_size of expected $expected_size">>$log_file

export XAUTHORITY=/home/wmfo-dj/.Xauthority
export DISPLAY=:0
if /usr/local/bin/rdlogmanager -g -m -s Automation -d 0 >>$log_file ; then
	echo "Return successfully! Exit." >>$log_file
	exit 0
else
	echo "rdlogmanager returned failure. See $log_file on `hostname`."
	echo "rdlogmanager failure" >>$log_file
	exit 1
fi
