$PBExportHeader$n_cst_tapi32.sru
forward
global type n_cst_tapi32 from nonvisualobject
end type
end forward

global type n_cst_tapi32 from nonvisualobject
end type
global n_cst_tapi32 n_cst_tapi32

type prototypes
function long tapiRequestMakeCall (ref string lpszDestAddress, ref string lpszAppName, ref string  lpszCalledParty, ref string  lpszComment) Library "tapi32.dll"  Alias for "tapiRequestMakeCallA;Ansi"
function long tapiGetLocationInfo (ref string  lpszCountryCode, ref string lpszCityCode) LIBRARY "tapi32.dll"  Alias for "tapiGetLocationInfoA;Ansi"
end prototypes

on n_cst_tapi32.create
TriggerEvent( this, "constructor" )
end on

on n_cst_tapi32.destroy
TriggerEvent( this, "destructor" )
end on

