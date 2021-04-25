$PBExportHeader$w_branch.srw
forward
global type w_branch from w_response
end type
type uo_2 from navigator_bar_adv within w_branch
end type
type tab_1 from tab within w_branch
end type
type tabpage_warehouse from userobject within tab_1
end type
type dw_3 from lol_dw within tabpage_warehouse
end type
type tabpage_warehouse from userobject within tab_1
dw_3 dw_3
end type
type tabpage_banks from userobject within tab_1
end type
type dw_2 from lol_dw within tabpage_banks
end type
type tabpage_banks from userobject within tab_1
dw_2 dw_2
end type
type tabpage_client from userobject within tab_1
end type
type dw_4 from lol_dw within tabpage_client
end type
type tabpage_client from userobject within tab_1
dw_4 dw_4
end type
type tab_1 from tab within w_branch
tabpage_warehouse tabpage_warehouse
tabpage_banks tabpage_banks
tabpage_client tabpage_client
end type
type cb_close from u_cb within w_branch
end type
type cb_delete from u_cb within w_branch
end type
type cb_save from u_cb within w_branch
end type
type cb_add from u_cb within w_branch
end type
type dw_1 from u_dw within w_branch
end type
type p_1 from picture within w_branch
end type
end forward

global type w_branch from w_response
integer x = 214
integer y = 221
integer width = 3003
integer height = 1916
string title = "ادارة الفــــروع"
windowtype windowtype = child!
boolean righttoleft = true
boolean center = true
boolean ib_isupdateable = false
uo_2 uo_2
tab_1 tab_1
cb_close cb_close
cb_delete cb_delete
cb_save cb_save
cb_add cb_add
dw_1 dw_1
p_1 p_1
end type
global w_branch w_branch

type variables
boolean ib_change = false,ib_new = False
uo_resize iuo_resize

end variables

forward prototypes
public function string of_readscript (string ar_file_nm)
public function long fn_createdb ()
public function boolean of_writescript ()
public subroutine of_ole_object ()
public subroutine of_default_check ()
public subroutine of_postitemchange (ref u_dw dw)
public function boolean of_default_check (ref u_dw dw)
public subroutine of_fill_array (ref str_pass_parmeters ar_parm, u_dw dw, string as_field_nm)
public function long of_getdefault (u_dw dw, string as_field_nm)
public function integer of_create_job (string as_source_db, string as_destination_db)
public function integer of_drop_job (string as_job_name)
end prototypes

public function string of_readscript (string ar_file_nm);integer li_FileNum, loops, i

long flen, bytes_read, new_pos

String ls_script
blob b, tot_b

// Set a wait cursor

SetPointer(HourGlass!)

// Get the file length, and open the file
flen = FileLength(ar_file_nm)

li_FileNum = FileOpen(ar_file_nm, StreamMode!, Read!, LockRead!)

// Determine how many times to call FileRead
IF flen > 32765 THEN
		IF Mod(flen, 32765) = 0 THEN
			loops = flen/32765
		ELSE
			loops = (flen/32765) + 1
		END IF
ELSE
		loops = 1
END IF

// Read the file
new_pos = 1
FOR i = 1 to loops
		bytes_read = FileRead(li_FileNum, ls_script)
		tot_b = tot_b + b
NEXT

FileClose(li_FileNum)

//MessageBox("",ls_script)

Return ls_script
end function

public function long fn_createdb ();String ls_Syntax,ls_result
Long ll_db_id
string ls_db_name 

SetPointer(HourGlass!)
//////create Transaction Object
Transaction SQLCA_II
SQLCA_II = create Transaction
SQLCA_II.DBMS = SQLCA.DBMS
SQLCA_II.Database = SQLCA.Database
SQLCA_II.LogPass = SQLCA.LogPass
SQLCA_II.ServerName = SQLCA.ServerName
SQLCA_II.LogId = SQLCA.LogId
SQLCA_II.AutoCommit = True
SQLCA_II.DBParm = SQLCA.DBParm
//Connect the Transaction Object
Connect Using SQLCA_II;

SELECT Max(database_id) 
	INTO :ll_db_id
	FROM master.sys.databases ;

