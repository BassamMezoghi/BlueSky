$PBExportHeader$w_store_splash.srw
forward
global type w_store_splash from w_splash
end type
type p_1 from picture within w_store_splash
end type
type dw_1 from u_dw within w_store_splash
end type
end forward

global type w_store_splash from w_splash
string tag = "0"
integer width = 2322
integer height = 1424
boolean center = true
integer transparency = 10
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = fadeanimation!
p_1 p_1
dw_1 dw_1
end type
global w_store_splash w_store_splash

on w_store_splash.create
int iCurrent
call super::create
this.p_1=create p_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_store_splash.destroy
call super::destroy
destroy(this.p_1)
destroy(this.dw_1)
end on

event open;
timer(SplashTimer,w_store_splash)
end event

event timer;
//if w_store_splash.tag = '1' then
	timer(0,w_store_splash)
//	open(w_store_frame)
	open(w_menu)
	close(w_store_splash)
//End if

//w_store_splash.tag = '1'
end event

type st_copyright from w_splash`st_copyright within w_store_splash
boolean visible = false
integer x = 5
integer y = 1368
integer width = 535
integer height = 44
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Blue Sky Technologies © 2012"
alignment alignment = left!
end type

type st_version from w_splash`st_version within w_store_splash
integer x = 777
integer y = 468
integer width = 768
integer height = 108
integer textsize = -16
fontcharset fontcharset = arabiccharset!
fontfamily fontfamily = anyfont!
string facename = "SC_OUHOD"
long textcolor = 8388608
long backcolor = 15780518
string text = "نسخة تجريبية"
alignment alignment = center!
end type

type st_application from w_splash`st_application within w_store_splash
boolean visible = false
integer x = 384
integer y = 52
integer width = 1627
fontcharset fontcharset = arabiccharset!
fontfamily fontfamily = anyfont!
string facename = "SC_OUHOD"
long textcolor = 8388608
long backcolor = 15780518
string text = "الأفضل لإدارة مـــــوارد الشركات"
alignment alignment = center!
end type

type gb_allaround from w_splash`gb_allaround within w_store_splash
boolean visible = false
integer x = 23
integer y = 12
integer width = 2263
integer height = 1396
end type

type ln_1 from w_splash`ln_1 within w_store_splash
integer beginy = 8
integer endx = 1326
integer endy = 8
end type

type ln_2 from w_splash`ln_2 within w_store_splash
boolean visible = false
integer beginy = 1412
integer endx = 2309
integer endy = 1412
end type

type ln_3 from w_splash`ln_3 within w_store_splash
boolean visible = false
integer beginx = 2304
integer beginy = 4
integer endx = 2304
integer endy = 1492
end type

type ln_4 from w_splash`ln_4 within w_store_splash
integer beginx = 5
integer beginy = 4
integer endx = 5
integer endy = 1456
end type

type p_splash from w_splash`p_splash within w_store_splash
boolean visible = false
integer x = 18
integer y = 12
integer width = 142
integer height = 340
boolean enabled = false
boolean originalsize = false
string picturename = "Blob!"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_store_splash
integer width = 2318
integer height = 1424
string picturename = "C:\Applications\icons\banners\summer-clouds.jpg"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_store_splash
integer width = 2322
integer height = 1424
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_background"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)

if(Not Demo)Then
	This.Modify("t_1.text=~'Blue Sky Technologies © ~'"+String(Year(today())))
	This.modify( "t_2.text=~""+gnv_app.iapp_object.displayname +"~"" )
	This.modify( "t_3.text=~""+gs_AppVer +"~"" )
//	This.modify( "t_user_info.text=~'  "+gstr_user_info.employee_name +"~  اهلا و سهلا بكم في'" )
end if
end event

