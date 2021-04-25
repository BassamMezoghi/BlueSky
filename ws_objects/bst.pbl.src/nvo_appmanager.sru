$PBExportHeader$nvo_appmanager.sru
forward
global type nvo_appmanager from n_cst_appmanager
end type
end forward

global type nvo_appmanager from n_cst_appmanager
boolean ib_microhelp = true
string is_appinifile = "Store.ini"
string is_userinifile = "app.ini"
end type
global nvo_appmanager nvo_appmanager

type prototypes

end prototypes

type variables
CONSTANT String MY_KEY = "jdhw0aymvpj298sjnwq011iwuehd"
CONSTANT String Encrypt_Algorithm = "3DES"
CONSTANT String is_initial_folder = ""
Decimal id_version = 1.00
double idb_filesize = 1.0
string is_NewAppVer
String is_hdd_no,is_computer_name
n_wininet in_ftp
s_ftpdirlist istr_dirlist[]

end variables

forward prototypes
public function boolean Char_to_boolean (character y_n_char)
public function integer of_about ()
public function string uf_get_ini_file ()
public function string of_getmykey ()
public subroutine of_fill_transaction (ref transaction at_trans, string as_file_nm, string as_section, boolean ab_autocommit, string as_lock)
public subroutine uf_fill_transaction (ref n_tr at_trans, string as_file_nm, string as_section, boolean ab_autocommit, string as_lock)
public function integer of_logondlg ()
public subroutine of_setapplicationstr ()
public function integer of_versioncheck ()
public function boolean of_checksqlspy ()
public function boolean of_checkdebug ()
public function character of_demo ()
public subroutine of_hddregistration ()
public function boolean of_checkmaxlogin ()
public function boolean of_connect ()
public function boolean of_checkversion ()
public function string of_get_dbid ()
public function boolean of_findwindow (string as_title)
public function integer of_dealer_by_user (long ar_user_id)
public function string of_employee_name (long ar_emid)
public function string of_getmaincurrancy ()
public function string of_getencryptionalgorithm ()
end prototypes

public function boolean Char_to_boolean (character y_n_char);if y_n_char = "Y" then
	return True
else
	return False
End if	
end function

public function integer of_about ();n_cst_aboutattrib lnv_aboutattrib

// Populate information passed to the About window.
this.Event pfc_preabout (lnv_aboutattrib)

Return OpenWithParm (w_menu, lnv_aboutattrib)
end function

public function string uf_get_ini_file ();return is_appinifile
end function

public function string of_getmykey ();Return MY_KEY
end function

public subroutine of_fill_transaction (ref transaction at_trans, string as_file_nm, string as_section, boolean ab_autocommit, string as_lock);String ls_provider, ls_dataBase, ls_server ,ls_dbms
String ls_pass, ls_id
String ls_upass , ls_uid
//n_cst_crypto lnv_crypt
n_cryptoapi lnv_crypto
Long ll_timer

gs_Lan				= ProfileString(is_appinifile , as_section		, "LAN"       		, "AR")

ls_dbms 			= ProfileString(is_appinifile , as_section		, "DBMS"       	, "OLE DB")
ls_provider 	= ProfileString(is_appinifile , as_section		, "Provider"       	, "SQLNCLI10")

ls_database 	= ProfileString(as_file_nm, "Database", "Database","BSTDB")
ls_server   	= ProfileString(as_file_nm, "Database", "ServerName","(local)\BSTSRVR")

ls_upass = ProfileString(as_file_nm, as_section, "UPASS"   , "None")
ls_uid 	= ProfileString(as_file_nm, as_section, "UID"   , "None")

IF ls_upass = "None" and ls_uid = "None" THEN  
	
	ls_upass = ProfileString("conn.ini", as_section, "UPASS"   , "None")
	ls_uid 	= ProfileString("conn.ini", as_section, "UID"   , "None")
	
	SetProfileString(as_file_nm , as_section , "UPASS" , ls_upass )
	SetProfileString(as_file_nm , as_section , "UID" 	, ls_uid )
	
END IF

ls_pass 	= lnv_crypto.of_decrypthex( Encrypt_Algorithm , ls_upass	, 	My_Key)
ls_id 	= lnv_crypto.of_decrypthex( Encrypt_Algorithm , ls_uid	,	My_Key)
ls_id 	= Mid(ls_id , pos(ls_id , "=") + 1 , len(ls_id))

