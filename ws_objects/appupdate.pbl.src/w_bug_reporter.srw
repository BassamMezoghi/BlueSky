$PBExportHeader$w_bug_reporter.srw
forward
global type w_bug_reporter from w_response
end type
type pb_2 from u_pb within w_bug_reporter
end type
type pb_1 from u_pb within w_bug_reporter
end type
type st_1 from statictext within w_bug_reporter
end type
type ddlb_1 from dropdownlistbox within w_bug_reporter
end type
type dw_1 from u_dw within w_bug_reporter
end type
end forward

global type w_bug_reporter from w_response
integer width = 4347
integer height = 2620
boolean righttoleft = true
boolean center = true
boolean ib_isupdateable = false
event ue_download_percent pbm_custom01
pb_2 pb_2
pb_1 pb_1
st_1 st_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_bug_reporter w_bug_reporter

type variables
n_wininet in_ftp
s_ftpdirlist istr_dirlist[]
Constant String is_initial_folder = ""
double idb_filesize = 1.0
string is_NewAppVer
String is_hdd_no,is_computer_name
end variables

forward prototypes
public subroutine of_createxmlfile ()
public function boolean wf_connect ()
public subroutine wf_disconnect ()
end prototypes

event ue_download_percent;TRY
String ls_msg
double db_res

if(idb_filesize = 0)Then idb_filesize = 1

db_res = wparam / idb_filesize

ls_msg = " تحميل " + String( db_res , "#0%" ) + " الى النهاية"

//this.SetMicroHelp(ls_msg)
//st_1.text = ls_msg

//hpb_1.position = Integer(db_res * 100)
CATCH(PbxRunTimeError re)
	MessageBox("",re.getmessage())
End Try
end event

public subroutine of_createxmlfile ();
end subroutine

public function boolean wf_connect ();String ls_server, ls_userid, ls_password, ls_result,ls_currentdir
Boolean lb_settings, lb_anonymous, lb_passive
Integer li_port

SetPointer(HourGlass!)
//FTP ini
ls_currentdir = gs_AppPath+"ftp.ini"

//FTP Information
ls_server  		= ProfileString(ls_currentdir , "ftp" ,  "server" , "ns1.onlydomains.net" )
ls_userid   		= ProfileString(ls_currentdir, "ftp" ,  "username" , "bassam" )
ls_password	= ProfileString(ls_currentdir, "ftp" ,  "password" , "er8AgPywA7nB" )
li_port 			= 21
lb_passive 	= True

//Connect to FTP server
ls_result = in_ftp.of_ftp_InternetConnect(ls_server, ls_userid, ls_password, li_port, lb_passive)

If Len(ls_result) > 0 Then
//	MessageBox("خطاء", ls_result, StopSign!)
//	st_1.text = "فشل الاتصال"
	Return False
End If

// restore current directory
If Len(ls_currentdir) > 0 Then
	in_ftp.of_ftp_SetCurrentDirectory(is_initial_folder+"/"+AppCode)
End If

Return True

end function

public subroutine wf_disconnect ();
// disconnect from session
in_ftp.of_Disconnect_Session()
end subroutine

on w_bug_reporter.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_bug_reporter.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

type pb_2 from u_pb within w_bug_reporter
integer x = 3794
integer y = 2304
integer width = 256
integer height = 224
integer taborder = 30
string text = ""
boolean default = true
string picturename = "C:\Applications\icons\hot\gif\48x48\Earth.gif"
string disabledname = "C:\Applications\icons\disabled\gif\48x48\Earth.gif"
end type

event clicked;call super::clicked;String ls_filename , ls_pathname , ls_result

// connect to the server
If Not wf_Connect() Then 
	MessageBox("خطاء","فشل الاتصال")
	return
end if

if(in_ftp.of_getsession( ) <=0 )then
	MessageBox("خطاء","فشل الاتصال")
	return
end if

ls_filename = "bugs.xml"
ls_pathname =  gs_AppPath + ls_filename

//download the file
ls_result = in_ftp.of_Ftp_ReadFile(ls_filename, ls_pathname, Handle(w_app_update), 1024)

If ls_result <> "" Then
	
	if(FileExists ( ls_pathname ))Then
		dw_1.ImportFile(ls_pathname)
	else
		dw_1.SaveAs(ls_pathname, XML!, false)
	end if
	
else
	dw_1.ImportFile(ls_pathname)
End If

wf_disconnect( )

This.enabled	= False
pb_1.enabled	= True

end event

type pb_1 from u_pb within w_bug_reporter
integer x = 4064
integer y = 2304
integer width = 256
integer height = 224
integer taborder = 20
boolean enabled = false
string text = ""
boolean originalsize = false
string picturename = "C:\Applications\icons\hot\gif\48x48\Update.gif"
string disabledname = "C:\Applications\icons\disabled\gif\48x48\Update.gif"
vtextalign vtextalign = multiline!
end type

event clicked;call super::clicked;//MessageBox("hello" , "before")
//MessageBox("", gs_AppPath+"bugs.xml")
//
dw_1.Accepttext( )

IF(dw_1.SaveAs(gs_AppPath+"bugs.xml", XML!, false ,EncodingUTF8!) = 1)Then

wf_connect( )

in_ftp.of_ftp_writefile( gs_AppPath+"bugs.xml" , "bugs.xml" )

wf_disconnect( )


This.enabled	= False
pb_2.enabled	= True
else
	MessageBox("","خطاء اثناء حفظ الملف")
end if
end event

type st_1 from statictext within w_bug_reporter
integer x = 3598
integer y = 68
integer width = 366
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": حالة البلاغ"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_bug_reporter
integer x = 370
integer y = 48
integer width = 3214
integer height = 728
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = true
boolean sorted = false
string item[] = {"جديد","غير واضح","مقبول","تحت الاجراء","إنتهاء"}
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

event selectionchanged;if(index< 1)Then 
	dw_1.SetFilter( "" )	
else
	dw_1.SetFilter( "ticket_status = '"+String(index)+"'" )
end if

dw_1.Filter( )
end event

event constructor;This.selectitem( 1 )
end event

type dw_1 from u_dw within w_bug_reporter
integer y = 196
integer width = 4320
integer height = 2088
integer taborder = 10
string dataobject = "d_ext_bugs"
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;if(Not pb_1.enabled)Then return

if(dwo.name = "b_add")Then
This.event pfc_insertrow( )
return
end if

if(dwo.name = "b_delete")Then
This.event pfc_deleterow( )
return
end if

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;This.SetItem(al_row , "user_nm"			, gstr_user_info.login_id )
This.SetItem(al_row , "active_fg"			, "Y" )
This.SetItem(al_row , "ticket_status"		, "1" )
This.SetItem(al_row , "appcode"			,  AppCode)
This.SetItem(al_row, "computer_nm" 	, gstr_user_info.computer_name )
This.SetItem(al_row, "hddno" 				, gstr_user_info.hdd_serial_no )
This.SetItem(al_row, "ticket_dt" 			, gnv_services.uf_today( ) )
This.SetItem(al_row, "appver" 				, is_NewAppVer )
This.SetItem(al_row , "ticket_no"			, string(gnv_services.uf_today( ) , "ddmmyyhhmmss" ) )
end event

