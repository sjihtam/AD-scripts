Import-Module ActiveDirectory

Write-Output "Starting script.."

Import-Csv "C:\ScriptsMailboxUsers.csv" | ForEach-Object {

if ( $_.'ParentOU' -eq "Medewerkers" )
{
    $emailEnd = "@mw.uvh.nl"
    $email = $_.'alias' + $emailEnd
    Write-Output $_.'email'
    New-Mailbox -UserPrincipalName $email -PrimarySmtpAddress $email -Alias $_.'alias' -Name $_.'name' –OrganizationalUnit $_.'ParentOU' -Password (ConvertTo-SecureString 'Groep123!' -AsPlainText -Force) -FirstName $_.'firstName' -LastName $_.'lastName' -DisplayName $_.'displayName' -ResetPasswordOnNextLogon $False 
}

if ( $_.'ParentOU' -eq "Studenten" )
{
    $emailEnd = "@st.uvh.nl"
    $email = $_.'alias' + $emailEnd
    Write-Output $_.'email'
    New-Mailbox -UserPrincipalName $email -PrimarySmtpAddress $email -Alias $_.'alias' -Name $_.'name' –OrganizationalUnit $_.'ParentOU' -Password (ConvertTo-SecureString 'Groep123!' -AsPlainText -Force) -FirstName $_.'firstName' -LastName $_.'lastName' -DisplayName $_.'displayName' -ResetPasswordOnNextLogon $False 
}
}





# enable mailbox for ad user
# Enable-Mailbox -Identity:'scripttestuser' -Alias:'scripttestuser' -Database: 'TestDBStore'