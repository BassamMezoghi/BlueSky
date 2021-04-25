$PBExportHeader$w_setup_confirmation.srw
forward
global type w_setup_confirmation from w_response
end type
type cb_1 from u_cb within w_setup_confirmation
end type
type st_1 from statictext within w_setup_confirmation
end type
type sle_1 from singlelineedit within w_setup_confirmation
end type
end forward

global type w_setup_confirmation from w_response
integer width = 1957
integer height = 144
boolean titlebar = false
boolean controlmenu = false
boolean center = true
cb_1 cb_1
st_1 st_1
sle_1 sle_1
end type
global w_setup_confirmation w_setup_confirmation

on w_setup_confirmation.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_1
end on

on w_setup_confirmation.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

type cb_1 from u_cb within w_setup_confirmation
integer x = 9
integer y = 16
integer taborder = 20
string text = "مـــوافق"
boolean default = true
end type

event clicked;call super::clicked;CloseWithReturn(Parent,trim(sle_1.text))
end event

type st_1 from statictext within w_setup_confirmation
integer x = 1600
integer y = 24
integer width = 402
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": رقم العميل"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_setup_confirmation
integer x = 375
integer y = 12
integer width = 1216
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1111-1111-1111-1111"
borderstyle borderstyle = stylelowered!
end type

