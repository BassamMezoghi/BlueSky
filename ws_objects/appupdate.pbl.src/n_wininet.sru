$PBExportHeader$n_wininet.sru
$PBExportComments$Windows Internet Explorer Functions
forward
global type n_wininet from nonvisualobject
end type
type filetime from structure within n_wininet
end type
type win32_find_data from structure within n_wininet
end type
type systemtime from structure within n_wininet
end type
end forward

type filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

type win32_find_data from structure
	unsignedlong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
	character		cfilename[260]
	character		calternatefilename[14]
end type

type systemtime from structure
	unsignedinteger		wyear
	unsignedinteger		wmonth
	unsignedinteger		wdayofweek
	unsignedinteger		wday
	unsignedinteger		whour
	unsignedinteger		wminute
	unsignedinteger		wsecond
	unsignedinteger		wmilliseconds
end type

global type n_wininet from nonvisualobject autoinstantiate
event ue_internetopen ( )
end type

type prototypes
// Windows Functions

Function ulong GetLastError ( &
	) Library "kernel32.dll"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"

Function boolean FileTimeToLocalFileTime ( &
	Ref filetime lpFileTime, &
	Ref filetime lpLocalFileTime &
	) Library "kernel32.dll" Alias For "FileTimeToLocalFileTime"

Function boolean FileTimeToSystemTime ( &
	Ref filetime lpFileTime, &
	Ref systemtime lpSystemTime &
	) Library "kernel32.dll" Alias For "FileTimeToSystemTime"

Function ulong CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileW"

