$PBExportHeader$uo_select_dt.sru
forward
global type uo_select_dt from userobject
end type
type dw_1 from u_dw within uo_select_dt
end type
end forward

global type uo_select_dt from userobject
integer width = 2094
integer height = 124
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_select_dt uo_select_dt

on uo_select_dt.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_select_dt.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within uo_select_dt
integer width = 2094
integer height = 128
integer taborder = 10
string dataobject = "exd_normal_select_dt"
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
end event

event itemchanged;This.accepttext( )
end event

