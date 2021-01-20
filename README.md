# SQL_Compliance_checker
Use the PowerShell script to check compliance for specific SQL server instance.

New update contains
----------------------

1. server name
2. Logins that need to be removed/added
3. DB File locations - flags red if any files in C drive
4. Lists SQL Services if running as localsystem
5. Ensure that below service accounts dont have below access 

	1. Log on as a service 
	2. Log on as a batch job 
	3. Replace a process-level token 
	4. Bypass traverse checking 
	5. Adjust memory quotas for a process
6. Displays port number
7. Displays ForceEncryption (0/1)
8. Checks for Filesystem Format
9. Displays SQL SErver authentication mode
10. checks if default sa login exists

