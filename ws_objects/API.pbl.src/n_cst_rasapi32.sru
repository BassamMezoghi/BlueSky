$PBExportHeader$n_cst_rasapi32.sru
forward
global type n_cst_rasapi32 from nonvisualobject
end type
end forward

global type n_cst_rasapi32 from nonvisualobject
end type
global n_cst_rasapi32 n_cst_rasapi32

type prototypes
Function ulong RasDial (ref RASDIALEXTENSIONS lpRasDialExtensions, string lpszPhonebook, ref RASDIALPARAMS lpRasDialParams[], ulong dwNotifierType, ulong lpvNotifier, ref ulong lphRasconn) Library "rasapi32.dll" Alias for "RasDialA;Ansi"
Function ulong RasGetErrorString (uint uErrorValue, ref string lpszErrorString, ulong cBufSize) Library "rasapi32.dll" Alias for "RasGetErrorStringA;Ansi"
Function ulong RasGetConnectStatus (ulong hrasconn, ref RASCONNSTATUS lprasconnstatus[]) Library "rasapi32.dll" Alias For "RasGetConnectStatusA;Ansi"
end prototypes

type variables
constant int RAS_MaxDeviceType     = 16
constant int RAS_MaxPhoneNumber    = 128
constant int RAS_MaxIpAddress      = 15
constant int RAS_MaxIpxAddress     = 21
constant int RAS_MaxEntryName      = 256
constant int RAS_MaxDeviceName     = 128
constant int RAS_MaxCallbackNumber = RAS_MaxPhoneNumber
constant int RAS_MaxAreaCode       = 10
constant int RAS_MaxPadType        = 32
constant int RAS_MaxX25Address     = 200
constant int RAS_MaxFacilities     = 200
constant int RAS_MaxUserData       = 200
constant int RAS_MaxReplyMessage   = 1024

//
// User, Group and Password lengths
//
constant int UNLEN       = 256                 // Maximum user name length
constant int LM20_UNLEN  = 20                  // LM 2.0 Maximum user name length
constant int GNLEN       = UNLEN               // Group name
constant int LM20_GNLEN  = LM20_UNLEN          // LM 2.0 Group name
constant int PWLEN       = 256                 // Maximum password length
constant int LM20_PWLEN  = 14                  // LM 2.0 Maximum password length
constant int SHPWLEN     = 8                   // Share password length (bytes)

//
// String Lengths for various LanMan names
//
constant int CNLEN       = 15                  // Computer name length
constant int LM20_CNLEN  = 15                  // LM 2.0 Computer name length
constant int DNLEN       = CNLEN               // Maximum domain name length
constant int LM20_DNLEN  = LM20_CNLEN          // LM 2.0 Maximum domain name length

/* Enumerates intermediate states to a connection.  (See RasDial)
*/
constant int RASCS_PAUSED = 4096 //0x1000
constant int RASCS_DONE   = 8192 //0x2000
constant int RASCS_OpenPort = 0
constant int RASCS_PortOpened = 1
constant int RASCS_ConnectDevice = 2 
constant int RASCS_DeviceConnected = 3
constant int RASCS_AllDevicesConnected =4
constant int RASCS_Authenticate =5
constant int RASCS_AuthNotify =5
constant int RASCS_AuthRetry =6
constant int RASCS_AuthCallback =7
constant int RASCS_AuthChangePassword =8
constant int RASCS_AuthProject =9
constant int RASCS_AuthLinkSpeed =9
constant int RASCS_AuthAck =10
constant int RASCS_ReAuthenticate =11
constant int RASCS_Authenticated =12
constant int RASCS_PrepareForCallback =13
constant int RASCS_WaitForModemReset =14
constant int RASCS_WaitForCallback =15
constant int RASCS_Projected =15
constant int RASCS_StartAuthentication =16
constant int RASCS_CallbackComplete =17
constant int RASCS_LogonNetwork =18
constant int RASCS_SubEntryConnected =19
constant int RASCS_SubEntryDisconnected =20
constant int RASCS_Interactive = RASCS_PAUSED
constant int RASCS_RetryAuthentication =4097
constant int RASCS_CallbackSetByCaller =4098
constant int RASCS_PasswordExpired =21
constant int RASCS_Connected = RASCS_DONE
constant int RASCS_Disconnected = 22
end variables

on n_cst_rasapi32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_rasapi32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

