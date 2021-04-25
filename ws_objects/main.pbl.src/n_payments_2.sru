$PBExportHeader$n_payments_2.sru
forward
global type n_payments_2 from n_bll
end type
end forward

global type n_payments_2 from n_bll
string is_shareddata = "Y"
string is_systempart = "PAYMENTS"
string is_mastertable = "PAYMENTS"
string is_master_id_column_nm = "ID"
string is_filter_dataobject = "d_ext_search_sales"
string is_result_dataobject = "d_search_payments_ii"
string is_master_dataobject = "d_payment_ii"
string is_ar_invoice_dataobject = "d_inv_contract_ii"
string is_en_invoice_dataobject = "d_inv_contract"
string is_invoice_btn_title = "طباعة"
end type
global n_payments_2 n_payments_2

type variables
DataStore ids_available 
end variables

forward prototypes
public function integer of_master_preupdate (long row)
public function string of_search ()
public subroutine of_master_btn_clicked (dwobject dwo, long row)
public function long of_master_postinsert (long ar_row)
public function integer of_master_validation (long row)
public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data)
public subroutine of_invoice ()
public function boolean of_sharevalidation (string ar_cid)
public function boolean salary_fg (string ar_flag)
public function boolean trading_fg (string ar_flag)
public function boolean savings_fg (string ar_flag)
public function boolean investment_fg (string ar_flag)
public function boolean heritage_fg (string ar_flag)
end prototypes

public function integer of_master_preupdate (long row);String ls_total_in_letter
Decimal ld_total_amount , ld_total_amount_
Long ll_row , ll_id , ll_RowCount
String ls_id , ls_ColType


IF NOT ib_MasterIdentity THEN
			
		ls_ColType = idw_master.Describe( is_master_id_column_nm+".ColType" )
		idw_result.Modify( is_master_id_column_nm+".identity='no'")	
		
		Choose Case ls_ColType
			Case "long"
				ll_id = idw_master.GetItemNumber( row , is_master_id_column_nm )
				IF IsNull(ll_id) THEN
			
					idw_master.setitem( row  , is_master_id_column_nm , Long(gnv_services.uf_get_id_from_parm_cd(is_MasterTable+"."+is_master_id_column_nm) ) ) 
					
				END IF
				
			Case Else 
				ls_id = idw_master.GetItemString( row , is_master_id_column_nm )
				IF IsNull(ls_id) THEN
			
					idw_master.setitem( row  , is_master_id_column_nm , gstr_user_info.dbid +"-"+gnv_services.uf_get_id_from_parm_cd(is_MasterTable+"_"+gstr_user_info.dbid) ) 
					
				END IF
		END CHOOSE
		
END IF


Return SUCCESS
end function

public function string of_search ();String ls_cond ,ls_nm ,ls_bill_cond  , ls_amount_cond, ls_bill_dt_cond
Long ll_bill_no , ll_to_bill_no
DateTime ldt_payment_dt , ldt_to_payment_dt
Decimal ld_amount , ld_to_amount

ls_nm 				= idw_filter.GetItemString(1 , "nm")
ll_bill_no 			= idw_filter.GetItemNumber(1 , "bill_no")
ll_to_bill_no 		= idw_filter.GetItemNumber(1 , "to_bill_no")
ls_bill_cond 		= idw_filter.GetItemString(1 , "billno_cond")
ldt_payment_dt 	= idw_filter.GetItemDatetime(1 , "bill_dt")
ldt_to_payment_dt = idw_filter.GetItemDatetime(1 , "to_bill_dt")
ls_bill_dt_cond 	= idw_filter.GetItemString(1 , "bill_cond")
ld_amount 			= idw_filter.GetItemDecimal(1 , "amount" )
ld_to_amount 		= idw_filter.GetItemDecimal(1 , "to_amount" )
ls_amount_cond 	= idw_filter.GetItemString(1 , "amount_cond")


IF gstr_user_info.office_id = '0' THEN
	ls_cond = " AND (POST_FG = '"+is_post+"') "
ELSE
	ls_cond = " AND (POST_FG = '"+is_post+"') AND ( ID like '"+gstr_user_info.office_id+"-%') "
END IF


IF not IsNull(ls_nm) THEN
	
	ls_cond += " AND ( cid = '"+ls_nm+"') "
	
END IF

