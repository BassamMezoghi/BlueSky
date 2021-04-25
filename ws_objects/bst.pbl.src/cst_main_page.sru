$PBExportHeader$cst_main_page.sru
forward
global type cst_main_page from u_cst_tabpage
end type
type dw_main from u_dw within cst_main_page
end type
end forward

global type cst_main_page from u_cst_tabpage
integer width = 3026
integer height = 1592
dw_main dw_main
end type
global cst_main_page cst_main_page

on cst_main_page.create
int iCurrent
call super::create
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
end on

on cst_main_page.destroy
call super::destroy
destroy(this.dw_main)
end on

event resize;call super::resize;dw_main.resize( NewWidth, NewHeight )
//dw_1.resize( newwidth, dw_1.height)
//dw_1.Modify( "name.width="+String(newwidth - 40))
end event

type dw_main from u_dw within cst_main_page
integer width = 3022
integer height = 1588
integer taborder = 10
string dataobject = "d_ext_main_screen"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

