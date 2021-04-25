$PBExportHeader$n_cst_bank.sru
forward
global type n_cst_bank from n_base
end type
end forward

global type n_cst_bank from n_base
end type
global n_cst_bank n_cst_bank

type variables
Long il_X,il_Y

end variables

forward prototypes
public function integer of_select_bank ()
public function long of_all_banks ()
public function datastore of_bank_list ()
public function integer of_select_employee_banks ()
public function long of_select_defaut_back (long branch_id)
public function long of_get_default_bank ()
end prototypes

public function integer of_select_bank ();str_pass_parmeters lstr_parm

if(gstr_user_info.hq)Then
//HQ
	if(gstr_user_info.office_id = "0")Then//HQ with main branch
		lstr_parm.string_parm[1] = "d_search_bank_for_branch"
		lstr_parm.string_parm[2] = "-"
	Else//selected branch
		lstr_parm.string_parm[1] = "d_search_bank_by_branch"
 		lstr_parm.string_parm[2] = gstr_user_info.office_id
	end if				
Else

		lstr_parm.string_parm[1] = "d_search_bank_by_branch"
 		lstr_parm.string_parm[2] = gstr_user_info.office_id
	   	
End if

/*************************************/
//lstr_parm.long_array[1] = w_menu.PointerX()
//lstr_parm.long_array[2] = w_menu.Pointery()

//OpenWithParm(w_search_banks_for_branch,lstr_parm)

lstr_parm = Message.powerobjectparm

if(lstr_parm.Long_array[1] = -1)then
	SetNull(lstr_parm.Long_array[1])
End if

Return lstr_parm.Long_array[1]
end function

public function long of_all_banks ();str_pass_parmeters lstr_parm

lstr_parm.string_parm[1] = "d_search_banks"
lstr_parm.string_parm[2] = "-"
/*************************************/
lstr_parm.long_array[1] = il_X
lstr_parm.long_array[2] = il_Y

//OpenWithParm(w_search_banks_for_branch,lstr_parm)

lstr_parm = Message.powerobjectparm

if(lstr_parm.Long_array[1] = -1)then
	SetNull(lstr_parm.Long_array[1])
End if

Return lstr_parm.Long_array[1]
end function

public function datastore of_bank_list ();DataStore lds

lds = Create DataStore

lds.DataObject = "d_bank"
lds.SetTransObject(SQLCA)
lds.Retrieve( )
lds.SetFilter( "Active_fg = 'Y'")
lds.Filter()

return lds
end function

public function integer of_select_employee_banks ();str_pass_parmeters lstr_parm

if(gstr_user_info.hq)Then
//HQ
	if(gstr_user_info.office_id = "0")Then//HQ with main branch
		lstr_parm.string_parm[1] = "d_search_bank_for_branch"
		lstr_parm.string_parm[2] = "-"
	Else//selected branch
		lstr_parm.string_parm[1] = "d_search_bank_by_branch"
 		lstr_parm.string_parm[2] = gstr_user_info.office_id
	end if				
Else

		lstr_parm.string_parm[1] = "d_search_bank_by_branch"
 		lstr_parm.string_parm[2] = gstr_user_info.office_id
	   	
End if

lstr_parm.string_parm[3] = "-"
/*************************************/
lstr_parm.long_array[1] = il_X
lstr_parm.long_array[2] = il_Y

//OpenWithParm(w_search_banks_for_branch,lstr_parm)

lstr_parm = Message.powerobjectparm

if(lstr_parm.Long_array[1] = -1)then
	SetNull(lstr_parm.Long_array[1])
End if

Return lstr_parm.Long_array[1]
end function

public function long of_select_defaut_back (long branch_id);Long ll_bank_id

SELECT TOP 1 BANK_ID
INTO :ll_bank_id
FROM BRANCH_BANK_LNK
WHERE ACTIVE_FG = 'Y' AND 
			 DEFAULT_FG = 'Y' AND 
			 BRANCH_ID = :branch_id;

IF IsNull(ll_bank_id) THEN
	Return 0
END IF

Return ll_bank_id
end function

public function long of_get_default_bank ();Long ll_bank_id

SELECT LONG_VALUE
INTO :ll_bank_id
FROM PARAM_CD
WHERE PARM_NM = "Default_bank";

IF IsNull(ll_bank_id) THEN
	ll_bank_id = 0
END IF
Return ll_bank_id
end function

on n_cst_bank.create
call super::create
end on

on n_cst_bank.destroy
call super::destroy
end on

