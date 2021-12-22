#Dit script maakt een home dir aan per user in de gespecificeerde OU's
#De map zal alleen toegangkelijk zijn per user
Import-Module activedirectory

#In de onderstaande OU's wordt gegeken naar de users.

$OUs=
"OU=Medewerkers,DC=uvh,DC=nl","OU=Studenten,DC=uvh,DC=nl"

#loop om door de bovenstaande Array te looopooo
Foreach($OU in $OUs){   

$users = Get-ADUser -Filter * -SearchBase $OU
$users | ForEach-Object {
# Assign user's home directory path
$sam = $_.SamAccountName
$homeDirectory = "\\fileserver\home_folders$\$sam" 
Set-ADUser -Identity $sam -HomeDirectory $homeDirectory -HomeDrive H;

#home dir aanmaken.
Try
{
    mkdir $homeDirectory > $null
}

#als aanmaken niet lukt wordt er een error gegeven
Catch
{
    Write-Error "Map is niet aangemaakt"
}

#
Set-ADUser $sam -HomeDrive H: -HomeDirectory $homeDirectory -ea Stop

#Rechten aanmaken voor gebruiker $sam. 
Try
{
    icacls "$homeDirectory" /grant "$($sam):(OI)(CI)F" 
}

#als rechten veranderen niet werk wordt er een error code teruggeven
Catch
{
    Write-Error "Rechten ging fout"
}
}
}