Choose Case ls_dbms
	Case "OLE DB"
	 	at_trans.DBMS       		= ls_dbms
		at_trans.Database   		= ls_database
      at_trans.ServerName 		= ls_server
    	at_trans.Logid      		= ls_id
    	at_trans.Logpass    		= ls_pass
    	at_trans.Lock       		= as_lock
    	at_trans.AutoCommit 		= ab_autocommit
    	at_trans.DBParm     		= "PROVIDER='"+ls_provider+"',DATASOURCE='" +ls_server +"',PROVIDERSTRING='DataBase=" +ls_database + "',Identity='SCOPE_IDENTITY()" 
		
	Case "ODBC"
		at_trans.DBMS				= ls_dbms
      	at_trans.Lock       	= as_lock
      	at_trans.AutoCommit	= ab_autocommit
		at_trans.DBParm 			= "ConnectString='DSN=Tawasol-online;UID="+ls_id+";PWD="+ls_pass+"'"
									  
	Case "SNC SQL Native Client(OLE DB)"
		at_trans.DBMS       		= ls_dbms
      at_trans.Database   		= ls_database
      at_trans.ServerName 		= ls_server
      at_trans.AutoCommit 		= ab_autocommit
		at_trans.lock       		= as_lock
      at_trans.Logid   			= ls_id
     	at_trans.Logpass 			= ls_pass
		at_trans.DBParm 			= "Provider='"+ls_provider+"',Database='"+ls_database+"',AppName='BST',PacketSize=2048,DateFormat='dd/mm/yyyy',DateTimeFormat='dd/mm/yyyy hh:mm:ss',TimeFormat='hh:mm:ss',Identity='SCOPE_IDENTITY()'"

End Choose



end subroutine

public subroutine uf_fill_transaction (ref n_tr at_trans, string as_file_nm, string as_section, boolean ab_autocommit, string as_lock);//String ls_provider, ls_dataBase, ls_server 
//String ls_pass, ls_uid
//n_cst_crypto lnv_crypt
//
//lnv_crypt = CREATE n_cst_crypto
//
//ls_provider = ProfileString(is_appinifile, as_section, "DBMS"       , "OLEDB")
//
//ls_database = ProfileString(is_appinifile, "Database", "Database","WAHA")
//ls_server   = ProfileString(is_appinifile, "Database", "ServerName","PSYCHO\MSSQLDEV")
//ls_pass     = ProfileString(is_appinifile, as_section, "PASS"       , "aqswde")
//ls_uid      = ProfileString(is_appinifile, as_section, "ID"         , "bam")
//
//ls_uid  = lnv_crypt.DecryptData(ls_uid , gnv_app.of_getmykey( ) ) 
//ls_pass = lnv_crypt.DecryptData( ls_pass , gnv_app.of_getmykey( ) )
//
//
////Choose Case ls_provider
////	Case "OLEDB"
////	 at_trans.DBMS       = "OLE DB"
////    at_trans.Logid      = ls_uid
////    at_trans.Logpass    = ls_pass
////    at_trans.Lock       = as_lock
////    at_trans.AutoCommit = ab_autocommit
////    at_trans.DBParm     = "PROVIDER='SQLNCLI',DATASOURCE='" +ls_server +"',PROVIDERSTRING='DataBase=" +ls_database + "'" 
////
////		
////	Case "ODBC"
////		at_trans.DBMS			= "ODBC"
////      at_trans.Lock       	= as_lock
////      at_trans.AutoCommit	= ab_autocommit
////      at_trans.DBPARM		= "ConnectString='Driver=SQL Native Client;Server=" + ls_server +&
////							        ";Database=" +ls_database + ";QuotedId=No;UID="+ls_uid+";PWD="+ls_pass+";',StripParmNames= 'Yes',CallEscape='YES',ConnectOption = ' SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT';DateTimeFormat='dd/mm/yyyy hh:mm:ss',TIMEOUT=160"  
////	Case "MS"
////		at_trans.DBMS       	= "MSS Microsoft SQL Server 6.x"
////      at_trans.Database   	= ls_database
////      at_trans.ServerName 	= ls_server
////      at_trans.AutoCommit 	= ab_autocommit
////		at_trans.lock       	= as_lock
////      at_trans.Logid   		= ls_uid
////      at_trans.Logpass 		= ls_pass
////
////End Choose
////
////SQLCA.DBMS       = "MSS Microsoft SQL Server 6.x"//ProfileString(is_appinifile, "Database", "DBMS", "MSS Microsoft SQL Server 6.x")
////SQLCA.Database   = ls_database
////SQLCA.ServerName = ls_server
////SQLCA.AutoCommit = ab_autocommit
////SQLCA.lock       = as_lock
////SQLCA.Logid   = ls_uid//ProfileString(is_appinifile, "Database", "ID","sa")
////SQLCA.Logpass = ls_pass//ProfileString(is_appinifile, "Database", "PASS","aqswde")
////
//at_trans.DBMS       	= "MSS Microsoft SQL Server 6.x"//ProfileString(is_appinifile, "Database", "DBMS", "MSS Microsoft SQL Server 6.x")
//at_trans.Database   	= ls_database
//at_trans.ServerName 	= ls_server
//at_trans.AutoCommit	= ab_autocommit
//at_trans.lock       	= as_lock
//at_trans.Logid   		= ls_uid//ProfileString(is_appinifile, "Database", "ID","sa")
//at_trans.Logpass 		= ls_pass//ProfileString(is_appinifile, "Database", "PASS","aqswde")
//
//DESTROY lnv_crypt
//
//
end subroutine