ls_db_name = 'Shop'+String(ll_db_id) 

ls_Syntax = "	CREATE DATABASE "+ls_db_name

Execute Immediate :ls_Syntax Using SQLCA_II;

IF(SQLCA_II.sqldbcode <> 0)Then

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

return ll_db_id
end function

public function boolean of_writescript ();integer li_FileNum
//String ls_AppPath

//ls_AppPath = gnv_services.of_applicationpath( )

FileDelete(gs_AppPath+"result.txt")

run("sqlcmd -S "+SQLCA.servername+" -E -d Shop15 -i ''"+gs_AppPath+"Demo.sql'' -o ''"+gs_AppPath+"result.txt'' ")

Return True
end function

public subroutine of_ole_object ();OleObject wsh
integer  li_rc

//CONSTANT integer MAXIMIZED = 3
//CONSTANT integer MINIMIZED = 2
//CONSTANT integer NORMAL = 1
//CONSTANT boolean WAIT = TRUE
//CONSTANT boolean NOWAIT = FALSE
//
wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "WScript.Shell" )

li_rc = wsh.Run("sqlcmd -S "+SQLCA.servername+" -U "+SQLCA.logid +" -P "+SQLCA.logpass +" -d Shop13 -i C:\ERP\Demo.sql -o C:\ERP\result.txt" , NORMAL, WAIT)
messagebox("hello", "world")

end subroutine

public subroutine of_default_check ();
end subroutine

public subroutine of_postitemchange (ref u_dw dw);of_default_check(dw)
end subroutine

public function boolean of_default_check (ref u_dw dw);Long ll_row , ll_count,ll_default = 0
boolean lb_res =false

ll_count = dw.RowCount()

For ll_row=1 to ll_count
	
	if(dw.GetItemString(ll_row , "default_fg") = "Y")Then
		ll_default++
	
		if(ll_default > 1)Then
		
			dw.SetItem(ll_row , "default_fg" , "N")
			ll_default = 1
			lb_res = True
		end if
		
	End if
	
Next

return lb_res
end function

public subroutine of_fill_array (ref str_pass_parmeters ar_parm, u_dw dw, string as_field_nm);Long ll_row,ll_count,ll_pos

ll_count = dw.RowCount()
ll_pos = 1
for ll_row=1 to ll_count
	if(dw.GetItemString(ll_row , "default_fg") = "N")Then
		ar_parm.Long_parm[ll_pos] = dw.GetItemNumber(ll_row , as_field_nm)
		ll_pos++
	end if
next

end subroutine

public function long of_getdefault (u_dw dw, string as_field_nm);Long ll_row , ll_count

ll_count = dw.RowCount()

for ll_row=1 to ll_count
	if(dw.GetItemString(ll_row , "default_fg") = "Y")Then
		return dw.GetItemNumber(ll_row , as_field_nm)		
	end if
next

SetNull(ll_count)

return ll_count
end function

public function integer of_create_job (string as_source_db, string as_destination_db);DataStore lds
Long ll_res = 1
lds = Create DataStore
lds.DataObject = "d_sp_create_job"
lds.SetTransObject(SQLCA)
lds.Retrieve(as_source_db , as_destination_db )

if(lds.GetItemNumber(1,"Result") <> 0)Then
	ll_res = -1
end if

Destroy lds

return ll_res
end function

public function integer of_drop_job (string as_job_name);DataStore lds
Long ll_res = 1
lds = Create DataStore
lds.DataObject = "d_sp_drop_job"
lds.SetTransObject(SQLCA)
lds.Retrieve( as_Job_name )

if(lds.GetItemNumber(1,"Result") <> 0)Then
	ll_res = -1
end if

Destroy lds

return ll_res
end function

on w_branch.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.tab_1=create tab_1
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_add=create cb_add
this.dw_1=create dw_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.p_1
end on

on w_branch.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.tab_1)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.dw_1)
destroy(this.p_1)
end on

event open;call super::open;
iuo_resize = CREATE uo_resize
iuo_resize.of_setTag(this)



dw_1.settransobject( SQLCA)
dw_1.event pfc_retrieve( )
 tab_1.tabpage_warehouse.dw_3.event pfc_retrieve( )
 
