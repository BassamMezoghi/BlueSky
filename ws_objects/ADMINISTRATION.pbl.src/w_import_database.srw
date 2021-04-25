$PBExportHeader$w_import_database.srw
forward
global type w_import_database from window
end type
type pb_2 from picturebutton within w_import_database
end type
type pb_1 from picturebutton within w_import_database
end type
type p_1 from picture within w_import_database
end type
type sle_file_size from lol_sle within w_import_database
end type
type st_7 from lol_st within w_import_database
end type
type sle_created_dt from lol_sle within w_import_database
end type
type st_6 from lol_st within w_import_database
end type
type sle_server_nm from lol_sle within w_import_database
end type
type st_5 from lol_st within w_import_database
end type
type sle_expiry from lol_sle within w_import_database
end type
type st_4 from lol_st within w_import_database
end type
type sle_backup_file from lol_sle within w_import_database
end type
type st_3 from lol_st within w_import_database
end type
type st_2 from lol_st within w_import_database
end type
type sle_db_nm from lol_sle within w_import_database
end type
type st_1 from statictext within w_import_database
end type
type gb_2 from groupbox within w_import_database
end type
type gb_1 from groupbox within w_import_database
end type
end forward

global type w_import_database from window
integer width = 2080
integer height = 1588
boolean titlebar = true
string title = "توريد قاعدة بيانات"
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
pb_2 pb_2
pb_1 pb_1
p_1 p_1
sle_file_size sle_file_size
st_7 st_7
sle_created_dt sle_created_dt
st_6 st_6
sle_server_nm sle_server_nm
st_5 st_5
sle_expiry sle_expiry
st_4 st_4
sle_backup_file sle_backup_file
st_3 st_3
st_2 st_2
sle_db_nm sle_db_nm
st_1 st_1
gb_2 gb_2
gb_1 gb_1
end type
global w_import_database w_import_database

type variables
String is_filename
end variables

forward prototypes
public function string fnremoveextention (string ar_file_nm)
public function integer fncheckrestorheader (ref datastore ar_lds, string ar_db_name, string ar_file_name)
end prototypes

public function string fnremoveextention (string ar_file_nm);Long ll_len,ll_pos

ll_len = LenA(ar_file_nm)
ll_pos = PosA(ar_file_nm,".") - 1

Return MidA(ar_file_nm , 1, ll_pos )
end function

public function integer fncheckrestorheader (ref datastore ar_lds, string ar_db_name, string ar_file_name);Datetime ld_Expiry_dt
String ls_descrept,ls_db_nm , ls_file_nm
//n_cst_crypto lnv_crypt

//lnv_crypt = CREATE n_cst_crypto

ld_Expiry_dt = ar_lds.GetItemDatetime(1,"expirationdate")
IF(not IsNull(ld_Expiry_dt))Then
	IF( ld_Expiry_dt <= gnv_services.uf_today( ) )Then
		Return -1
	End if
End if

ls_descrept = gnv_services.of_decrypt(ar_lds.GetItemString(1 , "backupdescription")) //lnv_crypt.decryptdata(  , gnv_app.of_getmykey( ) )
//Destroy lnv_crypt
if(ls_descrept <> "Bassam S.Mezoghi" or IsNull(ls_descrept))Then
	Return -2
End if

ls_db_nm = ar_lds.GetItemString(1 , "databasename")

IF(ar_db_name <> ls_db_nm)Then
	Return -3
End if

ls_file_nm = ar_lds.GetItemString(1 , "backupname")

IF(ls_file_nm <> fnremoveextention(ar_file_name))Then
	Return -4
End if

Return 1
end function

on w_import_database.create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.p_1=create p_1
this.sle_file_size=create sle_file_size
this.st_7=create st_7
this.sle_created_dt=create sle_created_dt
this.st_6=create st_6
this.sle_server_nm=create sle_server_nm
this.st_5=create st_5
this.sle_expiry=create sle_expiry
this.st_4=create st_4
this.sle_backup_file=create sle_backup_file
this.st_3=create st_3
this.st_2=create st_2
this.sle_db_nm=create sle_db_nm
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.pb_2,&
this.pb_1,&
this.p_1,&
this.sle_file_size,&
this.st_7,&
this.sle_created_dt,&
this.st_6,&
this.sle_server_nm,&
this.st_5,&
this.sle_expiry,&
this.st_4,&
this.sle_backup_file,&
this.st_3,&
this.st_2,&
this.sle_db_nm,&
this.st_1,&
this.gb_2,&
this.gb_1}
end on

