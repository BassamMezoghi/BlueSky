$PBExportHeader$n_cst_store.sru
forward
global type n_cst_store from n_base
end type
end forward

global type n_cst_store from n_base
end type
global n_cst_store n_cst_store

forward prototypes
public function integer of_select_store ()
public function datastore of_warehouse_list ()
public function integer of_default_store ()
end prototypes

public function integer of_select_store ();str_pass_parmeters lstr_parm

if(gstr_user_info.hq)Then

	if(gstr_user_info.office_id = "0")Then
		lstr_parm.string_parm[1] = "d_search_all_store"
		lstr_parm.string_parm[2] = "-"
	Else
		lstr_parm.string_parm[1] = "d_search_store_by_branch"
 		lstr_parm.string_parm[2] = gstr_user_info.office_id
	end if				
				
Else

		lstr_parm.string_parm[1] = "d_search_store_by_branch"
 		lstr_parm.string_parm[2] = gstr_user_info.office_id
	   	
End if

//OpenWithParm(w_search_warehouse_for_branch,lstr_parm)

lstr_parm = Message.powerobjectparm

if(lstr_parm.Long_array[1] = -1)then
	SetNull(lstr_parm.Long_array[1])
End if

Return lstr_parm.Long_array[1]
end function

public function datastore of_warehouse_list ();DataStore lds

lds = Create DataStore
lds.DAtaObject = "d_store_info"
lds.SetTransObject(SQLCA)
lds.retrieve( )

lds.SetFilter( "Active_fg='Y'")
lds.Filter( )

return lds
end function

public function integer of_default_store ();Long ll_bank_id

SELECT LONG_VALUE
INTO :ll_bank_id
FROM PARAM_CD
WHERE PARM_NM = "Default_store";

IF IsNull(ll_bank_id) THEN
	ll_bank_id = 0
END IF

Return ll_bank_id
end function

on n_cst_store.create
call super::create
end on

on n_cst_store.destroy
call super::destroy
end on

