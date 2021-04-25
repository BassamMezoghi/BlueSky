$PBExportHeader$w_app_update.srw
forward
global type w_app_update from w_popup
end type
type st_1 from statictext within w_app_update
end type
type pb_checkupdate from u_pb within w_app_update
end type
type hpb_1 from hprogressbar within w_app_update
end type
end forward

global type w_app_update from w_popup
integer width = 2757
integer height = 496
string title = "تحديث المنظومة"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean righttoleft = true
boolean center = true
event ue_download_percent pbm_custom01
st_1 st_1
pb_checkupdate pb_checkupdate
hpb_1 hpb_1
end type
global w_app_update w_app_update

type variables
n_wininet in_ftp
s_ftpdirlist istr_dirlist[]
Constant String is_initial_folder = ""
double idb_filesize = 1.0
string is_NewAppVer
String is_hdd_no,is_computer_name
end variables

forward prototypes
public function boolean wf_connect ()
public subroutine wf_disconnect ()
public function boolean wf_checkversion ()
public function boolean wf_downloadfile (string as_filename)
public function double of_getfiles (string as_file_name)
public subroutine of_createxmlfile ()
public subroutine wf_uploadfile (string as_file_name)
end prototypes

event ue_download_percent;TRY
String ls_msg
double db_res

if(idb_filesize = 0)Then idb_filesize = 1

db_res = wparam / idb_filesize

ls_msg = " تحميل " + String( db_res , "#0%" ) + " الى النهاية"

//this.SetMicroHelp(ls_msg)
st_1.text = ls_msg

hpb_1.position = Integer(db_res * 100)
CATCH(PbxRunTimeError re)
	MessageBox("",re.getmessage())
End Try
end event

public function boolean wf_connect ();String ls_server, ls_userid, ls_password, ls_result,ls_currentdir
Boolean lb_settings, lb_anonymous, lb_passive
Integer li_port
//n_cst_crypto lnv_crypt

//lnv_crypt = CREATE n_cst_crypto

ls_password  = ProfileString(gs_AppPath+"ftp.ini" , "ftp" ,  "password" , "BsT2oi8Ftp" )
ls_userid    = ProfileString(gs_AppPath+"ftp.ini" , "ftp" ,  "username" , "ftpuser" )
ls_server    = ProfileString(gs_AppPath+"ftp.ini" , "ftp" ,  "server" , "41.208.72.248" )

//ls_password  = lnv_crypt.DecryptData( ls_password ,  lnv_crypt.of_getmykey() ) 
//ls_userid = lnv_crypt.DecryptData( ls_userid , lnv_crypt.of_getmykey( ) )
//ls_server = lnv_crypt.DecryptData( ls_server , lnv_crypt.of_getmykey( ) )

//Destroy lnv_crypt

SetPointer(HourGlass!)
//FTP ini
ls_currentdir = gs_AppPath+"ftp.ini"

//FTP Information
li_port 			= 21
lb_passive 	= True

//Connect to FTP server
ls_result = in_ftp.of_ftp_InternetConnect(ls_server, ls_userid, ls_password, li_port, lb_passive)

If Len(ls_result) > 0 Then
//	MessageBox("خطاء", ls_result, StopSign!)
	st_1.text = "فشل الاتصال"
	Return False
End If

// restore current directory
//If Len(ls_currentdir) > 0 Then
//	in_ftp.of_ftp_SetCurrentDirectory(is_initial_folder+"/"+AppCode)
//End If

Return True

end function

public subroutine wf_disconnect ();of_createxmlfile()

in_ftp.of_ftp_writefile( gs_AppPath+"notes.xml" , "notes.xml" )

// disconnect from session
in_ftp.of_Disconnect_Session()
end subroutine

public function boolean wf_checkversion ();String ls_car,ls_cdbr
Boolean lb_res

ls_car	= ProfileString(gs_AppPath+"AppVersions.ini", "AppVersions", gs_AppVer, "1.0.0.0")
//Messagebox("from App version",ls_car)
if(ls_car = "1.0.0.0" )Then
	st_1.text = "لايوجد تحديث ارجو العودة في وقت لاحق"
	FileDelete(gs_AppPath+"AppVersions.ini")
	return False
end if

if(gnv_services.of_compar_application_version( gs_AppVer , ls_car) = 2 )Then
	FileDelete(gs_AppPath+"AppVersions.ini")
	is_NewAppVer = ls_car
	return True
end if

Return False
end function

public function boolean wf_downloadfile (string as_filename);String ls_pathname,ls_result

ls_pathname =  gs_AppPath+ as_filename//gs_AppPath+"download\"+ ls_filename

// download the file
ls_result = in_ftp.of_Ftp_ReadFile(as_filename, ls_pathname, Handle(This), 1024)

If ls_result = "" Then
	return True
Else
	return False
End If


end function

public function double of_getfiles (string as_file_name);TRY
	
	Constant ulong FILE_ATTRIBUTE_DIRECTORY = 16
	
	String ls_result, ls_curdir, ls_additem
	Integer li_maxfiles, li_file
	
	li_maxfiles = UpperBound(istr_dirlist)
	
	// 
	FOR li_file = 1 TO li_maxfiles
		
		If istr_dirlist[li_file].ul_Attributes <> FILE_ATTRIBUTE_DIRECTORY Then
			if(istr_dirlist[li_file].s_FileName = as_file_name)Then 
				return istr_dirlist[li_file].db_filesize
			end if		
		End If
		
	NEXT

