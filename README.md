# TeamsBulkChannelImport

The purpose of this script is to be able to upload Teams Channels in bulk with the use of a CSV file.

In order to use this script, you will need to modify the included CSV file and make sure that you are able to create channels in Teams. The headers in the CSV file are self explanatory except for maybe the Membership type for which the value will either be Public or Private. The script will pull the required information from the CSV.

If you get an error from Azure Directory, it is because you need to delete the channel directly from Azure. The error most likely occurs when you have used the channel name before and it won't let you reuse them without deleting them in Azure first.

The Teams PowerShell module is required to run this, but the script includes the script to install the module so that it will save you some typing. It does bypass the script policy for this script only.

Once the Teams Module is installed, it will have you sign into Teams. This is mandatory.

Once you're logged in, it will open File Explorer and will filter for the CSV file only. Once opened, the script will do the rest for you!