IF not IsNull(ll_bill_no) THEN
	
	IF ls_bill_cond <> "-" THEN
	
		ls_cond += " AND ( cast( substring(ID , 3 ,len(id)) as int) "+ls_bill_cond+" "+String(ll_bill_no)+" ) "
		
	ELSE
		
		ls_cond += " AND ( cast( substring(ID , 3 ,len(id)) as int) between "+String(ll_bill_no)+" and  "+String(ll_to_bill_no)+" ) "
		
	END IF
	
END IF

IF not IsNull(ldt_payment_dt) THEN
	
	IF ls_bill_dt_cond <> "-" THEN
	
		ls_cond += " AND ( PAYMENT_DT "+ls_bill_dt_cond+" '"+String(ldt_payment_dt , "dd MMM yyyy")+"' ) "
		
	ELSE
		
		ls_cond += " AND ( PAYMENT_DT between '"+String(ldt_payment_dt , "dd MMM yyyy")+"' and '"+String(ldt_to_payment_dt , "dd MMM yyyy")+"' ) "
		
	END IF
	
END IF

IF not IsNull(ld_amount) THEN
	
	IF ls_amount_cond <> "-" THEN
	
		ls_cond += " AND ( amount "+ls_amount_cond+" "+String(ld_amount)+" ) "
		
	ELSE
		
		ls_cond += " AND ( amount between "+String(ld_amount)+" and "+String(ld_to_amount)+" ) "
		
	END IF
	
END IF


Return is_sql + ls_cond
end function

public subroutine of_master_btn_clicked (dwobject dwo, long row);Long ll_id
String ls_type , ls_id
str_pass_parmeters lstr_parm
n_cst_store cs

IF dwo.name = "b_gui" THEN
	of_generate_gui(is_systemPart , idw_master)
	return 
END IF


IF(dwo.name = "b_clients")Then

	OpenWithParm(w_clients_search , lstr_parm)
	
	lstr_parm = Message.PowerObjectParm

	IF( upperbound(lstr_parm.string_parm) > 0 )Then
	
		ls_id = idw_master.GetItemString(row , "id")
		
		IF isnull(ls_id) THEN
			IF lstr_parm.string_parm[2] = "O" THEN
			 SELECT 1000000 - IsNull(SUM(SHARS),0) 
				 INTO :ll_id
				 FROM PAYMENTS  
				 WHERE PAYMENTS.CID = :lstr_parm.string_parm[1]
						AND 
						 PAYMENTS.ACTIVE_FG = 'Y';				
			ELSE
			 SELECT 500000 - IsNull(SUM(SHARS),0) 
				 INTO :ll_id
				 FROM PAYMENTS  
				 WHERE PAYMENTS.CID = :lstr_parm.string_parm[1]
						AND 
						 PAYMENTS.ACTIVE_FG = 'Y';
			END IF
		ELSE
			IF lstr_parm.string_parm[2] = "O" THEN
				SELECT 1000000 - IsNull(SUM(SHARS),0) 
					INTO :ll_id
					FROM PAYMENTS  
					WHERE PAYMENTS.CID = :lstr_parm.string_parm[1]
						AND 
						 PAYMENTS.ID <> :ls_id 
						AND 
						 PAYMENTS.ACTIVE_FG = 'Y' ;				
			ELSE
				SELECT 500000 - IsNull(SUM(SHARS),0) 
					INTO :ll_id
					FROM PAYMENTS  
					WHERE PAYMENTS.CID = :lstr_parm.string_parm[1]
						AND 
						 PAYMENTS.ID <> :ls_id 
						AND 
						 PAYMENTS.ACTIVE_FG = 'Y' ;
			END IF
		END IF
		
//		IF IsNull(ll_id) THEN ll_id = 500000
		
     	idw_master.SetItem( row , "cid" , lstr_parm.string_parm[1] )
     	idw_master.SetItem( row , "account" , ll_id - lstr_parm.long_array[1] )
		
		of_master_itemchange( dwo, row , lstr_parm.string_parm[1] )

	End if
	Return 
End if

IF dwo.name = "b_from_banks" THEN

	lstr_parm.string_parm[1] = "d_search_from_banks"
	OpenWithParm(w_search_banks , lstr_parm)
	
	lstr_parm = Message.PowerObjectParm
	
	IF lstr_parm.long_array[1] > 0 THEN
		
	   idw_master.SetItem( row , "from_bank_id" , lstr_parm.long_array[1] )
		of_master_itemchange( dwo, row , String(lstr_parm.long_array[1]) )	

	END IF
	Return 
