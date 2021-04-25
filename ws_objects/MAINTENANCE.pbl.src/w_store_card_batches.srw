$PBExportHeader$w_store_card_batches.srw
forward
global type w_store_card_batches from w_popup
end type
type pb_3 from u_pb within w_store_card_batches
end type
type pb_2 from u_pb within w_store_card_batches
end type
type pb_1 from u_pb within w_store_card_batches
end type
type dw_1 from u_dw within w_store_card_batches
end type
end forward

global type w_store_card_batches from w_popup
integer width = 1659
integer height = 1564
string title = "ارقام التشغيلة و الصلاحية"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
end type
global w_store_card_batches w_store_card_batches

type variables
Long il_scid = 0
end variables

on w_store_card_batches.create
int iCurrent
call super::create
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_store_card_batches.destroy
call super::destroy
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event open;call super::open;str_pass_parmeters lstr_parm

lstr_parm = Message.PowerObjectParm

il_scid = lstr_parm.Long_array[1]

dw_1.Event pfc_retrieve( )
end event

type pb_3 from u_pb within w_store_card_batches
integer x = 869
integer y = 1248
integer width = 256
integer height = 224
integer taborder = 40
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\48x48\delete.bmp"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_2 from u_pb within w_store_card_batches
integer x = 1120
integer y = 1248
integer width = 256
integer height = 224
integer taborder = 30
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\48x48\Refresh.bmp"
end type

event clicked;call super::clicked;dw_1.event pfc_retrieve( )
end event

type pb_1 from u_pb within w_store_card_batches
integer x = 1376
integer y = 1248
integer width = 256
integer height = 224
integer taborder = 20
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\48x48\ok.bmp"
end type

event clicked;call super::clicked;dw_1.event pfc_update( True , True)

Commit;

Close(Parent)
end event

type dw_1 from u_dw within w_store_card_batches
integer width = 1627
integer height = 1240
integer taborder = 10
string dataobject = "d_store_card_batches"
end type

event type long pfc_retrieve();call super::pfc_retrieve;Return This.retrieve(il_scid)
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

event buttonclicked;call super::buttonclicked;if(dwo.name = "b_dell")Then
	This.SetItem( row, "ACTIVE_FG" , "N")
	This.SetItem( row , "Last_modified_by" , gstr_user_info.Login_Id)
	This.SetItem( row , "Last_modified_dt" , Datetime(today(),now()))
	This.Filter( )
End if

if(dwo.name = "b_add")Then
	This.Event pfc_insertrow( )	
End if
end event

event pfc_postinsertrow(long al_row);call super::pfc_postinsertrow;This.scrolltorow( al_row)
This.SetItem(al_row , "sc_id" , il_scid)
This.SetItem(al_row , "Active_fg" , 'Y')
This.SetItem(al_row , "last_modified_by" , gstr_user_info.login_id )
This.SetItem(al_row , "last_modified_dt" , datetime(today(),now()) )

end event

