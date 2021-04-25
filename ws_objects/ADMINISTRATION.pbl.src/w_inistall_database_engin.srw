$PBExportHeader$w_inistall_database_engin.srw
forward
global type w_inistall_database_engin from window
end type
type cb_3 from commandbutton within w_inistall_database_engin
end type
type cb_2 from commandbutton within w_inistall_database_engin
end type
type dw_1 from u_dw within w_inistall_database_engin
end type
type st_2 from statictext within w_inistall_database_engin
end type
type st_1 from statictext within w_inistall_database_engin
end type
type p_1 from picture within w_inistall_database_engin
end type
type cb_1 from commandbutton within w_inistall_database_engin
end type
end forward

global type w_inistall_database_engin from window
integer width = 4128
integer height = 2420
windowtype windowtype = response!
long backcolor = 15780518
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
integer transparency = 3
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
st_2 st_2
st_1 st_1
p_1 p_1
cb_1 cb_1
end type
global w_inistall_database_engin w_inistall_database_engin

type prototypes
FUNCTION ulong GetFileVersionInfoSizeW ( REF string lpFilename, REF ulong lpdwHandle )  LIBRARY "version.dll"

FUNCTION integer GetFileVersionInfoW &
   ( REF string lpFilename, REF ulong lpdwHandle, ulong dwLen, &
     REF string lpData )  &
   LIBRARY "version.dll"

FUNCTION boolean VerQueryValueW &
   ( REF string lpBlock, string lpSubBlock, REF long lpBuffer, &
     REF uint puLen )  &
    LIBRARY "version.dll"

SUBROUTINE CopyMemory &
   ( REF string d, long s, long l )  &
   LIBRARY "kernel32.dll"  &
   ALIAS FOR RtlMoveMemory
	
FUNCTION boolean ExitWindowsEx(uint dwReserved, uint uReserved) LIBRARY "User32.dll"
	
end prototypes

type variables
String is_Step
end variables

forward prototypes
public function boolean of_windowsinstaller ()
public subroutine of_steps (string ar_step)
public function string of_checkdb ()
public function string of_unzip ()
public function boolean of_checkrequirment ()
public function boolean of_checkrequirments (integer ar_item)
end prototypes

public function boolean of_windowsinstaller ();String ls_path, ls_file, ls_test
DateTime ldt_ret
OLEObject obj_shell, obj_folder, obj_item
String as_filename = "C:\Windows\System32\msi.dll"

obj_shell = CREATE OLEObject
obj_shell.ConnectToNewObject( 'shell.application' )

