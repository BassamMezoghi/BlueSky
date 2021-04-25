$PBExportHeader$w_clients_search.srw
forward
global type w_clients_search from w_response
end type
type pb_close from picturebutton within w_clients_search
end type
type dw_2 from u_dw within w_clients_search
end type
type dw_1 from u_dw within w_clients_search
end type
end forward

global type w_clients_search from w_response
integer width = 3296
integer height = 2280
boolean titlebar = false
boolean controlmenu = false
boolean center = true
windowanimationstyle openanimation = toproll!
boolean ib_isupdateable = false
pb_close pb_close
dw_2 dw_2
dw_1 dw_1
end type
global w_clients_search w_clients_search

type variables
str_pass_parmeters istr_parm

end variables

on w_clients_search.create
int iCurrent
call super::create
this.pb_close=create pb_close
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_close
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_clients_search.destroy
call super::destroy
destroy(this.pb_close)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;//str_pass_parmeters lstr_parm

istr_parm = Message.powerobjectparm

istr_parm.string_parm[1] = "d_search_clients_list"


if(UpperBound(istr_parm.long_array) > 0)then
	This.move( istr_parm.long_array[1] , istr_parm.long_array[2])
end if

dw_2.insertrow( 0 )
dw_2.modify( "name.width=3200" )
dw_2.modify( "name_t.visible=0" )
dw_2.modify( "name.tooltip.enabled='1'" )

dw_1.event pfc_retrieve( )

gnv_services.of_color( dw_1 )




end event

type pb_close from picturebutton within w_clients_search
integer x = 3081
integer y = 2084
integer width = 183
integer height = 160
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "C:\Applications\icons\hot\png\32x32\Turn off.png"
alignment htextalign = left!
end type

event clicked;str_pass_parmeters lstr_parm
	
lstr_parm.long_array[1] = -1
	
closewithreturn(Parent,lstr_parm)
end event

type dw_2 from u_dw within w_clients_search
event of_keydown pbm_dwnkey
integer x = 18
integer y = 24
integer width = 3237
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

event of_keydown;Long row
str_pass_parmeters lstr_parm

IF KeyDown(KeyEnter!) THEN
	
	row = dw_1.GetRow( )
	IF row > 0 THEN
		lstr_parm.long_array[1] = dw_1.getitemnumber(row,"customer_id")
		lstr_parm.long_array[2] = dw_1.getitemnumber(row,"PRICE_LIST_ID")
		lstr_parm.decimal_array[1] = dw_1.getitemDecimal(row,"dp")
		CloseWithReturn(parent,lstr_parm)
	END IF	

END IF

IF KeyDown(KeyDownArrow!) THEN
	dw_1.setfocus( )
	dw_1.setrow( 1 )
END IF
end event

event editchanged;call super::editchanged;Long ll_found
String ls_sql , ls_like

This.accepttext( )

IF Pos(data, "+") = 1 THEN
	
	dw_1.SetFilter(  "match(shid , '^"+Replace ( data, 1, 1, "" )+"')" )
	dw_1.filter()

	IF(dw_1.RowCount() = 0 )THEN
		dw_1.SetFilter(  "match(nid , '^"+Replace ( data, 1, 1, "" )+"')" )
		dw_1.filter()
	END IF
	
ELSE

		IF(IsNumber(data))THEN
			dw_1.SetFilter(  "match(id , '^"+data+"')" )
			dw_1.filter()
		END IF
		
		
		IF(Not IsNumber(data) )THEN
			dw_1.SetFilter(  "match(nm , '."+data+"')" )	
			dw_1.filter()
		END IF
		
END IF

IF(dw_1.RowCount() > 0 )THEN
	dw_1.SetRow( 1 )
END IF
end event

type dw_1 from u_dw within w_clients_search
event dwnkey pbm_dwnkey
integer x = 18
integer y = 140
integer width = 3255
integer height = 1924
integer taborder = 20
string dataobject = "d_search_clients_list"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dwnkey;str_pass_parmeters lstr_parm
int ll_row 

IF(key = KeyEnter!)THEN
			
	ll_row = This.GetRow()

	lstr_parm.string_parm[1] = This.GetitemString(ll_row,"id")
	lstr_parm.long_array[1] = This.getitemnumber(ll_row,"shares") * ShareVactor
	

	closewithreturn(parent,lstr_parm)
	
	
END IF
end event

event constructor;call super::constructor;

This.settransobject( SQLCA )

This.of_SetRowSelect(TRUE)
This.inv_rowselect.of_SetStyle(0)

This.of_SetSort (TRUE)
This.inv_sort.of_SetColumnHeader(TRUE)

//This.retrieve( )
end event

event doubleclicked;call super::doubleclicked;if(row > 0 )Then
	str_pass_parmeters lstr_parm
	
	lstr_parm.string_parm[1] = dw_1.GetitemString(row,"id")
	lstr_parm.long_array[1] = dw_1.getitemnumber(row,"shares") * ShareVactor
	lstr_parm.string_parm[2] = dw_1.GetitemString(row,"client_type")

	closewithreturn(parent,lstr_parm)
	
End if
end event

event pfc_retrieve;call super::pfc_retrieve;return This.retrieve( )
end event

