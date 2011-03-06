#!/bin/bash 

date=`date`
echo "killing scanner from script at $date" >> logs/scanner.log
kill `ps -Af | grep threaded_scanner.py | grep -v grep | awk '{print $2}'`