//uo_1.event set_dw_nm( dw_1 , tab_1.tabpage_warehouse.dw_3, True)
uo_2.event set_dw_nm( dw_1 , tab_1.tabpage_warehouse.dw_3, True)
end event

event closequery;Long ll_answer

if ib_change then
	ll_answer = MessageBox("تنبيه","هل تريد حفظ التغيرات ؟",information!,yesnocancel!) 
	if ll_answer = 1 then
//		dw_1.Event pfc_update(True,True)
		cb_save.Event clicked( )
		return 1
	Else
		if ll_answer = 2 then
			return 0
		ELse
			return 1
		End if
	End if
	
	return 1
End if
end event

event resize;call super::resize;iuo_resize.of_doResize(this)
end event

type uo_2 from navigator_bar_adv within w_branch
integer x = 782
integer y = 1748
integer taborder = 30
end type

on uo_2.destroy
call navigator_bar_adv::destroy
end on

event prerowchange;call super::prerowchange;Long ll_answer
if(ib_change)Then
	ll_answer = MessageBox("تنبيه","هل تريد حفظ التغيرات ؟",information!,yesnocancel!) 
	if ll_answer = 1 then
		cb_save.Event clicked( )
		return True
	Else
		if ll_answer = 2 then
			ib_change = False
			This.cb_refresh.event clicked( )			
			return False
		ELse
			return True
		End if
	End if
Else
	return True
End if
end event

type tab_1 from tab within w_branch
integer x = 768
integer y = 1008
integer width = 2199
integer height = 720
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_warehouse tabpage_warehouse
tabpage_banks tabpage_banks
tabpage_client tabpage_client
end type

on tab_1.create
this.tabpage_warehouse=create tabpage_warehouse
this.tabpage_banks=create tabpage_banks
this.tabpage_client=create tabpage_client
this.Control[]={this.tabpage_warehouse,&
this.tabpage_banks,&
this.tabpage_client}
end on

on tab_1.destroy
destroy(this.tabpage_warehouse)
destroy(this.tabpage_banks)
destroy(this.tabpage_client)
end on

type tabpage_warehouse from userobject within tab_1
integer x = 18
integer y = 120
integer width = 2162
integer height = 584
long backcolor = 79741120
string text = "  المخــــــازن"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "C:\Applications\icons\hot\gif\16x16\Home.gif"
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_warehouse.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_warehouse.destroy
destroy(this.dw_3)
end on

type dw_3 from lol_dw within tabpage_warehouse
integer x = 5
integer y = 16
integer width = 2144
integer height = 560
integer taborder = 20
string dataobject = "d_branch_warehouse"
boolean righttoleft = true
end type

event buttonclicked;call super::buttonclicked;Long ll_row 

ib_change = True

If(dwo.name = "b_1")Then
	
		This.SetItem(row , "active_fg" , 'N')		
		This.SetItem(row , "deleted_by" , gstr_user_info.login_id )				
		This.SetItem(row , "deleted_dt" , gnv_services.uf_today( ) )						
		This.update(true,true)
		Commit;
		this.filter( )
		
End if

if(dwo.name = "b_2")Then
	str_pass_parmeters lstr_parm
	lstr_parm.string_parm[1] = "d_search_store_for_branch"
	lstr_parm.string_parm[2] = "-"
	
	of_fill_array( lstr_parm , This , "store_id" )
	
	//OpenWithParm(w_search_warehouse_for_branch,lstr_parm)
	
	lstr_parm = Message.powerobjectparm
	if(lstr_parm.long_array[1] > 0 )Then
		ll_row = this.insertrow( 0 )
		This.SetItem(ll_row , "id" , Long(gnv_services.uf_get_id_from_parm_cd( "BRANCH_STORE_LNK") ) )
		This.SetItem(ll_row , "store_id" , lstr_parm.long_array[1] )
		This.SetItem(ll_row , "branch_id" , dw_1.getItemNumber(dw_1.getrow() , "id"))
		This.SetItem(ll_row , "active_fg" , 'Y')		
		This.SetItem(ll_row , "created_by" , gstr_user_info.login_id )				
		This.SetItem(ll_row , "created_dt" , gnv_services.uf_today( ) )						
		if(this.RowCount() <= 1)Then
			This.SetItem(ll_row , "default_fg" , 'Y')
			dw_1.SetItem( dw_1.GetRow() , "default_store_id" ,   lstr_parm.long_array[1])
		else
			This.SetItem(ll_row , "default_fg" , 'N')			
		End if		
		
		cb_save.enabled = True
		
	End if
