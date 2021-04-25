$PBExportHeader$w_store_card_rank.srw
forward
global type w_store_card_rank from window
end type
type pb_4 from picturebutton within w_store_card_rank
end type
type pb_3 from picturebutton within w_store_card_rank
end type
type cb_2 from u_cb within w_store_card_rank
end type
type cb_1 from u_cb within w_store_card_rank
end type
type pb_2 from picturebutton within w_store_card_rank
end type
type pb_1 from picturebutton within w_store_card_rank
end type
type cb_close from u_cb within w_store_card_rank
end type
type dw_1 from u_dw within w_store_card_rank
end type
type gb_1 from groupbox within w_store_card_rank
end type
end forward

global type w_store_card_rank from window
integer width = 2327
integer height = 2216
boolean titlebar = true
string title = "ترتيب الاصناف"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
integer transparency = 10
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = fadeanimation!
pb_4 pb_4
pb_3 pb_3
cb_2 cb_2
cb_1 cb_1
pb_2 pb_2
pb_1 pb_1
cb_close cb_close
dw_1 dw_1
gb_1 gb_1
end type
global w_store_card_rank w_store_card_rank

type variables
Long il_row = 0;
end variables

on w_store_card_rank.create
this.pb_4=create pb_4
this.pb_3=create pb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.pb_4,&
this.pb_3,&
this.cb_2,&
this.cb_1,&
this.pb_2,&
this.pb_1,&
this.cb_close,&
this.dw_1,&
this.gb_1}
end on

on w_store_card_rank.destroy
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;Long ll_kind_id
String ls_sql 

//ll_kind_id = dw_2.GetItemNumber( 1 , "kind_id"     )
//
//
//if(isnull(ll_kind_id)  )then ll_kind_id  =  0
//


//ls_sql  = "SELECT STORE_CARD.CARD_NM, STORE_CARD.SC_ID, STORE_CARD.BCODE FROM STORE_CARD WHERE (STORE_CARD.ACTIVE_FG = 'Y')AND(STORE_CARD.CARD_KIND_ID = "+string(ll_kind_id)+")"	

//dw_1.setsqlselect( ls_sql )
//dw_1.retrieve( )
//	

end event

type pb_4 from picturebutton within w_store_card_rank
integer x = 2121
integer y = 632
integer width = 174
integer height = 148
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Wingdings 3"
boolean originalsize = true
string picturename = "C:\Applications\icons\icons\top.gif"
string disabledname = "C:\Applications\icons\icons\top.gif"
end type

event clicked;Long ll_old_row 

dw_1.accepttext()

//ll_row = dw_1.GetRow()

if(il_row > 1)then
  
  ll_old_row = il_row - 1
  
  dw_1.SetItem(il_row , "rank" , 1)
  dw_1.SetItem(1 , "rank" , il_row)
  dw_1.setrow(1)
  dw_1.SelectRow(1, TRUE)
  dw_1.scrolltorow( 1 )
  dw_1.accepttext( )
  dw_1.setsort( "rank" )
  dw_1.SetRedraw( False )
  dw_1.sort( )  
  dw_1.SetRedraw( True )  
  il_row = 1

end if
end event

type pb_3 from picturebutton within w_store_card_rank
integer x = 2121
integer y = 1088
integer width = 174
integer height = 148
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
boolean originalsize = true
string picturename = "C:\Applications\icons\icons\bottom.gif"
string disabledname = "C:\Applications\icons\icons\bottom.gif"
end type

event clicked;Long ll_row

dw_1.accepttext()

//ll_row = dw_1.GetRow()

if(il_row < dw_1.rowcount())then
  ll_row = il_row + 1
  dw_1.SetItem(il_row , "rank" , dw_1.rowcount())
  dw_1.SetItem(dw_1.rowcount() , "rank" , il_row)
  dw_1.setsort( "rank" )
  dw_1.SetRedraw( False )
  dw_1.sort( )  
  dw_1.SetRedraw( True )
  dw_1.SetRow(dw_1.rowcount())
  dw_1.SelectRow(dw_1.rowcount(), TRUE)
  dw_1.scrolltorow( dw_1.rowcount()   )
  dw_1.accepttext( )
  
  il_row = dw_1.rowcount()
