#!/bin/bash

# Return the number of Jamf Connect Login enabled users
# Will return an integer with the number of users who use Jamf Connect login
# — SRABBITT May 6, 2020 

# MIT License
#
# Copyright (c) 2020 Jamf Software

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# REQUIRED VARIABLES
# Put the name of the management account created for Jamf in a prestage enrollment here
jamfManagementAccount=jamfManagement

# Declare variable for JamfConnectUsers
JamfConnectUserCount=0

# Get a list of all users on the machine who have a password.  For each user check to see if 
# the user is named after the Jamf Management Account or the _mbsetupuser

####NOTE: That second thing may not be required; my setup of Parallels might have given the
# 	_mbsetupuser a password when it really didn't need one...
####NOTE: You may want to modify this to add any additional programatically created
#	local admin accounts you create in your environment.

for user in $(dscl . list /Users Password | awk '$2 != "*" {print $1}');do
	if [[ ("$user" != "$jamfManagementAccount") && ("$user" != "_mbsetupuser") ]]; then
		# Look in the dscl record for the user and see if there is an entry for OIDCProvider
		# Jamf Connect will add that to the user record when it is migrated or created
		MIGRATESTATUS=($(dscl . -read /Users/$user | grep "OIDCProvider: " | awk {'print $2'}))
		# If we didn't get a result, the variable is empty.  Thus that user hasn't been migrated.
		if [[ -z $MIGRATESTATUS ]]; 
		then
			# user is not a jamf connect user
			echo "$user is Not a Jamf Connect User"
		else
			echo "$user is a Jamf Connect user"
			JamfConnectUserCount=$((JamfConnectUserCount+1))
			
		fi
	fi
done

echo "<result>$JamfConnectUserCount</result>"


exit 0