End if
end event

event pfc_retrieve;call super::pfc_retrieve;Long ll_branch_id , ll_row , ll_store_id

If(dw_1.RowCount() <= 0)Then
	Return 0
End if

ll_row = dw_1.GetRow()


ll_branch_id = dw_1.GetItemNumber(ll_row , "id")

tab_1.tabpage_banks.dw_2.retrieve( ll_branch_id )
tab_1.tabpage_client.dw_4.retrieve( ll_branch_id )

ll_store_id = This.retrieve( ll_branch_id )

dw_1.SetItem(ll_row , "default_bank_id" , of_GetDefault(tab_1.tabpage_banks.dw_2 , "bank_id"))
dw_1.SetItem(ll_row , "default_store_id" , of_GetDefault(tab_1.tabpage_warehouse.dw_3, "store_id"))

Return ll_store_id
end event

event constructor;call super::constructor;This.SetTransobject( SQLCA)
end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_row,ll_branch_id

ll_branch_id = dw_1.GetItemNumber(dw_1.GetRow() , "id")

for ll_row=1 to This.RowCount()
	if( IsNull(This.GetItemNumber(ll_row , "branch_id") ) )Then
		This.SetItem(ll_row , "branch_id" , ll_branch_id)
	End if
next

return 1

end event

event doubleclicked;call super::doubleclicked;String ls_default ,ls_value
Long ll_client_id

ls_value = This.GetItemString(row , "default_fg")
ll_client_id = This.GetItemNumber(row , "store_id")
if( ls_value = "Y")Then
	ls_default = "N"	
	SetNull(ll_client_id)
	dw_1.SetItem( dw_1.GetRow() , "default_store_id" ,  ll_client_id)
Else
	ls_default = "Y"
	
End if

cb_save.enabled = True

This.SetItem(row , "default_fg" , ls_default)
This.Accepttext( )

if(not of_default_check(tab_1.tabpage_warehouse.dw_3))Then
	this.sort( )
	dw_1.SetItem( dw_1.GetRow() , "default_store_id" ,  ll_client_id)
End if
end event

type tabpage_banks from userobject within tab_1
integer x = 18
integer y = 120
integer width = 2162
integer height = 584
long backcolor = 79741120
string text = "  الخــــزينة"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "C:\Applications\icons\hot\gif\16x16\Dollar.gif"
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_banks.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_banks.destroy
destroy(this.dw_2)
end on

type dw_2 from lol_dw within tabpage_banks
integer y = 8
integer width = 2149
integer height = 560
integer taborder = 20
string dataobject = "d_branch_banks"
boolean righttoleft = true
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

event buttonclicked;call super::buttonclicked;Long ll_row 
ib_change = True
If(dwo.name = "b_1")Then
	
		This.SetItem(row , "active_fg" , 'N')		
		This.SetItem(row , "deleted_by" , gstr_user_info.login_id )				
		This.SetItem(row , "deleted_dt" , gnv_services.uf_today( ) )						
		This.update(true,true)
		Commit;
		this.filter( )
		
End if

