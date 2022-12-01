# TeamsBulkChannelImport

The purpose of this script is to be able to upload Teams Channels in bulk with the use of a CSV file. It saves time when you're trying to make a bunch of channels and add a lot of users to all the channels you made.


Prerequisites:


The Teams PowerShell module is required to run this, but the script includes the command to detect and install the module so that it will save you some typing. It does bypass the script policy for this script only and will not change the scripting policy permanently.

Once the Teams Module is installed, it will have you sign into Teams. This is mandatory.

Once you're logged in, it will open File Explorer and will filter for the CSV file only. Once opened, the script will do the rest for you!

CSV file prerequisite:


In order to use this script, you will need to modify the included CSV (comma separated values) file and make sure that you are able to create channels in Teams. The headers are already accounted for so all you have to do is change the fields below it. The script will pull the required information from the CSV.

To format the CSV, you can use Notepad and change the names in the 2nd line, making sure to separate everything with a comma, but I recommend using either Excel or Google Sheets. It's much less intimidating to edit. You can rename the CSV file to whatever you want.

Format of CSV:

<img width="765" alt="image" src="https://user-images.githubusercontent.com/70851634/205086803-8baf01ab-beaa-4f91-bd30-7d0f3454b894.png">

What to change in the 2nd row:

TeamsName: Name of the team that you're adding the channels to

TeamType: Standard, Private, or Shared are the only options. You must pick one of the three.

Be aware that Microsoft Teams only allows for 30 private channels and that once you have met that threshold, you will not be able to create new private channels until 30 days after private channels have been deleted.

ChannelName: Name of the channels you're creating

Owners: Whoever will own/oversee the channel

Members: You'll enter the email address of the channel user that you are adding.


For every user in the same row, you'll add another row so that it will look something like this:

<img width="764" alt="image" src="https://user-images.githubusercontent.com/70851634/205088060-15e67f87-ad96-4bd6-8656-547d2d2757ae.png">


If you get an error from Azure Directory because the "channel name has been used", it's because you need to delete the channel directly from Azure. The error most likely occurs when you have used the channel name before and/or deleted it and it won't let you reuse them without deleting them in Azure's directory.
