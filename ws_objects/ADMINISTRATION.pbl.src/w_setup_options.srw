$PBExportHeader$w_setup_options.srw
forward
global type w_setup_options from w_response
end type
type st_3 from statictext within w_setup_options
end type
type st_1 from statictext within w_setup_options
end type
type pb_2 from picturebutton within w_setup_options
end type
type pb_1 from picturebutton within w_setup_options
end type
type st_2 from statictext within w_setup_options
end type
type st_4 from statictext within w_setup_options
end type
end forward

global type w_setup_options from w_response
integer width = 1989
integer height = 608
boolean titlebar = false
boolean controlmenu = false
long backcolor = 16777215
boolean righttoleft = true
boolean center = true
st_3 st_3
st_1 st_1
pb_2 pb_2
pb_1 pb_1
st_2 st_2
st_4 st_4
end type
global w_setup_options w_setup_options

on w_setup_options.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_2=create st_2
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_4
end on

on w_setup_options.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_4)
end on

type st_3 from statictext within w_setup_options
integer x = 320
integer y = 312
integer width = 1618
integer height = 216
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_setup_options
integer x = 370
integer y = 124
integer width = 1408
integer height = 116
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "  تركيب قاعدة بيانات جديدة  "
alignment alignment = center!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean righttoleft = true
end type

type pb_2 from picturebutton within w_setup_options
integer x = 59
integer y = 312
integer width = 256
integer height = 224
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\bmp\48x48\Options.bmp"
alignment htextalign = left!
end type

event clicked;Open(w_db_setup)
Close(Parent)
end event

type pb_1 from picturebutton within w_setup_options
string tag = "  تركيب قاعدة بيانات جديدة  "
integer x = 59
integer y = 80
integer width = 256
integer height = 224
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\bmp\48x48\Admin.bmp"
alignment htextalign = right!
vtextalign vtextalign = multiline!
end type

event clicked;Long ll_res
//cs_sync lc_sync
//lc_sync = Create cs_sync

//ll_res = lc_sync.of_inital_db( ) 

if(ll_res <= 0)Then
	gnv_app.event pfc_exit( )
	
End if
end event

type st_2 from statictext within w_setup_options
integer x = 384
integer y = 356
integer width = 1408
integer height = 108
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "اعدادات الاتصال بقاعدة البيانات"
alignment alignment = center!
boolean focusrectangle = false
boolean righttoleft = true
end type

type st_4 from statictext within w_setup_options
integer x = 320
integer y = 80
integer width = 1618
integer height = 216
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