if(dwo.name = "b_2")Then
	str_pass_parmeters lstr_parm
	lstr_parm.string_parm[1] = "d_search_bank_for_branch"
	lstr_parm.string_parm[2] = "-"
	
	of_fill_array( lstr_parm , This , "bank_id" )
	
	//OpenWithParm(w_search_banks_for_branch,lstr_parm)
	
	lstr_parm = Message.powerobjectparm
	if(lstr_parm.long_array[1] > 0 )Then		
		ll_row = this.insertrow( 0 )
		This.SetItem(ll_row , "id" , Long(gnv_services.uf_get_id_from_parm_cd( "BRANCH_BANK_LNK") ))
		This.SetItem(ll_row , "Bank_id" , lstr_parm.long_array[1] )
		This.SetItem(ll_row , "branch_id" , dw_1.getItemNumber(dw_1.getrow() , "id"))
		This.SetItem(ll_row , "active_fg" , 'Y')		
		This.SetItem(ll_row , "created_by" , gstr_user_info.login_id )				
		This.SetItem(ll_row , "created_dt" , gnv_services.uf_today( ) )		
		if(this.RowCount() <= 1)Then
			This.SetItem(ll_row , "default_fg" , 'Y')
			dw_1.SetItem( dw_1.GetRow() , "default_bank_id" ,   lstr_parm.long_array[1])
		else
			This.SetItem(ll_row , "default_fg" , 'N')			
		End if		
		cb_save.enabled = True
	End if
End if
end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_row,ll_branch_id

ll_branch_id = dw_1.GetItemNumber(dw_1.GetRow() , "id")

for ll_row=1 to This.RowCount()
	if( IsNull(This.GetItemNumber(ll_row , "branch_id") ) )Then
		This.SetItem(ll_row , "branch_id" , ll_branch_id)
	End if
next

return 1
end event

event doubleclicked;call super::doubleclicked;String ls_default ,ls_value
Long ll_client_id

ls_value = This.GetItemString(row , "default_fg")
ll_client_id = This.GetItemNumber(row , "store_id")
if( ls_value = "Y")Then
	ls_default = "N"
	SetNull(ll_client_id)
	dw_1.SetItem( dw_1.GetRow() , "default_store_id" ,  ll_client_id)
Else
	ls_default = "Y"
	
End if

cb_save.enabled = True

This.SetItem(row , "default_fg" , ls_default)
This.Accepttext( )

if(not of_default_check(tab_1.tabpage_banks.dw_2))Then
	dw_1.SetItem( dw_1.GetRow() , "default_store_id" ,  ll_client_id)
	this.sort( )
End if
end event

type tabpage_client from userobject within tab_1
integer x = 18
integer y = 120
integer width = 2162
integer height = 584
long backcolor = 79741120
string text = "  الزبــائن"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "C:\Applications\icons\hot\gif\16x16\Customers.gif"
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_client.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_client.destroy
destroy(this.dw_4)
end on

type dw_4 from lol_dw within tabpage_client
integer x = 5
integer y = 4
integer width = 2139
integer height = 560
integer taborder = 30
string dataobject = "d_branch_client"
boolean righttoleft = true
end type

event buttonclicked;call super::buttonclicked;Long ll_row ,ll_id
ib_change = True
If(dwo.name = "b_1")Then
	
		This.SetItem(row , "active_fg" , 'N')		
		This.SetItem(row , "deleted_by" , gstr_user_info.login_id )				
		This.SetItem(row , "deleted_dt" , gnv_services.uf_today( ) )						
		This.update(true,true)
		Commit;
		this.filter( )
		
End if

if(dwo.name = "b_2")Then

	str_pass_parmeters lstr_parm
	
	ll_id = 	dw_1.getItemNumber(dw_1.getrow() , "id")
	if(IsNull(ll_id))Then ll_id = -1
	
	lstr_parm.string_parm[1] = "d_search_client_for_branch"
	lstr_parm.string_parm[2] = String(ll_id)
	of_fill_array(lstr_parm,This , "client_id")
	
	SetNull(ll_id)
	
	//OpenWithParm(w_search_client_for_branch,lstr_parm)
	
	lstr_parm = Message.powerobjectparm
	
	if(lstr_parm.long_array[1] > 0 )Then		
	
		ll_row = this.insertrow( 0 )
		This.SetItem(ll_row , "id" , Long(gnv_services.uf_get_id_from_parm_cd( "BRANCH_CLIENT_LNK") ))
		This.SetItem(ll_row , "client_id" , lstr_parm.long_array[1] )
		This.SetItem(ll_row , "branch_id" , ll_id)
		This.SetItem(ll_row , "active_fg" , 'Y')		
		This.SetItem(ll_row , "created_by" , gstr_user_info.login_id )				
		This.SetItem(ll_row , "created_dt" , gnv_services.uf_today( ) )		
		
		if(this.RowCount() <= 1)Then
			This.SetItem(ll_row , "default_fg" , 'Y')
			dw_1.SetItem( dw_1.GetRow() , "default_client_id" ,   lstr_parm.long_array[1])
		else
			This.SetItem(ll_row , "default_fg" , 'N')			
		End if
		
		cb_save.enabled = True
		
	End if