end if
end event

type cb_2 from u_cb within w_store_card_rank
integer x = 1413
integer y = 1988
integer width = 334
integer height = 112
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "تراجع"
end type

event clicked;call super::clicked;//Connect using SQLCA;
//dw_1.settransobject( SQLCA )
dw_1.retrieve( )
end event

type cb_1 from u_cb within w_store_card_rank
integer x = 1755
integer y = 1988
integer width = 334
integer height = 112
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "حفظ"
end type

event clicked;call super::clicked;//Connect using SQLCA;
//dw_1.settransobject( SQLCA )
dw_1.update(True , True )
Commit;
end event

type pb_2 from picturebutton within w_store_card_rank
integer x = 2121
integer y = 784
integer width = 174
integer height = 148
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
boolean originalsize = true
string picturename = "C:\Applications\icons\icons\up.gif"
string disabledname = "C:\Applications\icons\icons\up.gif"
end type

event clicked;Long ll_old_row 

dw_1.accepttext()

//ll_row = dw_1.GetRow()

if(il_row > 1)then
  
  ll_old_row = il_row - 1
  
  dw_1.SetItem(il_row     , "rank" , ll_old_row)
  dw_1.SetItem(ll_old_row , "rank" , il_row)
 dw_1.SetRedraw( False )
  dw_1.sort( )  
  dw_1.SetRedraw( True )
  dw_1.scrolltorow( il_row - 1 )
  dw_1.setrow(il_row - 1)
  dw_1.SelectRow(il_row - 1, True)

  il_row = ll_old_row



end if


end event

type pb_1 from picturebutton within w_store_card_rank
integer x = 2121
integer y = 932
integer width = 174
integer height = 148
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
boolean originalsize = true
string picturename = "C:\Applications\icons\icons\down.gif"
string disabledname = "C:\Applications\icons\icons\down.gif"
end type

event clicked;Long ll_row

//dw_1.accepttext()

if(il_row < dw_1.rowcount())then

  ll_row = il_row + 1

  dw_1.SetItem(il_row , "rank" , ll_row)
  dw_1.SetItem(ll_row , "rank" , il_row)
  dw_1.SetRedraw( False )
  dw_1.sort( )  
  dw_1.SetRedraw( True )
  dw_1.scrolltorow( il_row )
  dw_1.SetRow(il_row + 1)
  dw_1.SelectRow(il_row + 1, True)

  il_row = ll_row
  

end if
end event

type cb_close from u_cb within w_store_card_rank
integer x = 1070
integer y = 1988
integer width = 334
integer height = 112
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خـــروج"
end type

event clicked;call super::clicked;gstr_parm.long_array[1] = 0
close(Parent)
end event

type dw_1 from u_dw within w_store_card_rank
integer x = 32
integer y = 60
integer width = 2021
integer height = 1888
integer taborder = 10
string dataobject = "d_store_card_rank"
boolean hscrollbar = true
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;This.settransobject( SQLCA )

This.of_SetRowSelect(TRUE)
This.inv_rowselect.of_SetStyle(0)

This.of_SetSort (TRUE)
This.inv_sort.of_SetColumnHeader(TRUE)

This.retrieve( )

This.setsort( "rank" )
This.sort( )  
//Disconnect using SQLCA;
end event

event doubleclicked;call super::doubleclicked;String ls_en_nm,ls_code
Long ll_fid,ll_mid

ls_en_nm	= dw_1.GetItemString(row , "en_card_nm")
ls_code		= dw_1.GetItemString(row , "made_in")
ll_fid			= dw_1.GetItemNumber(row , "fid")
ll_mid		= dw_1.GetItemNumber(row , "mid")

Messagebox("en card name",ls_en_nm)
Messagebox("code",ls_code)
Messagebox("fid",ll_fid)
Messagebox("mid",ll_mid)

//gstr_parm.long_array[1] = This.getitemnumber(row , "sc_id")
//close(Parent)
end event

event clicked;call super::clicked;il_row = row

This.selectrow( row , True)

end event

type gb_1 from groupbox within w_store_card_rank
integer x = 18
integer width = 2066
integer height = 1976
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 33554432
long backcolor = 67108864
end type

