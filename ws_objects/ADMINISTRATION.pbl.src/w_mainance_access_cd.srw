$PBExportHeader$w_mainance_access_cd.srw
forward
global type w_mainance_access_cd from w_response
end type
type pb_2 from u_pb within w_mainance_access_cd
end type
type pb_1 from u_pb within w_mainance_access_cd
end type
type dw_accounts from lol_dw within w_mainance_access_cd
end type
end forward

global type w_mainance_access_cd from w_response
integer x = 214
integer y = 221
integer width = 2203
integer height = 784
boolean righttoleft = true
boolean center = true
pb_2 pb_2
pb_1 pb_1
dw_accounts dw_accounts
end type
global w_mainance_access_cd w_mainance_access_cd

type variables
String is_selected_data
boolean ib_change = False
str_stack istr_stack
end variables

on w_mainance_access_cd.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_accounts=create dw_accounts
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_accounts
end on

on w_mainance_access_cd.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_accounts)
end on

event open;call super::open;istr_stack = Message.PowerObjectParm

is_selected_data = istr_stack.as_data

dw_accounts.event pfc_retrieve( )
end event

type pb_2 from u_pb within w_mainance_access_cd
integer x = 1806
integer y = 532
integer width = 183
integer height = 160
integer taborder = 30
string text = ""
string picturename = "C:\Applications\icons\hot\gif\32x32\Cancel.gif"
long backcolor = 67108864
end type

event clicked;call super::clicked;CloseWithReturn(Parent, istr_stack)
end event

type pb_1 from u_pb within w_mainance_access_cd
integer x = 1989
integer y = 532
integer width = 183
integer height = 160
integer taborder = 20
string text = ""
string picturename = "C:\Applications\icons\hot\gif\32x32\Apply.gif"
long backcolor = 67108864
end type

event clicked;call super::clicked;String ls_account_name

dw_accounts.event pfc_update( True , True)
ls_account_name = dw_accounts.GetItemString(1 , "TITLE")

if( istr_stack.as_title <> ls_account_name )Then
	istr_stack.as_title = ls_account_name
End if

CloseWithReturn(Parent , istr_stack)
end event

type dw_accounts from lol_dw within w_mainance_access_cd
integer width = 2181
integer height = 528
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_maintance_access_cd"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransobject( SQLCA)
end event

event itemchanged;call super::itemchanged;//invo_ad.uf_controls( cb_new, cb_save, cb_del, cb_rollback,cb_info, "Edit" , pb_right , pb_left)
ib_change = True
end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve( Long(is_selected_data ) ) 
end event