End if
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_row,ll_branch_id

ll_branch_id = dw_1.GetItemNumber(dw_1.GetRow() , "id")

for ll_row=1 to This.RowCount()
	if( IsNull(This.GetItemNumber(ll_row , "branch_id") ) )Then
		This.SetItem(ll_row , "branch_id" , ll_branch_id)
	End if
next

return 1

end event

event doubleclicked;call super::doubleclicked;String ls_default ,ls_value
Long ll_client_id

ls_value = This.GetItemString(row , "default_fg")
ll_client_id = This.GetItemNumber(row , "client_id")
if( ls_value = "Y")Then
	ls_default = "N"	
	SetNull(ll_client_id)
	dw_1.SetItem( dw_1.GetRow() , "default_client_id" ,  ll_client_id)
Else
	ls_default = "Y"
	
End if

cb_save.enabled = True

This.SetItem(row , "default_fg" , ls_default)
This.Accepttext( )

if(not of_default_check(tab_1.tabpage_client.dw_4))Then
	this.sort( )
	dw_1.SetItem( dw_1.GetRow() , "default_client_id" ,  ll_client_id)
End if
end event

type cb_close from u_cb within w_branch
integer x = 1801
integer y = 1736
integer width = 288
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خروج"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_delete from u_cb within w_branch
integer x = 2386
integer y = 1736
integer width = 288
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إلغاء"
end type

event clicked;call super::clicked;if(MessageBox("تنبيه","هل انت متاكد من الالغاء؟",information!,yesno!) = 1)then

  dw_1.SetItem( dw_1.GetRow() , "Active_fg","N")
  dw_1.setitem( dw_1.GetRow() , "last_modified_by" , gstr_user_info.login_id )
  dw_1.setitem( dw_1.GetRow() , "last_modified_dt" , datetime(today(),Now()) )
  dw_1.event pfc_update( True , True)
  dw_1.retrieve( )
 
  
end if
end event

type cb_save from u_cb within w_branch
integer x = 2094
integer y = 1736
integer width = 288
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "حفـــظ"
end type

event clicked;call super::clicked;Long ll_db_id
//cs_sync lc_sync
//lc_sync = Create cs_sync

IF(ib_new)Then
	
	IF(dw_1.event pfc_update( True , True ) = 1) Then
		Commit;
		str_pass_parmeters lstr_pass
		
		lstr_pass.long_array[1] = dw_1.GetItemNumber(dw_1.GetRow() , "id")

	//	OpenWithParm(w_create_branch,lstr_pass)	
	
		lstr_pass = Message.PowerObjectParm
	
		IF( lstr_pass.string_parm[1] = "1" )Then
			gnv_services.retrieve_dddw( dw_1, 0, "dbid")
//	     		dw_1.SetItem(dw_1.GetRow() , "dbid" , lstr_pass.long_array[1] )			
//  		     dw_1.event pfc_update( True , True )
		     Commit;
			ib_change = False
			ib_new = False
		Else
			dw_1.deleterow( dw_1.getrow())
			dw_1.event pfc_update( True , True )
			Commit;
			//lc_sync.of_dropdb( lc_sync.of_dbnm( lstr_pass.long_array[1]  ) )
		End if
	End if

Else
	IF(dw_1.event pfc_update( True , True ) = 1) Then
		ib_change = False
		ib_new = False
	End if
End if

if(tab_1.tabpage_warehouse.dw_3.Event pfc_update(True , True) = 1)Then
	Commit;
End if

if(tab_1.tabpage_banks.dw_2.Event pfc_update(True , True) = 1 )Then
	Commit;
End if

if(tab_1.tabpage_client.dw_4.Event pfc_update(True , True) = 1)Then
	Commit;
End if


cb_add.Enabled    = True
cb_delete.Enabled = True
cb_save.Enabled   = False
end event