public function integer of_logondlg ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_LogonDlg
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = successful logon
//	 0 = User cancelled from the logon dialog
//	-1 = an error occurred opening the logon window
//
//	Description:  Obtain a User ID and password from the user
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_logonattrib	lnv_logonattrib
lnv_logonattrib.ii_logonattempts = 3

//////////////////////////////////////////////////////////////////////////////
// Load logon object values
//////////////////////////////////////////////////////////////////////////////
this.event pfc_prelogondlg (lnv_logonattrib)

//////////////////////////////////////////////////////////////////////////////
// Open logon window
//////////////////////////////////////////////////////////////////////////////
if OpenWithParm (w_store_logon, lnv_logonattrib) < 0 then
	return -1
end if

//////////////////////////////////////////////////////////////////////////////
// Get return logon object
//////////////////////////////////////////////////////////////////////////////
lnv_logonattrib = message.powerobjectparm

//////////////////////////////////////////////////////////////////////////////
// Store user id
//////////////////////////////////////////////////////////////////////////////
if LenA (lnv_logonattrib.is_userid) > 0 then
	if of_IsRegistryAvailable() then
		RegistrySet (is_userkey + "\logon", "userid", lnv_logonattrib.is_userid)
	else
		SetProfileString (is_userinifile, "logon", "userid", lnv_logonattrib.is_userid)
	end if

	of_SetUserID (lnv_logonattrib.is_userid)
end if

return lnv_logonattrib.ii_rc

end function

public subroutine of_setapplicationstr ();Char lc_char
DataStore lds_sys_setup
Long ll_rowCount

lds_sys_setup = Create Datastore

lds_sys_setup.DataObject = "d_sys_setup"
lds_sys_setup.SetTransObject( SQLCA )

lds_sys_setup.retrieve( 0 )//General
ll_rowCount = lds_sys_setup.RowCount()
gstr_user_info.application_parm[gnv_settings.OnArchiveCreateJournal] = Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.OnArchiveCreateJournal)	, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.ClientsShared] 				= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.ClientsShared)					, 1, ll_rowCount) , "value"))

lds_sys_setup.retrieve( 1 )//Sales
ll_rowCount = lds_sys_setup.RowCount()
gstr_user_info.application_parm[gnv_settings.IndexPrice] 						= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.IndexPrice)							, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.InforceSCFamily] 				= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.InforceSCFamily)					, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.ClientAccInv] 						= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.ClientAccInv)						, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.DealerInforce] 					= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.DealerInforce)						, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.ShwClientAccount] 				= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.ShwClientAccount)				, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.UpdateSalesInvAfterPrint] 	= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.UpdateSalesInvAfterPrint)		, 1, ll_rowCount) , "value"))	
gstr_user_info.application_parm[gnv_settings.SalesInvoiceSize] 				= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.SalesInvoiceSize)					, 1, ll_rowCount) , "value"))	
gstr_user_info.application_parm[gnv_settings.SalesDiscountPercent] 		= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.SalesDiscountPercent)			, 1, ll_rowCount) , "value"))	
gstr_user_info.application_parm[gnv_settings.SalesDiscountPercentFixed]	= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.SalesDiscountPercentFixed)	, 1, ll_rowCount) , "value"))	
gstr_user_info.application_parm[gnv_settings.UserStoreCardFamily]			= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.UserStoreCardFamily)			, 1, ll_rowCount) , "value"))	
gstr_user_info.application_parm[gnv_Settings.SalesQtyInventory ] 			= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.SalesQtyInventory)			, 1, ll_rowCount) , "value"))	
gstr_user_info.application_parm[gnv_Settings.viewscwithprice ] 			= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.viewscwithprice)			, 1, ll_rowCount) , "value"))	

lds_sys_setup.retrieve( 2 )//purchase
ll_rowCount = lds_sys_setup.RowCount()
gstr_user_info.application_parm[gnv_settings.InforceBuyPrice] 	= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.InforceBuyPrice)	, 1, ll_rowCount) , "value"))
gstr_user_info.application_parm[gnv_settings.CostPriceHistory] 	= Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.CostPriceHistory)	, 1, ll_rowCount) , "value"))

