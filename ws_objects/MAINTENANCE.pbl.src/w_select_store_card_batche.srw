$PBExportHeader$w_select_store_card_batche.srw
forward
global type w_select_store_card_batche from w_popup
end type
type pb_3 from u_pb within w_select_store_card_batche
end type
type dw_1 from u_dw within w_select_store_card_batche
end type
end forward

global type w_select_store_card_batche from w_popup
integer width = 1522
integer height = 1504
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean righttoleft = true
boolean center = true
pb_3 pb_3
dw_1 dw_1
end type
global w_select_store_card_batche w_select_store_card_batche

type variables
Long il_scid = 0
end variables

on w_select_store_card_batche.create
int iCurrent
call super::create
this.pb_3=create pb_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_3
this.Control[iCurrent+2]=this.dw_1
end on

on w_select_store_card_batche.destroy
call super::destroy
destroy(this.pb_3)
destroy(this.dw_1)
end on

event open;call super::open;str_pass_parmeters lstr_parm

lstr_parm = Message.PowerObjectParm

il_scid = lstr_parm.Long_array[1]

dw_1.Event pfc_retrieve( )
end event

type pb_3 from u_pb within w_select_store_card_batche
integer x = 14
integer y = 1260
integer width = 256
integer height = 224
integer taborder = 40
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\48x48\delete.bmp"
end type

event clicked;call super::clicked;str_pass_parmeters lstr_parm
	lstr_parm.long_array[1] = -1
	CloseWithReturn(Parent , lstr_parm)
end event

type dw_1 from u_dw within w_select_store_card_batche
integer width = 1499
integer height = 1240
integer taborder = 10
string dataobject = "d_select_store_card_batche"
end type

event type long pfc_retrieve();call super::pfc_retrieve;Return This.retrieve(il_scid)
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

event doubleclicked;call super::doubleclicked;
if(row > 0)Then
	str_pass_parmeters lstr_parm
	lstr_parm.long_array[1] = This.GetItemNumber(row , "id")
	CloseWithReturn(Parent , lstr_parm)
End if
end event

