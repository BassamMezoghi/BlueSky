﻿$PBExportHeader$n_cst_shell32.sru
forward
global type n_cst_shell32 from nonvisualobject
end type
end forward

global type n_cst_shell32 from nonvisualobject
end type
global n_cst_shell32 n_cst_shell32

type prototypes
Subroutine SHAddToRecentDocs ( uint uFlags, ref string pV ) Library "SHELL32.DLL" alias for "SHAddToRecentDocs;Ansi" 
Function ulong SHBrowseForFolder (ref BrowseInfoA lpBi ) Library "SHELL32.DLL" Alias for "SHBrowseForFolderA;Ansi"
Function boolean SHGetPathFromIDList (ulong pIDL, ref string pszPath) Library "SHELL32.DLL" Alias For "SHGetPathFromIDListA;Ansi"
Function ulong ShellExecute (ulong hWnd, ref string lpOperation, ref string lpFile, ref string lpParameters, ref string lpDirectory, integer nShowCmd) Library "SHELL32.DLL" alias for "ShellExecute;Ansi"
Function long SHFileOperation( Ref SHFILEOPSTRUCT lpFileOp ) Library "SHELL32.DLL" Alias For "SHFileOperationA;Ansi"
Function long SHGetSpecialFolderLocation( long hwndOwner, long nFolder, Ref Long ppidl ) Library "SHELL32.DLL"
Function long SHFormatDrive( ulong hWnd, ulong iDrive, ulong iCapacity, ulong iType ) Library "SHELL32.DLL"
Function ulong FindExecutable (ref string lpFile, ref string lpDirectory, ref string lpResult) Library "SHELL32.DLL" Alias for "FindExecutableA;Ansi"
Function ulong ExtractAssociatedIcon (ulong hInst, ref string lpIconPath, ref uint lpiIcon) Library "SHELL32.DLL" Alias for "ExtractAssociatedIconA;Ansi"
subroutine DragAcceptFiles (ulong hWnd, boolean fAccept) Library "SHELL32.DLL"
subroutine DragFinish (ulong hDrop) Library "SHELL32.DLL"
Function uint DragQueryFile (ulong hDrop, uint iFile, ref string szFileName, uint cb) Library "SHELL32.DLL" alias for "DragQueryFile;Ansi"
Function boolean Shell_NotifyIcon (ulong dwMessage, ref NOTIFYICONDATAA lpData) Library "SHELL32.DLL" Alias for "Shell_NotifyIconA;Ansi"

end prototypes

type variables
// SHBrowseForFolder constants
Public:
constant ulong BIF_RETURNONLYFSDIRS	= 1	// Browse for directory
constant ulong BIF_DONTGOBELOWDOMAIN	= 2	// For starting the Find Computer
constant ulong BIF_STATUSTEXT		= 4
constant ulong BIF_RETURNFSANCESTORS	= 8
constant ulong BIF_EDITBOX			= 16
constant ulong BIF_BROWSEFORCOMPUTER	= 4096	// Browse for computer
constant ulong BIF_BROWSEFORPRINTER	= 8192	// Browse for printers
constant ulong BIF_BROWSEINCLUDEFILES	= 16384	// Browse for everything

//
// SHAddToRecentDocs
//
constant ulong SHARD_PIDL      = 1
constant ulong SHARD_PATHA     = 2
constant ulong SHARD_PATHW     = 3
constant ulong SHARD_PATH  = SHARD_PATHA

// File Operation constants
constant ulong FO_MOVE		= 1
constant ulong FO_COPY		= 2
constant ulong FO_DELETE		= 3
constant ulong FO_RENAME		= 4

// File Operation flags
constant ulong FOF_MULTIDESTFILES		= 1	// 0x0001
constant ulong FOF_CONFIRMMOUSE		= 2	// 0x0002
constant ulong FOF_SILENT			= 4	// 0x0004
constant ulong FOF_RENAMEONCOLLISION	= 8	// 0x0008
constant ulong FOF_NOCONFIRMATION	= 16	// 0x0010
constant ulong FOF_WANTMAPPINGHANDLE	= 32	// 0x0020
constant ulong FOF_ALLOWUNDO		= 64	// 0x0040
constant ulong FOF_FILESONLY		= 128	// 0x0080
constant ulong FOF_SIMPLEPROGRESS	= 256	// 0x0100
constant ulong FOF_NOCONFIRMMKDIR	= 512	// 0x0200
constant ulong FOF_NOERRORUI		= 1024	// 0x0400

// SHGetSpecialFolderLocation constants
constant ulong CSIDL_DESKTOP		= 0	// 0x0000
constant ulong CSIDL_PROGRAMS		= 2	// 0x0002
constant ulong CSIDL_CONTROLS		= 3	// 0x0003
constant ulong CSIDL_PRINTERS		= 4	// 0x0004
constant ulong CSIDL_PERSONAL		= 5	// 0x0005
constant ulong CSIDL_FAVORITES		= 6	// 0x0006
constant ulong CSIDL_STARTUP		= 7	// 0x0007
constant ulong CSIDL_RECENT		= 8	// 0x0008
constant ulong CSIDL_SENDTO		= 9	// 0x0009
constant ulong CSIDL_BITBUCKET		= 10	// 0x000a
constant ulong CSIDL_STARTMENU		= 11	// 0x000b
constant ulong CSIDL_DESKTOPDIRECTORY	= 16	// 0x0010
constant ulong CSIDL_DRIVES		= 17	// 0x0011
constant ulong CSIDL_NETWORK		= 18	// 0x0012
constant ulong CSIDL_NETHOOD		= 19	// 0x0013
constant ulong CSIDL_FONTS		= 20	// 0x0014
constant ulong CSIDL_TEMPLATES		= 21	// 0x0015
constant ulong CSIDL_COMMON_STARTMENU	= 22	// 0x0016
constant ulong CSIDL_COMMON_PROGRAMS	= 23	// 0X0017
constant ulong CSIDL_COMMON_STARTUP	= 24	// 0x0018
constant ulong CSIDL_COMMON_DESKTOPDIRECTORY = 25 // 0x0019
constant ulong CSIDL_APPDATA		= 26	// 0x001a
constant ulong CSIDL_PRINTHOOD		= 27	// 0x001b

/* ShellExecute() and ShellExecuteEx() error codes */

/* regular WinExec() codes */
constant int SE_ERR_FNF              = 2       // file not found
constant int SE_ERR_PNF              = 3       // path not found
constant int SE_ERR_ACCESSDENIED     = 5       // access denied
constant int SE_ERR_OOM              = 8       // out of memory
constant int SE_ERR_DLLNOTFOUND      = 32

/* error values for ShellExecute() beyond the regular WinExec() codes */
constant int SE_ERR_SHARE            = 26
constant int SE_ERR_ASSOCINCOMPLETE  = 27
constant int SE_ERR_DDETIMEOUT       = 28
constant int SE_ERR_DDEFAIL          = 29
constant int SE_ERR_DDEBUSY          = 30
constant int SE_ERR_NOASSOC          = 31

end variables

on n_cst_shell32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_shell32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

