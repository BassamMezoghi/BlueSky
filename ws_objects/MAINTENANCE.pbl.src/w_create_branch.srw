$PBExportHeader$w_create_branch.srw
forward
global type w_create_branch from w_response
end type
type dw_1 from lol_dw within w_create_branch
end type
type cb_1 from lol_cb within w_create_branch
end type
type dw_progress from lol_dw within w_create_branch
end type
end forward

global type w_create_branch from w_response
integer x = 214
integer y = 221
integer width = 1957
integer height = 960
boolean titlebar = false
boolean controlmenu = false
boolean ib_isupdateable = false
dw_1 dw_1
cb_1 cb_1
dw_progress dw_progress
end type
global w_create_branch w_create_branch

type variables
str_pass_parmeters istr_parm
Long is_branch_id

end variables

forward prototypes
public subroutine of_delay (long ar_max_itr)
public function boolean of_writescript (long ar_db_id)
public function boolean of_sync_data (integer ar_sdbid, integer ar_ddbid)
public subroutine of_ole_object ()
public function long of_createdb ()
end prototypes

public subroutine of_delay (long ar_max_itr);Long ll_itr

for ll_itr=1 to ar_max_itr
	
next
end subroutine

public function boolean of_writescript (long ar_db_id);String ls_AppPath,ls_db_nm
OleObject wsh
integer  li_rc
integer li_FileNum
string ls_output
long ll_FLength

SELECT name 
INTO :ls_db_nm
FROM sys.databases
WHERE database_id = :ar_db_id;

if(IsNull(ls_db_nm))Then return False

//ls_AppPath = gnv_services.of_applicationpath( )

FileDelete(gs_AppPath+"result.txt")

wsh = CREATE OleObject

li_rc = wsh.ConnectToNewObject( "WScript.Shell" )

li_rc = wsh.Run("sqlcmd -S "+SQLCA.ServerName+" -U "+SQLCA.logid +" -P "+SQLCA.logpass +" -d "+ls_db_nm+" -i "+gs_AppPath+"Structure.sql -o "+gs_AppPath+"result.txt" , NORMAL, WAIT)
gnv_services.of_logs("Server Name:"+SQLCA.servername)
gnv_services.of_logs("User NAme:"+SQLCA.logid )
gnv_services.of_logs("Password :"+SQLCA.logpass)
gnv_services.of_logs("Database:"+ls_db_nm )
gnv_services.of_logs(" AppPath:"+gs_AppPath+"Structure.sql")
gnv_services.of_logs("sqlcmd st>>sqlcmd -S "+SQLCA.servername+" -U "+SQLCA.logid +" -P "+SQLCA.logpass +" -d "+ls_db_nm+" -i "+gs_AppPath+"Structure.sql -o "+gs_AppPath+"result.txt")
gnv_services.of_logs("Write Script fn>>Run Structure>>rc:"+String(li_rc))

li_rc = wsh.Run("sqlcmd -S "+SQLCA.servername+" -U "+SQLCA.logid +" -P "+SQLCA.logpass +" -d "+ls_db_nm+" -i "+gs_AppPath+"sp.sql -o "+gs_AppPath+"result.txt" , NORMAL, WAIT)
gnv_services.of_logs("sqlcmd sp>>sqlcmd -S "+SQLCA.servername+" -U "+SQLCA.logid +" -P "+SQLCA.logpass +" -d "+ls_db_nm+" -i "+gs_AppPath+"sp.sql -o "+gs_AppPath+"result.txt")
gnv_services.of_logs("Write Script fn>>Run sp>>rc:"+String(li_rc))

ll_FLength = FileLength(ls_AppPath+"result.txt")

li_FileNum = FileOpen(ls_AppPath+"result.txt", StreamMode!)

IF ll_FLength < 32767 Then
	FileRead(li_FileNum, ls_output)
Else
	ls_output = "--"	
End if

If(trim(ls_output) = "")Then
	Return True
Else
	Return False
End if
end function

public function boolean of_sync_data (integer ar_sdbid, integer ar_ddbid);DataStore lds
Long ll_res
lds = Create DataStore

lds.DataObject = "d_sp_initial_branch"
lds.SetTransObject(SQLCA)

