$PBExportHeader$tp_email_settings.sru
forward
global type tp_email_settings from u_cst_tabpage
end type
type rb_tls from radiobutton within tp_email_settings
end type
type rb_ssl from radiobutton within tp_email_settings
end type
type rb_none from radiobutton within tp_email_settings
end type
type st_5 from statictext within tp_email_settings
end type
type cbx_smtpauth from checkbox within tp_email_settings
end type
type st_4 from statictext within tp_email_settings
end type
type st_3 from statictext within tp_email_settings
end type
type st_2 from statictext within tp_email_settings
end type
type st_1 from statictext within tp_email_settings
end type
type sle_password from singlelineedit within tp_email_settings
end type
type sle_userid from singlelineedit within tp_email_settings
end type
type sle_port from singlelineedit within tp_email_settings
end type
type sle_server from singlelineedit within tp_email_settings
end type
end forward

global type tp_email_settings from u_cst_tabpage
integer width = 2240
integer height = 1520
rb_tls rb_tls
rb_ssl rb_ssl
rb_none rb_none
st_5 st_5
cbx_smtpauth cbx_smtpauth
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_password sle_password
sle_userid sle_userid
sle_port sle_port
sle_server sle_server
end type
global tp_email_settings tp_email_settings

on tp_email_settings.create
int iCurrent
call super::create
this.rb_tls=create rb_tls
this.rb_ssl=create rb_ssl
this.rb_none=create rb_none
this.st_5=create st_5
this.cbx_smtpauth=create cbx_smtpauth
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_password=create sle_password
this.sle_userid=create sle_userid
this.sle_port=create sle_port
this.sle_server=create sle_server
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tls
this.Control[iCurrent+2]=this.rb_ssl
this.Control[iCurrent+3]=this.rb_none
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.cbx_smtpauth
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.sle_password
this.Control[iCurrent+11]=this.sle_userid
this.Control[iCurrent+12]=this.sle_port
this.Control[iCurrent+13]=this.sle_server
end on

on tp_email_settings.destroy
call super::destroy
destroy(this.rb_tls)
destroy(this.rb_ssl)
destroy(this.rb_none)
destroy(this.st_5)
destroy(this.cbx_smtpauth)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.sle_userid)
destroy(this.sle_port)
destroy(this.sle_server)
end on

event constructor;call super::constructor;DataStore  ds
//n_cst_crypto lnv_crypt 
String ls_crypto

//lnv_crypt = CREATE n_cst_crypto 

ds = Create DataStore
ds.DataObject = "d_email_settings"
ds.SetTransobject( SQLCA )
ds.retrieve( )

IF ds.Rowcount( ) > 0 THEN
	
	IF ds.GetItemString(1 , "char_val") = "N" THEN
		cbx_smtpauth.checked = False
	ELSE
		cbx_smtpauth.checked = True
	END IF
	
	//MessageBox("N" , ds.GetItemString(2 , "char_val") )
	ls_crypto = trim(ds.GetItemString(2 , "char_val"))
	
	Choose Case upper(ls_crypto) 
		case "N"
			rb_none.checked 	= True
		case "S"
			rb_ssl.checked = True
		case "T"
			rb_tls.checked = True
	END Choose
	
	sle_server.text = ds.GetitemString(1 , "string_val")
	sle_port.text = String(ds.GetitemNumber(1 , "int_val"))
	sle_userid.text = ds.GetItemString(2 , "string_val")
	sle_password.text = gnv_services.of_decrypt(ds.GetItemString(3 , "string_val"))//lnv_crypt.decryptdata(  , lnv_crypt.of_getmykey( ))

END IF

Destroy ds;
//Destroy lnv_crypt;
end event

type rb_tls from radiobutton within tp_email_settings
integer x = 238
integer y = 1172
integer width = 457
integer height = 84
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TLS"
end type

type rb_ssl from radiobutton within tp_email_settings
integer x = 238
integer y = 1068
integer width = 457
integer height = 84
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SSL"
end type

type rb_none from radiobutton within tp_email_settings
integer x = 238
integer y = 964
integer width = 457
integer height = 84
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "None"
boolean checked = true
end type

type st_5 from statictext within tp_email_settings
integer x = 73
integer y = 876
integer width = 928
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMTP Server Encryption Type:"
boolean focusrectangle = false
end type

type cbx_smtpauth from checkbox within tp_email_settings
integer x = 82
integer y = 716
integer width = 1426
integer height = 84
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMTP Server requires userid/password"
boolean checked = true
end type

type st_4 from statictext within tp_email_settings
integer x = 23
integer y = 500
integer width = 352
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password:"
boolean focusrectangle = false
end type

type st_3 from statictext within tp_email_settings
integer x = 41
integer y = 360
integer width = 315
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "User ID:"
boolean focusrectangle = false
end type

type st_2 from statictext within tp_email_settings
integer x = 41
integer y = 220
integer width = 261
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Port:"
boolean focusrectangle = false
end type

type st_1 from statictext within tp_email_settings
integer x = 41
integer y = 80
integer width = 430
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMTP Server: "
boolean focusrectangle = false
end type

type sle_password from singlelineedit within tp_email_settings
integer x = 475
integer y = 488
integer width = 1125
integer height = 92
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_userid from singlelineedit within tp_email_settings
integer x = 475
integer y = 348
integer width = 1125
integer height = 92
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_port from singlelineedit within tp_email_settings
integer x = 475
integer y = 208
integer width = 338
integer height = 92
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_server from singlelineedit within tp_email_settings
integer x = 475
integer y = 68
integer width = 1125
integer height = 92
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

