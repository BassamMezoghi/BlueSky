$PBExportHeader$n_swap_money.sru
forward
global type n_swap_money from n_bll
end type
end forward

global type n_swap_money from n_bll
string is_shareddata = "Y"
string is_systempart = "SwapMoney"
string is_mastertable = "BANK_TRANSACTIONS"
string is_master_id_column_nm = "ID"
string is_filter_dataobject = "d_ext_search_expensses"
string is_result_dataobject = "d_search_swap_money"
string is_master_dataobject = "d_swap_money"
string is_special_btn_title = "تحويلات الخزينة"
end type
global n_swap_money n_swap_money

forward prototypes
public function long of_master_postinsert (long ar_row)
public function integer of_master_validation (long row)
public function long of_list_retrieve (long row)
public function integer of_master_preupdate (long row)
public function string of_search ()
public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data)
end prototypes

public function long of_master_postinsert (long ar_row);idw_master.SetItem( ar_row , "ACTIVE_FG"			, "Y")
idw_master.SetItem( ar_row , "POST_FG"				, "N")
idw_master.SetItem( ar_row , "BT_DT"        			, datetime(today(),time("00:00:00")))
idw_master.SetItem( ar_row , "CREATED_BY" 			, gstr_user_info.login_id )
idw_master.SetItem( ar_row , "CREATED_DT" 			, datetime(Today(),Now()) )

Return SUCCESS
end function

public function integer of_master_validation (long row);IF idw_master.GetItemNumber(row , "bank_id") = idw_master.GetItemNumber(row , "bank_id_") THEN
	
	MessageBox("تنبيه","يجب ان  تكون الخزينة مختلفة ")
	Return FAILURE
	
END IF

IF IsNull(idw_master.GetItemNumber(row , "bank_id")) or IsNull(idw_master.GetItemNumber(row , "bank_id_")) THEN
	
	MessageBox("تنبيه","يجب اختيار الخزينة")
	Return FAILURE
	
END IF

//IF IsNull(idw_master.GetItemDecimal(row , "amount")) or idw_master.GetItemDecimal(row , "amount") = 0 THEN
//	
//	MessageBox("تنبيه","يجب ان يكون المبلغ اكبر من  0")
//	Return FAILURE
//	
//END IF

Return SUCCESS
end function

public function long of_list_retrieve (long row);Return no_action
end function

public function integer of_master_preupdate (long row);Long ll_row
String ls_id

ll_row = idw_master.GetRow()

ls_id = idw_master.GetItemString( ll_row ,is_Master_id_column_nm )

IF IsNull(ls_id) THEN
	idw_master.SetItem( ll_row  , is_Master_id_column_nm , String(gstr_user_info.dbid )+"-"+gnv_services.uf_get_id_from_parm_cd(is_MasterTable) ) 
END IF
	
Return SUCCESS
end function

public function string of_search ();String   ls_cond , ls_condition , ls_mid 
Long     ll_bill_no ,ll_to_bill_no  , ll_client_id    , ll_sc_id
DateTime ldt_bill_dt , ldt_to_dt
Decimal ld_amount , ld_to_amount

ls_cond = " AND (POST_FG = '"+is_post+"') "

//**************************************************
//Bill date Condition
//*************************************************
ls_condition = ""
ls_condition = idw_filter.GetItemString(1 , "bill_cond")
ldt_bill_dt = idw_filter.GetItemDateTime(1 , "bill_dt")
  
IF Not IsNull(ldt_bill_dt) Then
	
	IF IsNull(ls_condition) OR ls_condition = "" Then ls_condition = "="
	
	Choose Case ls_condition		
		Case "-"
			ldt_to_dt = idw_filter.GetItemDateTime(1 , "to_bill_dt")
			If(IsNull(ldt_to_dt))Then 
				ls_cond += " and (BT_DT between '"+String(ldt_bill_dt, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_bill_dt , "dd mmm yyyy")+" 23:59:59')"
			ELSE
				ls_cond += " and (BT_DT between '"+String(ldt_bill_dt, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to_dt , "dd mmm yyyy")+" 23:59:59')"
			END IF
		Case Else 
	  		   	  ls_cond += " and (BT_DT "+ls_condition+" '"+string(ldt_bill_dt, "dd mmm yyyy")+" 00:00:00' )"
	end choose
End if

//**************************************************
//Bill No Condition
//*************************************************
ls_condition = ""
ls_condition = idw_filter.GetItemString(1 , "billno_cond")
ll_bill_no  = idw_filter.GetItemNumber(1 , "bill_no"  )
  	
IF Not IsNull(ll_bill_no) THEN
	
	IF IsNull(ls_condition) OR ls_condition = "" Then ls_condition = "="
	
	Choose Case ls_condition		
		Case "-"
			ll_to_bill_no = idw_filter.GetItemNumber(1 , "to_bill_no")
			IF IsNull(ll_to_bill_no) THEN
				IF ll_bill_no > 0 THEN
					ls_cond += " and (SUBSTRING(ID ,CHARINDEX('-',ID,1) +1 , len(ID))  between "+String(ll_bill_no)+" and "+string(ll_bill_no)+")"
				END IF
			ELSE
				IF ll_bill_no > 0 THEN
					ls_cond += " and (SUBSTRING(ID ,CHARINDEX('-',ID,1) +1 , len(ID)) between "+String(ll_bill_no)+" and "+string(ll_to_bill_no)+")"
				END IF
			END IF
		Case Else 
			IF ll_bill_no > 0 THEN
  		     		ls_cond += " and (SUBSTRING(ID ,CHARINDEX('-',ID,1) +1 , len(ID))  "+ls_condition+" "+String(ll_bill_no)+" )"				
				
			END IF
	End Choose
End if
//**************************************************
//Bill Amount Condition
//*************************************************
ls_condition = ""
ls_condition = idw_filter.GetItemString(1 , "amount_cond")
ld_amount  = idw_filter.GetItemDecimal(1 , "amount"  )
 	
  IF Not IsNull(ld_amount) Then 

	IF IsNull(ls_condition) OR ls_condition = "" Then ls_condition = "="

	Choose Case ls_condition		
		Case "-"
			ld_to_amount = idw_filter.GetItemDecimal(1 , "to_amount")
			IF IsNull(ld_to_amount) Then 
				ls_cond += " and (AMOUNT between "+String(ld_amount)+" and "+string(ld_amount)+")"
			ELSE
				ls_cond += " and (AMOUNT between "+String(ld_amount)+" and "+string(ld_to_amount)+")"
			End if
		Case Else 
  		     ls_cond += " and (AMOUNT "+ls_condition+" "+String(ld_amount)+" )"				
	End Choose
End if

Return is_sql + ls_cond

end function

public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data);idw_master.setitem( ar_row , "last_modified_by" , gstr_user_info.login_id )
idw_master.setitem( ar_row , "last_modified_dt" , datetime(today(),now()) )

ib_change = True
end subroutine

on n_swap_money.create
call super::create
end on

on n_swap_money.destroy
call super::destroy
end on

