$PBExportHeader$w_sqlpreview.srw
forward
global type w_sqlpreview from w_popup
end type
type pb_1 from picturebutton within w_sqlpreview
end type
type pb_apply from picturebutton within w_sqlpreview
end type
type mle_sql from multilineedit within w_sqlpreview
end type
type gb_1 from groupbox within w_sqlpreview
end type
end forward

global type w_sqlpreview from w_popup
integer width = 2469
integer height = 1476
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
boolean ib_isupdateable = false
pb_1 pb_1
pb_apply pb_apply
mle_sql mle_sql
gb_1 gb_1
end type
global w_sqlpreview w_sqlpreview

on w_sqlpreview.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_apply=create pb_apply
this.mle_sql=create mle_sql
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_apply
this.Control[iCurrent+3]=this.mle_sql
this.Control[iCurrent+4]=this.gb_1
end on

on w_sqlpreview.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_apply)
destroy(this.mle_sql)
destroy(this.gb_1)
end on

event open;call super::open;str_pass_parmeters lstr_parm

lstr_parm = Message.powerobjectparm

mle_sql.text = lstr_parm.string_parm[1]


end event

type pb_1 from picturebutton within w_sqlpreview
integer x = 2021
integer y = 1212
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean flatstyle = true
string picturename = "C:\Applications\icons\hot\gif\32x32\Turn off.gif"
alignment htextalign = left!
end type

event clicked;str_pass_parmeters lstr_parm

lstr_parm.string_parm[1] = "-"

CloseWithReturn(Parent , lstr_parm)
end event

type pb_apply from picturebutton within w_sqlpreview
integer x = 2222
integer y = 1212
integer width = 183
integer height = 160
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean flatstyle = true
string picturename = "C:\Applications\icons\hot\gif\32x32\Apply.gif"
alignment htextalign = left!
end type

event clicked;str_pass_parmeters lstr_parm

lstr_parm.string_parm[1] = mle_sql.text

CloseWithReturn(Parent , lstr_parm)
end event

type mle_sql from multilineedit within w_sqlpreview
integer x = 46
integer y = 84
integer width = 2345
integer height = 1080
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_sqlpreview
integer width = 2441
integer height = 1200
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SQL Preview"
end type

