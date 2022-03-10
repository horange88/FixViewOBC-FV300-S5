#!/bin/bash

DATA=`curl --silent --max-time 2 --connect-timeout 2 http://192.168.8.1/api/webserver/SesTokInfo`
SESSION_ID=`echo "$DATA" | grep "SessionID=" | cut -b 10-147`
TOKEN=`echo "$DATA" | grep "TokInfo" | cut -b 10-41`

curl --silent --max-time 3 --connect-timeout 3 -H "Cookie: $SESSION_ID" -H "__RequestVerificationToken: $TOKEN" http://192.168.8.1/api/monitoring/status