ls_path = Left( as_filename, LastPos( as_filename, "\" ) )
ls_file = Mid( as_filename, LastPos( as_filename, "\" ) + 1 )

IF FileExists( as_filename ) THEN
    obj_folder = obj_shell.NameSpace( ls_path )
    
    IF IsValid( obj_folder ) THEN
        obj_item = obj_folder.ParseName( ls_file )
        
        IF IsValid( obj_item ) THEN
            ls_test = obj_folder.GetDetailsOf( obj_item, 32 )
       //     ldt_ret = DateTime( ls_test )
        END IF
    END IF
END IF

DESTROY obj_shell
DESTROY obj_folder
DESTROY obj_item

MessageBox("",ls_test)

RETURN False
end function

public subroutine of_steps (string ar_step);/*************************************/
String ls_fname, ls_msg,ls_title
Long ll_rc,ll_row
Boolean lb_rc,lb_status
n_runandwait in_rwait

SetPointer(HourGlass!)

/**********************************************************/

choose case ar_step
	case "1"
		RegistryGet( "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "PROCESSOR_ARCHITECTURE", RegString!, ls_title)
		
		lb_status = of_checkrequirment()
		
		if(not lb_status)Then
			if(	MessageBox("تنبيه","هل تريد تركيب البرامج الناقصة؟",information!,yesno!) = 1)Then
				if(ls_title = "x86")Then				
					if(dw_1.GetItemString(1 , "status") = "F")Then
						ls_fname = "wusa ~""+gs_AppPath+"INSTMSI45.MSU~" /QUIET /NORESTART"						
						ll_rc = in_rwait.of_run(ls_fname, Hide!)
						of_checkrequirments(1)
					end if
				
					if(dw_1.GetItemString(2 , "status") = "F")Then
						ls_fname = gs_AppPath+"dotnetfx35sp1.exe /q:a /c:~"setup.exe /q /norestart~""
						ll_rc = in_rwait.of_run(ls_fname, Hide!)
						of_checkrequirments(2)
					end if

					if(dw_1.GetItemString(3 , "status") = "F")Then						
						ls_fname = "wusa ~""+gs_AppPath+"Windows6.0-KB928439-x86.msu~" /QUIET /NORESTART"
						ll_rc = in_rwait.of_run(ls_fname, Hide!)
						of_checkrequirments(3)
					end if
										
				else
					if(dw_1.GetItemString(1 , "status") = "F")Then
						ls_fname = "wusa ~""+gs_AppPath+"INSTMSI45-x64.MSU~" /QUIET /NORESTART"						
						ll_rc = in_rwait.of_run(ls_fname, Hide!)
						of_checkrequirments(1)
					end if
				
					if(dw_1.GetItemString(2 , "status") = "F")Then
						ls_fname = gs_AppPath+"dotnetfx35sp1.exe /q:a /c:~"setup.exe /q /norestart~""
						ll_rc = in_rwait.of_run(ls_fname, Hide!)
						of_checkrequirments(2)
					end if

					if(dw_1.GetItemString(3 , "status") = "F")Then						
						ls_fname = "wusa ~""+gs_AppPath+"Windows6.0-KB928439-x64.msu~" /QUIET /NORESTART"
						ll_rc = in_rwait.of_run(ls_fname, Hide!)
						of_checkrequirments(3)
					end if
				end if					
			end if		
		end if
		
		if(not lb_status)Then
			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,"تعذر تركيب البرامج الملحقة")
			dw_1.SetItem(ll_row , "status" 		,	"D")
		else
			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,"تم تركيب البرامج الضرورية لتركيب محرك قاعدة البيانات")
			dw_1.SetItem(ll_row , "status" 		,	"D")			
		end if
		/**********************************************************/		
		if(not lb_status)then
			return
		End if
		
		if(ls_title = "x86")Then
			ls_fname = gs_AppPath+"SQLEXPRWT_x86_ENU.exe /QS /ACTION=~"Install~" /IACCEPTSQLSERVERLICENSETERMS /ERRORREPORTING=~"1~" /FEATURES=SQLEngine,Tools /INSTANCENAME=~"BSTSRVR~" /AGTSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /AGTSVCSTARTUPTYPE=~"Automatic~" /ENABLERANU /SAPWD=~""+gs_password+"~" /SECURITYMODE=~"SQL~" /SQLCOLLATION=~"Arabic_CI_AS~" /SQLSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /SQLSVCSTARTUPTYPE=~"Automatic~" /ADDCURRENTUSERASSQLADMIN=~"True~" /NPENABLED=~"1~" /TCPENABLED=~"1~""
		else
			ls_fname = gs_AppPath+"SQLEXPRWT_x64_ENU.exe /QS /ACTION=~"Install~" /IACCEPTSQLSERVERLICENSETERMS /ERRORREPORTING=~"1~" /FEATURES=SQLEngine,Tools /INSTANCENAME=~"BSTSRVR~" /AGTSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /AGTSVCSTARTUPTYPE=~"Automatic~" /ENABLERANU /SAPWD=~""+gs_password+"~" /SECURITYMODE=~"SQL~" /SQLCOLLATION=~"Arabic_CI_AS~" /SQLSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /SQLSVCSTARTUPTYPE=~"Automatic~" /ADDCURRENTUSERASSQLADMIN=~"True~" /NPENABLED=~"1~" /TCPENABLED=~"1~""	
		end if	

		ll_row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_row , "title" 		,	"تركيب محرك قاعدة البيانات")
		dw_1.SetItem(ll_row , "status" 		,	"P")
		
		for ll_rc = 1 to 1000
			//delay
		next
		
		ll_rc = in_rwait.of_run(ls_fname, Hide!)
		
		if(ll_rc >= 0)Then
			dw_1.SetItem(ll_row , "status" 		,	"D")
			lb_rc = ExitWindowsEx(0,0) // Zero's tell it to shut down immediately.
		else
			dw_1.SetItem(ll_row , "status" 		,	"F")

			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,	"تركيب قاعدة البيانات")
			dw_1.SetItem(ll_row , "status" 		,	"F")

			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,	"حذف الملفات المؤقتة")
			dw_1.SetItem(ll_row , "status" 		,	"F")			

			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,"تعذر تركيب البرامج الملحقة")
			dw_1.SetItem(ll_row , "status" 		,	"D")
			
		end if
	case "2"

		ll_row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_row , "title" 		,	"تركيب قاعدة البيانات")
		dw_1.SetItem(ll_row , "status" 		,	"P")

		if(of_unzip() = "F")Then
			dw_1.SetItem(ll_row , "status" 		,	"F")
			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,	"حذف الملفات المؤقتة")
			dw_1.SetItem(ll_row , "status" 		,	"F")
			ll_row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_row , "title" 		,	"تم تركيب البرنامج بنجاح")
			dw_1.SetItem(ll_row , "status" 		,	"F")
			SetPointer(Arrow!)
			return
		end if
		
		//Installation Done

		ls_fname = 	"sqlcmd -S (local)\BSTSRVR -U sa -P "+gs_password+" -d master -i ~""+gs_AppPath+"MainLocationScript.sql~" -o ~""+gs_AppPath+"result.txt~""
		ll_rc = in_rwait.of_run(ls_fname, Hide!)	
		
		dw_1.SetItem(ll_row , "status" 		,	of_checkdb())

		ll_row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_row , "title" 		,	"حذف الملفات المؤقتة")
		dw_1.SetItem(ll_row , "status" 		,	"P")
	
	 	if(FileDelete(gs_AppPath+"MainLocationScript.sql"))Then
	 		dw_1.SetItem(ll_row , "status" 		,	"D")
		else
			dw_1.SetItem(ll_row , "status" 		,	"F")
		end if

		cb_2.enabled = not cb_2.enabled
		cb_3.enabled = not cb_3.enabled

		ll_row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_row , "title" 		,	"تم تركيب البرنامج بنجاح")
		dw_1.SetItem(ll_row , "status" 		,	dw_1.GetItemString(2 , "status"))
		