CATCH(PBXRuntimeError re )
	MessageBox("",re.getMessage() )
	Return 1.0

END TRY
end function

public subroutine of_createxmlfile ();DataStore lds
Long ll_row

lds = Create DataStore
lds.DataObject = "d_ext_updatestatus"

if(FileExists ( gs_AppPath+"notes.xml" ))Then
	lds.ImportFile(gs_AppPath+"notes.xml")
else
	lds.SaveAs(gs_AppPath+"notes.xml", XML!, false)
end if

ll_row = lds.InsertRow( 0)

lds.setItem(ll_row, "computername" 	, gstr_user_info.computer_name )
lds.setItem(ll_row, "hddno" 				, gstr_user_info.hdd_serial_no )
lds.setItem(ll_row, "downloaddate" 	, gnv_services.uf_today( ) )
lds.setItem(ll_row, "Field_1" 			, is_NewAppVer )
//lds.setItem(ll_row, "Field_2" 			, gs_ProVer )

lds.SaveAs(gs_AppPath+"notes.xml", XML!, false)
end subroutine

public subroutine wf_uploadfile (string as_file_name);in_ftp.of_getsession( ) 

in_ftp.of_ftp_writefile( gs_AppPath+as_file_name , as_file_name )
end subroutine

on w_app_update.create
int iCurrent
call super::create
this.st_1=create st_1
this.pb_checkupdate=create pb_checkupdate
this.hpb_1=create hpb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.pb_checkupdate
this.Control[iCurrent+3]=this.hpb_1
end on

on w_app_update.destroy
call super::destroy
destroy(this.st_1)
destroy(this.pb_checkupdate)
destroy(this.hpb_1)
end on

event open;call super::open;//pb_checkupdate.event clicked( )
end event

type st_1 from statictext within w_app_update
integer x = 64
integer y = 28
integer width = 2647
integer height = 120
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
boolean righttoleft = true
end type

type pb_checkupdate from u_pb within w_app_update
integer x = 27
integer y = 168
integer width = 256
integer height = 224
integer taborder = 10
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\48x48\Earth.bmp"
string disabledname = "C:\Applications\icons\disabled\bmp\48x48\Earth.bmp"
end type

event clicked;call super::clicked;TRY
// download file
String ls_filename, ls_pathname, ls_result
Integer li_rtn
st_1.text = "...الاتصال بالخادم"

// connect to the server
If Not wf_Connect() Then 
	st_1.text ="فشل الاتصال بالخادم"
	ls_Result = "-"
	Return
end if

if(in_ftp.of_getsession( ) <=0 )then
	st_1.text ="فشل الاتصال بالخادم"
	ls_Result = "-"
	Return
end if

st_1.text = "...التأكد من وجود تحديث جديد للمنظومة"

ls_filename = "AppVersions.ini"

ls_pathname =  gs_AppPath + ls_filename

// download the file
ls_result = in_ftp.of_Ftp_ReadFile(ls_filename, ls_pathname, Handle(this), 1024)

If ls_result <> "" Then
	MessageBox("خطاء", ls_result, StopSign!)
	ls_Result = "-"
	Return
End If


//	in_ftp.of_ftp_SetCurrentDirectory("/Extractor")
//	ls_result = in_ftp.of_Ftp_ReadFile("extractor.exe.manifest"	, gs_AppPath+"extractor.exe.manifest"	, Handle(This), 1024)		
//	ls_result = in_ftp.of_Ftp_ReadFile("extractor.exe"				, gs_AppPath+"extractor.exe"				, Handle(This), 1024)
//	ls_result = in_ftp.of_Ftp_ReadFile("extractor.pbd"				, gs_AppPath+"extractor.pbd"				, Handle(This), 1024)	
//

//in_ftp.of_ftp_SetCurrentDirectory(is_initial_folder+"/"+AppCode)

//if(wf_checkversion())then
//	
//	hpb_1.position = 0
//
//	idb_filesize = of_getfiles(is_NewAppVer+".bst")
//	
//	ls_pathname =  gs_AppPath+ is_NewAppVer+".bst"
//	//make sure the file exists
//	if(not in_ftp.of_ftp_fileexists(is_NewAppVer+".txt"))Then 
//		st_1.text = "الملف المطلوب غير متوفر حالياً في الخادم ارجو المحاولة في وقت لاحق و شكرا"
//		return
//	end if
	
	// download the file
	ls_result = in_ftp.of_Ftp_ReadFile("test.txt", ls_pathname, Handle(This), 1024)

	If ls_result <> "" Then
		MessageBox("خطاء", ls_result, StopSign!)
	End If	
//else
//	ls_result = "-"
//end if

CATCH(PbxRunTimeError re)
	MessageBox("خطاء",re.getmessage())
	ls_Result = "-"
	return
FINALLY
	
	// disconnect from the server
	wf_Disconnect()
//	Messagebox("",ls_result)
	if(ls_result = "")Then
		gs_UpdateFile = "test.txt"//is_NewAppVer+".txt"
		if(Messagebox("تنبيه","لتركيب التحديث يجب اعادة تششغيل المنظومة ~nهل تريد اعادة التشغيل الان؟",Information!,YesNo!) = 1)Then			
			gnv_app.Event pfc_exit( )
		else
			Close(Parent)
		end if
	End if
END TRY

end event

type hpb_1 from hprogressbar within w_app_update
integer x = 311
integer y = 168
integer width = 2418
integer height = 216
unsignedinteger maxposition = 100
integer setstep = 1
end type

