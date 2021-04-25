$PBExportHeader$n_cst_advapi32.sru
forward
global type n_cst_advapi32 from nonvisualobject
end type
end forward

global type n_cst_advapi32 from nonvisualobject
end type
global n_cst_advapi32 n_cst_advapi32

type prototypes
Function boolean GetUserName (ref string  lpBuffer, ref ulong nSize) Library "ADVAPI32.DLL" Alias for "GetUserNameA;Ansi"
Function boolean LogonUser ( ref string lpszUsername, ref string lpszDomain, ref string lpszPassword, ulong dwLogonType,  ulong dwLogonProvider, ref ulong phToken) Library "ADVAPI32.DLL" Alias for "LogonUserA;Ansi"
Function long RegOpenKeyEx (ulong hKey, string lpSubKey, ulong ulOptions, ulong samDesired,  ref ulong phkResult) Library "ADVAPI32.DLL" Alias for "RegOpenKeyExA;Ansi"
Function long RegSetValueEx (ulong hKey, string lpValueName, ulong Reserved, ulong dwType, string  lpData, ulong cbData) Library "ADVAPI32.DLL" Alias for "RegSetValueExA;Ansi"
Function boolean QueryServiceStatusEx (ulong hService, ulong InfoLevel, ref SERVICE_STATUS_PROCESS lpBuffer, ulong cbBufSize, ref ulong pcbBytesNeeded) Library "ADVAPI32.DLL" alias for "QueryServiceStatusEx;Ansi"
Function boolean OpenProcessToken(ulong ProcessHandle, ulong DesiredAccess, ref ulong TokenHandle) Library "advapi32.dll"
Function boolean LookupPrivilegeValue (string lpSystemName,string lpName, ref luid lpLuid) Library "advapi32.dll" Alias For "LookupPrivilegeValueA;Ansi"
Function boolean AdjustTokenPrivileges (ulong TokenHandle, boolean DisableAllPrivileges, ref TOKEN_PRIVILEGES NewState, ulong BufferLength, ref TOKEN_PRIVILEGES PreviousState, ulong ReturnLength) Library "advapi32.dll" Alias For "AdjustTokenPrivileges;Ansi"
Function boolean InitiateSystemShutdown(ref string lpMachineName, ref string lpMessage,  ulong dwTimeout, boolean bForceAppsClosed,  boolean bRebootAfterShutdown) Library "ADVAPI32.DLL" Alias for "InitiateSystemShutdownA;Ansi"
end prototypes

type variables
public:
//
// Info levels for QueryServiceStatusEx
//

constant	int SC_STATUS_PROCESS_INFO      = 0

//
//  The following are masks for the predefined standard access types
//

constant ulong DELET                            = 65536 //(0x00010000L)
constant ulong READ_CONTROL                     = 131072 //(0x00020000L)
constant ulong WRITE_DAC                        = 262144 //(0x00040000L)
constant ulong WRITE_OWNER                      = 524288 //(0x00080000L)
constant ulong SYNCHRONIZE                      = 1048576 //(0x00100000L)

constant ulong STANDARD_RIGHTS_REQUIRED         = 983040 //(0x000F0000L)

constant ulong STANDARD_RIGHTS_READ             = READ_CONTROL
constant ulong STANDARD_RIGHTS_WRITE            = READ_CONTROL
constant ulong STANDARD_RIGHTS_EXECUTE          = READ_CONTROL

constant ulong STANDARD_RIGHTS_ALL              = 2031616 //(0x001F0000L)

constant ulong SPECIFIC_RIGHTS_ALL              = 65535 //(0x0000FFFFL)

//
// AccessSystemAcl access type
//

constant ulong ACCESS_SYSTEM_SECURITY           = 16777216 //(0x01000000L)

//
// MaximumAllowed access type
//

constant ulong MAXIMUM_ALLOWED                  = 33554432 //(0x02000000L)

//
//  These are the generic rights.
//

constant ulong GENERIC_READ                     = 2147483648	//(0x80000000L)
constant ulong GENERIC_WRITE                    = 1073741824	//(0x40000000L)
constant ulong GENERIC_EXECUTE                  = 536870912	 	//(0x20000000L)
constant ulong GENERIC_ALL                      = 268435456	 	//(0x10000000L)

//
// Token Specific Access Rights.
//

