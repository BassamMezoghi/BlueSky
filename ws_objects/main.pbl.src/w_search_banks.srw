$PBExportHeader$w_search_banks.srw
forward
global type w_search_banks from w_response
end type
type pb_1 from picturebutton within w_search_banks
end type
type dw_2 from u_dw within w_search_banks
end type
type dw_1 from u_dw within w_search_banks
end type
end forward

global type w_search_banks from w_response
integer x = 214
integer y = 221
integer width = 1623
integer height = 1568
boolean titlebar = false
boolean controlmenu = false
long backcolor = 67108864
boolean righttoleft = true
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = fadeanimation!
boolean ib_isupdateable = false
pb_1 pb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_search_banks w_search_banks

type variables
Long il_res = -1
end variables

on w_search_banks.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_search_banks.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;str_pass_parmeters lstr_parm
Long ll_count,ll_row
String ls_filter

lstr_parm = Message.powerobjectparm

if(UpperBound(lstr_parm.long_array) > 0)then
	This.move( lstr_parm.long_array[1] , lstr_parm.long_array[2])
end if

dw_1.dataobject = lstr_parm.string_parm[1]
dw_1.settransobject( SQLCA )
dw_1.retrieve( )	

gnv_services.of_color(dw_1)

dw_2.insertrow( 0 )
end event

event close;call super::close;str_pass_parmeters lstr_parm
	
lstr_parm.long_array[1] = il_res
	
CloseWithReturn(This,lstr_parm)
end event

type pb_1 from picturebutton within w_search_banks
integer x = 1422
integer y = 1384
integer width = 183
integer height = 160
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\bmp\32x32\Turn off.bmp"
vtextalign vtextalign = vcenter!
string powertiptext = "رجوع"
end type

event clicked;il_res = -1
Parent.event close( )
end event

type dw_2 from u_dw within w_search_banks
event bst_keydown pbm_dwnkey
integer x = 160
integer y = 28
integer width = 1339
integer height = 92
integer taborder = 10
string dataobject = "d_search_field"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event bst_keydown;IF KEYDOWN(KeyDownArrow!) THEN
	dw_1.setfocus( )
END IF 

IF KeyDown(KeyEnter!) THEN
	
	IF dw_1.RowCount() > 0 THEN
			il_res = dw_1.getitemnumber(1,"bank_id")
			Parent.event close( )	
	END IF
	
END IF
end event

event editchanged;call super::editchanged;
	
dw_1.SetFilter(  "match(title , '^"+data+"')" )	

dw_1.filter()

end event

type dw_1 from u_dw within w_search_banks
event dwnkey pbm_dwnkey
integer y = 140
integer width = 1605
integer height = 1232
integer taborder = 20
string dataobject = "d_search_from_banks"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dwnkey;IF keyDown(KeyEnter!) Then
	il_res = dw_1.getitemnumber(This.GetRow(),"bank_id")
	Parent.event close( )
end if
end event

event constructor;call super::constructor;This.settransobject( SQLCA )

This.of_SetRowSelect(TRUE)
This.inv_rowselect.of_SetStyle(0)

This.of_SetSort (TRUE)
This.inv_sort.of_SetColumnHeader(TRUE)

This.retrieve( )
end event

event doubleclicked;call super::doubleclicked;if(row > 0 )Then
//	str_pass_parmeters lstr_parm	
//	lstr_parm.long_array[1] = dw_1.getitemnumber(row,"bank_id")
//	closewithreturn(parent,lstr_parm)	

	il_res = dw_1.getitemnumber(row,"id")
	Parent.event close( )

End if
end event