lds_sys_setup.retrieve( 3 )//Rejected
ll_rowCount = lds_sys_setup.RowCount()
gstr_user_info.application_parm[gnv_settings.UpdateRejectInvAfterPrint] = Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.UpdateRejectInvAfterPrint), 1, ll_rowCount) , "value"))

lds_sys_setup.retrieve( 11 )//Payments	
ll_rowCount = lds_sys_setup.RowCount()
gstr_user_info.application_parm[gnv_settings.PaymentsInvoiceSize] = Long(lds_sys_setup.GetItemString( lds_sys_setup.find( "id="+string(gnv_settings.PaymentsInvoiceSize), 1, ll_rowCount) , "value"))

	
Destroy lds_sys_setup
end subroutine

public function integer of_versioncheck ();String ls_VersionStopper
String ls_AppVer

SELECT STRING_VALUE
INTO :ls_VersionStopper
FROM PARAM_CD
WHERE parm_nm = 'VersionStoper';

if(IsNull(ls_VersionStopper))Then return 1

if(ls_VersionStopper = "N" )Then return 2

SELECT STRING_VALUE
INTO :ls_AppVer
FROM PARAM_CD
WHERE parm_nm = 'Version';

if(IsNull(ls_AppVer))Then return 0

if(gnv_services.of_compar_application_version(ls_AppVer , gs_Appver) = 1 )Then
	Return -1
else
	return 3
end if




end function

public function boolean of_checksqlspy ();String ls_sqlspy

SELECT string_value
INTO :ls_sqlspy
FROM PARAM_CD
WHERE parm_nm = 'sqlspy';

if(isnull(ls_sqlspy))then
 return false
else
	if(ls_sqlspy = "N")then return false
	return true
end if
end function

public function boolean of_checkdebug ();String ls_debug

SELECT string_value
INTO :ls_debug
FROM PARAM_CD
WHERE parm_nm = 'debug';

if(isnull(ls_debug))then
 return false
else
	if(ls_debug = "N")then return false
	return true
end if
end function

public function character of_demo ();Char lc_setup
String ls_title

if(Demo)Then
	iapp_object.DisplayName 	= "Blue Sky Technologies"
	lc_setup                			= "N"
	
	RegistryGet( "HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft SQL Server\Instance Names\SQL", "BSTSRVR", RegString!, ls_title)
	
	if(trim(ls_title) = "")Then
		OpenWithParm(w_inistall_database_engin , "1")
		if(Message.StringParm = "-1" )Then
			This.event pfc_exit( )
		end if
	Else

		SQLCA.DBMS       		= "OLE DB"
		SQLCA.Database   		= "master"
		SQLCA.ServerName 	= "(local)\BSTSRVR"
		SQLCA.AutoCommit	= True
		SQLCA.lock       			= "RU"
		SQLCA.Logid   			= "sa"
		SQLCA.Logpass 		= gs_password
		SQLCA.DBParm     	= "PROVIDER='SQLNCLI10',DATASOURCE='" +SQLCA.ServerName +"',PROVIDERSTRING='DataBase=" +SQLCA.Database + "','CursorLock='Opt'" 
		
		Connect using SQLCA;

		if(SQLCA.sqlcode < 0 )Then
			MessageBox("Connection status",SQLCA.sqlerrtext )
			return "N"
		End if		
		
		ls_title = ""
		
		SELECT name
		INTO :ls_title
		FROM sys.databases
		WHERE name = 'BSTDB';
		
		if(IsNull(ls_title) or trim(ls_title) = "")Then	
			OpenWithParm(w_inistall_database_engin , "2")
		End if
		
		Disconnect using SQLCA;		
	End if
	
Else
	
	iapp_object.DisplayName 	= ProfileString(is_userinifile , "app", "CompanyNm","")
	lc_setup             					= ProfileString(is_appinifile, "DataBase", "DbSetUp","Y")
	
End if

return lc_setup
end function

public subroutine of_hddregistration ();nvo_security lcs_security
//**********************Get HDD serial no and Comuter name*******************
lcs_security = create nvo_security

gstr_user_info.Computer_name 	= lcs_security.of_GetComputerName( )
gstr_user_info.ip 						= lcs_security.of_GetCurrentipaddress( )

lcs_security.of_SetComputerName(gstr_user_info.Computer_name  , gstr_user_info.hdd_serial_no)

destroy lcs_security
//***********************************************************************

end subroutine