end choose

SetPointer(Arrow!)
end subroutine

public function string of_checkdb ();int li_count

SELECT count(name)
INTO :li_count
FROM sys.databases
WHERE NAME = "BSTDB";

if(li_count > 0)Then
	return "D"
else
	return "F"
end if
end function

public function string of_unzip ();ULong lul_unzFile
string is_zipfile
boolean lb_res
n_zlib ln_zlib
is_zipfile = gs_AppPath+"111120111900.bst"
// set password
ln_zlib.of_SetPassword(gs_password+"^")
// open the zip archive
lul_unzFile = ln_zlib.of_unzOpen(is_zipfile)
// extract the file
lb_res = ln_zlib.of_ExtractFile(lul_unzFile, gs_AppPath+"MainLocationScript.sql", "MainLocationScript.sql")
// close the zip archive
ln_zlib.of_unzClose(lul_unzFile)

if(lb_res)Then
	return "D"
else
	return "F"
end if
end function

public function boolean of_checkrequirment ();String ls_title ,ls_dllversion
uLong  ll_data
Long ll_row
OleObject fso
long li_rc

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem(ll_row , "title" , "Windows Installer Version")

//get the file path
RegistryGet( "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer", "InstallerLocation", RegString!, ls_title)

if(trim(ls_title) = "")Then
	dw_1.SetItem(ll_row , "status" , "F")
else
	fso = CREATE OleObject
	li_rc = fso.ConnectToNewObject("Scripting.FileSystemObject")
	ls_dllversion = FSO.GetFileVersion( ls_title+"msi.dll")
	DESTROY fso

	ls_title = mid(ls_dllversion , 1,3)

	if(dec(ls_title) >= 4.5 )Then
		dw_1.SetItem(ll_row , "status" , "D")
	else
		dw_1.SetItem(ll_row , "status" , "F")
			
//		ll_row = dw_1.insertrow( 0 )
//		dw_1.SetItem(ll_row , "title" , "Framework 3.5 SP1")
//		dw_1.SetItem(ll_row , "status" , "F")
//
//		ll_row = dw_1.insertrow( 0 )
//		dw_1.SetItem(ll_row , "title" , "PowerShell 2.0")
//		dw_1.SetItem(ll_row , "status" , "F")
//
//		return False
	end if

end if

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem(ll_row , "title" , "Framework 3.5 SP1")

RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5", "Version", RegString!, ls_title)

if(trim(ls_title) <> "")Then
	
	RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5", "SP", ReguLong!, ll_data)
	if(ll_data = 1)Then
		dw_1.SetItem(ll_row , "status" , "D")
	else
		dw_1.SetItem(ll_row , "status" , "F")
//		ll_row = dw_1.insertrow( 0 )
//		dw_1.SetItem(ll_row , "title" , "Check PowerShell 2.0")
//		dw_1.SetItem(ll_row , "status" , "F")
//		return False
	end if
	
else	
	dw_1.SetItem(ll_row , "status" , "F")