constant ulong TOKEN_ASSIGN_PRIMARY    = 1	//(0x0001)
constant ulong TOKEN_DUPLICATE         = 2	//(0x0002)
constant ulong TOKEN_IMPERSONATE       = 4	//(0x0004)
constant ulong TOKEN_QUERY             = 8	//(0x0008)
constant ulong TOKEN_QUERY_SOURCE      = 16	//(0x0010)
constant ulong TOKEN_ADJUST_PRIVILEGES = 32	//(0x0020)
constant ulong TOKEN_ADJUST_GROUPS     = 64	//(0x0040)
constant ulong TOKEN_ADJUST_DEFAULT    = 128	//(0x0080)
//
constant ulong TOKEN_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED 	+ & 
											  TOKEN_ASSIGN_PRIMARY 			+ & 
											  TOKEN_DUPLICATE					+ &	
			                          TOKEN_IMPERSONATE         	+ &
         			                 TOKEN_QUERY               	+ &
                  			        TOKEN_QUERY_SOURCE        	+ &
			                          TOKEN_ADJUST_PRIVILEGES   	+ &
         			                 TOKEN_ADJUST_GROUPS       	+ &
                  			        TOKEN_ADJUST_DEFAULT)


constant ulong TOKEN_READ = (STANDARD_RIGHTS_READ      		+ &
	     			              TOKEN_QUERY)
		

constant ulong TOKEN_WRITE = (STANDARD_RIGHTS_WRITE     		+ &
		                        TOKEN_ADJUST_PRIVILEGES   		+ &
     		                     TOKEN_ADJUST_GROUPS      		+ &
            		            TOKEN_ADJUST_DEFAULT)

constant ulong TOKEN_EXECUTE = (STANDARD_RIGHTS_EXECUTE)



// The attributes of a privilege 

constant ulong SE_PRIVILEGE_ENABLED_BY_DEFAULT = 1 			//&H1 - The privilege is enabled by default
constant ulong SE_PRIVILEGE_ENABLED = 2 							//&H2 - The privilege is enabled.
constant ulong SE_PRIVILEGE_USED_FOR_ACCESS = 2147483648		//&H80000000 - The privilege was used to gain access to an object or service. This flag is used to identify the relevant privileges in a set passed by a client application that may contain unnecessary privileges.

////////////////////////////////////////////////////////////////////////
//                                                                    //
//               NT Defined Privileges                                //
//                                                                    //
////////////////////////////////////////////////////////////////////////

constant string SE_CREATE_TOKEN_NAME              = ("SeCreateTokenPrivilege")
constant string SE_ASSIGNPRIMARYTOKEN_NAME        = ("SeAssignPrimaryTokenPrivilege")
constant string SE_LOCK_MEMORY_NAME               = ("SeLockMemoryPrivilege")
constant string SE_INCREASE_QUOTA_NAME            = ("SeIncreaseQuotaPrivilege")
constant string SE_UNSOLICITED_INPUT_NAME         = ("SeUnsolicitedInputPrivilege")
constant string SE_MACHINE_ACCOUNT_NAME           = ("SeMachineAccountPrivilege")
constant string SE_TCB_NAME                       = ("SeTcbPrivilege")
constant string SE_SECURITY_NAME                  = ("SeSecurityPrivilege")
constant string SE_TAKE_OWNERSHIP_NAME            = ("SeTakeOwnershipPrivilege")
constant string SE_LOAD_DRIVER_NAME               = ("SeLoadDriverPrivilege")
constant string SE_SYSTEM_PROFILE_NAME            = ("SeSystemProfilePrivilege")
constant string SE_SYSTEMTIME_NAME                = ("SeSystemtimePrivilege")
constant string SE_PROF_SINGLE_PROCESS_NAME       = ("SeProfileSingleProcessPrivilege")
constant string SE_INC_BASE_PRIORITY_NAME         = ("SeIncreaseBasePriorityPrivilege")
constant string SE_CREATE_PAGEFILE_NAME           = ("SeCreatePagefilePrivilege")
constant string SE_CREATE_PERMANENT_NAME          = ("SeCreatePermanentPrivilege")
constant string SE_BACKUP_NAME                    = ("SeBackupPrivilege")
constant string SE_RESTORE_NAME                   = ("SeRestorePrivilege")
constant string SE_SHUTDOWN_NAME                  = ("SeShutdownPrivilege")
constant string SE_DEBUG_NAME                     = ("SeDebugPrivilege")
constant string SE_AUDIT_NAME                     = ("SeAuditPrivilege")
constant string SE_SYSTEM_ENVIRONMENT_NAME        = ("SeSystemEnvironmentPrivilege")
constant string SE_CHANGE_NOTIFY_NAME             = ("SeChangeNotifyPrivilege")
constant string SE_REMOTE_SHUTDOWN_NAME           = ("SeRemoteShutdownPrivilege")
end variables

on n_cst_advapi32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_advapi32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

