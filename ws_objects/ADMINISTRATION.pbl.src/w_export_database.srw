$PBExportHeader$w_export_database.srw
forward
global type w_export_database from window
end type
type pb_2 from picturebutton within w_export_database
end type
type pb_1 from picturebutton within w_export_database
end type
type cbx_1 from checkbox within w_export_database
end type
type sle_1 from singlelineedit within w_export_database
end type
type gb_2 from groupbox within w_export_database
end type
type p_1 from picture within w_export_database
end type
end forward

global type w_export_database from window
integer width = 2075
integer height = 1168
boolean titlebar = true
string title = "تصدير قاعدة البيانات"
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
pb_2 pb_2
pb_1 pb_1
cbx_1 cbx_1
sle_1 sle_1
gb_2 gb_2
p_1 p_1
end type
global w_export_database w_export_database

type variables
String is_filename
end variables

forward prototypes
public function string of_remove_file_name (string ar_full_file_name)
end prototypes

public function string of_remove_file_name (string ar_full_file_name);long ll_len,ll_last_position

ll_len = LenA(ar_full_file_name)

ll_last_position = LastPos(ar_full_file_name , "\")

return MidA(ar_full_file_name , 1 , ll_last_position)
end function

on w_export_database.create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.cbx_1=create cbx_1
this.sle_1=create sle_1
this.gb_2=create gb_2
this.p_1=create p_1
this.Control[]={this.pb_2,&
this.pb_1,&
this.cbx_1,&
this.sle_1,&
this.gb_2,&
this.p_1}
end on

on w_export_database.destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.cbx_1)
destroy(this.sle_1)
destroy(this.gb_2)
destroy(this.p_1)
end on

event open;////lb_1.dirlist( "c:\" , 16384)
//// lb_1.DirList("c:\", 16400, st_1)
//lb_1.DirList("c:\", 16384, st_1)
end event

type pb_2 from picturebutton within w_export_database
integer x = 1541
integer y = 844
integer width = 256
integer height = 224
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\Applications\icons\hot\bmp\48x48\Turn off.bmp"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type pb_1 from picturebutton within w_export_database
integer x = 1797
integer y = 844
integer width = 256
integer height = 224
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\Applications\icons\hot\bmp\48x48\Pick.bmp"
alignment htextalign = left!
end type

event clicked;String ls_Syntax , ls_database,ls_path,ls_file_nm
String ls_expiry_dt,ls_key


ls_path = "C:\"

GetFolder( "الافضل لإدارة موارد الشركات", ls_path )

SetPointer(HourGlass!)
//lnv_crypt = CREATE n_cst_crypto

ls_database = SQLCA.database //ProfileString( gnv_app.of_getappinifile( ) , "Database" , "Database"   , "BS_SYSTEM")

ls_file_nm = String(today(),"mmddyyyy")+String(now(),"hhmmss")
sle_1.text = ls_path+"\"+ls_file_nm
//is_filename = st_1.text

ls_expiry_dt = ""
IF(cbx_1.checked)Then
	ls_expiry_dt = "RETAINDAYS = 5,"	
End if

ls_key= "Bassam S.Mezoghi"
ls_key = gnv_services.of_encrypt_password(ls_key)
 
ls_Syntax = "BACKUP DATABASE "+ls_database+" &
					TO  DISK = N'"+/*of_remove_file_name(is_filename)+ls_file_nm*/ ls_path+"\"+ls_file_nm+".bak"+"' &
					WITH &
					DESCRIPTION = N'"+ls_key+"',&
					NOFORMAT, &
					NOINIT,  &
					NAME = N'"+ls_file_nm+"', &
					SKIP, &
					STATS = 10;"
					

Disconnect Using SQLCA;

SQLCA.autocommit = True

Connect Using SQLCA;

Execute Immediate :ls_Syntax Using SQLCA;

IF(SQLCA.sqldbcode = 0)Then
   	SetPointer(Arrow!)
   	Messagebox("","تم التصدير بنجاح؟")
   	SetPointer(HourGlass!)
Else
	Messagebox("",SQLCA.sqlerrtext)
End if

Disconnect using SQLCA ;

SQLCA.autocommit = False

Connect using SQLCA;

SetPointer(Arrow!)
end event

type cbx_1 from checkbox within w_export_database
integer x = 18
integer y = 760
integer width = 1138
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
long textcolor = 8388608
long backcolor = 16777215
string text = "لتزامن قاعدة البيانات مع الادارة الرئيسية"
boolean righttoleft = true
end type

type sle_1 from singlelineedit within w_export_database
integer x = 27
integer y = 572
integer width = 1998
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_export_database
integer y = 488
integer width = 2053
integer height = 220
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "إسم الملف"
boolean righttoleft = true
end type

type p_1 from picture within w_export_database
integer x = 5
integer width = 2057
integer height = 400
boolean originalsize = true
string picturename = "C:\Applications\icons\banners\trendy_header_.bmp"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

