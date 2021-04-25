$PBExportHeader$uo_small_select_dt.sru
forward
global type uo_small_select_dt from userobject
end type
type dw_1 from u_dw within uo_small_select_dt
end type
end forward

global type uo_small_select_dt from userobject
integer width = 1467
integer height = 120
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_small_select_dt uo_small_select_dt

type variables
DateTime start_dt , end_dt
end variables

on uo_small_select_dt.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_small_select_dt.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within uo_small_select_dt
integer width = 1467
integer height = 128
integer taborder = 10
string dataobject = "exd_small_select_dt"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean righttoleft = true
end type

event constructor;call super::constructor;This.settransobject( SQLCA )

This.of_SetDropDownCalendar(TRUE)
This.iuo_calendar.of_Register("start_dt", This.iuo_calendar.DDLB)
This.iuo_calendar.of_Register("end_dt", This.iuo_calendar.DDLB)

This.Insertrow( 0 )
end event

event editchanged;call super::editchanged;//This.accepttext( )
//start_dt  = This.GetItemDateTime(1,"start_dt")
//start_dt  = This.GetItemDateTime(1,"end_dt")
end event

event itemchanged;This.accepttext( )
start_dt  = This.GetItemDateTime(1,"start_dt")
end_dt  = This.GetItemDateTime(1,"end_dt")
end event