//	return False
end if

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem(ll_row , "title" , "PowerShell 1.0")

RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine", "PowerShellVersion", RegString!, ls_title)

if(trim(ls_title) = "2.0")Then
	dw_1.SetItem(ll_row , "status" , "D")
else
	dw_1.SetItem(ll_row , "status" , "F")
	//return False
End if

int li_itr
boolean lb_status = True
for li_itr = 1 to 3
	if(dw_1.GetItemString(li_itr , "status") = "F")Then
		lb_status = False
		exit
	end if
next

return lb_status
end function

public function boolean of_checkrequirments (integer ar_item);String ls_title,ls_dllversion
OleObject fso
int li_rc
int li_itr
ulong ll_data
boolean lb_status = True

choose case ar_item
	case 1
		//get the file path
		RegistryGet( "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Installer", "InstallerLocation", RegString!, ls_title)

		if(trim(ls_title) = "")Then
			dw_1.SetItem(1 , "status" , "F")
		else
			fso = CREATE OleObject
			li_rc = fso.ConnectToNewObject("Scripting.FileSystemObject")
			ls_dllversion = FSO.GetFileVersion( ls_title+"msi.dll")
			DESTROY fso

			ls_title = mid(ls_dllversion , 1,3)

			if(dec(ls_title) >= 4.5 )Then
				dw_1.SetItem(1 , "status" , "D")
			else
				dw_1.SetItem(1 , "status" , "F")			
			end if

end if

	case 2
		RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5", "Version", RegString!, ls_title)

		if(trim(ls_title) <> "")Then
	
			RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5", "SP", ReguLong!, ll_data)
			if(ll_data = 1)Then
				dw_1.SetItem(2 , "status" , "D")
			else
				dw_1.SetItem(2 , "status" , "F")
			end if
	
		else	
			dw_1.SetItem(2 , "status" , "F")
	end if

case 3
RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine", "PowerShellVersion", RegString!, ls_title)

if(trim(ls_title) = "1.0")Then
	dw_1.SetItem(3 , "status" , "D")
else
	dw_1.SetItem(3 , "status" , "F")
	//return False
End if

end choose

for li_itr = 1 to 3
	if(dw_1.GetItemString(li_itr , "status") = "F")Then
		lb_status = False
		exit
	end if
next

return lb_status
end function

on w_inistall_database_engin.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.p_1=create p_1
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.dw_1,&
this.st_2,&
this.st_1,&
this.p_1,&
this.cb_1}
end on

on w_inistall_database_engin.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cb_1)
end on

event open;Long ll_row

is_Step = Message.StringParm

if(is_step = "2")Then

		ll_row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_row , "title" 		,	"تركيب محرك قاعدة البيانات")
		dw_1.SetItem(ll_row , "status" 		,	"D")


End if
end event

type cb_3 from commandbutton within w_inistall_database_engin
integer x = 2437
integer y = 2240
integer width = 530
integer height = 144
integer taborder = 20
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "خـــــروج"
boolean flatstyle = true
end type

event clicked;CloseWithReturn(Parent , "-1")
end event

type cb_2 from commandbutton within w_inistall_database_engin
integer x = 2999
integer y = 2240
integer width = 530
integer height = 144
integer taborder = 20
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "انتهـــــاء"
boolean flatstyle = true
end type

event clicked;	CloseWithReturn(Parent , "1")
end event

type dw_1 from u_dw within w_inistall_database_engin
integer x = 1431
integer y = 856
integer width = 2683
integer height = 572
integer taborder = 20
string dataobject = "d_ext_instalation_status"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type st_2 from statictext within w_inistall_database_engin
integer x = 1783
integer y = 460
integer width = 2263
integer height = 176
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 8388608
long backcolor = 15780518
string text = "اضغط علي زر تركيب للبدء في تجهيز الكمبيوتر بالأدوات اللأزمة لتشغيل برنامج الأفضل لإدارة موارد الشركات"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
boolean righttoleft = true
end type

type st_1 from statictext within w_inistall_database_engin
integer x = 1417
integer y = 104
integer width = 2697
integer height = 132
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 8388608
long backcolor = 15780518
string text = "شـــــكرا لثـــــــقتكم"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
boolean righttoleft = true
end type

type p_1 from picture within w_inistall_database_engin
integer width = 1413
integer height = 2396
string picturename = "C:\Applications\icons\banners\iphone 4 clouds wallpaper.jpg"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_inistall_database_engin
integer x = 3561
integer y = 2240
integer width = 530
integer height = 144
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "تركيب "
boolean flatstyle = true
end type

