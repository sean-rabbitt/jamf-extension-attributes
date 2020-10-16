# jamf-extension-attributes
Useful extension attributes I've created for Jamf Pro servers

All code is offered free, as in beer.  As in I'll gladly take one.  Or a gin and tonic.

Look for Unmigrated Users:
An extension attribute for Jamf Connect and Jamf Pro.  Add this script as an EA.
EA will return a list of short names on a machine of users have a local password
who are not yet migrated to Jamf Connect Login.  

Sample Use:
Use EA with a Smart Computer Group.  Use the Smart Computer Group to scope a configuration
profile that DenyLocal login for any users who haven't migrated yet.

Sample Use:
Search for machines that have "rogue" local accounts not controlled by your IdP's controls.


Look for Network Users:
Search for mobile account users 


Will return either "No Network Accounts" if no accounts exist or a list of the 
short names of network accounts on a macOS device

Sample Use:
Use with smart groups in Jamf Pro to scope for NoMAD or Jamf Connect to demobilize
user accounts.  For example, if no network accounts exist, remove the DeMobilize mechanism
from Jamf Connect Login with an authchanger command.  Or, use the presence of no
mobile accounts as the trigger to turn on Migrate flag in a Jamf Connect Login 
configuration profile.


Jamf Helper Utility:
Uses the Jamf Helper app to put an alert on the screen for a user.

Sample Use:
When deployed with a Jamf Pro policy, use PARAMETER 4 for the title of the 
window, PARAMETER 5 for a header on top of your important message,
PARAMETER 6 for your message including \n newlines, and PARAMETER 7 for
the text shown on the continue button.

Last Jamf Connect menu bar agent login within range:
Find out if a user has logged into Jamf Connect successfully within a certain time frame in days

Sample Use:
Use as an extension attribute in Jamf Pro.  If a user hasn't logged in successfully in X days,
you can use the EA to create a Smart Computer Group.  Remediate the issue however you wish, but
some suggestions are to:
* Add the DenyLocal preference set to TRUE for com.jamf.connect.login - forces network login on next
	login even if FileVault is enabled
* Use the Jamf Helper Utility as a script to force sign-in with a message explaining why they are
	being required to log in