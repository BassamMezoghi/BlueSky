$PBExportHeader$n_cst_winspool.sru
forward
global type n_cst_winspool from nonvisualobject
end type
end forward

global type n_cst_winspool from nonvisualobject
end type
global n_cst_winspool n_cst_winspool

type prototypes
Function ulong ConnectToPrinterDlg (ulong hWnd, ulong Flags) Library "WINSPOOL.DRV" 
end prototypes

on n_cst_winspool.create
TriggerEvent( this, "constructor" )
end on

on n_cst_winspool.destroy
TriggerEvent( this, "destructor" )
end on

