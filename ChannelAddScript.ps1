#Check for powershell microsoft teams module which is required to run the next commands
#Get-Module -ListAvailable -Name MicrosoftTeams is the original command

Write-Host "Checking for the Teams PowerShell Module. Please wait..."
$command = Get-Module -ListAvailable -Name MicrosoftTeams

if($command){
Write-Host "Teams PowerShell Module was found. Connecting to Microsoft Teams now."
}

 
else{
	Write-Host "Teams PowerShell Module is not installed on this system and is required before proceeding."
    $installmod = Read-Host -Prompt "Install it now? (y or n to continue)"
    
	if ($installmod -eq 'n')
	{
	Write-Error 'Teams PowerShell Module was not installed. Aborting script...'
	break;
	}
	
	elseif ($installmod -eq 'y')
	{
	Install-Module -Name MicrosoftTeams -Force -AllowClobber -Scope CurrentUser
	#Adding "-Scope Current User" was needed in order to install the module without elevated access or modifying the script execution policy.
	#need a way to loop back to the if statement so that it can loop back to the beginning.
	Write-Host "Teams PowerShell Module was installed successfully. Connecting to Microsoft Teams now."
	}
}

#connects to log in splash only when the module is either found or installed.
Connect-MicrosoftTeams
Write-Host "Teams Module connected."
Write-Host "Opening File Explorer to import CSV file..."

#Select-File function is how the File Explorer opens up so that you can choose the file.

function Select-File {
  param([string]$Directory = $PWD)

  $dialog = [System.Windows.Forms.OpenFileDialog]::new()
  $dialog.InitialDirectory = (Resolve-Path $Directory).Path
  $dialog.RestoreDirectory = $true
  $dialog.Filter = "Comma Separated Values (*.csv)|*.csv"

  $result = $dialog.ShowDialog()

  if($result -eq [System.Windows.Forms.DialogResult]::OK){
    return $dialog.FileName
  }
}

$path = Select-File

Write-Host "Importing CSV file now. This may take some time. Please wait... "
$csv = Import-Csv $path

#Previous version: $csv = Import-Csv 'C:\foldername\nameoffile.csv' - If Select-File isn't working, then the Import-Csv command with the file location replaced in those quotes will work.
##idea: call command to load the "choose file" window so that user doesn't need to copy/paste filepath and then store file path as variable.

ForEach ($Class in $csv){
$TeamName = $class.TeamsName
$Membership = $class.TeamType
$Channel = $class.ChannelName
$ChannelOwnerName = $class.Owners
$Email = $class.Members


$TeamID = Get-Team -DisplayName $TeamName| Select -expand GroupID
Write-Host $TeamID #this was just for my reference to make sure I had pulled the GroupID for the team in the CSV file.
#TeamsName, TeamType, ChannelName, Owners, and Members are the column headers in the CSV file.

New-TeamChannel -GroupID $TeamID -DisplayName $Channel -Owner $ChannelOwnerName -MembershipType $Membership

#The TeamID is the id from the Team, not the Channel's group ID.
#need if statements to handle errors for teams you don't have permission to create channels in
#adds users from the CSV to the channel specified in the CSV. GroupID is the Team's ID, not channel's ID
Write-Host "Adding user $Email in Channel $Channel"
Add-TeamChannelUser -GroupID $TeamID -DisplayName $Channel -user $Email
}

#when everything imports successfully
#If an error mentions the channel name being taken, that means it's still in Azure's database
#It would also have to be deleted there in order for the channel name to be reused.

#The below statement tells me that the script completed. It will print regardless of error.
Write-Host "CSV file import process complete." -ForegroundColor Green
