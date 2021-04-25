$PBExportHeader$w_source_info.srw
forward
global type w_source_info from w_response
end type
type uo_1 from navigator_bar within w_source_info
end type
type cb_2 from u_cb within w_source_info
end type
type cb_1 from commandbutton within w_source_info
end type
type cb_next from u_cb within w_source_info
end type
type cb_prior from u_cb within w_source_info
end type
type cb_close from u_cb within w_source_info
end type
type cb_delete from u_cb within w_source_info
end type
type cb_save from u_cb within w_source_info
end type
type cb_add from u_cb within w_source_info
end type
type dw_1 from u_dw within w_source_info
end type
end forward

global type w_source_info from w_response
integer x = 214
integer y = 221
integer width = 3191
integer height = 2276
boolean maxbox = true
windowtype windowtype = child!
boolean center = true
boolean ib_isupdateable = false
uo_1 uo_1
cb_2 cb_2
cb_1 cb_1
cb_next cb_next
cb_prior cb_prior
cb_close cb_close
cb_delete cb_delete
cb_save cb_save
cb_add cb_add
dw_1 dw_1
end type
global w_source_info w_source_info

type variables
boolean ib_change = false
uo_resize iuo_resize

end variables

on w_source_info.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_add=create cb_add
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_next
this.Control[iCurrent+5]=this.cb_prior
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_add
this.Control[iCurrent+10]=this.dw_1
end on

on w_source_info.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.dw_1)
end on

event open;call super::open;
iuo_resize = CREATE uo_resize

iuo_resize.of_setTag(this)

dw_1.settransobject( SQLCA)
dw_1.event pfc_retrieve( )

uo_1.event set_dw_nm( dw_1 , dw_1 , fALSE)

end event

event closequery;Long ll_answer

if ib_change then
	ll_answer = MessageBox("تنبيه","هل تريد حفظ التغيرات ؟",information!,yesnocancel!) 
	if ll_answer = 1 then
		dw_1.Event pfc_update(True,True)
		return 1
	Else
		if ll_answer = 2 then
			return 0
		ELse
			return 1
		End if
	End if
	
	return 1
End if
end event

event resize;call super::resize;iuo_resize.of_doResize(this)
end event

type uo_1 from navigator_bar within w_source_info
integer x = 32
integer y = 2068
integer width = 640
integer height = 100
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call navigator_bar::destroy
end on

type cb_2 from u_cb within w_source_info
integer x = 2007
integer y = 2068
integer width = 288
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "طباعة"
end type

event clicked;call super::clicked;
dw_1.accepttext( )

gstr_parm.string_parm[1] = "d_rpt_source_info"

gstr_parm.long_array[1]    = dw_1.getitemnumber( dw_1.getrow() , "customer_id")

open(w_print_info)
end event

type cb_1 from commandbutton within w_source_info
integer x = 1719
integer y = 2068
integer width = 288
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "بحث"
end type

event clicked;
//gstr_parm.string_parm[1] = "d_customer_list_m"
//
str_pass_parmeters lstr_parm

//open(w_search_source)

lstr_parm = Message.PowerObjectParm

if lstr_parm.long_array[1] > 0 then
	
   dw_1.scrolltorow(  dw_1.find( "customer_id = "+string(lstr_parm.long_array[1]) , 1 , dw_1.rowcount( ) ) )
	
End if
end event

type cb_next from u_cb within w_source_info
boolean visible = false
integer x = 41
integer y = 1176
integer width = 133
integer taborder = 40
integer weight = 700
fontcharset fontcharset = arabiccharset!
string text = "<<"
end type

event clicked;call super::clicked;dw_1.scrollnextrow( )

If dw_1.getrow( ) = dw_1.rowcount() then
	cb_prior.enabled = True
	cb_next.enabled  = False
Else
   cb_prior.enabled = True
	cb_next.enabled  = True
End if
end event

type cb_prior from u_cb within w_source_info
boolean visible = false
integer x = 174
integer y = 1176
integer width = 133
integer taborder = 40
integer weight = 700
fontcharset fontcharset = arabiccharset!
string text = ">>"
end type