public function boolean of_checkmaxlogin ();DataStore ds
boolean lb_res

ds = Create DataStore

ds.DataObject = "d_logs_ii"
ds.SetTRansobject( SQLCA )
ds.retrieve()

if(ds.RowCount() > MaxLogin)Then
	lb_res = False
Else 
	lb_res = True	
End if

Destroy ds
Return lb_res
end function

public function boolean of_connect ();String ls_server, ls_userid, ls_password, ls_result,ls_currentdir
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

public function boolean of_checkversion ();String ls_car,ls_cdbr
Boolean lb_res

ls_car	= ProfileString(gs_AppPath+"AppVersions.ini", "AppVersions", gs_AppVer, "1.0.0.0")
//Messagebox("from App version",ls_car)
if(ls_car = "1.0.0.0" )Then
//	st_1.text = "لايوجد تحديث ارجو العودة في وقت لاحق"
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

public function string of_get_dbid ();Long ll_dbid

SetNull(ll_dbid)

SELECT DBID
INTO :ll_dbid
FROM SERIAL_NO inner join BRANCH_CD on (SERIAL_NO.BRANCH_ID = BRANCH_CD.ID  )
WHERE HDSERIAL_NO = :gstr_user_info.hdd_serial_no and SUSPEND_FG = 'N';

IF IsNull(ll_dbid) THEN
	Return "0"
ELSE
	Return String(ll_dbid)
END IF
end function

public function boolean of_findwindow (string as_title);ulong hWnd
string ls_class
boolean lb_res = False
n_cst_user32 lnv_user

lnv_user = Create n_cst_user32

SetNull(ls_class)

hWnd = lnv_user.FindWindow(ls_class, as_title)

IF NOT IsNull(hWnd) THEN
	IF hWnd > 0 then lb_res = True
END IF

Destroy lnv_user
Return lb_res

/***************/

end function

public function integer of_dealer_by_user (long ar_user_id);Long ll_dealer_id

SELECT dealer_id
INTO :ll_dealer_id
FROM DEALER inner join users on dealer.emid = users.emid
WHERE users.user_no = :ar_user_id;

IF IsNull(ll_dealer_id) THEN
	ll_dealer_id = 0
END IF	


//MessageBox( "" , ll_dealer_id )

Return ll_dealer_id

end function

public function string of_employee_name (long ar_emid);String ls_em_nm

SELECT EM_NM 
INTO :ls_em_nm
FROM EMPLOYEES
WHERE EMID = :ar_emid;

IF IsNull(ls_em_nm) THEN
	
	ls_em_nm = "غير معروف"
	
END IF

Return ls_em_nm
end function

public function string of_getmaincurrancy ();String ls_MainCurrency


SELECT STRING_VALUE
INTO :ls_MainCurrency
FROM PARAM_CD
WHERE PARM_NM = "MainCurrency";

IF IsNull(ls_MainCurrency) THEN
	ls_MainCurrency =  ""
END IF

Return ls_MainCurrency
end function

public function string of_getencryptionalgorithm ();Return Encrypt_Algorithm
end function

event pfc_open;call super::pfc_open;Boolean lb_debug
Char ls_restore_fg = 'N' 
String ls_client_no
n_cst_logonattrib	lnv_logonattrib	
n_cst_user32 lnv_user

//Create Services Object
gnv_services 		= Create nvo_services
gnv_security	 	= Create nvo_security
gnv_msg				= Create n_cst_msg

