#!/bin/bash

TITLE=$4
HEADING=$5
## The new message variable passed to jamfHelper (this takes care of newlines)
DESCRIPTION=$( printf "$6" )
BUTTONTEXT=$7

"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"\
	-windowType hud -title "$TITLE"\
	-heading "$HEADING"\
	-alignHeading natural -description "$DESCRIPTION"\
	-alignDescription natural -icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns"\
	-button1 "$BUTTONTEXT" -alignCountdown center -lockHUD