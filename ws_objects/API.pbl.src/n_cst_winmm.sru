$PBExportHeader$n_cst_winmm.sru
forward
global type n_cst_winmm from nonvisualobject
end type
end forward

global type n_cst_winmm from nonvisualobject
end type
global n_cst_winmm n_cst_winmm

type prototypes
Function ulong mciSendString (string lpstrCommand, ref string lpstrReturnString, uint uReturnLength, ulong hwndCallback) Library "WINMM.DLL" Alias for "mciSendStringA;Ansi"
end prototypes

on n_cst_winmm.create
TriggerEvent( this, "constructor" )
end on

on n_cst_winmm.destroy
TriggerEvent( this, "destructor" )
end on

