$PBExportHeader$w_rank_client_into_group.srw
forward
global type w_rank_client_into_group from window
end type
type pb_3 from picturebutton within w_rank_client_into_group
end type
type pb_2 from picturebutton within w_rank_client_into_group
end type
type pb_1 from picturebutton within w_rank_client_into_group
end type
type dw_1 from u_dw within w_rank_client_into_group
end type
type gb_1 from groupbox within w_rank_client_into_group
end type
end forward

global type w_rank_client_into_group from window
integer width = 2121
integer height = 2236
boolean titlebar = true
string title = "ترتيب الزبائن في المجموعة"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_rank_client_into_group w_rank_client_into_group

on w_rank_client_into_group.create
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.pb_3,&
this.pb_2,&
this.pb_1,&
this.dw_1,&
this.gb_1}
end on

on w_rank_client_into_group.destroy
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type pb_3 from picturebutton within w_rank_client_into_group
integer x = 1929
integer y = 936
integer width = 174
integer height = 148
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Applications\icons\hot\bmp\32x32\Erase.bmp"
alignment htextalign = left!
string powertiptext = "حدف من المجموعة"
end type

event clicked;Long ll_group_id

SetNull(ll_group_id)

dw_1.SetItem(dw_1.getrow(), "group_id" , ll_group_id)
dw_1.SetItem(dw_1.getrow(), "rank" , dw_1.rowcount( )+1 )
dw_1.update()
dw_1.Event pfc_retrieve()
end event

type pb_2 from picturebutton within w_rank_client_into_group
integer x = 1929
integer y = 1084
integer width = 174
integer height = 148
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Applications\PB 11.0\SYSTEM\code\icons\down.gif"
alignment htextalign = left!
string powertiptext = "الى اسفل"
end type

event clicked;Long ll_row

dw_1.accepttext()

ll_row = dw_1.GetRow()

if(ll_row < dw_1.rowcount())then

  dw_1.SetItem(ll_row , "rank" , ll_row + 1)
  dw_1.SetItem(ll_row + 1 , "rank" , ll_row)
  dw_1.update()
  dw_1.retrieve( gstr_parm.long_array[1] )
  dw_1.SetRow(ll_row + 1)
  dw_1.SelectRow(ll_row + 1, TRUE)
end if
end event

type pb_1 from picturebutton within w_rank_client_into_group
integer x = 1929
integer y = 788
integer width = 174
integer height = 148
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Applications\PB 11.0\SYSTEM\code\icons\up.gif"
alignment htextalign = left!
string powertiptext = "الى اعلى"
end type

event clicked;Long ll_row

dw_1.accepttext()

ll_row = dw_1.GetRow()

if(ll_row > 1)then

  dw_1.SetItem(ll_row , "rank" , ll_row - 1)
  dw_1.SetItem(ll_row - 1 , "rank" , ll_row)
  dw_1.update()
  dw_1.retrieve( gstr_parm.long_array[1] )
  dw_1.setrow(ll_row - 1)
  dw_1.SelectRow(ll_row - 1, TRUE)

end if


end event

type dw_1 from u_dw within w_rank_client_into_group
integer x = 59
integer y = 84
integer width = 1815
integer height = 1968
integer taborder = 10
string dataobject = "d_customer_group_rank"
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.of_SetRowSelect(FALSE)

This.Event pfc_retrieve( )
end event

event type long pfc_retrieve();call super::pfc_retrieve;Long ll_rows , ll_count , ll_current_row

ll_rows = This.retrieve( gstr_parm.long_array[1] )

ll_count = This.rowcount( )

For ll_current_row = 1 To ll_count

    This.SetItem( ll_current_row , "rank" , ll_current_row)
    
Next

This.Update()

return ll_rows
end event

type gb_1 from groupbox within w_rank_client_into_group
integer x = 18
integer width = 1897
integer height = 2088
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "الزبائن"
boolean righttoleft = true
end type