ll_res = lds.retrieve( ar_sdbid,ar_ddbid)
gnv_services.of_logs("sync data>>retrieve Result:"+String(ll_res))
if(ll_res > 0 )Then
     gnv_services.of_logs("sync data>>Get Item:"+String(lds.getitemnumber( 1 , "res")))
	If(lds.getitemnumber( 1 , "res") > 0)then
		Commit using SQLCA;
		Return True
	Else
		Return False
	End if
	
Else
	
	Return False
	
End if
end function

public subroutine of_ole_object ();OleObject wsh
integer  li_rc

wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "WScript.Shell" )

li_rc = wsh.Run("Notepad" , NORMAL, WAIT)
messagebox("hello", "world")

end subroutine

public function long of_createdb ();String ls_Syntax,ls_result
Long ll_db_id
string ls_db_name 

SetPointer(HourGlass!)
//create Transaction Object
Transaction SQLCA_II
SQLCA_II 					= CREATE Transaction
SQLCA_II.DBMS 			= SQLCA.DBMS
SQLCA_II.Database 	= SQLCA.Database
SQLCA_II.LogPass 		= SQLCA.LogPass
SQLCA_II.ServerName = SQLCA.ServerName
SQLCA_II.LogId 			= SQLCA.LogId
SQLCA_II.AutoCommit = True
SQLCA_II.DBParm 		= SQLCA.DBParm
//Connect the Transaction Object
Connect Using SQLCA_II;

SELECT Max(database_id) 
	INTO :ll_db_id
	FROM master.sys.databases ;

ls_db_name = 'Shop'+String(ll_db_id + 1) 

ls_Syntax = "CREATE DATABASE "+ls_db_name + "  COLLATE ARABIC_CI_AS"

Execute Immediate :ls_Syntax Using SQLCA_II;

IF(SQLCA_II.sqldbcode <> 0)Then
	MessageBox("",SQLCA_II.sqlerrtext )
	Disconnect using SQLCA_II;
	Destroy SQLCA_II;
	Return 0
	
End if

SELECT database_id 
	INTO :ll_db_id
	FROM master.sys.databases 
	WHERE name = :ls_db_name;

if(IsNull(ll_db_id))Then ll_db_id = 0

Disconnect using SQLCA_II;

Destroy SQLCA_II;

UPDATE BRANCH_CD 
	SET 
			DBID = :ll_db_id
			,DB_NM = :ls_db_name
	WHERE id = :is_branch_id;
	
Return ll_db_id
end function

on w_create_branch.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_progress=create dw_progress
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_progress
end on

on w_create_branch.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_progress)
end on

event pfc_postopen;call super::pfc_postopen;Long ll_row,ll_db_id,ll_sDBID , ll_it
string ls_file_nm
//cs_sync  lc_sync

//lc_sync = Create cs_sync

//lstr_parm = Message.powerobjectparm

ll_row = 1
ll_db_id = of_createDB()

gnv_services.of_logs( "Post Open>>Create Database>>DBID:"+String(ll_db_id) )

//ll_sDBID = lc_sync.of_dbid( SQLCA.database )

gnv_services.of_logs("Post Open>>Source DBID:"+String(ll_sDBID))

istr_parm.Long_array[1] = ll_db_id

if(ll_db_id = 0)Then
	dw_progress.SetItem(ll_row , "result" , "1")
	ll_row = dw_progress.insertrow(0)
	dw_progress.SetItem(ll_row , "Title" , "تهيئة قاعدة البيانات" )
	dw_progress.SetItem(ll_row , "result" , "1")
	ll_row = dw_progress.insertrow(0)
	dw_progress.SetItem(ll_row , "Title" , "تعين القيم الافتراضية و تزامن قاعدة البيانات" )
	dw_progress.SetItem(ll_row , "result" , "1")
	ll_row = dw_progress.insertrow(0)
	dw_progress.SetItem(ll_row , "Title" , "تصدير قاعدة البيانات" )
	dw_progress.SetItem(ll_row , "result" , "1")
	dw_progress.accepttext( )
	istr_parm.string_parm[1] = "0"				
