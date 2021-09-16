#################################################################################  
## SQL Service Status Report in HTML  using Powershell 
## Created by Shamvil Hasan Kazmi 
## Date : 16 September 2021  
## Version : 1.3  
## Below code will generate an HTML output which will give the status of all SQL service in the HTML format.The script you have create the 
## folder "test" in C Drive or give the path in the last line of code where you want to generate the file.
#################################################################################
#CSS Declaration

$hostname = Read-Host -Prompt 'Input your server  name'
$serverinstance = Read-Host -Prompt 'Input the instance name'
$servername = $hostname+'\'+$serverinstance

$Style = "<style>
body {

background-color:#FAFAFA;

}
.body {
  min-height:inherit;
  scroll-behavior: smooth;
  border-width: thin;
  padding-left: 200px;
  min-width: 500px;
  min-width: 200px;
  white-space: pre-wrap;
  color: purple;
  border-color:purple;
  margin-left: 150px;
  margin-right: 150px;
  -webkit-transition: background-color 0.4s ease-out;
  -moz-transition: background-color 0.4s ease-out;
  -o-transition: background-color 0.4s ease-out;
  transition: background-color 0.4s ease-out;
}
.body:hover {
  text-align: left;
  font-style: oblique;
  padding-left: 200px;
  min-width: 500px;
  min-width: 200px;
  color: PURPLE;
  min-height:inherit;
  white-space: pre-wrap;
  scroll-behavior: smooth;
  border-color: #E5C7E5;
  margin-left: 140px;margin-right: 140px;
  animation-name: example;
  animation-duration: 0.5s;
  box-shadow : 5px 5px 20px purple;
}
.bodyr {
  min-height:inherit;
  scroll-behavior: smooth;
  border-width: thin;
  padding-left: 200px;
  min-width: 500px;
  min-width: 200px;
  white-space: pre-wrap;
  color: purple;
  border-color:purple;
  margin-left: 150px;
  margin-right: 150px;
  -webkit-transition: background-color 0.4s ease-out;
  -moz-transition: background-color 0.4s ease-out;
  -o-transition: background-color 0.4s ease-out;
  transition: background-color 0.4s ease-out;
}
.bodyr:hover {
  text-align: left;
  font-style: oblique;
  padding-left: 200px;
  min-width: 500px;
  min-width: 200px;
  color: PURPLE;
  min-height:inherit;
  white-space: pre-wrap;
  scroll-behavior: smooth;
  border-color: #E5C7E5;
  margin-left: 140px;margin-right: 140px;
  animation-name: example;
  animation-duration: 0.5s;
  box-shadow : 5px 5px 20px red;
}
.bodyg {
  min-height:inherit;
  scroll-behavior: smooth;
  border-width: thin;
  padding-left: 200px;
  min-width: 500px;
  min-width: 200px;
  white-space: pre-wrap;
  color: purple;
  border-color:purple;
  margin-left: 150px;
  margin-right: 150px;
  -webkit-transition: background-color 0.4s ease-out;
  -moz-transition: background-color 0.4s ease-out;
  -o-transition: background-color 0.4s ease-out;
  transition: background-color 0.4s ease-out;
}
.bodyg:hover {
  text-align: left;
  font-style: oblique;
  padding-left: 200px;
  min-width: 500px;
  min-width: 200px;
  color: PURPLE;
  min-height:inherit;
  white-space: pre-wrap;
  scroll-behavior: smooth;
  border-color: #E5C7E5;
  margin-left: 140px;margin-right: 140px;
  animation-name: example;
  animation-duration: 0.5s;
  box-shadow : 5px 5px 20px green;
}

