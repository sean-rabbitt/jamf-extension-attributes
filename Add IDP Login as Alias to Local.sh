#!/bin/bash

# Add a local user login alias that matches the user's IDP login for Jamf Connect Login if 
# network is offline.  Assumes that you're running this as a policy from Jamf Pro scripts.  
# If not, change the definition of the LOCALUSER variable below to the alternative method.
#
# Deploy with a Jamf Pro policy set to scope All Users and Specific Computers where
# the specific computers is a smart group containing all machines that have Jamf Connect Login
# installed.  Set trigger to Reoccuring Checkin and Execution Frequency to Once per User.
# — SRABBITT May 19, 2020 1:13 PM

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


# $3 is obtained from Jamf Pro when running through policy or self service.
LOCALUSER=$3

# Alternative method - /bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'
# LOCALUSER=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')

# NETWORKUSER finds the "NetworkUser: " tag in a dscl lookup.
NETWORKUSER=($(dscl . -read /Users/$LOCALUSER| grep "NetworkUser: " | awk {'print $2'}))

# Sanity Check - If NETWORKUSER is empty, we have an issue.
if [[ -z "$NETWORKUSER" ]]; then
	# User is not migrated to Jamf Connect Login - abort
	exit 1
fi
# Add alias to local user's login name.
dscl . -merge /Users/$LOCALUSER RecordName $NETWORKUSER

exit 0