Function boolean ReadFile ( &
	ulong hFile, &
	Ref blob lpBuffer, &
	ulong nNumberOfBytesToRead, &
	Ref ulong lpNumberOfBytesRead, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function boolean CloseHandle ( &
	ulong hObject &
	) Library "kernel32.dll"

// WinINet Common Functions

Function ulong InternetOpen ( &
	string lpszAgent, &
	ulong dwAccessType, &
	string lpszProxy, &
	string lpszProxyBypass, &
	ulong dwFlags &
	) Library "wininet.dll" Alias For "InternetOpenW"

Function boolean InternetCloseHandle ( &
	ulong hInternet &
	) Library "wininet.dll"

Function ulong InternetConnect ( &
	ulong hInternet, &
	string lpszServerName, &
	uint nServerPort, &
	string lpszUserName, &
	string lpszPassword, &
	ulong dwService, &
	ulong dwFlags, &
	ulong dwContext &
	) Library "wininet.dll" Alias For "InternetConnectW"

Function boolean InternetFindNextFile ( &
	ulong hFind, &
	Ref WIN32_FIND_DATA lpvFindData &
	) Library "wininet.dll" Alias For "InternetFindNextFileW"

Function boolean InternetGetLastResponseInfo ( &
	Ref ulong lpdwError, &
	Ref string lpszBuffer, &
	Ref ulong lpdwBufferLength &
	) Library "wininet.dll" Alias For "InternetGetLastResponseInfoW"

Function boolean InternetReadFile ( &
	ulong hFile, &
	Ref blob lpBuffer, &
	ulong dwNumberOfBytesToRead, &
	Ref ulong lpdwNumberOfBytesRead &
	) Library "wininet.dll" Alias For "InternetReadFile"

Function boolean InternetSetOption ( &
	ulong hInternet, &
	ulong dwOption, &
	string lpBuffer, &
	ulong dwBufferLength &
	) Library "wininet.dll" Alias For "InternetSetOptionW"

Function boolean InternetWriteFile ( &
	ulong hFile, &
	blob lpBuffer, &
	ulong dwNumberOfBytesToWrite, &
	Ref ulong lpdwNumberOfBytesWritten &
	) Library "wininet.dll" Alias For "InternetWriteFile"

// WinINet FTP Functions

Function boolean FtpCommand ( &
	ulong hConnect, &
	boolean fExpectResponse, &
	ulong dwFlags, &
	string lpszCommand, &
	ulong dwContext, &
	ref ulong phFtpCommand &
	) Library "wininet.dll" Alias For "FtpCommandW"

Function boolean FtpCreateDirectory ( &
	ulong hConnect, &
	string lpszDirectory &
	) Library "wininet.dll" Alias For "FtpCreateDirectoryW"

Function boolean FtpDeleteFile ( &
	ulong hConnect, &
	string lpszFileName &
	) Library "wininet.dll" Alias For "FtpDeleteFileW"

Function ulong FtpFindFirstFile ( &
	ulong hConnect, &
	string lpszSearchFile, &
	Ref WIN32_FIND_DATA lpFindFileData, &
	ulong dwFlags, &
	ulong dwContext &
	) Library "wininet.dll" Alias For "FtpFindFirstFileW"

Function boolean FtpGetCurrentDirectory ( &
	ulong hConnect, &
	Ref string lpszCurrentDirectory, &
	Ref ulong lpdwCurrentDirectory &
	) Library "wininet.dll" Alias For "FtpGetCurrentDirectoryW"

Function boolean FtpGetFile ( &
	ulong hConnect, &
	string lpszRemoteFile, &
	string lpszNewFile, &
	boolean fFailIfExists, &
	ulong dwFlagsAndAttributes, &
	ulong dwFlags, &
	ulong dwContext &
	) Library "wininet.dll" Alias For "FtpGetFileW"

Function ulong FtpGetFileSize ( &
	ulong hFile, &
	Ref ulong lpdwFileSizeHigh &
	) Library "wininet.dll" Alias For "FtpGetFileSize"

Function ulong FtpOpenFile ( &
	ulong hConnect, &
	string lpszFileName, &
	ulong dwAccess, &
	ulong dwFlags, &
	ulong dwContext &
	) Library "wininet.dll" Alias For "FtpOpenFileW"

Function boolean FtpPutFile ( &
	ulong hConnect, &
	string lpszLocalFile, &
	string lpszNewRemoteFile, &
	ulong dwFlags, &
	ulong dwContext &
	) Library "wininet.dll" Alias For "FtpPutFileW"

Function boolean FtpRemoveDirectory ( &
	ulong hConnect, &
	string lpszDirectory &
	) Library "wininet.dll" Alias For "FtpRemoveDirectoryW"

Function boolean FtpRenameFile ( &
	ulong hConnect, &
	string lpszExisting, &
	string lpszNew &
	) Library "wininet.dll" Alias For "FtpRenameFileW"

Function boolean FtpSetCurrentDirectory ( &
	ulong hConnect, &
	string lpszDirectory &
	) Library "wininet.dll" Alias For "FtpSetCurrentDirectoryW"

end prototypes

type variables
// Internet handles
ulong iul_internet
ulong iul_session

// Internet open types
CONSTANT uint INTERNET_OPEN_TYPE_PRECONFIG							= 0
CONSTANT uint INTERNET_OPEN_TYPE_DIRECT								= 1
CONSTANT uint INTERNET_OPEN_TYPE_PROXY									= 3
CONSTANT uint INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY	= 4

// Internet service types
CONSTANT uint INTERNET_SERVICE_URL		= 0
CONSTANT uint INTERNET_SERVICE_FTP		= 1
CONSTANT uint INTERNET_SERVICE_GOPHER	= 2
CONSTANT uint INTERNET_SERVICE_HTTP		= 3

// Port numbers
CONSTANT uint INTERNET_INVALID_PORT_NUMBER	= 0
CONSTANT uint INTERNET_DEFAULT_FTP_PORT		= 21
CONSTANT uint INTERNET_DEFAULT_GOPHER_PORT	= 70
CONSTANT uint INTERNET_DEFAULT_HTTP_PORT		= 80
CONSTANT uint INTERNET_DEFAULT_HTTPS_PORT		= 443
CONSTANT uint INTERNET_DEFAULT_SOCKS_PORT		= 1080

// FTP transfer flags
CONSTANT uint FTP_TRANSFER_TYPE_ASCII	= 1
CONSTANT uint FTP_TRANSFER_TYPE_BINARY	= 2

// Internet flags
CONSTANT ulong INTERNET_FLAG_RELOAD				= 2147483648
CONSTANT ulong INTERNET_FLAG_NO_CACHE_WRITE	= 67108864
CONSTANT ulong INTERNET_FLAG_RAW_DATA			= 1073741824
CONSTANT ulong INTERNET_FLAG_PASSIVE			= 134217728

// Internet API error returns
CONSTANT uint INTERNET_ERROR_BASE				= 12000
CONSTANT uint ERROR_INTERNET_EXTENDED_ERROR	= (INTERNET_ERROR_BASE + 3)

// Options used by InternetSetOption
CONSTANT ulong INTERNET_OPTION_PROXY_USERNAME = 43
CONSTANT ulong INTERNET_OPTION_PROXY_PASSWORD = 44

end variables

forward prototypes
public function string of_ftp_deletefile (string as_filename)
public function string of_disconnect_session ()
public function datetime of_filedatetimetopb (filetime astr_filetime)
public function string of_ftp_createdirectory (string as_directory)
public function integer of_ftp_directory (ref s_ftpdirlist astr_dirlist[])
public function string of_ftp_internetconnect (string as_servername)
public function string of_ftp_internetconnect (string as_servername, string as_userid, string as_password)
public function string of_ftp_putfile (string as_source, string as_target, boolean ab_ascii)
public function string of_ftp_removedirectory (string as_directory)
public function string of_ftp_renamefile (string as_filename, string as_newname)
public function unsignedlong of_getsession ()
public function string of_internetclosehandle (ref unsignedlong aul_handle)
public function string of_internetopen ()
public function string of_ftp_command (string as_command, ref string as_response)
public function string of_ftp_setcurrentdirectory (string as_directory)
public function string of_ftp_getcurrentdirectory (ref string as_directory)
public function string of_ftp_getfile (string as_source, string as_target, boolean ab_ascii)
public function string of_ftp_readfile (string as_source, string as_target, long al_window, long al_event)
public function string of_ftp_readfile (string as_source, string as_target)
public function string of_ftp_writefile (string as_source, string as_target)
public function string of_ftp_writefile (string as_source, string as_target, long al_window, long al_event)
public function boolean of_ftp_fileexists (string as_filename)
public function boolean of_ftp_directoryexists (string as_dirname)
public function string of_ftp_readstring (string as_filename, ref string as_content)
public function string of_ftp_writestring (string as_filename, string as_content)
public function string of_getlasterror ()
public function string of_ftp_internetconnect (string as_servername, string as_userid, string as_password, unsignedinteger aui_port, boolean ab_passive)
public function string of_internetsetoption (unsignedlong aul_option, string as_value)
end prototypes

event ue_internetopen();// initialize the internet dll

String ls_result

ls_result = this.of_InternetOpen()
If Len(ls_result) > 0 Then
	MessageBox(this.ClassName(), ls_result, StopSign!)
End If

end event

public function string of_ftp_deletefile (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_DeleteFile
//
// PURPOSE:    This function deletes a file on the FTP server.
//
// ARGUMENTS:  as_directory	- The directory to create
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result

If FtpDeleteFile(iul_session, as_filename) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_disconnect_session ();// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Disconnect_Session
//
// PURPOSE:    This function disconnects the current session.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_result

If iul_session > 0 Then
	ls_result = this.of_InternetCloseHandle(iul_session)
End If

Return ls_result

end function

public function datetime of_filedatetimetopb (filetime astr_filetime);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_FileDateTimeToPB
//
// PURPOSE:    This function converts a file datetime to a PB datetime.
//
// ARGUMENTS:  astr_filetime	- filetime structure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// 05/13/2009	RolandS		Added FileTimeToSystemTime
// -----------------------------------------------------------------------------

DateTime ldt_filedate
FILETIME	lstr_localtime
SYSTEMTIME lstr_systime
String ls_time
Date ld_fdate
Time lt_ftime

SetNull(ldt_filedate)

If Not FileTimeToLocalFileTime(astr_FileTime, &
			lstr_localtime) Then Return ldt_filedate

If Not FileTimeToSystemTime(lstr_localtime, &
			lstr_systime) Then Return ldt_filedate

ld_fdate = Date(lstr_systime.wYear, &
					lstr_systime.wMonth, lstr_systime.wDay)

ls_time = String(lstr_systime.wHour) + ":" + &
			 String(lstr_systime.wMinute) + ":" + &
			 String(lstr_systime.wSecond) + ":" + &
			 String(lstr_systime.wMilliseconds)

lt_ftime = Time(ls_Time)

ldt_filedate = DateTime(ld_fdate, lt_ftime)

Return ldt_filedate

end function

public function string of_ftp_createdirectory (string as_directory);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_CreateDirectory
//
// PURPOSE:    This function creates a directory on the FTP server.
//
// ARGUMENTS:  as_directory	- The directory to create
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result

If FtpCreateDirectory(iul_session, as_directory) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function integer of_ftp_directory (ref s_ftpdirlist astr_dirlist[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_Directory
//
// PURPOSE:    This function returns a structure containing a list of files
//					and subdirectories on the FTP server.
//
// ARGUMENTS:  astr_dirlist	- By ref structure of files/dirs
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

WIN32_FIND_DATA lstr_FindData
ulong		lul_hFind
String	ls_null, ls_retval
Integer	li_file
Boolean	lb_morefiles = True

SetNull(ls_null)

lul_hFind = FtpFindFirstFile(iul_session, ls_null, lstr_FindData, &
					INTERNET_FLAG_RAW_DATA + &
					INTERNET_FLAG_NO_CACHE_WRITE + &
					INTERNET_FLAG_RELOAD, 0)

If lul_hFind = 0 Then Return 0

DO WHILE lb_morefiles
	li_file = li_file + 1
	// get file name
	astr_dirlist[li_file].s_FileName = String(lstr_FindData.cfilename)
	astr_dirlist[li_file].s_AltFileName = String(lstr_FindData.calternatefilename)
	If Trim(astr_dirlist[li_file].s_AltFileName) = "" Then
		astr_dirlist[li_file].s_AltFileName = astr_dirlist[li_file].s_FileName
	End If
	// get file date/time
	astr_dirlist[li_file].dt_CreationTime = &
		this.of_FileDateTimeToPB(lstr_FindData.ftCreationTime)
	astr_dirlist[li_file].dt_LastAccessTime = &
		this.of_FileDateTimeToPB(lstr_FindData.ftLastAccessTime)
	astr_dirlist[li_file].dt_LastWriteTime = &
		this.of_FileDateTimeToPB(lstr_FindData.ftLastWriteTime)
	// get file size
	astr_dirlist[li_file].db_FileSize = (lstr_FindData.nFileSizeHigh * (2.0 ^ 32)) + &
		lstr_FindData.nFileSizeLow
	// get file attributes
	astr_dirlist[li_file].ul_Attributes = lstr_FindData.dwFileAttributes
	// find next file
	lb_morefiles = InternetFindNextFile(lul_hFind, lstr_FindData)
LOOP

// close out directory handle
InternetCloseHandle(lul_hFind)

Return UpperBound(astr_dirlist[])

end function

public function string of_ftp_internetconnect (string as_servername);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_InternetConnect
//
// PURPOSE:    This function opens a FTP session.
//
// ARGUMENTS:  as_servername	- The name of the remote server
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/11/2009	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_null

SetNull(ls_null)

Return of_ftp_InternetConnect(as_servername, ls_null, ls_null, &
						INTERNET_DEFAULT_FTP_PORT, False)

end function

public function string of_ftp_internetconnect (string as_servername, string as_userid, string as_password);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_InternetConnect
//
// PURPOSE:    This function opens a FTP session.
//
// ARGUMENTS:  as_servername	- The name of the remote server
//					as_userid		- The userid to login with
//					as_password		- The password to login with
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/11/2009	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Return of_ftp_InternetConnect(as_servername, as_userid, as_password, &
						INTERNET_DEFAULT_FTP_PORT, False)

end function

public function string of_ftp_putfile (string as_source, string as_target, boolean ab_ascii);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_PutFile
//
// PURPOSE:    This function uploads a local file to the remote server.
//
// ARGUMENTS:  as_source	- The local filename
//					as_target	- The filename on the server
//					ab_ascii		- Use ASCII or Binary transfer
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result
Ulong		lul_mode

If ab_ascii Then
	lul_mode = FTP_TRANSFER_TYPE_ASCII
Else
	lul_mode = FTP_TRANSFER_TYPE_BINARY
End If

If FtpPutFile(iul_session, as_source, as_target, lul_mode, 0) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_removedirectory (string as_directory);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_RemoveDirectory
//
// PURPOSE:    This function removes a directory from the FTP server.
//
// ARGUMENTS:  as_directory	- The directory to delete
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result

If FtpRemoveDirectory(iul_session, as_directory) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_renamefile (string as_filename, string as_newname);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_RenameFile
//
// PURPOSE:    This function renames a file on the FTP server.
//
// ARGUMENTS:  as_filename	- The file being renamed
//					as_newname	- The new name for the file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result

If FtpRenameFile(iul_session, as_filename, as_newname) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function unsignedlong of_getsession ();// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_GetSession
//
// PURPOSE:    This function returns the session handle.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Return iul_session

end function

public function string of_internetclosehandle (ref unsignedlong aul_handle);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_InternetCloseHandle
//
// PURPOSE:    This function closes a handle.
//
// ARGUMENTS:  aul_handle	- The handle being closed
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_result

If InternetCloseHandle(aul_handle) Then
	aul_handle = 0
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_internetopen ();// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_InternetOpen
//
// PURPOSE:    This function initializes the internet dll.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Application la_app
String ls_null, ls_result

SetNull(ls_null)

la_app = GetApplication()

iul_internet = InternetOpen(la_app.AppName, INTERNET_OPEN_TYPE_PRECONFIG, &
						ls_null, ls_null, 0)

If IsNull(iul_internet) Or iul_internet = 0 Then
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_command (string as_command, ref string as_response);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_Command
//
// PURPOSE:    This function executes a command on the FTP server.
//
// ARGUMENTS:  as_command	- The command to execute
//					as_response	- Server response string ( by ref )
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
ULong lul_ftphandle
String ls_result
ULong lul_errorcode, lul_bufSize

If FtpCommand(iul_session, False, FTP_TRANSFER_TYPE_ASCII, &
			as_command, 0, lul_ftphandle) Then
	// get response buffer size
	InternetGetLastResponseInfo(lul_errorcode, as_response, lul_bufSize)
	If lul_bufSize > 0 Then
		// get response
		as_response = Space(lul_bufSize + 1)
		InternetGetLastResponseInfo(lul_errorcode, &
						as_response, lul_bufSize)
	End If
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_setcurrentdirectory (string as_directory);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.Ftp_SetCurrentDirectory
//
// PURPOSE:    This function changes the current directory on the FTP server.
//
// ARGUMENTS:  as_directory	- the directory to change to
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result

If FtpSetCurrentDirectory(iul_session, as_directory) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_getcurrentdirectory (ref string as_directory);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_GetCurrentDirectory
//
// PURPOSE:    This function returns the current directory on the FTP server.
//
// ARGUMENTS:  as_directory	- The directory ( by ref )
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result
ULong lul_rc, lul_buflen

lul_buflen = 256

as_directory = Space(lul_buflen)

If FtpGetCurrentDirectory(iul_session, as_directory, lul_buflen) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_getfile (string as_source, string as_target, boolean ab_ascii);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_GetFile
//
// PURPOSE:    This function retrieves a file from an FTP server and
//					saves it to local filename.
//
// ARGUMENTS:  as_source	- The filename on the server
//					as_target	- The local filename
//					ab_ascii		- Use ASCII or Binary transfer
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_result
Ulong		lul_mode

// delete local file if it exists
If FileExists(as_target) Then
	FileDelete(as_target)
End If

// set transfer mode
If ab_ascii Then
	lul_mode = FTP_TRANSFER_TYPE_ASCII
Else
	lul_mode = FTP_TRANSFER_TYPE_BINARY
End If

If FtpGetFile(iul_session, as_source, as_target, FALSE, 0, lul_mode, 0) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_readfile (string as_source, string as_target, long al_window, long al_event);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_ReadFile
//
// PURPOSE:    This function reads a remote file and writes it locally. If a
//					window handle is passed, a percent done string is sent.
//					The al_event arg is 1023 + the pbm_custom## number.
//
// ARGUMENTS:  as_source	- The local filename
//					as_target	- The filename on the server
//					al_window	- Handle of the window
//					al_event		- Event number
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong GENERIC_READ = 2147483648
Integer li_fnum
Boolean lb_rtn, lb_loop
ULong lul_hFile, lul_bytesread, lul_bufsize
ULong lul_sizelow, lul_sizehigh, lul_totalread
String ls_result, ls_response, ls_buffer
Blob lblob_buffer

lul_bufsize = 2048
lb_loop = True

// open the remote file
lul_hFile = FtpOpenFile(iul_session, as_source, &
					GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)
If lul_hFile > 0 Then
	// get the file size
	lul_SizeLow = FtpGetFileSize(lul_hFile, lul_SizeHigh)
	// open the local file
	li_fnum = FileOpen(as_target, StreamMode!, &
						Write!, LockReadWrite!, Replace!)
	do while lb_loop
		lblob_buffer = Blob(Space(lul_bufsize))
		lb_loop = InternetReadFile(lul_hFile, lblob_buffer, &
							lul_bufsize, lul_bytesread)
		If lul_bytesread = 0 Then
			lb_loop = False
		Else
			If al_window > 0 Then
				lul_totalread += lul_bytesread
				Send(al_window, al_event, lul_totalread, lul_SizeLow)
			End If
			FileWrite(li_fnum, BlobMid(lblob_buffer, 1, lul_bytesread))
		End If
	loop
	InternetCloseHandle(lul_hFile)
	FileClose(li_fnum)
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_readfile (string as_source, string as_target);// override of of_ftp_ReadFile defaulting window/event
Return of_ftp_ReadFile(as_source, as_target, 0, 0)

end function

public function string of_ftp_writefile (string as_source, string as_target);// override of of_ftp_WriteFile defaulting window/event
Return of_ftp_WriteFile(as_source, as_target, 0, 0)

end function

public function string of_ftp_writefile (string as_source, string as_target, long al_window, long al_event);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_WriteFile
//
// PURPOSE:    This function reads a local file and writes it remotely. If a
//					window handle is passed, a percent done string is sent.
//					The al_event arg is 1023 + the pbm_custom## number.
//
// ARGUMENTS:  as_source	- The local filename
//					as_target	- The filename on the server
//					al_window	- Handle of the window
//					al_event		- Event number
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ     = 2147483648
Constant ULong GENERIC_WRITE    = 1073741824
Constant ULong FILE_SHARE_READ  = 1
Constant ULong FILE_SHARE_WRITE = 2
Constant ULong OPEN_EXISTING    = 3
ULong lul_file, lul_bufsize, lul_hFile
ULong lul_totalread, lul_bytesread, lul_byteswritten
Long ll_filesize
Blob lblob_buffer
Boolean lb_loop
String ls_result

lul_bufsize = 2048
lb_loop = True

// open the local file
lul_file = CreateFile(as_source, GENERIC_READ, &
					FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
If lul_file > 0 Then
	// get the file size
	ll_filesize = FileLength(as_source)
	// open the remote file
	lul_hFile = FtpOpenFile(iul_session, as_target, &
						GENERIC_WRITE, FTP_TRANSFER_TYPE_BINARY, 0)
	do while lb_loop
		lblob_buffer = Blob(Space(lul_bufsize))
		lb_loop = ReadFile(lul_file, lblob_buffer, &
							lul_bufsize, lul_bytesread, 0)
		If lul_bytesread = 0 Then
			lb_loop = False
		Else
			If al_window > 0 Then
				lul_totalread += lul_bytesread
				Send(al_window, al_event, lul_totalread, ll_filesize)
			End If
			lb_loop = InternetWriteFile(lul_hFile, lblob_buffer, &
								lul_bytesread, lul_byteswritten)
		End If
	loop
	CloseHandle(lul_file)
	InternetCloseHandle(lul_hFile)
Else
	ls_result = "Could not open '" + as_source + "' for read!"
End If

Return ls_result

end function

public function boolean of_ftp_fileexists (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_FileExists
//
// PURPOSE:    This function searches for a file in the working directory
//					on the FTP server to see if it exists.
//
// ARGUMENTS:  as_filename	- The name of the file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

WIN32_FIND_DATA lstr_FindData
ulong		lul_hFind
String	ls_result
Boolean	lb_rtn

lul_hFind = FtpFindFirstFile(iul_session, as_filename, lstr_FindData, &
					INTERNET_FLAG_RAW_DATA + &
					INTERNET_FLAG_NO_CACHE_WRITE + &
					INTERNET_FLAG_RELOAD, 0)

If IsNull(lul_hFind) Or lul_hFind = 0 Then
	ls_result = this.of_GetLastError()
	lb_rtn = False
Else
	// If the requested file is the first one - we're done
	If lstr_FindData.cfilename = as_filename Then
		lb_rtn = True
	Else
		lb_rtn =  False
	End If
End If

// close out directory handle
InternetCloseHandle(lul_hFind)

Return lb_rtn

end function

public function boolean of_ftp_directoryexists (string as_dirname);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_DirectoryExists
//
// PURPOSE:    This function searches for a directory in the working directory
//					on the FTP server to see if it exists.
//
// ARGUMENTS:  as_filename	- The name of the file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

WIN32_FIND_DATA lstr_FindData
Constant ulong FILE_ATTRIBUTE_DIRECTORY = 16
ulong		lul_hFind
String	ls_result
Boolean	lb_rtn

lul_hFind = FtpFindFirstFile(iul_session, as_dirname, lstr_FindData, &
					INTERNET_FLAG_RAW_DATA + &
					INTERNET_FLAG_NO_CACHE_WRITE + &
					INTERNET_FLAG_RELOAD, 0)

If IsNull(lul_hFind) Or lul_hFind = 0 Then
	ls_result = this.of_GetLastError()
	lb_rtn = False
Else
	// If the requested directory is the first one - we're done
	If lstr_FindData.dwFileAttributes = FILE_ATTRIBUTE_DIRECTORY Then
		lb_rtn = True
	Else
		lb_rtn =  False
	End If
End If

// close out directory handle
InternetCloseHandle(lul_hFind)

Return lb_rtn

end function

public function string of_ftp_readstring (string as_filename, ref string as_content);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_ReadString
//
// PURPOSE:    This function reads a remote file and returns it to
//					a string variable.
//
// ARGUMENTS:  as_filename	- The remote filename
//					as_content	- File contents ( by ref )
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong GENERIC_READ = 2147483648
ULong lul_hFile, lul_bufsize, lul_bytesread
Blob lblob_buffer
String ls_result, ls_content
Boolean lb_loop

as_content = ""
lul_bufsize = 2048
lb_loop = True
// open the remote file
lul_hFile = FtpOpenFile(iul_session, as_filename, &
					GENERIC_READ, FTP_TRANSFER_TYPE_ASCII, 0)
If lul_hFile > 0 Then
	do while lb_loop
		lblob_buffer = Blob(Space(lul_bufsize))
		lb_loop = InternetReadFile(lul_hFile, lblob_buffer, &
							lul_bufsize, lul_bytesread)
		If lul_bytesread = 0 Then
			lb_loop = False
		Else
			ls_content += String(BlobMid(lblob_buffer, 1, lul_bytesread), EncodingAnsi!)
		End If
	loop
	InternetCloseHandle(lul_hFile)
	as_content = ls_content
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_ftp_writestring (string as_filename, string as_content);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_WriteString
//
// PURPOSE:    This function writes a string to a file on the remote server.
//
// ARGUMENTS:  as_filename - The filename on the server
//					as_content	- The content of the file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 10/13/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong GENERIC_WRITE = 1073741824
String ls_result, ls_buffer
ULong lul_bufsize, lul_hFile, lul_byteswritten
Long ll_pos, ll_max
Blob lblob_buffer
Boolean lb_rtn

lul_bufsize = 2048

// open the remote file
lul_hFile = FtpOpenFile(iul_session, as_filename, &
					GENERIC_WRITE, FTP_TRANSFER_TYPE_ASCII, 0)
If lul_hFile > 0 Then
	ll_max = Len(as_content)
	For ll_pos = 1 To ll_max Step 2048
		ls_buffer = Mid(as_content, ll_pos, lul_bufsize)
		lblob_buffer = Blob(ls_buffer, EncodingAnsi!)
		lb_rtn = InternetWriteFile(lul_hFile, lblob_buffer, &
								Len(lblob_buffer), lul_byteswritten)
		If lb_rtn = False Then Exit
	Next
	InternetCloseHandle(lul_hFile)
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_getlasterror ();// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_GetSession
//
// PURPOSE:    This function gets the last error number and
//					returns descriptive error text.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/11/2009	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
ULong lul_error, lul_exterror, lul_buffSize
String ls_buffer
Boolean lb_rc

ls_buffer = Space(250)
		
lul_error = GetLastError()

If lul_error = ERROR_INTERNET_EXTENDED_ERROR Then
	// get extended error information
	InternetGetLastResponseInfo(lul_exterror, ls_buffer, lul_buffSize)
	If lul_buffSize > 0 Then
		ls_buffer = Space(lul_buffSize + 2)
		lb_rc = InternetGetLastResponseInfo(lul_exterror, ls_buffer, lul_buffSize)
		If lb_rc = False Then
			ls_buffer = "An extended error was returned from the server. The call " + &
				"to InternetGetLastResponseInfo to retrieve the error text failed."
		End If
	Else
		ls_buffer = "An extended error was returned from the server. The call " + &
			"to InternetGetLastResponseInfo to retrieve the error text failed."
	End If
Else
	FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
			lul_error, LANG_NEUTRAL, ls_buffer, Len(ls_buffer), 0)
End If

Return Trim(ls_buffer)

end function

public function string of_ftp_internetconnect (string as_servername, string as_userid, string as_password, unsignedinteger aui_port, boolean ab_passive);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_InternetConnect
//
// PURPOSE:    This function opens a FTP session.
//
// ARGUMENTS:  as_servername	- The name of the remote server
//					as_userid		- The userid to login with
//					as_password		- The password to login with
//					aui_port			- The port to connect to
//					ab_passive		- Whether passivce semantics should be used
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/11/2009	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_result
ULong lul_flags
UInt lui_port

lui_port = aui_port
If lui_port = 0 Then
	lui_port = INTERNET_DEFAULT_FTP_PORT
End If

If ab_passive Then
	lul_flags = INTERNET_FLAG_PASSIVE
End If

iul_session = InternetConnect(iul_internet, as_servername, lui_port, as_userid, as_password, INTERNET_SERVICE_FTP, lul_flags, 0)

If IsNull(iul_session) Or iul_session = 0 Then
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

public function string of_internetsetoption (unsignedlong aul_option, string as_value);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_InternetSetOption
//
// PURPOSE:    This function sets string based options.
//
// ARGUMENTS:  aul_option	- The option to set
//					as_value		- The value to use
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/12/2009	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_result

If InternetSetOption(iul_session, aul_option, as_value, Len(as_value)) Then
	ls_result = ""
Else
	ls_result = this.of_GetLastError()
End If

Return ls_result

end function

on n_wininet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_wininet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// initialize the internet dll
this.Post Event ue_internetopen()

end event

event destructor;// close out the internet dll

String ls_result

If iul_session > 0 Then
	ls_result = this.of_InternetCloseHandle(iul_session)
	If Len(ls_result) > 0 Then
		MessageBox(this.ClassName(), ls_result, StopSign!)
	End If
End If

If iul_internet > 0 Then
	ls_result = this.of_InternetCloseHandle(iul_internet)
	If Len(ls_result) > 0 Then
		MessageBox(this.ClassName(), ls_result, StopSign!)
	End If
End If

end event

