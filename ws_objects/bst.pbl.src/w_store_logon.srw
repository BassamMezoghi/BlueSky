$PBExportHeader$w_store_logon.srw
forward
global type w_store_logon from w_logon
end type
type p_1 from picture within w_store_logon
end type
type st_4 from statictext within w_store_logon
end type
type st_1 from statictext within w_store_logon
end type
type st_5 from statictext within w_store_logon
end type
end forward

global type w_store_logon from w_logon
integer width = 2747
integer height = 1972
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean righttoleft = true
boolean center = true
integer transparency = 5
p_1 p_1
st_4 st_4
st_1 st_1
st_5 st_5
end type
global w_store_logon w_store_logon

on w_store_logon.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_4=create st_4
this.st_1=create st_1
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_5
end on

on w_store_logon.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.st_5)
end on

type p_logo from w_logon`p_logo within w_store_logon
boolean visible = false
integer x = 41
end type

type st_help from w_logon`st_help within w_store_logon
boolean visible = false
integer x = 1614
integer y = 292
integer width = 617
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 15780518
long backcolor = 16777215
string text = "نسخة تجريبية"
alignment alignment = center!
end type

type cb_ok from w_logon`cb_ok within w_store_logon
integer x = 1833
integer y = 1164
integer width = 434
integer height = 124
integer transparency = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "دخــــول"
boolean flatstyle = true
end type

type cb_cancel from w_logon`cb_cancel within w_store_logon
integer x = 1381
integer y = 1164
integer width = 434
integer height = 124
integer transparency = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خــــروج"
boolean flatstyle = true
end type

type sle_userid from w_logon`sle_userid within w_store_logon
integer x = 453
integer y = 664
integer width = 1815
integer height = 116
integer textsize = -14
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 16777215
end type

type sle_password from w_logon`sle_password within w_store_logon
integer x = 453
integer y = 928
integer width = 1815
integer height = 116
integer textsize = -14
long textcolor = 12632256
long backcolor = 16777215
end type

type st_2 from w_logon`st_2 within w_store_logon
integer x = 1778
integer y = 548
integer width = 517
integer height = 108
integer textsize = -14
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 16777215
string text = "اســـم المستخدم"
alignment alignment = center!
end type

type st_3 from w_logon`st_3 within w_store_logon
integer x = 1879
integer y = 828
integer width = 398
integer height = 92
integer textsize = -14
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 16777215
string text = "كلمة الســر"
alignment alignment = center!
end type

type p_1 from picture within w_store_logon
integer width = 2743
integer height = 1972
boolean originalsize = true
string picturename = "C:\Applications\icons\banners\33.jpg"
boolean focusrectangle = false
end type

type st_4 from statictext within w_store_logon
integer x = 178
integer y = 1612
integer width = 1029
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 16777215
string text = "Blue sky technology copy right © 2018"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_store_logon
integer x = 1934
integer y = 224
integer width = 448
integer height = 96
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 16777215
string text = "تسجيل الدخول"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_store_logon
integer x = 530
integer y = 204
integer width = 1408
integer height = 124
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 16777215
string text = "لمنظومة إكتتاب مصرف السراي"
alignment alignment = right!
boolean focusrectangle = false
end type