type cb_add from u_cb within w_branch
integer x = 2679
integer y = 1736
integer width = 288
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إضافة"
end type

event clicked;call super::clicked;dw_1.event pfc_insertrow( )

tab_1.tabpage_banks.dw_2.retrieve(0)
tab_1.tabpage_warehouse.dw_3.retrieve(0)
tab_1.tabpage_client.dw_4.retrieve(0)


cb_add.Enabled    = False
cb_delete.Enabled = False
cb_save.Enabled   = True

end event

type dw_1 from u_dw within w_branch
integer x = 759
integer width = 2217
integer height = 996
integer taborder = 10
string dataobject = "d_branch_cd"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean righttoleft = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;This.settransobject( SQLCA )
end event

event itemchanged;call super::itemchanged;This.accepttext( )

This.setitem( row , "last_modified_by" , gstr_user_info.login_id )
This.setitem( row , "last_modified_dt" , datetime(today(),Now()) )


cb_add.enabled   = False
cb_delete.enabled = False
cb_save.enabled  = True
ib_change = True

end event

event type long pfc_insertrow();Long ll_row

ll_row = This.insertrow(0)

if IsNull(ll_row) or ( ll_row = -1 ) then
	
	MessageBox('Error' , 'Can not add new record')
	return 0
	
else
	
	This.setitem( ll_row , "active_fg"        , "Y")
	This.setitem( ll_row , "Created_by" , gstr_user_info.login_id )
  	This.setitem( ll_row , "Created_dt" , datetime(today(),Now()) )
		
   	This.scrolltorow( ll_row )	
	ib_new = True
	return 1	
	
End if
	
	
end event

event pfc_retrieve;call super::pfc_retrieve;return This.retrieve( )
end event

event type integer pfc_update(boolean ab_accepttext, boolean ab_resetflag);Long ll_update

ll_update = This.update( )

if ll_update = -1 or IsNull(ll_update) then
	
	ROLLBACK ;
	
	MessageBox("Error","Can not Update Your Data")
	
	return 0
	
else
	
	COMMIT ;
	
	
	return 1
	
End if
end event

event editchanged;call super::editchanged;ib_change = True
end event

event buttonclicked;call super::buttonclicked;if(dwo.name = "b_1")Then
	gstr_parm.string_parm[1] = "-"	
	str_pass_parmeters lstr_parm
	lstr_parm.string_parm[1] = "d_customer_list_by_dealer"
	lstr_parm.string_parm[2] = "-"
	lstr_parm.string_parm[1] = "d_customer_list_2"
	lstr_parm.string_parm[2] = "-"

	//openWithParm(w_customer_search,lstr_parm)
  	lstr_parm = Message.powerobjectparm
	  
  	if lstr_parm.long_array[1] > 0 then
		This.SetItem( row , "default_client_id" , lstr_parm.long_array[1] )
  	End if
End if
end event

event pfc_postupdate;call super::pfc_postupdate;//cs_sync lcs_sync
String ls_org_flag , ls_cur_flag,ls_dbname
Long ll_row ,ll_res = 1

ll_row = This.Getrow()

//lcs_sync = Create cs_sync

ls_org_flag = This.GetItemString(ll_row,"online_fg" , delete!,True)
ls_cur_flag = This.GetItemString(ll_row,"online_fg")
//ls_dbname = lcs_sync.of_dbnm( This.GetItemNumber(ll_row , "dbid") )

if(IsNull(ls_org_flag))Then
	if(ls_cur_flag = "Y")Then
		ll_res = of_Create_job(SQLCA.DataBase ,  ls_dbname )
	end if
else
	if(ls_org_flag <> ls_cur_flag )then
		if(ls_cur_flag = "Y")then
			ll_res = of_Create_job(SQLCA.DataBase ,  ls_dbname )
		else
			ll_res = of_Drop_job("Merge_"+ls_dbname )
		end if
	else
		ll_res = 1
	end if
end if

//Destroy lcs_sync

return ll_res
end event

type p_1 from picture within w_branch
integer width = 750
integer height = 1832
string picturename = "C:\Applications\icons\banners\Green Banner.bmp"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