on w_import_database.destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.p_1)
destroy(this.sle_file_size)
destroy(this.st_7)
destroy(this.sle_created_dt)
destroy(this.st_6)
destroy(this.sle_server_nm)
destroy(this.st_5)
destroy(this.sle_expiry)
destroy(this.st_4)
destroy(this.sle_backup_file)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_db_nm)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type pb_2 from picturebutton within w_import_database
integer x = 1550
integer y = 1264
integer width = 256
integer height = 224
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\bmp\48x48\Turn off.bmp"
alignment htextalign = left!
end type

event clicked;close(Parent)
end event

type pb_1 from picturebutton within w_import_database
integer x = 1797
integer y = 1264
integer width = 256
integer height = 224
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\bmp\48x48\Put away.bmp"
alignment htextalign = left!
end type

event clicked;	String ls_fullname,ls_filename,ls_dbms
	String ls_provider , ls_appinifile
	Long li_open
	Int li_res
	String ls_Syntax , ls_database

	gstr_user_info.Restor_status = False
	li_open = GetFileOpenName("تحميل النسخة الاحتياطية", ls_fullname, ls_filename,".bak","*.bak")
	
	st_1.text = ls_fullname
	
	SetPointer(HourGlass!)
	
	IF li_open  < 1 Then 
		
		Return	
		
	Else
		
//		DataStore lds
//		lds = Create DataStore
//		lds.DataObject = "d_sp_backupinfo"
//		lds.SetTransobject( SQLCA )
//		
//		If(	lds.retrieve(ls_fullname) > 0 AND lds.rowcount( ) > 0 )Then			
//		
			ls_database = SQLCA.database
//			li_res = fncheckrestorheader(lds,ls_database,ls_filename)
//			choose case li_res
//				case -1
//						MessageBox("تنبيه","الملف منتهي الصلاحية لايمكن توريدة~nيجب ان يتم التوريد في اقل من خمسة ايام من تاريخ التصدير")
//						return
//				case -2
//						MessageBox("تنبيه","الملف غير موثوق المصدر")
//						return
//				case -3
//						MessageBox("تنبيه","اسم قاعدة البيانات المسجلة في الملف غير متطابقة مع قاعدة البيانات الحالية")
//						return
//				case -4
//						MessageBox("تنبيه","تم تغير اسم الملف يدويا~nالملف لم يعد محل للثقة")
//						return
//			end choose						
//			
//			sle_db_nm.text = lds.GetItemstring(1 , "Databasename")
//			sle_backup_file.text = lds.GetItemstring(1 , "backupname")
//			sle_server_nm.text = lds.GetItemstring(1 , "servername")
//			sle_expiry.text = string(lds.GetItemDatetime(1 , "expirationdate"),"yyyy/mm/dd hh:mm:ss")
//			sle_created_dt.text = string(lds.GetItemDatetime(1 , "databasecreationdate"),"yyyy/mm/dd hh:mm:ss")
//			sle_file_size.text = String(lds.GetItemDecimal(1 , "backupsize"))
//////////////////////////////////////////////////////////////////////////////////
			ls_Syntax = "RESTORE DATABASE "+ls_database+" FROM  DISK = N'"+ls_fullname+"' WITH  FILE = 1, NOUNLOAD,  REPLACE, STATS = 10"

			ls_appinifile 	= gnv_app.of_getappinifile( ) 
			ls_provider		= ProfileString(ls_appinifile, "Database", "Provider","SQLNCLI10")
			
			Disconnect using SQLCA;
			
			ls_dbms = SQLCA.dbms
			
			SQLCA.DBParm 		= "PROVIDER='"+ls_provider+"',DATASOURCE='" +SQLCA.servername  +"',PROVIDERSTRING='DataBase=" +"master" + "'" 
			SQLCA.Autocommit = True
			
			Connect Using SQLCA;

			IF(SQLCA.sqldbcode < 0)Then
			
				MessageBox("",SQLCA.sqlerrtext )
			
			End if

			Execute Immediate :ls_Syntax Using SQLCA;

			IF(SQLCA.sqlcode = 0)Then
				   SetPointer(Arrow!)
				   Messagebox("تنبيه","تم التوريد بنجاح؟",Information!)
				   gstr_user_info.Restor_status = True				   
			Else				   
				   MessageBox( "" , SQLCA.sqlerrtext )
			End if

			Disconnect using SQLCA;
		
			SQLCA.dbms   		= ls_dbms
			SQLCA.autocommit 	= False

			Connect using SQLCA;

			SetPointer(Arrow!)