event clicked;///*************************************/
//String ls_fname, ls_msg,ls_title
//Long ll_rc,ll_row
//n_runandwait in_rwait
//
//SetPointer(HourGlass!)
//
///**********************************************************/
///**********************************************************/
//RegistryGet( "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "PROCESSOR_ARCHITECTURE", RegString!, ls_title)
//
//if(ls_title = "x86")Then
//	ls_fname = gs_AppPath+"SQLEXPRWT_x86_ENU.exe /QS /ACTION=~"Install~" /IACCEPTSQLSERVERLICENSETERMS /ERRORREPORTING=~"1~" /FEATURES=SQLEngine,Tools /INSTANCENAME=~"BSTSRVR~" /AGTSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /AGTSVCSTARTUPTYPE=~"Automatic~" /ENABLERANU /SAPWD=~""+gs_password+"~" /SECURITYMODE=~"SQL~" /SQLCOLLATION=~"Arabic_CI_AS~" /SQLSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /SQLSVCSTARTUPTYPE=~"Automatic~" /ADDCURRENTUSERASSQLADMIN=~"True~" /NPENABLED=~"1~" /TCPENABLED=~"1~""
//else
//	ls_fname = gs_AppPath+"SQLEXPRWT_x64_ENU.exe /QS /ACTION=~"Install~" /IACCEPTSQLSERVERLICENSETERMS /ERRORREPORTING=~"1~" /FEATURES=SQLEngine,Tools /INSTANCENAME=~"BSTSRVR~" /AGTSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /AGTSVCSTARTUPTYPE=~"Automatic~" /ENABLERANU /SAPWD=~""+gs_password+"~" /SECURITYMODE=~"SQL~" /SQLCOLLATION=~"Arabic_CI_AS~" /SQLSVCACCOUNT=~"NT AUTHORITY\NETWORK SERVICE~" /SQLSVCSTARTUPTYPE=~"Automatic~" /ADDCURRENTUSERASSQLADMIN=~"True~" /NPENABLED=~"1~" /TCPENABLED=~"1~""	
//end if
//
//ll_row = dw_1.InsertRow(0)
//dw_1.SetItem(ll_row , "title" 		,	"تركيب محرك قاعدة البيانات")
//dw_1.SetItem(ll_row , "status" 		,	"P")
//
//ll_rc = in_rwait.of_run(ls_fname, Hide!)
//
//if(ll_rc >= 0)Then
//
//	dw_1.SetItem(ll_row , "status" 		,	"D")
//	ll_row = dw_1.InsertRow(0)
//	dw_1.SetItem(ll_row , "title" 		,	"تركيب قاعدة البيانات")
//	dw_1.SetItem(ll_row , "status" 		,	"P")
//
//	of_unzip()
//	//Installation Done
//	ls_fname = 	"sqlcmd -S .\BSTSRVR -U sa -P "+gs_password+" -d master -i "+gs_AppPath+"MainLocationScript.sql -o "+gs_AppPath+"result.txt"
//	ll_rc = in_rwait.of_run(ls_fname, Hide!)	
//	dw_1.SetItem(ll_row , "status" 		,	"D")
//	ll_row = dw_1.InsertRow(0)
//	dw_1.SetItem(ll_row , "title" 		,	"حذف الملفات المؤقتة")
//	dw_1.SetItem(ll_row , "status" 		,	"P")
//	
// //	FileDelete(gs_AppPath+"MainLocationScript.sql")
// 	dw_1.SetItem(ll_row , "status" 		,	"D")
//	 SetPointer(Arrow!)	
//	cb_2.enabled = not cb_2.enabled
//	cb_3.enabled = not cb_3.enabled
//
//	ll_row = dw_1.InsertRow(0)
//	dw_1.SetItem(ll_row , "title" 		,	"تم تركيب البرنامج بنجاح")
//	dw_1.SetItem(ll_row , "status" 		,	"D")
//
//Else
//	SetPointer(Arrow!)	
//	dw_1.SetItem(ll_row , "status" 		,	"F")
////	Messagebox("تنبيه","تعذر تركيب محرك قاعدة البيانات "+" : "+String(ll_rc))	
//	ll_row = dw_1.InsertRow(0)
//	dw_1.SetItem(ll_row , "title" 		,"تعذر تركيب البرامج الملحقة")
//	dw_1.SetItem(ll_row , "status" 		,	"F")
//
//End if
//
//
///**************************************/


of_steps(is_step)

This.enabled = False
end event