//Get the Application Path
gnv_services.of_applicationpath(gs_FileName ,gs_AppPath)
//Get the hdd serial no
gstr_user_info.hdd_serial_no =   Trim(gnv_security.of_serialnumber( "C:\"))


IF gstr_user_info.hdd_serial_no <> "914321548-71EQB2APB"  &
	and gstr_user_info.hdd_serial_no <> "643444563-S15NNYAD703310" &
		and gstr_user_info.hdd_serial_no <> "2350484853-172238802675" &
			and gstr_user_info.hdd_serial_no <> "3299989196-73QBP8X4T" THEN
	IF gs_AppVer = "" or gs_AppVer = "0.0.0.0" or isnull(gs_AppVer)  THEN 
	
		gnv_msg.of_message(-1) //MessageBox("تنبيه","تعذر الحصول على رقم النسخة"+"~n~n"+"لايمكن تشغيل المنظومة دون التعرف على رقم النسخة ",StopSign!)	
		This.Event pfc_Exit()	
	
	END IF
END IF

IF(of_Demo() = "Y")Then
	
	Open(w_setup_confirmation)
	
	ls_client_no = Message.stringparm
	
	IF(IsNull(ls_client_no) or Trim(ls_client_no) = "")Then
		this.Event pfc_Exit()		
	End if
	
	IF(ls_client_no  = AppCode )Then
		This.of_fill_transaction( SQLCA  , is_appinifile , "DataBase" , False , "RU")
		Open(w_setup_options)
	Else
		gnv_msg.of_Message(-2) //		Messagebox("تنبيه","إدخال خاطئ")
		This.Event pfc_Exit()		
	End if
	
Else
	//Fill The transaction
	This.of_fill_transaction( SQLCA  , is_appinifile , "DataBase" , False , "RU")
End if

///Connect to database
Connect Using (SQLCA) ;

IF SQLCA.SqlCode < 0 THEN
	gnv_msg.of_Message(-3)	//MessageBox("خطأ قاعدة البيانات","تعذر الاتصال بقاعدة البيانات",StopSign!)
	//MessageBox("خطأ قاعدة البيانات",SQLCA.sqlerrtext )
	This.Event pfc_Exit()
End If

//check if the PC registered
if(not gnv_security.of_checkserialnoregistration(gstr_user_info.hdd_serial_no) )Then 
	gnv_msg.of_Message(1)  //MessageBox("تنبيه","هذا الجهاز غير مرخص له باستعمال المنظومة")
	gnv_services.of_logs( "تنبيه ::: الجهاز غير مرخص" )
	this.Event pfc_Exit() 
end if

//update the registration with Computer name
of_hddregistration()
//check application version
if(of_versioncheck() <= 0)Then
	gnv_msg.of_Message(2)  //MessageBox("تنبيه","هذه النسخة من المنظومة قديمة ارجو طلب المنظومة الجديدة~nمن الادارة شكرا...",StopSign!)
	gnv_services.of_logs( "تنبيه :::نسخة المنظومة قديمة" )
	Open(w_app_update)
	DESTROY  gnv_security ;
	This.Event pfc_Exit()
end if

IF( Not of_findwindow("TeamViewer") AND gstr_user_info.teamviewer = "Y" )THEN
	gnv_msg.of_Message(3)  //MessageBox("تنبيه","يجب تشغيل برنامج تيم فيور للتشغيل المنظومة",StopSign!)
	gnv_services.of_logs( "تنبيه ::: تشغيل تيم فيور" )
	DESTROY  gnv_security ;
	This.Event pfc_Exit()	
END IF

This.event pfc_prelogondlg( lnv_logonattrib )
of_SetUserID ( lnv_logonattrib.is_userid )


//enable of disable debug
lb_debug = of_checkdebug()
if(lb_debug)Then
	gnv_app.of_SetDebug(lb_debug)
	gnv_app.inv_debug.of_setsqlspy( of_checksqlspy() and lb_debug)
End if

//************************************************************//
IF gstr_user_info.hdd_serial_no = "914321548-7E1BQA2BP"  &
or gstr_user_info.hdd_serial_no = "643444563-S15NNYAD703310" &
or gstr_user_info.hdd_serial_no = "2350484853-172238802675"  THEN
	SetNull(gs_dbid)	
	gstr_user_info.hq = True
	This.event pfc_logon( "support" , "15987")
		
ELSE
	IF of_LogonDlg() <= 0 Then
		DESTROY  gnv_security ;
		This.Event pfc_Exit()
	End if
END IF
//*****************************************************************
//***************************CheckMaxLogin*****************************


if(Demo)Then 
	if(of_CheckMaxLogin())Then 	This.Event pfc_Exit()
end if

//******************************************************************

//MessageBox("1", gs_Lan)
//Set Interface Language
gnv_services.of_Set_Language()
Choose Case gs_Lan
	Case "AR"
		IF gstr_user_info.branch_nm = "" THEN	gstr_user_info.branch_nm 	= "الفرع الرئيسي"
	Case "EN"
			gstr_user_info.branch_nm 	= "Headquarter"
	Case "FR"
			gstr_user_info.branch_nm 	= "Siège Social"
End Choose

Open(w_store_splash)

end event

on nvo_appmanager.create
call super::create
end on

on nvo_appmanager.destroy
call super::destroy
end on

event pfc_logon;call super::pfc_logon;String  ls_user_id,ls_password,ls_securty_lvl,ls_user_name , ls_reset_password
Char ls_active_FG ,lc_forece_sc_family 
Long ll_user_id,ll_branch_id,ll_emid

//if the Database changed then reconnecting to the new database
IF gs_dbid <> "-" THEN

	DISCONNECT USING SQLCA;
	SQLCA.database = gs_dbid
	CONNECT USING SQLCA;
	
END IF

gstr_user_info.login_id 	= as_userid
gstr_user_info.password		= as_password

//as_password 					= gnv_services.of_encrypt_password( as_password )

gnv_services.of_logs( "تسجيل الدخول" )

SELECT USER_ID,PASSWORD,ACTIVE_FG,USER_NM ,USER_NO,IsNull(BRANCH_ID , 0),EMID , INCOME
INTO   :ls_user_id,:ls_PASSWORD,:ls_active_fg,:ls_user_name,:ll_user_id,:ll_branch_id,:ll_emid , :ls_reset_password
FROM   USERS
WHERE  USER_ID = :as_userid; //and password = :as_password;

If SQLCA.SqlCode < 0 Or SQLCA.SqlCode = 100 Then
	gnv_msg.of_Message(4)  //MessageBox("Login Error","اسم المستخدم غير موجود او  كلمة السر غير صحيحة",StopSign!)

	gnv_services.of_logs("اسم المستخدم او كلمة السر غير صحيحة")
	Return -1
End If

ls_password = gnv_services.of_decrypt( ls_password )

IF IsNull(ls_password) THEN
	Open(w_password_reset)
	IF Message.StringParm = "N" THEN
		gnv_msg.of_Message(4)  //MessageBox("Login Error","اسم المستخدم غير موجود او  كلمة السر غير صحيحة",StopSign!)

		gnv_services.of_logs("اسم المستخدم او كلمة السر غير صحيحة")
		Return -1
	END IF
ELSEIF ls_password <> gstr_user_info.password THEN
	gnv_msg.of_Message(4)  //MessageBox("Login Error","اسم المستخدم غير موجود او  كلمة السر غير صحيحة",StopSign!)

	gnv_services.of_logs("اسم المستخدم او كلمة السر غير صحيحة")
	Return -1
	
END IF


If ls_active_FG <> 'Y' Then
	
	gnv_msg.of_Message(5)  //MessageBox("Validation Error","تم توقيف هذا المستخدم",StopSign!)
	gnv_services.of_logs("المستخدم موقوف")
	Return -1
	
End If

of_SetApplicationStr()

gstr_user_info.dealer_id = of_dealer_by_user(ll_user_id)
//Get Main Currency
gstr_user_info.MainCurrency = of_GetMainCurrancy()

gstr_user_info.office_id = String( ll_branch_id )//from user table
gstr_user_info.dbid		= String( gnv_security.of_get_branch_by_serial_no( gstr_user_info.hdd_serial_no ) )

IF Long(gstr_user_info.Office_id) <> 0 and gstr_user_info.office_id <> gstr_useR_info.dbid THEN
	
		gnv_msg.of_Message(6)//MessageBox("تنبيه", "المستخدم غير مصرح له بالدخول الى هذا الفرع" )
		gnv_services.of_logs("تنبيه  ::: المستخدم غير مصرح له بالدخول الى هذا الفرع")
		Return -1
	
END IF

//Password Reset
IF ls_reset_password = "Y" THEN
	
	Open(w_password_reset)
	
	IF Message.Stringparm = "N" THEN 
		gnv_services.of_logs("reset password faild")
		Return -1
	END IF
		
END IF


gnv_services.of_getreportdate( )

//if the HQ then return 0
gstr_user_info.login_id 			 	= ls_user_id
gstr_user_info.employee_name 			= ls_user_name
gstr_user_info.id            			= ll_user_id

///fill the user fid array
//gnv_services.of_user_store_card_family( gstr_user_info.id )
iapp_object.DisplayName = gnv_services.of_Company_name( )

// Application copyright message
of_SetCopyright ("User Name  "+ls_user_name + "~n~nCopyright © 2017, " + iapp_object.DisplayName + ", All Rights Reserved. ~n~nDesigned By Bassam S.Mezoghi ")
of_SetVersion ("Version " + String(gs_AppVer))

gnv_services.of_logs("تسجيل الدخول بنجاح" )


gnv_security.event destructor( )
gnv_security.event constructor( )

Return 1
end event

event constructor;call super::constructor;// Name of the application
iapp_object.DisplayName=""

// Microhelp functionality
of_SetMicroHelp (true)

// The file name of the application INI file
of_SetAppIniFile ("constr.ini")

// The file name of the user INI file
of_SetUserIniFile ("app.ini")

// Application registry key
//of_SetAppKey ("")

// User registry key
//of_SetUserKey ("")

// The file name of the application's online help file
//of_SetHelpFile ("")

// The application version
//of_SetVersion ("Version 1.0")

// The application logo (bitmap file name)
of_SetLogo ("logo.gif")
end event

event pfc_idle;call super::pfc_idle;TRY
// download file
String ls_filename, ls_pathname, ls_result
Integer li_rtn

// connect to the server
If Not of_Connect() Then 
	ls_Result = "-"
	Return
end if

if(in_ftp.of_getsession( ) <=0 )then
	ls_Result = "-"
	Return
end if

ls_filename = "AppVersions.ini"

ls_pathname =  gs_AppPath + ls_filename

// download the file
ls_result = in_ftp.of_Ftp_ReadFile(ls_filename, ls_pathname, Handle(this), 1024)

If ls_result <> "" Then
	MessageBox("خطاء", ls_result, StopSign!)
	ls_Result = "-"
	Return
End If


	in_ftp.of_ftp_SetCurrentDirectory("/Extractor")
	ls_result = in_ftp.of_Ftp_ReadFile("extractor.exe.manifest"	, gs_AppPath+"extractor.exe.manifest"	, Handle(This), 1024)		
	ls_result = in_ftp.of_Ftp_ReadFile("extractor.exe"				, gs_AppPath+"extractor.exe"				, Handle(This), 1024)
	ls_result = in_ftp.of_Ftp_ReadFile("extractor.pbd"				, gs_AppPath+"extractor.pbd"				, Handle(This), 1024)	


in_ftp.of_ftp_SetCurrentDirectory(is_initial_folder+"/"+AppCode)

if(of_checkversion())then
	
	idb_filesize = w_app_update.of_getfiles(is_NewAppVer+".bst")
	
	ls_pathname =  gs_AppPath+ is_NewAppVer+".bst"
	//make sure the file exists
	if(not in_ftp.of_ftp_fileexists(is_NewAppVer+".bst"))Then 
//		st_1.text = "الملف المطلوب غير متوفر حالياً في الخادم ارجو المحاولة في وقت لاحق و شكرا"
		return
	end if
	
	// download the file
	ls_result = in_ftp.of_Ftp_ReadFile(is_NewAppVer+".bst", ls_pathname, Handle(This), 1024)

	If ls_result <> "" Then
		MessageBox("خطاء", ls_result, StopSign!)
	End If	
else
	ls_result = "-"
end if

CATCH(PbxRunTimeError re)
	MessageBox("خطاء",re.getmessage())
	ls_Result = "-"
	return
FINALLY
	
	// disconnect from the server
//	w_app_update.wf_Disconnect()
//	Messagebox("",ls_result)
	if(ls_result = "")Then
		gs_UpdateFile = is_NewAppVer+".bst"
		if(Messagebox("تنبيه","لتركيب التحديث يجب اعادة تششغيل المنظومة ~nهل تريد اعادة التشغيل الان؟",Information!,YesNo!) = 1)Then			
			gnv_app.Event pfc_exit( )
		else
			restart()
			Close(Parent)
		end if
	End if
END TRY



end event

event pfc_close;call super::pfc_close;filedelete(gs_AppPath+"sc.csv")
filedelete(gs_AppPath+"cs.csv")
filedelete(gs_AppPath+"clients.csv")
filedelete(gs_AppPath+"pl.csv")
filedelete(gs_AppPath+"AccDic.csv")
filedelete(gs_AppPath+"store.csv")
filedelete(gs_AppPath+"nm.xml")
filedelete(gs_AppPath+"st.xml")
filedelete(gs_AppPath+"sc.xml")
filedelete(gs_AppPath+"de.xml")
filedelete(gs_AppPath+"fi.xml")
filedelete(gs_AppPath+"price_list.xml")
//filedelete(gs_AppPath+"wh_inv.xml")



end event

event pfc_systemerror;//int li_filehandle
String ls_message

IF gstr_user_info.login_id = "support" or gstr_user_info.login_id = "admin" THEN

	
	ls_message = 'Error Number '+string(error.number) & 
		+'.~r~nError text = '+Error.text &
		+'.~r~nWindow/Menu/Object = '+error.windowmenu &
		+'.~r~nError Object/Control = '+Error.object &
		+'.~r~nScript = '+Error.objectevent &
		+'.~r~nLine in Script = '+string(Error.line) + '.'
		
		MessageBox("Error Number",ls_message)

ELSE
	gnv_services.of_log("Error.log" , "PC:"+gstr_user_info.computer_name )
	gnv_services.of_log("Error.log" , "USER:"+gstr_user_info.login_id )
	gnv_services.of_log("Error.log" , String(Error.Number))
	gnv_services.of_log("Error.log" , Error.text )
	gnv_services.of_log("Error.log" , Error.windowmenu)
	gnv_services.of_log("Error.log" , Error.object)
	gnv_services.of_log("Error.log" , Error.Objectevent)
	
	gnv_msg.of_message(-5)
END IF


end event

