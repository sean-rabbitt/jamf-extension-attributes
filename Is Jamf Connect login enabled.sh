#!/bin/bash

# Is Jamf Connect login window enabled

loginwindow_check=$(security authorizationdb read system.login.console | grep 'JamfConnectLogin:Initialize' 2>&1 > /dev/null; echo $?)

if [ $loginwindow_check == 0 ]; then
	echo "<result>TRUE</result>"
else
	echo "<result>FALSE</result>"
fi