Else
	dw_progress.SetItem(ll_row , "result" , "2")
	ll_row = dw_progress.insertrow(0)
	dw_progress.SetItem(ll_row , "Title" , "تهيئة قاعدة البيانات" )
	dw_progress.SetItem(ll_row , "result" , "0")
	of_delay(10000)
	if(not of_writeScript(ll_db_id))Then//faild to prepare database
		dw_progress.SetItem(ll_row , "result" , "1")
		ll_row = dw_progress.insertrow(0)
		dw_progress.SetItem(ll_row , "Title" , "تعين القيم الافتراضية و تزامن قاعدة البيانات" )
		dw_progress.SetItem(ll_row , "result" , "1")
		ll_row = dw_progress.insertrow(0)
		dw_progress.SetItem(ll_row , "Title" , "تصدير قاعدة البيانات" )
		dw_progress.SetItem(ll_row , "result" , "1")
		dw_progress.accepttext( )
		istr_parm.string_parm[1] = "0"						
	Else
		dw_progress.SetItem(ll_row , "result" , "2")
		ll_row = dw_progress.insertrow(0)
		dw_progress.SetItem(ll_row , "Title" , "تعين القيم الافتراضية و تزامن قاعدة البيانات" )
		dw_progress.SetItem(ll_row , "result" , "0")	
		of_delay(10000)		
		if(not of_sync_data(ll_sDBID,ll_db_id))Then
			dw_progress.SetItem(ll_row , "result" , "1")
			ll_row = dw_progress.insertrow(0)
			dw_progress.SetItem(ll_row , "Title" , "تصدير قاعدة البيانات" )
			dw_progress.SetItem(ll_row , "result" , "1")
			dw_progress.accepttext( )
			istr_parm.string_parm[1] = "0"				
		Else
			dw_progress.SetItem(ll_row , "result" , "2")
			ll_row = dw_progress.insertrow(0)
			dw_progress.SetItem(ll_row , "Title" , "تصدير قاعدة البيانات" )
			dw_progress.SetItem(ll_row , "result" , "0")
			of_delay(10000)			
//			if(lc_sync.of_backupDB(lc_sync.of_DBNM(ll_db_id),ls_file_nm ))then
//				dw_progress.SetItem(ll_row , "result" , "2")
//				istr_parm.string_parm[1] = "1"
//				istr_parm.string_parm[2] = ls_file_nm
//			Else
//				dw_progress.SetItem(ll_row , "result" , "1")	
//				istr_parm.string_parm[1] = "0"
//			End if
			dw_progress.accepttext( )		
		End if
	End if
End if

IF(istr_parm.string_parm[1] = "0")Then
	ll_row = dw_progress.insertrow(0)
	dw_progress.SetItem(ll_row , "Title" , "تراجع" )
	dw_progress.SetItem(ll_row , "result" , "0")		
	//lc_sync.of_dropdb(lc_sync.of_DBNM(ll_db_id))
	dw_progress.SetItem(ll_row , "result" , "2")	
End if

cb_1.enabled = True
end event

event open;call super::open;Long ll_row
ll_row = dw_progress.insertrow(0)
str_pass_parmeters lstr_parm

lstr_parm = Message.powerobjectparm

is_branch_id = lstr_parm.long_array[1]

gnv_services.of_logs( "Pass branch id:"+String(is_branch_id) )

dw_progress.SetItem(ll_row , "Title" , "إنشاء قاعدة بيانات" )
dw_progress.SetItem(ll_row , "result" , "0")
dw_progress.accepttext( )
of_delay(10000)
end event

type dw_1 from lol_dw within w_create_branch
boolean visible = false
integer x = 466
integer y = 656
integer width = 1431
integer height = 272
integer taborder = 20
string dataobject = "d_sp_initial_branch"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransobject( SQLCA )
end event

type cb_1 from lol_cb within w_create_branch
integer x = 9
integer y = 840
integer taborder = 20
boolean enabled = false
string text = "رجوع"
end type

event clicked;call super::clicked;
CloseWithReturn(Parent,istr_parm)
end event

type dw_progress from lol_dw within w_create_branch
integer width = 1934
integer height = 824
integer taborder = 10
string dataobject = "d_ext_progress"
boolean livescroll = false
end type