/////////////////////////////////////////////////////////////////////////////////

	//	End if
			
	End if
end event

type p_1 from picture within w_import_database
integer width = 2057
integer height = 400
boolean originalsize = true
string picturename = "C:\Applications\icons\banners\trendy_header_.bmp"
boolean focusrectangle = false
end type

type sle_file_size from lol_sle within w_import_database
integer x = 46
integer y = 1120
integer width = 613
integer height = 76
integer taborder = 80
long backcolor = 16777215
boolean displayonly = true
end type

type st_7 from lol_st within w_import_database
integer x = 407
integer y = 1044
integer width = 256
long textcolor = 8388608
long backcolor = 16777215
string text = "حجم الملف"
alignment alignment = center!
end type

type sle_created_dt from lol_sle within w_import_database
integer x = 731
integer y = 1120
integer width = 613
integer height = 76
integer taborder = 70
long backcolor = 16777215
boolean displayonly = true
end type

type st_6 from lol_st within w_import_database
integer x = 1024
integer y = 1044
integer width = 347
long textcolor = 8388608
long backcolor = 16777215
string text = "تاريخ التكوين"
alignment alignment = center!
end type

type sle_server_nm from lol_sle within w_import_database
integer x = 1403
integer y = 1120
integer width = 613
integer height = 76
integer taborder = 60
long backcolor = 16777215
boolean displayonly = true
end type

type st_5 from lol_st within w_import_database
integer x = 1769
integer y = 1044
integer width = 261
long textcolor = 8388608
long backcolor = 16777215
string text = "اسم الخادم"
alignment alignment = center!
end type

type sle_expiry from lol_sle within w_import_database
integer x = 46
integer y = 908
integer width = 613
integer height = 76
integer taborder = 60
long backcolor = 16777215
boolean displayonly = true
end type

type st_4 from lol_st within w_import_database
integer x = 338
integer y = 832
integer width = 370
long textcolor = 8388608
long backcolor = 16777215
string text = "تاريخ الصلاحية"
alignment alignment = center!
end type

type sle_backup_file from lol_sle within w_import_database
integer x = 731
integer y = 908
integer width = 613
integer height = 76
integer taborder = 60
long backcolor = 16777215
boolean displayonly = true
end type

type st_3 from lol_st within w_import_database
integer x = 946
integer y = 832
integer width = 398
long textcolor = 8388608
long backcolor = 16777215
string text = "اسم ملف الاحتياطي"
alignment alignment = center!
end type

type st_2 from lol_st within w_import_database
integer x = 1623
integer y = 832
integer width = 398
long textcolor = 8388608
long backcolor = 16777215
string text = "اسم قاعدة البيانات"
end type

type sle_db_nm from lol_sle within w_import_database
integer x = 1403
integer y = 908
integer width = 613
integer height = 76
integer taborder = 50
long backcolor = 16777215
boolean displayonly = true
end type

type st_1 from statictext within w_import_database
integer x = 46
integer y = 564
integer width = 1979
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_import_database
integer x = 14
integer y = 484
integer width = 2034
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

type gb_1 from groupbox within w_import_database
integer x = 14
integer y = 724
integer width = 2034
integer height = 528
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "  معلومات اضافية  "
boolean righttoleft = true
end type

