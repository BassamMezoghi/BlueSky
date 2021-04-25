$PBExportHeader$n_cst_mpr.sru
forward
global type n_cst_mpr from nonvisualobject
end type
end forward

global type n_cst_mpr from nonvisualobject
end type
global n_cst_mpr n_cst_mpr

type prototypes
Function ulong WNetGetUniversalName (string lpLocalPath, ulong dwInfoLevel, ref UNIVERSAL_NAME_INFOA lpBuffer, ref ulong lpBufferSize) Library "MPR.DLL" Alias for "WNetGetUniversalNameA;Ansi"
Function ulong WNetGetConnection (string lpLocalName,  ref string lpRemoteName,  ref ulong lpnLength) Library "MPR.DLL"  Alias for "WNetGetConnectionA;Ansi"
Function long WNetGetUser (string lpName, ref string lpUserName, ref long lpnLength) Library "MPR.DLL" Alias for "WNetGetUserA;Ansi"

end prototypes

on n_cst_mpr.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_mpr.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

