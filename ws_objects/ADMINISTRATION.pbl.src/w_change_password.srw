$PBExportHeader$w_change_password.srw
forward
global type w_change_password from window
end type
type cb_close from u_cb within w_change_password
end type
type cb_ok from u_cb within w_change_password
end type
type st_4 from statictext within w_change_password
end type
type st_3 from statictext within w_change_password
end type
type st_2 from statictext within w_change_password
end type
type st_1 from statictext within w_change_password
end type
type sle_confirm from u_sle within w_change_password
end type
type sle_password from u_sle within w_change_password
end type
type sle_current_password from u_sle within w_change_password
end type
type gb_1 from groupbox within w_change_password
end type
end forward

global type w_change_password from window
integer width = 1591
integer height = 796
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
cb_close cb_close
cb_ok cb_ok
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_confirm sle_confirm
sle_password sle_password
sle_current_password sle_current_password
gb_1 gb_1
end type
global w_change_password w_change_password

on w_change_password.create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_confirm=create sle_confirm
this.sle_password=create sle_password
this.sle_current_password=create sle_current_password
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_ok,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_confirm,&
this.sle_password,&
this.sle_current_password,&
this.gb_1}
end on

on w_change_password.destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_confirm)
destroy(this.sle_password)
destroy(this.sle_current_password)
destroy(this.gb_1)
end on

type cb_close from u_cb within w_change_password
integer x = 832
integer y = 644
integer height = 108
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خروج"
end type

event clicked;call super::clicked;close(Parent)
end event

type cb_ok from u_cb within w_change_password
integer x = 1189
integer y = 644
integer height = 108
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "موافق"
end type

event clicked;call super::clicked;String ls_password,ls_cpass

SELECT PASSWORD
INTO   :ls_password
FROM   users
WHERE user_id = :gstr_user_info.login_id ;

ls_cpass = sle_current_password.text 

IF gnv_services.of_decrypt( ls_password ) <> ls_cpass THEN

	MessageBox("تنبيه" , "كلمة المرور القديمة غير صحيحة")
	Return

END IF


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
		  SET PASSWORD = :ls_password ,last_modified_dt = getdate()
		  WHERE user_id = :gstr_user_info.login_id ;
	  
		  CloseWithReturn(Parent , "Y")

		ELSE
				
			MessageBox("تنبيه","يجب ان تكون كلمة السر~nباللغة الانجليزية او ارقام")		
				
		END IF
	 
ELSE
	
	MessageBox("تنبيه","كلمة السر الجديدةو التاكيد غير متساوين")

END IF

end event

type st_4 from statictext within w_change_password
integer x = 69
integer y = 488
integer width = 1385
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 8388608
long backcolor = 134217752
string text = "كلمة السر يجب ان تكون باللغة الانجليزية"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_change_password
integer x = 1083
integer y = 352
integer width = 448
integer height = 68
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 8388608
long backcolor = 67108864
string text = ": تاكيد كلمة السر"
boolean focusrectangle = false
end type

type st_2 from statictext within w_change_password
integer x = 1083
integer y = 220
integer width = 448
integer height = 68
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 8388608
long backcolor = 67108864
string text = ": كلمة السر الجديدة"
boolean focusrectangle = false
end type

type st_1 from statictext within w_change_password
integer x = 1083
integer y = 96
integer width = 448
integer height = 68
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 8388608
long backcolor = 67108864
string text = ": كلمة السر الحالية"
boolean focusrectangle = false
end type

type sle_confirm from u_sle within w_change_password
integer x = 32
integer y = 328
integer width = 1047
integer height = 100
integer taborder = 30
boolean password = true
integer limit = 8
end type

type sle_password from u_sle within w_change_password
integer x = 32
integer y = 204
integer width = 1047
integer height = 100
integer taborder = 20
boolean password = true
integer limit = 8
end type

type sle_current_password from u_sle within w_change_password
integer x = 32
integer y = 80
integer width = 1047
integer height = 100
integer taborder = 10
boolean password = true
integer limit = 8
end type

type gb_1 from groupbox within w_change_password
integer x = 9
integer width = 1559
integer height = 468
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 8388608
long backcolor = 67108864
string text = "تغير كلمة السر"
boolean righttoleft = true
end type

