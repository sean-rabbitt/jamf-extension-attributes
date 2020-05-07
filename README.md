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