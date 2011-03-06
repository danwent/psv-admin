#!/bin/bash 

kill `ps -Af | grep notary_http.py | grep -v grep | awk '{print $2}'`