END IF


IF(dwo.name = "b_sum")Then

	of_total()
	idw_master.event pfc_update( True , True )
	Return 
	
END IF

If(dwo.name = "b_expenses")Then
	
	gstr_parm.string_parm[1] = "d_view_result_expenses_income_bill"
	gstr_parm.long_array[1] = idw_master.GetItemNumber(row , is_master_id_column_nm )
	Return 
	
End if

IF( dwo.name = "b_stores")THEN
		
		
		IF Not IsNull(ll_id) THEN
			idw_master.SetItem(row , "store_id" , ll_id)
			idw_master.Event itemchanged(row , dwo , string(ll_id))	
		END IF
		
		Destroy cs
		
		Return 
		
END IF
end subroutine

public function long of_master_postinsert (long ar_row);
IF idw_master.describe( is_Created_by_column_nm+".ColType" ) <> '?' and idw_master.describe( is_Created_by_column_nm+".ColType" ) <> '!'THEN
	idw_master.SetItem( ar_row ,is_Created_by_column_nm , gstr_user_info.login_id )
END IF

IF idw_master.describe( is_Created_dt_column_nm+".ColType" ) <> '?' and idw_master.describe( is_Created_dt_column_nm+".ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,is_Created_dt_column_nm , today() )
END IF

IF idw_master.describe( "ACTIVE_FG.ColType" ) <> '?' and idw_master.describe( "ACTIVE_FG.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"Active_fg" , "Y" )
END IF

IF idw_master.describe( "POST_FG.ColType" ) <> '?' and idw_master.describe( "POST_FG.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"POST_FG" , "N" )
END IF

IF idw_master.describe( "other_expences.ColType" ) <> '?' and idw_master.describe( "other_expences.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"other_expences" , 0.0 )
END IF


IF idw_master.describe( "payment_dt.ColType" ) <> '?' and idw_master.describe( "payment_dt.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"payment_dt" , DateTime(today(),Time("00:00:00")) )
END IF

ids_available.retrieve( )

idw_master.SetItem( ar_row ,"price" , 30.975 )
idw_master.SetItem( ar_row ,"rep_fg" , "N" )
idw_master.SetItem( ar_row ,"type_id" , 1 )
idw_master.SetItem( ar_row ,"bank_id" , 1 )
idw_master.SetItem( ar_row ,"AvailableShares" , ids_available.GetItemNumber(1 , "av") )

idw_master.SetItem( ar_row ,"sid" , 2 )

idw_master.ScrollToRow(ar_row)
idw_master.SetRow(ar_Row)
idw_master.setfocus( )


Return SUCCESS
	
end function

public function integer of_master_validation (long row);Long ll_account ,ll_shares , ll_shares_old, ll_AbailableShares
String ls_cid , ls_rep_fg,ls_rep_name , ls_id
String ls_bond 
Long ll_from_bank
DataStore ds

ds = CREATE DataStore
ds.DataObject = "d_validation"
ds.SetTransObject(SQLCA)

idw_master.AcceptText( )

ls_cid 	 				= idw_master.GetItemString( row , "cid")
ll_shares 				= idw_master.GetItemNumber( row , "shars", Primary!, false)
ll_shares_old 			= idw_master.GetItemNumber( row , "shars", Primary!, true)
ll_account				= idw_master.GetItemNumber( row , "account")
ll_AbailableShares	= idw_master.GetItemNumber( row , "AvailableShares")
ls_bond 					= idw_master.GetItemString( row , "bond")
ll_from_bank			= idw_master.GetItemNumber( row , "from_bank_id" )

ls_id			= idw_master.GetItemString( row , "id")

ls_rep_fg 	= idw_master.GetItemString( row , "rep_fg")
ls_rep_name = idw_master.GetItemString( row , "rep_name")

/****************check the clients id******************/
IF IsNull(ls_cid) THEN

	gnv_msg.of_message( 69 )
	Return FAILURE
	
END IF

/****************Check if Shares**************************/
IF IsNull(ll_shares) or ll_shares <= 0 THEN
	
	gnv_msg.of_message( 70 )
	Return FAILURE
	
END IF

/*****************Check shares Availabelity**********************/ 

IF ( IsNull(ll_account) or ll_account = 0 ) and IsNull(ls_id) and ll_AbailableShares <= 0 THEN
	
	gnv_msg.of_message( 67 )
	Return FAILURE
	
END IF

IF IsNull(ls_id) THEN

	IF ll_shares > ll_AbailableShares THEN
		gnv_msg.of_message( 68 )
		Return FAILURE
	END IF

	IF ll_account  < ll_shares THEN
		gnv_msg.of_message( 68 )
		Return FAILURE
	END IF

ELSE
	
	IF ll_shares_old < ll_shares THEN
		
		IF ( ll_shares - ll_shares_old ) > ll_AbailableShares THEN
	
			gnv_msg.of_message( 68 )
			Return FAILURE
			
		END IF
		
		IF ( ll_shares - ll_shares_old ) > ll_account THEN
			
			gnv_msg.of_message( 68 )
			Return FAILURE
			
		END IF
		
	END IF

END IF

/******************Check Represintator Flag*****************/
IF ls_rep_fg = "Y" and ( IsNull(ls_rep_name) OR Len(Trim(ls_rep_name)) < 4) THEN
	gnv_msg.of_message( 71 )
	Return FAILURE	
END IF

IF Not( salary_fg( idw_master.GetItemString( row , "salary_fg") ) OR &
			trading_fg( idw_master.GetItemString( row , "trading_fg") ) OR &
				savings_fg( idw_master.GetItemString( row , "savings_fg") ) OR &
					investment_fg( idw_master.GetItemString( row , "investment_fg") ) OR &
						 heritage_fg( idw_master.GetItemString( row , "heritage_fg") ) )THEN
	
	gnv_msg.of_message( 80 )
	Return FAILURE

END IF

 
 /*******************************************************/
 
 IF IsNull(ls_id) THEN
	
	IF ds.Retrieve(ls_bond , ls_cid , ll_from_bank ) > 0 THEN
		
		IF ds.GetItemNumber(1 , "count") > 0 THEN
			IF gnv_msg.of_message(81) = 2 THEN
				Return Failure
			END IF
		END IF
		
	END IF
	
 END IF
 
RETURN SUCCESS
end function

public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data);String ls_id 
Long ll_shares

IF ar_dwo.name = "shid" THEN
	
	SELECT ID,SHARES
	INTO :ls_id ,:ll_shares
	FROM CLIENTS
	WHERE SHID = :ar_data;
	
	IF ls_id = "" THEN 
		return 
	END IF	
	
	idw_master.SetItem(ar_row , "cid" , ls_id)
	idw_master.SetItem(ar_row , "account" , ll_shares * 2 )
	
END IF


IF ar_dwo.name = "type_id_1" or ar_dwo.name = "type_id" THEN
	
	IF ar_data = "2" THEN
		IF gstr_user_info.dbid = "1" THEN idw_master.SetItem( ar_row ,"bank_id" , 2 )
		IF gstr_user_info.dbid = "2" THEN idw_master.SetItem( ar_row ,"bank_id" , 3 )
	END IF
	
END IF


idw_master.SetItem( ar_row , "modified_by" , gstr_user_info.login_id )
idw_master.SetItem( ar_row , "modified_dt" , gnv_services.uf_today() )

idw_master.event editchanged( ar_row, ar_dwo , ar_data)
end subroutine

public subroutine of_invoice ();str_pass_parmeters lstr_parm


lstr_parm.String_parm[1] = is_ar_invoice_dataobject
lstr_parm.String_parm[2] = idw_master.getitemString( idw_master.GetRow() , "id")


OpenWithParm(w_print , lstr_parm)


idw_master.SetItem(idw_master.GetRow() , "POST_FG" , "Y" )
idw_master.update()
Commit;

of_result_retrieve( )
end subroutine

public function boolean of_sharevalidation (string ar_cid);


Return TRue
end function

public function boolean salary_fg (string ar_flag);IF ar_flag = "Y" THEN
	Return True
END IF

Return False


end function

public function boolean trading_fg (string ar_flag);IF ar_flag = "Y" THEN
	Return True
END IF

Return False


end function

public function boolean savings_fg (string ar_flag);IF ar_flag = "Y" THEN
	Return True
END IF

Return False


end function

public function boolean investment_fg (string ar_flag);IF ar_flag = "Y" THEN
	Return True
END IF

Return False


end function

public function boolean heritage_fg (string ar_flag);IF ar_flag = "Y" THEN
	Return True
END IF

Return False


end function

on n_payments_2.create
call super::create
end on

on n_payments_2.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_available = CREATE DataStore
ids_available.DataObject = "d_av"
ids_available.SetTRansObject(SQLCA)
end event