@keyframes example{
  0% {margin-left: 150px;margin-right: 150px;}
  25% {margin-left: 148px;margin-right: 148px;}
  100% {margin-left: 140px;margin-right: 140px;}
}
.table1, thead, th, td {
  border-width: thin;
  border-color: inherit;
  border-style:solid;
  padding: 5px;
  margin-left: 300px;
}
.table1 {
  border-style: none;
}
thead:hover, th:hover, td:hover {
  border-color: #C7AF4D;
  animation-name: example2;
  animation-duration: 1s;
}
@keyframes example2 {
  0% {border-color: inherit;}
  100% {border-color: #C7AF4D;}
}
.body {background-color: #EFEEEE; border-radius: 15px 50px 30px; border: 1px solid purple;}
.bodyr {background-color: #EFEEEE; border-radius: 15px 50px 30px; border: 1px solid red;}
.bodyg {background-color: #EFEEEE; border-radius: 15px 50px 30px; border: 1px solid green;}
.body:hover, .bodyr:hover, .bodyg:hover{background-color: #EFEEEE; border-radius: 15px 50px 30px;}
</style>"
$head = $style
$frag0 = "<div class = ""body""><h2>SQL Servername :</h2>&nbsp" + $servername +"</div>"

$var1 = invoke-sqlcmd -ServerInstance $servername -Query "declare @flag1 int,@flag2 int,@flag3 int
set @flag1 = 0 set @flag2 = 0 set @flag3 = 0
if (select count(name) from sys.syslogins where name = '#######ADD YOUR ADMIN GROUP########') = 1
select '#######ADD YOUR ADMIN GROUP######## is already added' as result
else 
begin
select '#######ADD YOUR ADMIN GROUP######## account needs to be added' as result 
set @flag1 =1
end
if (select count(name) from sys.syslogins where name = '#######ADD YOUR REPORTING SERVICE ACCOUNT########') = 1
select '#######ADD YOUR REPORTING SERVICE ACCOUNT######## is already added' as result
else 
begin
select '#######ADD YOUR REPORTING SERVICE ACCOUNT######## account needs to be added' as result
set @flag2 = 1
end
if ((select count(*) from sys.syslogins where name  like'DOMAIN\u%' or name like 'DOMAIN\adm_u%') = 0)
select 'no individual account found' as result
else
begin
set @flag3 = 1
select name +' needs to be removed'  as result from sys.syslogins where name  like'DOMAIN\u%' or name like 'DOMAIN\adm_u%' 
end
if ((@flag1 + @flag2 + @flag3) > 0)
select 'red' as overall
else
select 'green' as overall" 

$var2 = $var1 | Select-Object overall |foreach-object {$_.overall} 



if (  $var2 -eq "red" )
{
$frag1 = $var1 | select-object result  |ConvertTo-Html -Property 'result'   -Fragment -PreContent '<div class="bodyr"><h2>Logins that need to be added or removed</h2><table class="table1">' -PostContent '</table></div>'|Out-String
}
else{
$frag1 = $var1 | select-object result  |ConvertTo-Html -Property 'result'   -Fragment -PreContent '<div class="bodyg"><h2>Logins that need to be added or removed</h2><table class="table1">' -PostContent '</table></div>'|Out-String
}
$var3 = invoke-sqlcmd -ServerInstance $servername -Query "declare @flag1 int
if (select count(*) from sys.database_files where physical_name like 'C%') <> 0
begin 
set @flag1 = 1
select 'database files found in C drive' as comment, name as Datafiles, @flag1 as Flag from sys.database_files where physical_name like 'C%'
end
else
begin
set @flag1 =0
select '-' as Datafiles, 'no db files in c drive found' as comment, @flag1 as Flag
end " 

$var4 = $var3 |select-object Flag |ForEach-Object{$_.flag} 

if ($var4 -gt 0)
{
$frag2 = $var3| select-object Datafiles, comment |ConvertTo-Html -fragment -precontent '<div class="bodyr"><h2>DB File locations </H2><table class="table1">' -PostContent '</table></div>' |Out-String
}
else
{
$frag2 = $var3| select-object Datafiles, comment |ConvertTo-Html -fragment -precontent '<div class="bodyg"><h2>DB File locations </H2><table class="table1">' -PostContent '</table></div>' |Out-String
}

$var5 = Get-WmiObject win32_service -ComputerName $hostname | Where-Object {$_.name -like "*SQL*" -and $_.name -notlike "*writer*"  -and $_.Startname -like "*LocalSystem*"} |select-object   name, @{N='Service Account';E={$_.Startname}} , startmode, state  

$var6 = 'All SQL services run with network account'|
    ForEach-Object {Add-Member -InputObject $_ -Type NoteProperty -Name Filesystem_Status -Value $_;$_}
if (!$var5)
{
$frag3 =  $var6 |ConvertTo-Html -fragment -Property 'Filesystem_Status' -precontent '<div class="bodyg"><h2>SQL Server with Service account as LocalSystem </H2><table class="table1">' -PostContent '</table></div>'|Out-String
}
else {
$frag3 = $var5 |ConvertTo-Html -fragment -precontent '<div class="bodyr"><h2>SQL Server with Service account as LocalSystem </H2><table class="table1">' -PostContent '</table></div>'|Out-String
}


$sas = Get-WmiObject win32_service  -ComputerName $hostname |Where-Object {$_.name -like "*SQL*"  -and $_.Description -like "*Provides storage, processing and controlled access of data, and rapid transaction processing*" -or $_.description -like "*Executes jobs, monitors SQL Server, fires alerts, and allows automation of some administrative tasks*"}|select-object   @{N='Service Account';E={$_.Startname}} 
function get-rightsonwin  {
#requires -version 2

# Fail script if we can't find SecEdit.exe
$SecEdit = Join-Path ([Environment]::GetFolderPath([Environment+SpecialFolder]::System)) "SecEdit.exe"
if ( -not (Test-Path $SecEdit) ) {
  Write-Error "File not found - '$SecEdit'" -Category ObjectNotFound
  exit
}

# LookupPrivilegeDisplayName Win32 API doesn't resolve logon right display
# names, so use this hashtable
$UserLogonRights = @{
  "SeBatchLogonRight"                 = "Log on as a batch job"
  "SeDenyBatchLogonRight"             = "Deny log on as a batch job"
  "SeDenyInteractiveLogonRight"       = "Deny log on locally"
  "SeDenyNetworkLogonRight"           = "Deny access to this computer from the network"
  "SeDenyRemoteInteractiveLogonRight" = "Deny log on through Remote Desktop Services"
  "SeDenyServiceLogonRight"           = "Deny log on as a service"
  "SeInteractiveLogonRight"           = "Allow log on locally"
  "SeNetworkLogonRight"               = "Access this computer from the network"
  "SeRemoteInteractiveLogonRight"     = "Allow log on through Remote Desktop Services"
  "SeServiceLogonRight"               = "Log on as a service"
}

# Create type to invoke LookupPrivilegeDisplayName Win32 API
$Win32APISignature = @'
[DllImport("advapi32.dll", SetLastError=true)]
public static extern bool LookupPrivilegeDisplayName(
  string systemName,
  string privilegeName,
  System.Text.StringBuilder displayName,
  ref uint cbDisplayName,
  out uint languageId
);
'@
$AdvApi32 = Add-Type advapi32 $Win32APISignature -Namespace LookupPrivilegeDisplayName -PassThru

# Use LookupPrivilegeDisplayName Win32 API to get display name of privilege
# (except for user logon rights)
function Get-PrivilegeDisplayName {
  param(
    [String] $name
  )
  $displayNameSB = New-Object System.Text.StringBuilder 1024
  $languageId = 0
  $ok = $AdvApi32::LookupPrivilegeDisplayName($null, $name, $displayNameSB, [Ref] $displayNameSB.Capacity, [Ref] $languageId)
  if ( $ok ) {
    $displayNameSB.ToString()
  }
  else {
    # Doesn't lookup logon rights, so use hashtable for that
    if ( $UserLogonRights[$name] ) {
      $UserLogonRights[$name]
    }
    else {
      $name
    }
  }
}

# Outputs list of hashtables as a PSObject
function Out-Object {
  param(
    [System.Collections.Hashtable[]] $hashData
  )
  $order = @()
  $result = @{}
  $hashData | ForEach-Object {
    $order += ($_.Keys -as [Array])[0]
    $result += $_
  }
  New-Object PSObject -Property $result | Select-Object $order
}

# Translates a SID in the form *S-1-5-... to its account name;
function Get-AccountName {
  param(
    [String] $principal
  )
  if ( $principal[0] -eq "*" ) {
    $sid = New-Object System.Security.Principal.SecurityIdentifier($principal.Substring(1))
    $sid.Translate([Security.Principal.NTAccount])
  }
  else {
    $principal
  }
}

$TemplateFilename = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName())
$LogFilename = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName())
$StdOut = & $SecEdit /export /cfg $TemplateFilename /areas USER_RIGHTS /log $LogFilename
 if ( $LASTEXITCODE -eq 0 ) {
  Select-String '^(Se\S+) = (\S+)' $TemplateFilename | Foreach-Object {
    $Privilege = $_.Matches[0].Groups[1].Value
    $Principals = $_.Matches[0].Groups[2].Value -split ','
    foreach ( $Principal in $Principals ) {
      Out-Object `
        @{"Privilege" = $Privilege},
        @{"PrivilegeName" = Get-PrivilegeDisplayName $Privilege},
        @{"Principal" = Get-AccountName $Principal}
        
    }
  }
}


else {
  $OFS = ""
  Write-Error "$StdOut"
}
Remove-Item $TemplateFilename,$LogFilename -ErrorAction SilentlyContinue #|-Object $Principal='Everyone'

  
 }
 foreach ($serviceaccount in $sas) {
$array1 = get-rightsonwin |select-object Privilege, PrivilegeName, Principal | Where-Object Principal -eq  $serviceaccount.'Service Account'
 }

 $array2 = get-rightsonwin |select-object Privilege, PrivilegeName, Principal | Where-Object Principal -eq 'everyone'

if (($array1.count + $array2.count) -gt 0){

$frag4 = 'All service account and everyone permission is correct for above list'|
    ForEach-Object {Add-Member -InputObject $_ -Type NoteProperty -Name Result -Value $_;$_} |ConvertTo-Html -property 'Result' -fragment -precontent '<div class="bodyg"><h2>Ensure that below service accounts dont have below access </H2><table class="table1"><h3>
1. Log on as a service <br>
2. Log on as a batch job <br>
3. Replace a process-level token <br>
4. Bypass traverse checking <br>
5. Adjust memory quotas for a process</h3>' -PostContent "</table></div>" |Out-String

}

else{


 
 $frag4 = $array1 + $array2 |ConvertTo-Html -fragment -precontent '<div class="bodyr"><h2>Ensure that below service accounts dont have below access </H2><table class="table1"><h3>
1. Log on as a service <br>
2. Log on as a batch job <br>
3. Replace a process-level token <br>
4. Bypass traverse checking <br>
5. Adjust memory quotas for a process</h3>' -PostContent "<h4>Please send aforementioned service account lists to Wintel team<h4></table></div>" |Out-String


}


$var8 = Invoke-Sqlcmd -ServerInstance $servername -Query "DECLARE       @portNo1   NVARCHAR(10)
  
EXEC   xp_instance_regread
@rootkey    = 'HKEY_LOCAL_MACHINE',
@key        =
'Software\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib\Tcp\IpAll',
@value_name = 'TcpPort',
@value      = @portNo1 OUTPUT
  

-- Execute below script if SQL Server is configured with dynamic port number
DECLARE       @portNo2   NVARCHAR(10)
  
EXEC   xp_instance_regread
@rootkey    = 'HKEY_LOCAL_MACHINE',
@key        =
'Software\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib\Tcp\IpAll',
@value_name = 'TcpDynamicPorts',
@value      = @portNo2 OUTPUT

select convert(int, ISNULL(@portno1, 0) ) + ISNULL(convert(int, @portno2 ), 0) as port
" |select-object port 


if ($var8.port -in '1433','1434','1435','1436')
{
$frag5 = $var8 |ConvertTo-Html -Property 'port' -Fragment -PreContent '<div class="bodyr"><h2>SQL Server port</h2><table class="table1">' -PostContent '</table></div>'|Out-String
}
else {
$frag5 = $var8 |ConvertTo-Html -Property 'port' -Fragment -PreContent '<div class="bodyg"><h2>SQL Server port</h2><table class="table1">' -PostContent '</table></div>'|Out-String
}

$forceencryption =  Invoke-Sqlcmd -ServerInstance $servername -Query "DECLARE @getValue INT

EXEC master..xp_instance_regread

      @rootkey = N'HKEY_LOCAL_MACHINE',

      @key=

N'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib',

      @value_name = N'ForceEncryption',

      @value = @getValue OUTPUT

SELECT @getValue as ForceEncryption" |select-object ForceEncryption
if ($forceencryption.ForceEncryption -eq '0'){
$frag6 = $forceencryption |ConvertTo-Html -Property 'ForceEncryption'  -Fragment -PreContent '<div class="bodyr"><h2>Force encryption </h2><table class="table1">' -PostContent '</table><h4>{0 for No, 1 for yes}<br>The value should be 1 for all production servers</h4></div>'|Out-String
}
else {
$frag6 = $forceencryption |ConvertTo-Html -Property 'ForceEncryption'  -Fragment -PreContent '<div class="bodyg"><h2>Force encryption </h2><table class="table1">' -PostContent '</table><h4>{0 for No, 1 for yes}<br>The value should be 1 for all production servers</h4></div>'|Out-String
}
$alldisk = Invoke-Command -ComputerName $hostname {Get-volume }| select-object driveletter,filesystemlabel, filesystem| Where-Object filesystem -ne 'NTFS'
$notntfscount = $alldisk.count
if ($notntfscount -eq '0'){
$ntfs_status = "no non-NTFS filesystem exists"|
    ForEach-Object {Add-Member -InputObject $_ -Type NoteProperty -Name Filesystem_Status -Value $_; $_}
    $frag7 = $ntfs_status |select-object Filesystem_status|ConvertTo-Html -Property Filesystem_status -Fragment -PreContent '<div class="bodyg"><h2>FileSystem Format</h2>' -PostContent '</div>'|Out-String 
}
else {$ntfs_status=$alldisk
$frag7 = $ntfs_status |select-object driveletter, filesystemlabel, filesystem|ConvertTo-Html  -Fragment -PreContent '<div class="bodyr"><h2>FileSystem Format</h2>' -PostContent '</div>'|Out-String}


$frag8 = invoke-sqlcmd -ServerInstance $servername -Query "DECLARE @AuthenticationMode INT  
EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', 
N'Software\Microsoft\MSSQLServer\MSSQLServer',   
N'LoginMode', @AuthenticationMode OUTPUT  
SELECT CASE @AuthenticationMode    
WHEN 1 THEN 'Windows Authentication'   
WHEN 2 THEN 'Windows and SQL Server Authentication'   
ELSE 'Unknown'  
END as [Authentication Mode] "|select-object "authentication mode"  |convertto-html -property 'Authentication Mode' -fragment -PreContent '<div class="body"><h2>SQL server authentication Mode</h2>' -PostContent '</div>'|out-string


$var9 = invoke-sqlcmd -ServerInstance $servername -Query "if ((select count(name) from sys.sql_logins where name ='sa')=1)
select 'rename sa account' as findings, name,is_disabled,is_policy_checked from sys.sql_logins where name ='sa'
else
select 'sa name doesnot exist' as findings,name,is_disabled,is_policy_checked from sys.sql_logins where name ='sa'" | select-object findings, name, is_disabled, is_policy_checked 

$var10 = $var9 |select-object findings
$var11 = $var9 |select-object name
$var12 = $var9 |select-object is_disabled  
$var13 = $var9 |select-object is_policy_checked

if ($var10.findings -eq 'rename sa account') {$var14=1}else {$var14=0}
if ($var11.name -eq 'sa') {$var15=1} else {$var15=0}
if (($var12.is_disabled) -eq $false) {$var16=1} else {$var16=0} 
if (($var13.is_policy_checked) -eq $false) {$var17=1} else {$var17=0}

$var18 = $var14 + $var15 + $var16 + $var17


if ($var18 -gt '0')
{$frag9 = $var9|ConvertTo-Html   -Fragment -PreContent '<div class="bodyr"><h2>sa logins</h2><table class="table1">' -PostContent '</table></div>'|Out-String }
else {$frag9 = $var9|ConvertTo-Html   -Fragment -PreContent '<div class="bodyg"><h2>sa logins</h2><table class="table1">' -PostContent '</table></div>'|Out-String }

 


ConvertTo-HTML -head $head -PostContent $frag0, $frag1,$frag2,$frag3, $frag4, $frag5, $frag6, $frag7,$frag8,$frag9 -PreContent "<div class=""body""><h1>SQL Server Hardening Report</h1> </div>"  |Set-Content "C:\temp\test\Combined.html"

C:\temp\test\Combined.html

#End of the code 
 



