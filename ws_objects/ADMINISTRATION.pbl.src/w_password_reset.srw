$PBExportHeader$w_password_reset.srw
forward
global type w_password_reset from window
end type
type cb_close from u_cb within w_password_reset
end type
type cb_ok from u_cb within w_password_reset
end type
type st_3 from statictext within w_password_reset
end type
type st_2 from statictext within w_password_reset
end type
type sle_confirm from u_sle within w_password_reset
end type
type sle_password from u_sle within w_password_reset
end type
type gb_1 from groupbox within w_password_reset
end type
end forward

global type w_password_reset from window
integer width = 1655
integer height = 484
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
cb_close cb_close
cb_ok cb_ok
st_3 st_3
st_2 st_2
sle_confirm sle_confirm
sle_password sle_password
gb_1 gb_1
end type
global w_password_reset w_password_reset

on w_password_reset.create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.st_3=create st_3
this.st_2=create st_2
this.sle_confirm=create sle_confirm
this.sle_password=create sle_password
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_ok,&
this.st_3,&
this.st_2,&
this.sle_confirm,&
this.sle_password,&
this.gb_1}
end on

on w_password_reset.destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_confirm)
destroy(this.sle_password)
destroy(this.gb_1)
end on

type cb_close from u_cb within w_password_reset
integer x = 919
integer y = 356
integer height = 104
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خروج"
boolean cancel = true
end type

event clicked;call super::clicked;closeWithReturn(Parent , "N")
end event

type cb_ok from u_cb within w_password_reset
integer x = 1275
integer y = 356
integer height = 104
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "موافق"
boolean default = true
end type

event clicked;call super::clicked;String ls_password

IF trim(sle_password.text) = trim(sle_confirm.text) THEN  
     
		 ls_password = trim(sle_password.text) 
		 
		 IF POS(ls_password , " ") > 0  THEN
			MessageBox("تنبيه" , "يجب ان لا تحتوي كلمة السر على فراغ")
			Return 
		 END IF
		 
		 IF Len(ls_password) < 6 THEN 
			MessageBox( "تنبيه" , "يجب ان تتكون كلمة السر على الاقل من 6 خانات" )
			Return 
		 END IF
	 
	 	IF Match (ls_password , "[A-Za-z0-9]" ) THEN
	  
		  ls_password = gnv_services.of_encrypt_password( ls_password )
		  
		  UPDATE USERS 
		  SET PASSWORD = :ls_password , INCOME = 'N',LAST_MODIIFE_DT = getdate()
		  WHERE user_id = :gstr_user_info.login_id ;
	  
		  CloseWithReturn(Parent , "Y")

		ELSE
				
				MessageBox("تنبيه","يجب ان تكون كلمة السر~nباللغة الانجليزية او ارقام")		
				
		END IF
	 
ELSE
	
	MessageBox("تنبيه","كلمة السر الجديدةو التاكيد غير متساوين")

END IF

end event

type st_3 from statictext within w_password_reset
integer x = 1083
integer y = 212
integer width = 448
integer height = 68
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = ": تاكيد كلمة السر"
boolean focusrectangle = false
end type

type st_2 from statictext within w_password_reset
integer x = 1083
integer y = 88
integer width = 558
integer height = 68
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = ": كلمة السر الجديدة"
boolean focusrectangle = false
end type

type sle_confirm from u_sle within w_password_reset
integer x = 32
integer y = 196
integer width = 1047
integer height = 100
integer taborder = 30
boolean password = true
integer limit = 8
end type

type sle_password from u_sle within w_password_reset
integer x = 32
integer y = 72
integer width = 1047
integer height = 100
integer taborder = 20
boolean password = true
integer limit = 8
end type

type gb_1 from groupbox within w_password_reset
integer x = 9
integer width = 1623
integer height = 328
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long backcolor = 67108864
string text = "تغير كلمة السر"
boolean righttoleft = true
end type

