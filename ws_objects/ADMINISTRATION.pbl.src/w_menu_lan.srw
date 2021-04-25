$PBExportHeader$w_menu_lan.srw
forward
global type w_menu_lan from w_popup
end type
type dw_menu_lan from u_dw within w_menu_lan
end type
end forward

global type w_menu_lan from w_popup
integer height = 992
boolean minbox = false
boolean maxbox = false
boolean center = true
dw_menu_lan dw_menu_lan
end type
global w_menu_lan w_menu_lan

on w_menu_lan.create
int iCurrent
call super::create
this.dw_menu_lan=create dw_menu_lan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_menu_lan
end on

on w_menu_lan.destroy
call super::destroy
destroy(this.dw_menu_lan)
end on

event open;call super::open;String ls_ACID


ls_Acid = Message.StringParm

dw_menu_lan.DataObject = "d_menu_lan"
dw_menu_lan.SetTransObject( SQLCA )
dw_menu_lan.retrieve(ls_acid)
end event

event close;call super::close;dw_menu_lan.update( )

Commit ;
end event

type dw_menu_lan from u_dw within w_menu_lan
integer width = 2450
integer height = 884
integer taborder = 10
string dataobject = "d_menu_lan"
end type