event clicked;call super::clicked;dw_1.scrollpriorrow( )

If dw_1.getrow() <= 1 then
	cb_prior.enabled = False
	cb_next.enabled  = True
Else
	cb_prior.enabled = True
	cb_next.enabled  = True
End if
end event

type cb_close from u_cb within w_source_info
integer x = 1426
integer y = 2068
integer width = 288
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خروج"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_delete from u_cb within w_source_info
integer x = 2592
integer y = 2068
integer width = 288
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إلغاء"
end type

event clicked;call super::clicked;if(MessageBox("تنبيه","هل انت متاكد من الالغاء؟",information!,yesno!) = 1)then

  dw_1.SetItem( dw_1.GetRow() , "Active_fg","N")
  dw_1.setitem( dw_1.GetRow() , "last_modified_by" , gstr_user_info.login_id )
  dw_1.setitem( dw_1.GetRow() , "last_modified_dt" , datetime(today(),Now()) )
  dw_1.event pfc_update( True , True)
  dw_1.retrieve( )
//  dw_2.retrieve()
  
end if
end event

type cb_save from u_cb within w_source_info
integer x = 2299
integer y = 2068
integer width = 288
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "حفـــظ"
end type

event clicked;call super::clicked;dw_1.event pfc_update( True , True )
//dw_2.retrieve( )

cb_add.Enabled    = True
cb_delete.Enabled = True
cb_save.Enabled   = False
cb_next.Enabled   = True
cb_prior.Enabled  = True
ib_change = false
end event

type cb_add from u_cb within w_source_info
integer x = 2885
integer y = 2068
integer width = 288
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إضافة"
end type

event clicked;call super::clicked;if(Demo and dw_1.RowCount() > MaxRows)Then Return
dw_1.event pfc_insertrow( )

cb_add.Enabled    = False
cb_delete.Enabled = False
cb_save.Enabled   = True
cb_next.Enabled   = False
cb_prior.Enabled  = False
end event

type dw_1 from u_dw within w_source_info
integer x = 14
integer width = 3159
integer height = 2064
integer taborder = 10
string dataobject = "d_source_info"
boolean vscrollbar = false
boolean border = false
boolean righttoleft = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;This.settransobject( SQLCA )
end event

event itemchanged;call super::itemchanged;This.accepttext( )

This.setitem( row , "last_modified_by" , gstr_user_info.login_id )
This.setitem( row , "last_modified_dt" , datetime(today(),Now()) )


cb_add.enabled   = False
cb_delete.enabled = False
cb_save.enabled  = True
cb_prior.enabled = False
cb_next.enabled  = False
ib_change = True

end event

event type long pfc_insertrow();Long ll_row

ll_row = This.insertrow(0)

if IsNull(ll_row) or ( ll_row = -1 ) then
	
	MessageBox('Error' , 'Can not add new record')
	return 0
	
else
	
	This.setitem( ll_row , "active_fg"        , "Y")
	This.setitem( ll_row , "last_modified_by" , gstr_user_info.login_id )
   This.setitem( ll_row , "last_modified_dt" , datetime(today(),Now()) )
   This.setitem( ll_row , "INITIAL_DT"       , datetime(today(),Now()) )
   This.setitem( ll_row , "KIND"             , "M" )
	
	
   This.scrolltorow( ll_row )	
	
		
   return 	1
	
End if
	
	
end event

event type long pfc_retrieve();call super::pfc_retrieve;return This.retrieve( )
end event

event type integer pfc_update(boolean ab_accepttext, boolean ab_resetflag);Long ll_update

ll_update = This.update( )

if ll_update = -1 or IsNull(ll_update) then
	
	ROLLBACK ;
	
	MessageBox("Error","Can not Update Your Data")
	
	return 0
	
else
	
	COMMIT ;
	
	
	return 1
	
End if
end event

event editchanged;call super::editchanged;ib_change = True
end event

event buttonclicking;call super::buttonclicking;Long ll_row

gstr_parm.long_array[1] = This.GetItemNumber( row , "group_id")

open(w_rank_client_into_group)

ll_row = row

This.retrieve( )

This.scrolltorow( ll_row )
end event

