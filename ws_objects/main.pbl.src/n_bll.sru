$PBExportHeader$n_bll.sru
forward
global type n_bll from n_base
end type
end forward

global type n_bll from n_base
end type
global n_bll n_bll

type variables
public :
 		String is_post = "N"
		String is_SharedData = "N"
		String is_Price_type = "cost"
		String is_Qty_Validation = "N"
		String is_SystemPart = ""
		String is_MasterTable = ""
		String is_DetailTable = ""
		
		String is_Master_id_column_nm = ""
		String is_Detail_id_column_nm = ""
		String is_price_column_nm = "Price"
		String is_discount_column = "discount"
		String is_pdiscount_column = "dpercent"
		String is_Created_by_column_nm = "CREATED_BY"
		String is_Created_dt_column_nm = "CREATED_DT"

		String is_filter_DataObject = ""
		String is_result_DataObject = ""
		String is_master_DataObject = ""
		String is_list_DataObject = ""
		String is_detail_DataObject = ""


		String is_ar_invoice_DataObject
		String is_en_invoice_DataObject
		String is_sql
		String is_special_btn_title = "توريد"
		String is_New_btn_title = "إضــافـــة"
		String is_Save_btn_title = "حفـــــظ"
		String is_RollBack_btn_title = "تراجع"
		String is_Invoice_btn_title = "فــــــاتورة"
		String is_gb_search_list_title = "نتيجة البحث"
		String is_gb_item_list_title = "بنود الفاتورة"
		
		Boolean ib_change = False
		Boolean ib_new = False
		Boolean ib_new_band = False
		Boolean ib_special_btn_visible = False
		Boolean ib_MasterIdentity = False
		Boolean ib_DetailIdentity = False
		
		
		Long il_default_store
		Long il_default_client
		
		//n_cst_sales ics_sales
		n_cst_guidb csGui
		
		u_dw  idw_details
 		u_dw  idw_filter
  		u_dw  idw_result
   	u_dw  idw_master
	 	u_dw  idw_list
		
private:		
		DataStore ids_Cost_price
		//n_cst_Store_card csStocks
		Boolean ib_MasterDetailPage = True
		

end variables

forward prototypes
public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master, ref u_dw dw_list, ref u_dw dw_details)
public subroutine of_search_filter_design ()
public subroutine of_detail_itemchange (dwobject dwo, long row, string data)
public function long of_detail_postinsert (long ar_row)
public function long of_detail_postupdate ()
public function integer of_detail_validation ()
public subroutine of_list_btn_clicked (dwobject dwo, long row)
public function long of_list_deleterow (long row)
public subroutine of_list_itemchange (dwobject dwo, long row, string data)
public subroutine of_list_onclick (long ar_row)
public function long of_list_postinsert (long row)
public function long of_list_postupdate ()
public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data)
public function long of_master_postinsert (long ar_row)
public function long of_master_postupdate ()
public function long of_master_retrieve ()
public function integer of_master_validation (long row)
public function string of_search ()
private subroutine of_filter_constract ()
private subroutine of_detail_constract ()
private subroutine of_list_constract ()
private subroutine of_master_constract ()
private subroutine of_result_constract ()
public function long of_result_retrieve ()
public subroutine of_initial_cost_finder ()
public function decimal of_cost_finder (long ar_sc_id, datetime ar_dt, string ar_type)
public subroutine of_invoice ()
public function integer of_master_preupdate (long row)
public function integer of_detail_preupdate ()
public subroutine of_list_design ()
public subroutine of_result_design ()
public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master, ref u_dw dw_list, ref u_dw dw_details, ref hprogressbar progress)
public subroutine of_list_dddw_retrieve ()
public subroutine of_detail_dddw_retrieve ()
public subroutine of_master_btn_clicked (dwobject dwo, long row)
public subroutine of_initial_sale_price ()
public subroutine of_initial_clients ()
public subroutine of_total ()
public subroutine of_result_row_change (long currentrow, long newrow)
public subroutine of_result_onclick (long row)
public subroutine of_filter_btn_clicked (dwobject dwo, long row)
public subroutine of_result_btn_clicked (dwobject dwo, long row)
public function long of_list_preupdate ()
public subroutine of_master_design ()
public subroutine of_detail_design ()
public function long of_detail_preinsert ()
public function long of_list_retrieve (long row)
public function integer of_sc_duplcity (long sc_id, long row)
public subroutine of_detail_postitemchange (dwobject dwo, long row, string data)
public function integer of_special_btn ()
public function boolean of_check_inventory (long ar_sc_id, long ar_store_id, long ar_barch_id, long ar_id, long ar_old_qty, long ar_new_qty)
public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master)
public subroutine of_initial_datastores ()
public subroutine of_initial_datawindow ()
public subroutine of_generate_gui (string as_section, ref u_dw ar_dw)
public subroutine of_apply_gui (string as_section, ref u_dw ar_dw)
public subroutine of_filter_design ()
public function boolean of_check_identity (string ar_table, string ar_colmn)
public subroutine of_print ()
public subroutine of_past ()
public subroutine of_copy ()
public subroutine of_hlp (ref datawindow ar_dw)
public subroutine of_detail_btn_clicked (dwobject dwo, long row)
public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master, ref u_dw dw_list)
end prototypes

public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master, ref u_dw dw_list, ref u_dw dw_details);
idw_filter = dw_filter
idw_result = dw_result
idw_master = dw_master
idw_list = dw_list
idw_details = dw_details

of_initial_datastores()
of_initial_datawindow()


of_list_constract() 
of_detail_constract()
of_master_constract()
of_filter_constract()
of_result_constract()

of_result_design()
of_list_design()
of_master_design()
of_detail_design()

is_sql = dw_result.GetSQLSelect( )

of_result_retrieve()
of_master_retrieve()

end subroutine

public subroutine of_search_filter_design ();of_apply_gui("Filter" , idw_filter)
end subroutine

public subroutine of_detail_itemchange (dwobject dwo, long row, string data);String ls_ex_fg
Datetime ldt_dt
Long ll_quantity,ll_batche_id,ll_store_id,ll_sc_id = 0
Decimal ld_price   
String ls_barcode
n_cst_store_card csSC

idw_details.AcceptText( )
 
 IF dwo.name = "barcode" THEN
	
	csSC 	= Create n_cst_store_card	
	ll_sc_id 	= csSC.of_getitembybarcode( data )
	
	idw_details.SetItem( row, "sc_id" , ll_sc_id)
	idw_details.SetItem( row, "quantity" , 1)
 END IF
 
IF ll_sc_id <= 0 THEN
	ll_sc_id    = idw_details.getitemnumber( row , "SC_ID"    )
END IF

ldt_dt = gnv_services.uf_today( )

if(dwo.name = "b_paste" or dwo.name = "sc_id" or dwo.name = "sc_id_1" or dwo.name = "b_store" or dwo.name = "b_stocks" or dwo.name = "barcode")Then

	idw_details.setredraw( False )

	//set default value to qty
	ll_quantity = 0
	ll_batche_id = idw_details.GetItemNumber(Row , "batche_id" )
	
	IF idw_details.Describe( "store_id.visible" ) = "1" THEN	
		ll_store_id = idw_details.GetItemNumber(row , "store_id")
	//	ll_quantity =  ics_sales.of_get_inventory(  ll_sc_id,ll_store_id ,ll_batche_id)
	ELSEIF idw_master.Describe( "store_id.visible" ) = "1" THEN	
		ll_store_id = idw_master.GetItemNumber( idw_master.GetRow() , "store_id" )
		//ll_quantity =  ics_sales.of_get_inventory(  ll_sc_id,ll_store_id ,ll_batche_id)		
	END IF
	
	IF is_Price_type = "cost" THEN
		IF(gstr_user_info.application_parm[gnv_settings.costpricehistory]  = 1)Then
			
			ld_price = of_cost_finder( ll_sc_id , ldt_dt , '1' )
			
		Else	
			
			ld_price = of_cost_finder( ll_sc_id , ldt_dt  , '3' )
			
		End if
		ELSEIF(is_Price_type = "sales")THEN
			//ld_price = ics_sales.of_getpricelist( ll_sc_id , ics_sales.of_pricelistid(  idw_master.GetItemNumber(idw_master.GetRow() , "nm") ) )
		ELSE
			
			ld_price =	idw_details.GetItemDecimal( Row , "other_price" )	
			IF IsNull(ld_price) or ld_price = 0.0 THEN
		
				ld_price = gnv_services.uf_GetBuyPrice(ll_sc_id)		
				idw_details.setitem( Row , "other_price"      , ld_price )		

			End if	
			
			ld_price = ld_price * idw_master.getItemDecimal( idw_master.GetRow( ) , "ex_rate" )
				

	END IF
	
	ib_change   = True
	
	idw_details.SetItem( row , "qty" , ll_quantity)
	
	IF idw_details.describe("PRICE.coltype") <> "!" THEN
		idw_details.SetItem( row , "PRICE", ld_price)
	END IF
	
	idw_details.setredraw( True )
	
End if


If(dwo.name = "batche_id")Then

		ll_batche_id = idw_details.GetItemNumber(Row , "batche_id" )
		
		//ll_quantity = ics_sales.of_get_inventory( ll_sc_id,ll_store_id ,ll_batche_id )
		ib_change   = True
		idw_details.SetItem(row , "qty" , ll_quantity)
		
End if


//IF ib_change THEN
	idw_details.SetItem( row , "last_modified_by" , gstr_user_info.login_id )
	idw_details.SetItem( row , "last_modified_dt" , ldt_dt )
//END IF

of_detail_postitemchange(dwo , row , data)

end subroutine

public function long of_detail_postinsert (long ar_row);
ib_change = True

return Success
end function

public function long of_detail_postupdate ();
ib_change            = False

Return Success
end function

public function integer of_detail_validation ();Long ll_sc_id 
Long ll_Store_id ,ll_id,ll_old_qty , ll_new_qty
Long ll_found
Long ll_qty , ll_row //, ll_rowCount
Decimal ld_price
String ls_id,ls_coltype
String ls_Stock_type

IF is_detail_dataobject = "" THEN Return SUCCESS

idw_details.Accepttext( )

For ll_row = 1 To idw_list.RowCount()
	
ll_sc_id 		= idw_list.GetItemNumber( ll_row , "sc_id" )
ll_qty 			= idw_list.GetItemNumber( ll_row , "quantity" )
ll_old_qty 		= idw_list.GetItemNumber( ll_row , "quantity" ,Primary!,True)	
ll_new_qty 		= idw_list.GetItemNumber( ll_row , "quantity" , Primary!,False )
//ls_Stock_type 	= csStocks.of_getitemname( ll_sc_id , "type_fg", "string")

IF IsNull(ll_sc_id) THEN
	gnv_msg.of_Message(10) //MessageBox("تنبيه","يجب اختيار صنف" , information!)
	Return Failure
END IF

IF IsNull(ll_qty)  or ll_qty <= 0 THEN
	gnv_msg.of_Message(11) //MessageBox("تنبيه","يجب إدخال الكمية المطلوبة", information!)
	Return Failure
END IF

IF idw_master.describe( "Rate.visible" ) = "1" THEN
		
	ld_price = Round(idw_master.GetItemDecimal(idw_master.GetRow() , "rate" ) * idw_list.GetItemDecimal(ll_row , "price" ) , 3)
	IF  ld_price <> Round(idw_list.GetItemDecimal(ll_row , "price_in_ld") , 3)  THEN 
   		
			gnv_msg.of_Message(12) //MessageBox("تنبيه","سعر بالدينار لا يساوي السعر بالعملة الاجنبية")
			Return FAILURE
		
	END IF
	
END IF

//P or empty string products 
//S Services 
IF ls_Stock_type <> "S"  THEN
	IF idw_list.describe( "store_id.visible" ) = "1" THEN 
		ll_store_id 	= idw_list.GetItemNumber( ll_row , "store_id" )
		IF IsNull(ll_store_id) THEN
			gnv_msg.of_Message(13) //MessageBox("تنبيه","يجب اختيار المخزن" , information!)
			Return Failure
		END IF
	END IF	
END IF

IF idw_list.describe( "price.visible" ) = "1" THEN 
	ld_price 	= idw_list.GetItemDecimal( ll_row , "price" )
	IF IsNull(ld_price)  or ld_price <= 0.0 THEN
		gnv_msg.of_Message(14) //MessageBox("تنبيه","يجب إدخال سعر البيع", information!)
		Return Failure
	END IF
END IF
	
//****************************check item duplicity************************//
ll_found = of_sc_duplcity(ll_sc_id , ll_row )

//*************check Quantity************************8
IF ls_Stock_type <> "S" THEN
	IF is_Qty_Validation = "Y" THEN
		ll_id 	= idw_list.GetItemNumber( ll_row , is_Detail_id_column_nm )	
		IF Not of_check_inventory(ll_sc_id,ll_store_id,0 , ll_id,ll_old_qty , ll_new_qty) THEN 
		
			IF idw_list.Describe("ITEM_STATUS.type") <> "!" THEN 
				idw_list.SetItem( ll_row , "ITEM_STATUS" , "F") 
				idw_list.ScrollToRow( ll_row )
			END IF
		
			Return Failure
		ELSE
			IF idw_list.Describe("ITEM_STATUS.type") <> "!" THEN idw_list.SetItem( ll_row , "ITEM_STATUS" , "O") 
		END IF
	
	END IF
END IF

NEXT

Return Success
end function

public subroutine of_list_btn_clicked (dwobject dwo, long row);str_pass_parmeters lstr_parm
str_pass_parmeters lstr_pass
DataStore ds
String ls_import_type ,ls_file_nm , ls_qty
String ls_clipboard
Long ll_row ,ll_RowCount
Long ll_itr
Long ll_total_rows,ll_iter,ll_header_row
datetime ldt_today

IF dwo.name = "b_add" THEN
	
//	IF is_detail_dataobject <> "" THEN
//		idw_details.Event pfc_insertrow()
//	ELSE
		idw_list.event pfc_insertrow( )
//	END IF
	
	ib_change = True

END IF


IF dwo.name = "b_del" THEN
	
	idw_list.Event pfc_deleterow( )
	
END IF

////////////////////////////////////////////////////

IF dwo.name = "b_paste" THEN
	

		Open( w_import_list )
		lstr_pass = Message.PowerObjectParm
	
		ll_RowCount = UpperBound(lstr_pass.long_array)
		ldt_today = gnv_services.uf_today( )
	
		FOR ll_itr=1 to ll_RowCount

			ll_row = idw_list.insertrow(0)
	
			of_list_postinsert( ll_row )
		
			idw_list.setitem( ll_row , "sc_id" 					, lstr_pass.long_array[ll_itr] )
			of_detail_itemchange( dwo , ll_row, String(lstr_pass.long_array[ll_itr] ) )
			ll_itr++
			idw_list.setitem( ll_row , "quantity" 	  			, lstr_pass.long_array[ll_itr] )
		
		NEXT
	
	
END IF

IF dwo.name = "b_copy" THEN
	
	ll_RowCount = idw_list.RowCount()
	
	ls_clipboard = ""
	
	FOR ll_itr=1 to ll_RowCount
	
		ls_clipboard += String(idw_list.GetItemNumber( ll_itr , "sc_id"))+"~t"+String(idw_list.GetItemNumber( ll_itr , "quantity"))+"~n"

	NEXT
	
	clipboard(ls_clipboard)
	
END IF

IF dwo.name = "b_gui" THEN
	of_generate_gui(is_systempart+"_Item" , idw_list)
END IF

end subroutine

public function long of_list_deleterow (long row);String ls_ColType , ls_id
Long ll_current_row , ll_id

ls_ColType = idw_details.describe( is_Detail_id_column_nm+".ColType" )

Choose Case ls_ColType
	Case "long"
				
		ll_id = idw_list.GetItemNumber( Row , is_Detail_id_column_nm )
				
		IF IsNull(ll_id) THEN
			
			idw_list.deleterow( Row )
			Return SUCCESS
					
		END IF
	Case Else 
		
		ls_id = idw_list.GetItemString( Row , is_Detail_id_column_nm )
		IF IsNull(ls_id) THEN
			
			idw_list.deleterow( Row )
			Return SUCCESS
			
		END IF
		
End Choose


IF gnv_msg.of_Message(15)/*"تنبيه","هل انت متاكد من الغاء بند؟", information! , YesNo!)*/ = 1 THEN
		
	ib_change = True	
 	idw_list.setitem( row , "Active_fg" , "N")
	 
	IF idw_list.Describe( "deleted_by.visible" ) <> "!"  THEN
		idw_list.setitem( row , "deleted_by" , gstr_user_info.login_id )	
	ELSE
		idw_list.setitem( row , "last_modified_by" , gstr_user_info.login_id )
	END IF
	
	IF idw_list.describe( "deleted_dt.visible" ) <> "!"  THEN
		idw_list.setitem( row , "deleted_dt" , gnv_services.uf_today( ) )
	ELSE
		idw_list.setitem( row , "last_modified_dt" , gnv_services.uf_today( ) )	
	END IF
	
	idw_list.SetRedraw( False )
	idw_list.SetFilter("Active_fg = 'Y'")
	idw_list.filter( )
	
	IF( idw_list.RowCount() > 0 )Then		
		
//		if(row > 1)THEN
			idw_list.ScrollTorow( row - 1)
			idw_details.ScrollToRow(row - 1)
//		End if
		
	END IF
	
	idw_list.SetRedraw( True )
	Return SUCCESS
	
ELSE
	
	Return FAILURE
	
END IF

end function

public subroutine of_list_itemchange (dwobject dwo, long row, string data);//Long ll_quantity
//Decimal ld_price   
//
//This.accepttext( )
//
//This.setitem( row , "last_modified_by" , gstr_user_info.login_id )
//This.setitem( row , "last_modified_dt" , datetime(today(),now()) )
//
////il_sc_id    = This.getitemnumber( row , "SC_ID"    )
////il_quantity = This.getitemnumber( row , "Quantity" )
////il_store_id = This.getitemnumber( row , "STORE_ID" )
////
//ib_change   = True
//
//
////ids_inv_sc.retrieve( il_sc_id , il_store_id )
//
//if(ids_inv_sc.rowcount() > 0 )then
//   ll_quantity = ids_inv_sc.getitemnumber( 1 , "total" )
//else
//	ll_quantity = 0
//end if
//
//
////id_price       = ld_price
//
//This.setitem( row , "PRICE", ld_price)
//
//This.accepttext( )
//
////il_row      = row
//
////cb_add_item.enabled  = False
////cb_save_item.enabled = True
end subroutine

public subroutine of_list_onclick (long ar_row);
IF( ar_row > 0 and is_detail_dataobject <> "" )Then

	idw_details.ScrollToRow(ar_row)

End if
end subroutine

public function long of_list_postinsert (long row);n_cst_store csStore

IF ib_MasterDetailPage THEN
	
	idw_list.ScrollToRow(row)
	
	IF idw_list.describe( is_Created_by_column_nm+".ColType" ) <> '?' and idw_list.describe( is_Created_by_column_nm+".ColType" ) <> '!' THEN
		idw_list.SetItem( row ,is_Created_by_column_nm , gstr_user_info.login_id )
	END IF
	
	IF idw_list.describe( is_Created_dt_column_nm+".ColType" ) <> '?' and idw_list.describe( is_Created_dt_column_nm+".ColType" ) <> '!' THEN
		idw_list.SetItem( row ,is_Created_dt_column_nm , today() )
	END IF
	
	IF idw_list.describe( "ACTIVE_FG.ColType" ) <> '?' and idw_list.describe( "ACTIVE_FG.ColType" ) <> '!' THEN
		idw_list.SetItem( row ,"Active_fg" , "Y" )
	END IF
	
	IF idw_list.describe( "POST_FG.ColType" ) <> '?' and idw_list.describe( "POST_FG.ColType" ) <> '!' THEN
		idw_list.SetItem( row ,"POST_FG" , "N" )
	END IF

	IF idw_list.describe( "STORE_ID.ColType" ) <> '?' and idw_list.describe( "STORE_ID.ColType" ) <> '!' THEN
		
		csStore = Create n_cst_store
		idw_list.SetItem( row ,"STORE_ID" , csStore.of_default_store( ) )
		Destroy csStore
		
	END IF
	
END IF

return Success
end function

public function long of_list_postupdate ();ib_change = False
Return Success
end function

public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data);
idw_master.setitem( ar_row , "modified_by" , gstr_user_info.login_id )
idw_master.setitem( ar_row , "modified_dt" , datetime(today(),now()) )

ib_change = True
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

IF idw_master.describe( "arrive_dt.ColType" ) <> '?' and idw_master.describe( "arrive_dt.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"arrive_dt" , DateTime(today(),Time("00:00:00")) )
END IF

IF idw_master.describe( "bill_dt.ColType" ) <> '?' and idw_master.describe( "bill_dt.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"bill_dt" , DateTime(today(),Time("00:00:00")) )
END IF

IF idw_master.describe( "client_type.ColType" ) <> '?' and idw_master.describe( "client_type.ColType" ) <> '!' THEN
	idw_master.SetItem( ar_row ,"client_type" , "N" )
END IF

idw_master.ScrollToRow(ar_row)
idw_master.SetRow(ar_Row)

IF ib_Masterdetailpage THEN of_list_retrieve( ar_row )

Return SUCCESS
	
end function

public function long of_master_postupdate ();	ib_change = False
	Return SUCCESS
end function

public function long of_master_retrieve ();Long ll_count ,ll_row

ll_row = idw_master.GetRow()

idw_master.setredraw( False )

IF is_SharedData = "N" THEN
	ll_count = idw_master.retrieve( )
ELSE
	ll_count = idw_master.RowCount( )
END IF

idw_master.SetRedraw( True )

IF is_list_DataObject <> "" THEN 
	IF is_detail_dataobject <> "" THEN
		idw_list.Sharedata( idw_details )
	END IF
END IF

IF ll_count > 0  Then

	IF ib_MasterDetailPage THEN	of_list_retrieve(idw_master.GetRow() )

End if	


Return ll_count
end function

public function integer of_master_validation (long row);
return Success
end function

public function string of_search ();String ls_cond

ls_cond = " AND (POST_FG = '"+is_post+"') "

return is_sql + ls_cond
end function

private subroutine of_filter_constract ();idw_filter.SetTransObject(SQLCA)

of_search_filter_design()

idw_filter.insertrow( 0 )
end subroutine

private subroutine of_detail_constract ();idw_details.SetTransObject( SQLCA )
end subroutine

private subroutine of_list_constract ();idw_list.SetTransObject( SQLCA )

idw_list.of_SetSort (TRUE)
idw_list.inv_sort.of_SetColumnHeader(TRUE)

end subroutine

private subroutine of_master_constract ();

idw_master.settransobject( SQLCA ) 

IF is_SharedData = "N" THEN
	idw_master.event pfc_retrieve( )
END IF

end subroutine

private subroutine of_result_constract ();idw_result.SetTransObject( SQLCA )
//idw_result.of_SetRowSelect(TRUE)
//idw_result.inv_rowselect.of_SetStyle(0)

idw_result.of_SetSort (TRUE)
idw_result.inv_sort.of_SetColumnHeader(TRUE)

end subroutine

public function long of_result_retrieve ();Long ll_rows,ll_count

idw_result.setsqlselect( of_search() )

idw_result.SetTransObject(SQLCA)

IF is_post = 'N' THEN ll_rows = idw_result.retrieve( )

IF is_SharedData = "N" THEN
	ll_count = idw_master.retrieve( )
ELSE
	idw_result.Sharedata( idw_master )
	ll_count = idw_master.RowCount( )
END IF

idw_master.SetRedraw( True )

IF ll_count > 0  Then
	
	of_list_retrieve(idw_master.GetRow() )
	
End if	

IF is_list_DataObject <> "" THEN
	
	IF is_detail_dataobject <> "" THEN
		idw_list.Sharedata( idw_details )
	END IF
	
END IF

Return ll_count
end function

public subroutine of_initial_cost_finder ();ids_Cost_Price = Create DataStore
ids_Cost_Price.dataobject = "ds_cost_price"
ids_Cost_Price.settransobject( SQLCA )

end subroutine

public function decimal of_cost_finder (long ar_sc_id, datetime ar_dt, string ar_type);Decimal ld_price = 0.0

IF ids_Cost_price.retrieve( ar_sc_id ,ar_dt , ar_type ) > 0 THEN
	ld_price = ids_Cost_price.GetItemDecimal(1, "Costprice")
END IF

IF IsNull(ld_price) THEN ld_price = 0.0

Return ld_price
end function

public subroutine of_invoice ();String ls_coltype
str_pass_parmeters lstr_parm


ls_coltype = idw_master.describe( is_master_id_column_nm+".ColType" )

IF Pos( ls_coltype , "char") > 0 THEN
		lstr_parm.string_parm[3] = idw_master.GetItemString( idw_master.GetRow() , is_Master_id_column_nm)
ELSE
		lstr_parm.long_array[1] = idw_master.GetItemNumber( idw_master.GetRow() , is_Master_id_column_nm)
END IF
	
lstr_parm.string_parm[1] = is_ar_invoice_DataObject
lstr_parm.string_parm[2] = is_en_invoice_DataObject	

OpenWithParm(w_print  ,lstr_parm )
end subroutine

public function integer of_master_preupdate (long row);String ls_total_in_letter
Decimal ld_total_amount , ld_total_amount_
Long ll_row , ll_id , ll_RowCount
String ls_id , ls_ColType

IF Not ib_MasterIdentity THEN
			
		ls_ColType = idw_master.describe( is_master_id_column_nm+".ColType" )
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
			
					idw_master.setitem( row  , is_master_id_column_nm , gnv_services.uf_get_id_from_parm_cd(is_MasterTable) ) 
					
				END IF
		End Choose
		
END IF



IF idw_master.describe( "total_amount.visible" ) <> "1" THEN Return Success

IF ib_MasterDetailPage THEN
	
	ld_total_amount = idw_list.GetItemDecimal( 1 , "total_" )
	IF IsNull(ld_total_amount) THEN ld_total_amount = 0
	idw_master.SetItem(row , "total_amount" , ld_total_amount)
	
	IF idw_master.describe("total_amount_other.visible") = "1" THEN
		ld_total_amount = idw_list.GetItemDecimal( 1 , "total_other_" )
		IF IsNull(ld_total_amount) THEN ld_total_amount = 0
		idw_master.SetItem(row , "total_amount_other" , ld_total_amount)
	END IF
	
END IF
//ld_total_amount 	= idw_master.GetItemDecimal( row , "total_amount" , Primary!,True)
//ld_total_amount_ 	= idw_master.GetItemDecimal( row , "total_amount" , Primary!,False )
//
//IF( ld_total_amount <> ld_total_amount_ )THEN
//
//	ld_total_amount = idw_master.GetItemDecimal(row , "total_amount")
//	
//	IF ld_total_amount = 0 or IsNull(ld_total_amount) THEN 
//		SetNull( ls_total_in_letter )
//		IF idw_master.Describe( "total_in_letter.visible"	) = "1" THEN	idw_master.SetItem( row , "total_in_letter", ls_total_in_letter)
//		Return Success
//	END IF
//	
//	IF idw_master.Describe( "total_in_letter.visible"	) = "1" THEN
//		ls_total_in_letter  = "فقط "+gnv_services.pre_convert(ld_total_amount ,"L.D","Derhams",3)+" لاغير"
//		idw_master.SetItem( row , "total_in_letter", ls_total_in_letter)
//	END IF
//	
//END IF

Return SUCCESS
end function

public function integer of_detail_preupdate ();Return SUCCESS
end function

public subroutine of_list_design ();Long ll_max, ll_cnt
String ls_col, ls_type ,ls_color , ls_gr_color
str_pass_parmeters lstr_parm

lstr_parm = gnv_services.of_backGroundColor()

ls_color = mid(lstr_parm.String_parm[1] , pos(lstr_parm.String_parm[1] , "=")+1 ,len(lstr_parm.String_parm[1]) )
ls_gr_color = mid(lstr_parm.String_parm[2] , pos(lstr_parm.String_parm[2] , "=")+1 ,len(lstr_parm.String_parm[2]) )

idw_list.Modify( "DataWindow.color="+ls_color )
idw_list.Modify( "DataWindow.brushmode=2" )
idw_list.Modify( "DataWindow.transparency=11" )
idw_list.Modify( "DataWindow.gradient.angle=0" )
idw_list.Modify( "DataWindow.gradient.color='16777215'" )
idw_list.Modify( "DataWindow.gradient.focus=51" )
idw_list.Modify( "DataWindow.gradient.scale=86" )
idw_list.Modify( "DataWindow.gradient.spread=83" )
idw_list.Modify( "DataWindow.gradient.transparency=0" )

idw_list.Modify("created_by_t.text='انشاء بواسطة'")
idw_list.Modify("created_dt_t.text='تاريخ الانشاء'")
idw_list.Modify("last_modified_by_t.text='حدثت بواسطة '")
idw_list.Modify("last_modified_dt_t.text='تاريخ التحديث'")

ll_max = Long( idw_list.Describe("DataWindow.Column.Count") )

For ll_cnt = 1 To ll_max
	
	ls_col = idw_list.describe( "#"+string(ll_cnt)+".Name" )
	ls_type = idw_list.describe(ls_col + ".type")

	IF(ls_type = "column" or ls_type = "compute")THEN
	
		idw_list.Modify( ls_col+".color='8388608~tif( currentRow() = getrow() , rgb(128,0,0) , rgb(0,0,128))'" )
		idw_list.Modify( ls_col+".background.mode='1'") 
		idw_list.Modify( ls_col+".background.color='553648127'")//+ls_color)//536870912
		idw_list.Modify( ls_col+".background.transparency='0'") 
		idw_list.Modify( ls_col+".background.gradient.color="+ls_color)//15780518
		idw_list.Modify( ls_col+".background.gradient.transparency='0'") 
		idw_list.Modify( ls_col+".background.gradient.angle='144'") 
		idw_list.Modify( ls_col+".background.brushmode='1'")
		idw_list.Modify( ls_col+".background.gradient.repetition.length='50'") 
		idw_list.Modify( ls_col+".background.gradient.focus='61'")
		idw_list.Modify( ls_col+".background.gradient.scale='60'") 
		idw_list.Modify( ls_col+".background.gradient.spread='80'") 
		idw_list.Modify( ls_col+".font.face='Arial (Arabic)'")
		idw_list.Modify( ls_col+".font.height='-12'")
		idw_list.Modify( ls_col+".font.weight='700'")
		idw_list.Modify( ls_col+".font.family='2'")
		idw_list.Modify( ls_col+".font.pitch='2'")
		idw_list.Modify( ls_col+".font.charset='178'")
		
	END IF

Next

of_apply_gui("Items",idw_list)
end subroutine

public subroutine of_result_design ();Long ll_max, ll_cnt
String ls_col, ls_type,ls_visible , ls_x ,ls_color , ls_gr_color
str_pass_parmeters lstr_parm

lstr_parm = gnv_services.of_backGroundColor()

ls_color = mid(lstr_parm.String_parm[1] , pos(lstr_parm.String_parm[1] , "=")+1 ,len(lstr_parm.String_parm[1]) )
ls_gr_color = mid(lstr_parm.String_parm[2] , pos(lstr_parm.String_parm[2] , "=")+1 ,len(lstr_parm.String_parm[2]) )

idw_result.Modify( "DataWindow.color="+ls_color )
idw_result.Modify( "datawindow.brushmode=2" )
idw_result.Modify( "datawindow.transparency=11" )
idw_result.Modify( "datawindow.gradient.angle=0" )
idw_result.Modify( "datawindow.gradient.color=16777215" )
idw_result.Modify( "datawindow.gradient.focus=51" )
idw_result.Modify( "datawindow.gradient.scale=86" )
idw_result.Modify( "datawindow.gradient.spread=83" )
idw_result.Modify( "datawindow.gradient.transparency=0" )
/////Header
//idw_result.Modify( "header.color='536870912'" )
//idw_result.Modify( "header.brushmode=0" )
//idw_result.Modify( "header.transparency=0" )
//idw_result.Modify( "header.gradient.angle=0" )
//idw_result.Modify( "header.gradient.color=8421504" )
//idw_result.Modify( "header.gradient.focus=0" )
//idw_result.Modify( "header.gradient.scale=100" )
//idw_result.Modify( "header.gradient.spread=100" )
//idw_result.Modify( "header.gradient.transparency=0" )
/////Footer
//idw_result.Modify( "footer.color='536870912'" )
//idw_result.Modify( "footer.brushmode=0" )
//idw_result.Modify( "footer.transparency=0" )
//idw_result.Modify( "footer.gradient.angle=0" )
//idw_result.Modify( "footer.gradient.color=8421504" )
//idw_result.Modify( "footer.gradient.focus=0" )
//idw_result.Modify( "footer.gradient.scale=100" )
//idw_result.Modify( "footer.gradient.spread=100" )
//idw_result.Modify( "footer.gradient.transparency=0" )
/////Detail
//idw_result.Modify( "detail.color='536870912~tif( mod(getrow() , 2) = 1 , rgb(176,226,255) , 553648127 )'" )
//idw_result.Modify( "detail.brushmode=0" )
//idw_result.Modify( "detail.transparency=42" )
//idw_result.Modify( "detail.gradient.angle=0" )
//idw_result.Modify( "detail.gradient.color=16777215" )
//idw_result.Modify( "detail.gradient.focus=0" )
//idw_result.Modify( "detail.gradient.scale=100" )
//idw_result.Modify( "detail.gradient.spread=100" )
//idw_result.Modify( "detail.gradient.transparency=0" )
//
IF is_result_DataObject = "" THEN Return

ll_max = Long( idw_result.Describe("DataWindow.Column.Count") )

For ll_cnt = 1 To ll_max
	
	ls_col = idw_result.describe( "#"+string(ll_cnt)+".Name" )
	ls_type = idw_result.describe(ls_col + ".type")
	ls_visible = idw_result.describe(ls_col + ".visible")
	
	IF( ( ls_type = "column"  or ls_type = "compute") and ls_visible = "1")THEN
	
		idw_result.Modify( ls_col+".color='8388608~tif( currentRow() = getrow() , rgb(128,0,0) , rgb(0,0,128))'" )
		idw_result.Modify( ls_col+".background.mode='1'") 
		idw_result.Modify( ls_col+".background.color='553648127'")//+ls_color)//536870912
		idw_result.Modify( ls_col+".background.transparency='0'") 
		idw_result.Modify( ls_col+".background.gradient.color="+ls_color)//15780518
		idw_result.Modify( ls_col+".background.gradient.transparency='0'") 
		idw_result.Modify( ls_col+".background.gradient.angle='144'") 
		idw_result.Modify( ls_col+".background.brushmode='1'")
		idw_result.Modify( ls_col+".background.gradient.repetition.length='50'") 
		idw_result.Modify( ls_col+".background.gradient.focus='61'")
		idw_result.Modify( ls_col+".background.gradient.scale='60'") 
		idw_result.Modify( ls_col+".background.gradient.spread='80'") 
		idw_result.Modify( ls_col+".font.face='Arial (Arabic)'")
		idw_result.Modify( ls_col+".font.height='-12'")
		idw_result.Modify( ls_col+".font.weight='700'")
		idw_result.Modify( ls_col+".font.family='2'")
		idw_result.Modify( ls_col+".font.pitch='2'")
		idw_result.Modify( ls_col+".font.charset='178'")
		
	END IF

Next

of_apply_gui("Result" , idw_result )



end subroutine

public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master, ref u_dw dw_list, ref u_dw dw_details, ref hprogressbar progress);
progress.position = 0

//step 1 set datawindow to local varible
idw_filter 		= dw_filter
idw_result 		= dw_result
idw_master 		= dw_master
idw_list 		= dw_list
idw_details 	= dw_details

progress.position += 5

//initial datastore and datawindow
of_initial_datastores()
of_initial_datawindow()

progress.position += 15 //20

//set transaction Object
of_list_constract() 
of_detail_constract()
of_master_constract()
of_filter_constract()
of_result_constract()

progress.position += 5 // 25

//redesign grid datawindow
of_Filter_design()
of_result_design()
progress.position += 5 //30
of_list_design()
progress.position += 5 //35
of_master_design()
progress.position += 5 //40
of_detail_design()

//get original SQL
is_sql = dw_result.getsqlselect( )
progress.position += 2 //42

//retrieve search result dw
of_result_retrieve()

progress.position += 30 //72 

//of_master_retrieve()

progress.position += 28 //100
end subroutine

public subroutine of_list_dddw_retrieve ();//Long ll_row
//DataWindowChild ldwc_temp
//
//idw_details.GetChild( "sc_id" , ldwc_temp)
//
//ldwc_temp.SetTransObject(SQLCA)
//
//IF gs_AppPath = "" THEN
//	ll_row = ldwc_temp.Retrieve()
//ELSEIF  FileExists( gs_AppPath+"sc.csv" ) THEN
//		ldwc_temp.ImportFile( gs_AppPath+"cs.csv" )
//		ll_row = ldwc_temp.Rowcount( )
//	ELSE
//		ll_row = ldwc_temp.Retrieve( )
//		ldwc_temp.SaveAs(gs_AppPath+"cs.csv", CSV!, false)
//END IF
end subroutine

public subroutine of_detail_dddw_retrieve ();//Long ll_row
//DataWindowChild ldwc_temp
//
//idw_details.GetChild( "sc_id" , ldwc_temp)
//
//ldwc_temp.SetTransObject(SQLCA)
//
//IF gs_AppPath = "" THEN
//	ll_row = ldwc_temp.Retrieve()
//ELSEIF  FileExists( gs_AppPath+"sc.csv" ) THEN
//		ldwc_temp.ImportFile( gs_AppPath+"cs.csv" )
//		ll_row = ldwc_temp.Rowcount( )
//	ELSE
//		ll_row = ldwc_temp.Retrieve( )
//		ldwc_temp.SaveAs(gs_AppPath+"cs.csv", CSV!, false)
//END IF
//
//idw_details.GetChild( "store_id" , ldwc_temp)
//
//ldwc_temp.SetTransObject(SQLCA)
//
//IF gs_AppPath = "" THEN
//	ll_row = ldwc_temp.Retrieve()
//ELSEIF  FileExists( gs_AppPath+"store.csv" ) THEN
//		ldwc_temp.ImportFile( gs_AppPath+"store.csv" )
//		ll_row = ldwc_temp.Rowcount( )
//	ELSE
//		ll_row = ldwc_temp.Retrieve( )
//		ldwc_temp.SaveAs(gs_AppPath+"store.csv", CSV!, false)
//END IF
end subroutine

public subroutine of_master_btn_clicked (dwobject dwo, long row);Long ll_id
String ls_type
str_pass_parmeters lstr_parm
n_cst_store cs

IF dwo.name = "b_gui" THEN
	of_generate_gui(is_systemPart , idw_master)
END IF

IF(dwo.name = "b_clients")Then

	
	OpenWithParm(w_clients_search , lstr_parm)
	
	lstr_parm = message.powerobjectparm

	IF( upperbound(lstr_parm.string_parm) > 0 )Then

     	idw_master.SetItem( row , "cid" , lstr_parm.string_parm[1] ) 
		idw_master.SetItem( row , "modified_by" , gstr_user_info.login_id )
     	idw_master.SetItem( row , "modified_dt" , gnv_services.uf_today() )

	End if

End if
IF(dwo.name = "b_sum")Then

	of_total()
	idw_master.event pfc_update( True , True )
	
end if

If(dwo.name = "b_expenses")Then
	gstr_parm.string_parm[1] = "d_view_result_expenses_income_bill"
	gstr_parm.long_array[1] = idw_master.GetItemNumber(row , is_master_id_column_nm )
	//open(w_view_expenses)
End if

IF( dwo.name = "b_stores")THEN
		
		//cs = Create n_cst_store
		//ll_id = cs.of_select_store()
		
		IF Not IsNull(ll_id) THEN
			idw_master.SetItem(row , "store_id" , ll_id)
			idw_master.Event itemchanged(row , dwo , string(ll_id))	
		END IF
		
		Destroy cs
		
	END IF
end subroutine

public subroutine of_initial_sale_price ();//ids_price = Create DataStore
//ids_price.dataobject = "ds_price_list_lnk"
//ids_price.settransobject( SQLCA )


end subroutine

public subroutine of_initial_clients ();
//ids_clients = Create DataStore
//ids_clients.dataobject = "d_customer_list_2"
//ids_clients.settransobject( SQLCA )
//ids_clients.retrieve( gstr_user_info.city_id )
end subroutine

public subroutine of_total ();Decimal ld_total_amount , ld_total_
String ls_total_in_letter
Long ll_row

ll_row = idw_master.GetRow()

IF idw_master.describe( "total_amount.visible" ) <> "1" THEN Return 

ld_total_amount = idw_master.GetItemDecimal(ll_row , "total_amount")
ld_total_ = idw_list.GetItemDecimal(1 , "total_")

IF IsNull(ld_total_amount) THEN ld_total_amount = 0.0
IF IsNull(ld_total_) THEN ld_total_ = 0.0

IF ld_total_amount  <> ld_total_ THEN

	idw_master.SetItem( ll_row, "total_amount",ld_total_ )

	idw_master.SetItem(ll_row , "last_modified_by" , gstr_user_info.login_id )
	idw_master.SetItem(ll_row , "last_modified_dt" , gnv_services.uf_today( ) )

END IF

IF idw_master.Describe( "total_in_letter.visible"	) = "1" THEN
		ls_total_in_letter  = "فقط "+gnv_services.pre_convert(ld_total_amount ,"L.D","Derhams",3)+" لاغير"
		idw_master.SetItem( ll_row , "total_in_letter", ls_total_in_letter)
END IF
end subroutine

public subroutine of_result_row_change (long currentrow, long newrow);if newrow <= 0 then 
	of_result_onclick( currentrow )
else
	of_result_onclick( newrow )
end if
end subroutine

public subroutine of_result_onclick (long row);if(row > 0) Then
	
	idw_master.ScrollToRow( row )
	//	idw_list.Event pfc_retrieve()
	of_list_retrieve(row)
	
End if
end subroutine

public subroutine of_filter_btn_clicked (dwobject dwo, long row);Long ll_dealer_id
String ls_type
str_pass_parmeters lstr_parm

IF(dwo.name = "b_clients")Then

	
	OpenWithParm(w_clients_search , lstr_parm)
	
	lstr_parm = message.powerobjectparm

	IF( upperbound(lstr_parm.string_parm) > 0 )Then

     	idw_filter.SetItem( row , "nm" , lstr_parm.string_parm[1] ) 
	
	End if

End if

 if(string(dwo.name) = "b_stocks" )then

	  str_pass_parmeters lstr_parm2
	  lstr_parm2.long_array[1] = 0
    // Openwithparm(w_search_store_card_pls , lstr_parm2)
	  if(gstr_parm.long_array[1] > 0 )then
	    idw_filter.SetItem(row , "sc_id" , gstr_parm.long_array[1] )
     end if
  end if
  
If(dwo.name = "b_store")Then
		Long ll_res
		n_cst_store cs
	//	cs = Create n_cst_store
	//	ll_res = cs.of_select_store()
		IF(Not IsNull(ll_res))Then
			idw_filter.SetItem(row , "store_id" , ll_res)
		End if
	//	Destroy cs
End if

IF dwo.name = "b_gui" THEN
	of_generate_gui(is_systempart+"_Filter" , idw_filter)
END IF
end subroutine

public subroutine of_result_btn_clicked (dwobject dwo, long row);str_pass_parmeters lstr_parm


IF dwo.name = "b_search" THEN

	idw_filter.Accepttext( )
	idw_result.SetSQLSelect( of_search() )
	idw_result.SetTransObject(SQLCA)

	idw_result.retrieve( )

	IF is_shareddata = "Y" THEN
		idw_result.sharedata( idw_master )
	END IF
	
	of_result_retrieve( )

END IF

IF dwo.name = "b_new" THEN

	idw_filter.setredraw( False )
	idw_filter.DeleteRow( 0 )
	idw_filter.scrolltorow( idw_filter.insertrow( 1 ) )
	idw_filter.setredraw( True )
	
END IF

IF dwo.name = "b_sql" THEN
	
	lstr_parm.string_parm[1] = idw_result.GetSQLSelect ( )
	
	OpenWithParm(w_sqlpreview , lstr_parm)
	
	lstr_parm = Message.powerobjectparm
	
	IF lstr_parm.string_parm[1] <> "-" THEN
		idw_result.SetSQLPreview( lstr_parm.string_parm[1] )
	End if	
	
END IF

IF dwo.name = "b_reset" THEN
	
	IF gnv_msg.of_message(38) = 1 THEN
		idw_result.SetItem( row , "POST_FG" , "N" )
		idw_result.update(True , True)
		Commit;
		idw_result.retrieve( )
		of_result_retrieve( )
	END IF
	
END IF

IF dwo.name = "b_delete" THEN
	
	IF gnv_msg.of_message(38) = 1 THEN
		idw_result.SetItem( row , "ACTIVE_FG" , "N" )
		idw_result.SetItem( row , "LAST_MODIFIED_BY" , gstr_user_info.login_id )
		idw_result.SetItem( row , "LAST_MODIFIED_DT" , gnv_services.uf_today( ) )
		idw_result.update(True , True)
		Commit;
		idw_result.retrieve( )
		of_result_retrieve( )
	END IF
	
END IF

IF dwo.name = "b_undo" THEN
	
	IF gnv_msg.of_message(38) = 1 THEN
		idw_result.SetItem( row , "ACTIVE_FG" , "Y" )
		idw_result.SetItem( row , "LAST_MODIFIED_BY" , gstr_user_info.login_id )
		idw_result.SetItem( row , "LAST_MODIFIED_DT" , gnv_services.uf_today( ) )
		idw_result.update(True , True)
		Commit;
		idw_result.retrieve( )
		of_result_retrieve( )
	END IF
	
END IF
end subroutine

public function long of_list_preupdate ();Long ll_id ,ll_Row , ll_RowCount
String ls_id , ls_ColType
Long ll_Master_id  = 0
String ls_Master_id = "0"

ll_RowCount = idw_list.RowCount()

ls_ColType = idw_master.describe( is_Master_id_column_nm+".ColType" )
Choose Case ls_ColType
	Case "long"
		ll_Master_id = idw_master.GetItemNumber( idw_master.GetRow() , is_Master_id_column_nm)
		IF IsNull(ll_Master_id) THEN Return Failure
	Case Else 
		ls_Master_id = idw_master.GetItemString( idw_master.GetRow() , is_Master_id_column_nm)
		IF IsNull(ls_Master_id) THEN Return Failure
End Choose

IF Not ib_DetailIdentity THEN

	ls_ColType = idw_details.describe( is_Detail_id_column_nm+".ColType" )
	idw_list.Modify( is_Detail_id_column_nm+".identity='no'")
	
	FOR ll_Row = 1 To ll_RowCount
					
		Choose Case ls_ColType
			Case "long"
				
				ll_id = idw_list.GetItemNumber( ll_Row , is_Detail_id_column_nm )
				
				IF IsNull(ll_id) THEN
			
					idw_list.setitem( ll_Row  , is_Detail_id_column_nm , Long(gnv_services.uf_get_id_from_parm_cd(is_DetailTable+"."+is_Detail_id_column_nm) ) ) 

					IF ll_master_id > 0 THEN
						idw_list.setitem( ll_Row  , is_Master_id_column_nm , ll_master_id ) 
					ELSE
						idw_list.setitem( ll_Row  , is_Master_id_column_nm , ls_master_id) 
					END IF
					
				END IF
			Case Else 
				ls_id = idw_list.GetItemString( ll_Row , is_Detail_id_column_nm )
				IF IsNull(ls_id) THEN
			
					idw_list.setitem( ll_Row  , is_Detail_id_column_nm , gnv_services.uf_get_id_from_parm_cd(is_DetailTable) ) 

					IF ll_master_id > 0 THEN
						idw_list.setitem( ll_Row  , is_Master_id_column_nm , ll_master_id ) 
					ELSE
						idw_list.setitem( ll_Row  , is_Master_id_column_nm , ls_master_id) 
					END IF
					
				END IF
		End Choose

	NEXT
	
ELSE
	
		FOR ll_Row = 1 To ll_RowCount
					
			Choose Case ls_ColType
				Case "long"
		
							idw_list.setitem( ll_Row  , is_Master_id_column_nm , ll_master_id ) 
					
				Case Else 
						
							idw_list.setitem( ll_Row  , is_Master_id_column_nm , ls_master_id) 
						
			End Choose

		NEXT
	
END IF

Return Success
end function

public subroutine of_master_design ();of_apply_gui("Header" , idw_master)
end subroutine

public subroutine of_detail_design ();of_apply_gui("Details" , idw_details)
end subroutine

public function long of_detail_preinsert ();Long ll_bill_no
String ls_bill_no
String ls_ColType
Long ll_res

ll_res = Success

ls_ColType = idw_master.Describe( 	This.is_master_id_column_nm+".ColType" )

IF Pos( ls_ColType , "char") > 0 THEN
	
	ls_bill_no = idw_master.GetItemString( idw_master.GetRow(), is_master_id_column_nm )
	IF IsNull(ls_bill_no) THEN ll_res = Failure

ELSE
	
	ll_bill_no = idw_master.GetItemNumber( idw_master.GetRow(), is_master_id_column_nm )	
	IF IsNull(ll_bill_no) THEN  ll_res = Failure

End if

IF ll_res = Failure THEN 
	gnv_msg.of_Message(9) //MessageBox("تنبيه","يجب حفظ بيانات الفاتورة اولا ثم اضافة البنود")
	Return Failure
END IF

Return Success
end function

public function long of_list_retrieve (long row);Long ll_rows,ll_current_row
Long ll_current_list_row
String ls_coltype,ls_id
Long ll_id

ll_current_row = row//idw_result.GetRow()

IF ib_MasterDetailPage THEN ll_current_list_row = idw_list.GetRow()

ls_coltype = idw_master.describe( is_master_id_column_nm+".ColType" )

IF ll_current_row <= 0 or idw_result.RowCount() <= 0 THEN 	
	IF Pos( ls_coltype , "char") > 0 THEN		
		 IF ib_MasterDetailPage THEN idw_list.Retrieve("-1")		 
	ELSE		
		 IF ib_MasterDetailPage THEN idw_list.Retrieve(-1)		 
	END IF	
	Return no_action 
END IF

IF ib_MasterDetailPage THEN idw_list.SetRedraw( False )

IF Pos( ls_coltype , "char") > 0 THEN
	
		ls_id = idw_master.GetItemString( ll_current_row , is_master_id_column_nm )
		
		IF IsNull(ls_id) OR ls_id = "" THEN
			IF ib_MasterDetailPage THEN ll_rows = idw_list.Retrieve( "-1" )
		ELSE
			IF ib_MasterDetailPage THEN 
				ll_rows = idw_list.Retrieve( ls_id )
				idw_list.ScrollToRow( ll_current_list_row )
			END IF
		END IF
		
ELSE

		ll_id = idw_master.GetItemNumber( ll_current_row , is_master_id_column_nm )
		
		IF IsNull(ll_id) OR ll_id <= 0 THEN
			IF ib_MasterDetailPage THEN ll_rows = idw_list.Retrieve( -1 )
		ELSE
			IF ib_MasterDetailPage THEN 
				ll_rows = idw_list.Retrieve( ll_id )
				idw_list.ScrollToRow( ll_current_list_row )
			END IF
		END IF
		
END IF

IF ib_MasterDetailPage THEN of_list_dddw_retrieve()
IF ib_MasterDetailPage THEN of_detail_dddw_retrieve()

IF( ll_rows > 0 )Then

	IF ib_MasterDetailPage AND is_detail_dataobject <> "" THEN 
		idw_details.ScrollToRow( ll_current_list_row )
	END IF
End if

IF ib_MasterDetailPage THEN idw_list.setredraw( True )

return ll_rows
end function

public function integer of_sc_duplcity (long sc_id, long row);Long ll_found,ll_id
Long ll_itr,ll_qty
String ls_ColType,ls_id
Decimal ld_price , ld_other_price
Long ll_row_to_delete = 0

ll_found = 0

IF ProfileString(gnv_app.of_getappinifile( ) , "Database", "RemoveDuplicatItems" , "Yes" )	= "No" THEN Return ll_found

ls_ColType = idw_list.describe( is_detail_id_column_nm+".ColType" )

IF Pos(ls_ColType ,"char") > 0 THEN

	ls_id = idw_list.GetItemString( row , is_detail_id_column_nm )
	
	IF IsNull( ls_id ) THEN  
	
		ll_found = 0
		
	ELSE

		ll_found = idw_list.Find( "( ( sc_id = "+string(sc_id)+" ) and  IsNull("+is_detail_id_column_nm+") ) or ( ( sc_id = "+string(sc_id)+" ) and ( not IsNull("+is_detail_id_column_nm+") ) )" ,0 , idw_list.RowCount()  )
		
	END IF
	
ELSE
	
FOR ll_itr = row to idw_list.RowCount()
	
	ll_row_to_delete = 0
	
	IF ( idw_list.GetItemNumber(ll_itr , "sc_id") = idw_list.GetItemNumber( row  , "sc_id") and  idw_list.GetItemDecimal(ll_itr , is_price_column_nm ) = idw_list.GetItemDecimal( row  , is_price_column_nm) ) and ll_itr <> row THEN
		
		IF IsNull(idw_list.getitemNumber( ll_itr , is_detail_id_column_nm) ) and (IsNull(idw_list.getitemNumber( row ,is_detail_id_column_nm) )) THEN
			
			ll_qty = idw_list.getitemnumber( ll_itr ,"quantity" ) + idw_list.getitemnumber( row ,"quantity" )
			idw_list.SetItem( row , "quantity" , ll_qty)
			ll_row_to_delete = ll_itr			
			
		ELSEIF	IsNull(idw_list.getitemNumber( ll_itr , is_detail_id_column_nm) ) THEN
			
			ll_qty = idw_list.getitemnumber( ll_itr ,"quantity" ) + idw_list.getitemnumber( row ,"quantity" )
			idw_list.SetItem( row , "quantity" , ll_qty)
			ll_row_to_delete = ll_itr	
			
		ELSEIF IsNull(idw_list.getitemNumber( row , is_detail_id_column_nm) ) THEN
			
			ll_qty = idw_list.getitemnumber( ll_itr ,"quantity" ) + idw_list.getitemnumber( row ,"quantity" )
			idw_list.SetItem( ll_itr , "quantity" , ll_qty)
			ll_row_to_delete = row	

		END IF
		
		ld_price = 0.0
		IF idw_list.Describe( "price.visible" ) = "1" THEN
			
			ld_price = idw_list.GetItemDecimal( ll_itr , "price")
			idw_list.SetItem( ll_itr , "price" , ld_price)
			
			IF idw_list.Describe( "total.visible" ) = "1" THEN idw_list.SetItem( ll_itr , "total" , ll_qty * ld_price)
			
		END IF
		
		ld_other_price = 0.0
		IF idw_list.Describe( "other_price.visible" ) = "1" THEN
			
			ld_other_price = idw_list.GetItemDecimal( ll_itr , "other_price")
			idw_list.SetItem( ll_itr , "other_price" , ld_other_price )
			idw_list.SetItem( ll_itr , "other_total" ,ll_qty * ld_other_price)
	
		END IF
		
	END IF
	IF ll_row_to_delete > 0 THEN
		idw_list.DeleteRow(ll_row_to_delete)			
	END IF
NEXT

		ll_found = 0

END IF

Return ll_found
end function

public subroutine of_detail_postitemchange (dwobject dwo, long row, string data);
end subroutine

public function integer of_special_btn ();Return Success
end function

public function boolean of_check_inventory (long ar_sc_id, long ar_store_id, long ar_barch_id, long ar_id, long ar_old_qty, long ar_new_qty);Long ll_old_qty,ll_new_qty,ll_inv_qty,ll_diffrent_quantity
Long ll_id

ll_id 		= ar_id //idw_details.GetItemNumber( 1 , "id" )	
ll_old_qty 	= ar_old_qty //idw_details.GetItemNumber( 1 , "quantity" ,Primary!,True)	
ll_new_qty 	= ar_new_qty //idw_details.GetItemNumber( 1 , "quantity" , Primary!,False )

//ll_inv_qty  	= ics_sales.of_get_inventory(ar_sc_id, ar_store_id, ar_barch_id)

IF ll_new_qty < 0 THEN 
		gnv_msg.of_Message(8) //MessageBox("تنبيه","ارجو التأكد من الكمية المدرجة في الفاتورة" ,information!)
     	Return False
END IF

//in case no changes to qty on saved band
IF ll_old_qty = ll_new_qty and Not IsNull(ll_id) THEN Return True

IF( ll_new_qty > ll_inv_qty ) THEN
	
	IF ll_old_qty = ll_new_qty THEN 
		gnv_msg.of_Message(8) //MessageBox("تنبيه","ارجو التأكد من الكمية المدرجة في الفاتورة" ,information!)
     	Return False
	END IF
	
	IF(IsNull(ll_old_qty) or ll_old_qty < 0 )THEN ll_old_qty = 0
	
	ll_diffrent_quantity = ll_old_qty - ll_new_qty
	ll_diffrent_quantity = ll_inv_qty + ll_diffrent_quantity
	
	IF(ll_diffrent_quantity < 0)THEN
	
     	gnv_msg.of_Message(8) //MessageBox("تنبيه","ارجو التأكد من الكمية المدرجة في الفاتورة",information!)
	  	Return False
		  
	END IF
	
END IF

Return True

end function

public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master);
idw_filter = dw_filter
idw_result = dw_result
idw_master = dw_master

ib_MasterDetailPage = False

of_initial_datastores()
of_initial_datawindow()

of_master_constract()
of_filter_constract()
of_result_constract()

of_result_design()
of_master_design()

is_sql = dw_result.getsqlselect( )

of_result_retrieve()
of_master_retrieve()
end subroutine

public subroutine of_initial_datastores ();of_initial_cost_finder( )
of_initial_sale_price()
of_initial_clients()
end subroutine

public subroutine of_initial_datawindow ();//dw_detail.DataObject			= is_detail_dataObject

idw_filter.DataObject 		= is_filter_dataObject
idw_result.DataObject 		= is_result_dataObject
idw_master.DataObject 		= is_master_dataObject

IF is_list_dataObject <> "" THEN idw_list.DataObject 				= is_list_dataObject
IF is_detail_dataObject <> "" THEN idw_details.DataObject 		= is_detail_dataObject
end subroutine

public subroutine of_generate_gui (string as_section, ref u_dw ar_dw);
Integer li_col_idx, &
        li_pos

String  ls_objects, &
        ls_control, &
        ls_columns[], &
        ls_type, &
        ls_visible

n_cst_guidb csGuiDB

li_col_idx = 1
ls_objects = ar_dw.object.datawindow.objects 

csGuiDB = Create n_cst_guidb
csGuiDB.of_load( is_systempart )

DO while ls_objects <> ""
   	 	li_pos = Pos(ls_objects, "~t")

		 IF li_pos > 0 THEN
			  ls_control = left(ls_objects, li_pos - 1)
			  ls_objects = mid(ls_objects, li_pos + 1)
		 ELSE
			  ls_control = ls_objects
			  ls_objects = ""
		 END IF
	
		 ls_type = ar_dw.describe(ls_control + ".type")
		 ls_visible = ar_dw.describe(ls_control + ".visible")
		 
		 IF ls_visible = "1" THEN

			 csGuiDB.of_add( is_systempart  , as_section, ls_control+".x", ar_dw.Describe(ls_control + ".x") )
			 csGuiDB.of_add( is_systempart  , as_section, ls_control+".y", ar_dw.Describe(ls_control + ".y") )
			 csGuiDB.of_add( is_systempart  , as_section, ls_control+".width", ar_dw.Describe(ls_control + ".width") )
			 csGuiDB.of_add( is_systempart  , as_section, ls_control+".height", ar_dw.Describe(ls_control + ".height") )
 			 csGuiDB.of_add( is_systempart  , as_section, ls_control+".font.weight", ar_dw.Describe(ls_control + ".font.weight") )
			 csGuiDB.of_add( is_systempart  , as_section, ls_control+".font.height", ar_dw.Describe(ls_control + ".font.height") )
 
			 IF ar_dw.Describe(ls_control + ".righttoleft") <> "!" THEN
						csGuiDB.of_add( is_systempart , as_section, ls_control+".righttoleft", ar_dw.Describe(ls_control + ".righttoleft") )
			 END IF

			 IF ar_dw.Describe(ls_control + ".alignment") <> "!" THEN
						csGuiDB.of_add( is_systempart  , as_section, ls_control+".alignment", ar_dw.Describe(ls_control + ".alignment") )
			 END IF

		END IF
		 
		 IF ls_type = "column" AND ls_visible = "1" THEN 
			
			  csGuiDB.of_add( is_systempart  , as_section, ls_control+".format", ar_dw.Describe(ls_control + ".format") )
			  IF ar_dw.Describe(ls_control + ".editmask.mask") <> "?" THEN
			  	 csGuiDB.of_add( is_systempart  , as_section, ls_control+".editmask.mask", ar_dw.Describe(ls_control + ".editmask.mask") )			  
			  END IF
			  
			IF ar_dw.Describe(ls_control + ".dddw.name") <> "?" THEN
				
				csGuiDB.of_add( is_systempart  , as_section, ls_control+".dddw.name", ar_dw.Describe(ls_control + ".dddw.name") )
				csGuiDB.of_add( is_systempart  , as_section, ls_control+".dddw.datacolumn", ar_dw.Describe(ls_control + ".dddw.datacolumn") )
				csGuiDB.of_add( is_systempart  , as_section, ls_control+".dddw.displaycolumn", ar_dw.Describe(ls_control + ".dddw.displaycolumn") )
							
			END IF
			
		 END IF
		 
		 IF ( ls_type = "text" or ls_type = "groupbox") AND ls_visible = "1" THEN
			
			  csGuiDB.of_add( is_systempart  , as_section, ls_control+".text", ar_dw.Describe(ls_control + ".text") )

		 END IF
		 
		IF ar_dw.Describe(ls_control + ".tooltip.enabled") = "1" THEN
			csGuiDB.of_add( is_systempart  , as_section, ls_control+".tooltip.tip", ar_dw.Describe(ls_control + ".tooltip.tip") )
			csGuiDB.of_add( is_systempart  , as_section, ls_control+".tooltip.title", ar_dw.Describe(ls_control + ".tooltip.title") )			
		END IF
		
		IF ar_dw.Describe(ls_control + ".values") <> "?" and ar_dw.Describe(ls_control + ".values") <> "!" THEN
			csGuiDB.of_add( is_systempart  , as_section, ls_control+".values", ar_dw.Describe(ls_control + ".values") )
		END IF
		
		csGuiDB.of_add( is_systempart  , as_section, ls_control+".visible", ls_visible )
LOOP

csGuiDB.of_save( )

Destroy csGuiDB
end subroutine

public subroutine of_apply_gui (string as_section, ref u_dw ar_dw);Long li_col_idx,li_pos 
String  ls_objects, ls_control,ls_type, ls_visible
Long ll_StartPos , ll_Rows , ll_pos, ll_tag
Boolean lb_change = False , lb_itr_change = True
str_Objects lstr_Object[] ,lstr_Sort[]

IF is_SystemPart = "" THEN Return

li_col_idx = 1
ls_objects = ar_dw.object.datawindow.objects 

Do While ls_Objects <> ""
	   	 
		 li_pos = Pos(ls_objects, "~t")

		 IF li_pos > 0 THEN
			  lstr_Object[li_col_idx].obj = left(ls_objects, li_pos - 1)			  
			  ls_objects = mid(ls_objects, li_pos + 1)
		 ELSE
			  lstr_Object[li_col_idx].obj = ls_objects
			  ls_objects = ""
		 END IF
		 
		 IF IsNumber(ar_dw.describe( lstr_Object[li_col_idx].obj + ".tag")) THEN  
					lstr_Object[li_col_idx].tag = Long(ar_dw.describe( lstr_Object[li_col_idx].obj + ".tag"))
		 ELSE
					lstr_Object[li_col_idx].tag = 60000
		 END IF

		 li_col_idx++
		 
LOOP

ll_Rows = UPPERBOUND(lstr_Object)

FOR ll_pos = 1 TO ll_Rows
	
		//IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".visible" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".visible")) = "0" THEN

		ar_dw.Modify( lstr_Object[ll_pos].obj + ".visible="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".visible" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".visible")) )			
			
		//END IF
	
		 ls_type 		= ar_dw.describe( lstr_Object[ll_pos].obj + ".type")
		 ls_visible 	= ar_dw.describe( lstr_Object[ll_pos].obj + ".visible")
		 
		 
 		 IF ls_visible = "1" THEN

			ar_dw.Modify( lstr_Object[ll_pos].obj + ".x="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".x" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".x")) )
	  	   ar_dw.Modify( lstr_Object[ll_pos].obj + ".y="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".y" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".y")) )
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".width="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".width" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".width")) )
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".height="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".height" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".height")) )
			
			 IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".righttoleft" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".righttoleft="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".righttoleft" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".righttoleft")) )
			 END IF

			 IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".alignment" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".alignment="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".alignment" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".alignment")) )
			 END IF

			 IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".font.weight" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".font.weight='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".font.weight" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".font.weight")) +"'")
			 END IF

			 IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".font.height" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".font.height='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".font.height" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".font.height")) +"'")
			 END IF

			
		END IF
		
		 IF ls_type = "column" AND ls_visible = "1" THEN
			
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".format='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".format" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".format")) +"'")
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".tabsequence='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".tabsequence" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tabsequence")) +"'")
			
			IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , "?") <> "?" THEN
				
				IF ar_dw.Describe(lstr_Object[ll_pos].obj +".editmask.ddcalendar") = "yes" THEN	
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.mask='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".editmask.mask"))+"'")
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.ddcalendar=yes" )
				ELSE
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.mask='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".editmask.mask"))+"'")
				END  IF	
			END IF

			IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".values" , "!") <> "!" THEN 	ar_dw.Modify( lstr_Object[ll_pos].obj + ".values='"+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".values" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".values") )+"'" )
			
			IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.name" , "?") <> "?" THEN
				
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.name="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.name" , ar_dw.Describe(ls_control + ".dddw.name") ) )
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.datacolumn="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.datacolumn" , ar_dw.Describe(ls_control + ".dddw.datacolumn")) )
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.displaycolumn="+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.displaycolumn" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".dddw.displaycolumn")) )
				
			END IF
			
		 END IF
		 
		 IF ( ls_type = "text" or ls_type = "groupbox") AND ls_visible = "1" THEN
			
			  ar_dw.Modify( lstr_Object[ll_pos].obj + '.text="'+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".text" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".text"))+'"')

		 END IF
		 
		 IF ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.enabled") = "1" THEN
			ar_dw.Modify( lstr_Object[ll_pos].obj + '.tooltip.tip="'+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".tooltip.tip" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.tip"))+'"')
			IF ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.title") <> "?" THEN		ar_dw.Modify( lstr_Object[ll_pos].obj + '.tooltip.title="'+csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".tooltip.title" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.title"))+'"')		
		END IF
		 
	NEXT 

end subroutine

public subroutine of_filter_design ();of_apply_gui("Filter" , idw_Filter)
end subroutine

public function boolean of_check_identity (string ar_table, string ar_colmn);DataStore ds
Boolean lb_return = False

IF ar_table = "" or ar_colmn = "" THEN Return True

ds = Create Datastore
ds.DataObject = "d_check_identity"
ds.SetTransObject( SQLCA )
ds.retrieve( ar_table , ar_colmn)

IF ds.GetITemNumber(1 , "isidentity") = 1 THEN
	lb_return = True
END IF	

Destroy ds

Return lb_return
end function

public subroutine of_print ();//String ls_coltype
//DataStore lds
//
//ls_coltype = idw_master.describe( is_master_id_column_nm+".ColType" )
//
//lds = Create DataStore
//
//IF gs_lan = "AR" THEN
//	lds.DataObject = is_ar_invoice_DataObject
//ELSE
//	lds.DataObject = is_en_invoice_DataObject
//END IF
//
//lds.SetTransObject( SQLCA )
//
//IF Pos( ls_coltype , "char") > 0 THEN
//		lds.retrieve( idw_master.GetItemString( idw_master.GetRow() , is_Master_id_column_nm) )
//ELSE
//		lds.retrieve( idw_master.GetItemNumber( idw_master.GetRow() , is_Master_id_column_nm) )
//END IF
//
//lds.print( )
//
//Destroy lds
end subroutine

public subroutine of_past ();Long ll_cid ,ll_list_id,ll_row , ll_RowCount , ll_itr , ll_itr2
Long ll_store_id , ll_sc_id
DateTime ldt_today
String ls_clipboard
Decimal ld_price
DWObject dwo
str_pass_parmeters lstr_pass
	
Open(w_import_list)
lstr_pass = Message.PowerObjectParm
	
ll_RowCount = UpperBound(lstr_pass.long_array)
ldt_today = gnv_services.uf_today( )
ib_change = True
ll_itr2 = 1
FOR ll_itr=1 to ll_RowCount

		ll_row = idw_details.insertrow(0)
		idw_details.Scrolltorow( ll_row )
		
		of_detail_postinsert( ll_row )
		dwo         = idw_details.Object.__get_attribute ("sc_id", true)
		of_detail_itemchange(dwo , ll_row , String(lstr_pass.long_array[ll_itr]))
		
		idw_list.Setredraw( True )
		
		idw_details.setitem( ll_row , "sc_id"		, lstr_pass.long_array[ll_itr] )
		//	ll_store_id = idw_details.GetItemNumber(row , "store_id")
 		//	idw_details.setitem( ll_row , "qty" 	  		, ics_sales.of_get_inventory(  lstr_pass.long_array[ll_itr],ll_store_id ,0) )
		

		IF Not gnv_settings.of_getsyssetup( gnv_settings.indexprice )  THEN
			
			IF lstr_pass.decimal_array[ll_itr2] > 0.0 THEN
				idw_details.setitem( ll_row , is_price_column_nm , lstr_pass.decimal_array[ll_itr2] )
			ELSE
				//idw_details.setitem( ll_row , is_price_column_nm , ics_sales.of_getpricelist( lstr_pass.long_array[ll_itr] , ics_sales.of_pricelistid(  idw_master.GetItemNumber(idw_master.GetRow() , "nm") ) )  )
			END IF
			
		ELSE
			
			//idw_details.setitem( ll_row , is_price_column_nm 	, ics_sales.of_getpricelist( lstr_pass.long_array[ll_itr] , ics_sales.of_pricelistid(  idw_master.GetItemNumber(idw_master.GetRow() , "nm") ) )  )
			
		END IF
		
		ll_itr++
		ll_itr2++
		idw_details.setitem( ll_row , "quantity" 	, lstr_pass.long_array[ll_itr] )
		
NEXT

Return 
end subroutine

public subroutine of_copy ();String ls_clipboard
Long ll_RowCount , ll_itr

ll_RowCount = idw_list.RowCount()
	
ls_clipboard = ""
	
FOR ll_itr=1 to ll_RowCount
	
	ls_clipboard += String(idw_list.GetItemNumber( ll_itr , "sc_id"))+"~t"+String(idw_list.GetItemNumber( ll_itr , "quantity"))+"~n"

NEXT
	
clipboard(ls_clipboard)
end subroutine

public subroutine of_hlp (ref datawindow ar_dw);Long ll_ins

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "F2" )
ar_dw.SetItem( ll_ins , "description" , "فاتورة جديدة")

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "Ctrl+Space" )
ar_dw.SetItem( ll_ins , "description" , "بند جديد" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "Ctrl+S" )
ar_dw.SetItem( ll_ins , "description" , "حفــظ البيانات" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "Ctrl+1" )
ar_dw.SetItem( ll_ins , "description" , " قائمة الزبائن في حالة تعبئة بيانات الفاتورة و قائمة المخازن في حالة بنود الفاتورة" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "Ctrl+2" )
ar_dw.SetItem( ll_ins , "description" , "قائمة الاصناف" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "F3" )
ar_dw.SetItem( ll_ins , "description" ,"نسخ بنود الفاتورة" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "F4" )
ar_dw.SetItem( ll_ins , "description" ,"لصق بنود الفاتورة")

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "Ctrl+P" )
ar_dw.SetItem( ll_ins , "description" ,"للطباعة")


end subroutine

public subroutine of_detail_btn_clicked (dwobject dwo, long row);Long ll_res
n_cst_store cs
str_pass_parmeters lstr_parm

IF( dwo.name = "b_stocks" )then

	IF idw_master.describe( "fid.visible" ) = "1" THEN
	
		ll_res = idw_master.GetItemNumber(idw_master.getrow() , "fid")
		
		IF not IsNull(ll_res) THEN
			lstr_parm.long_array[1] = ll_res
		END IF
	
	END IF
	
	lstr_parm.String_parm[1] = is_SystemPart
	
 //  Openwithparm(w_search_store_card_pls , lstr_parm)
	
	IF gstr_parm.long_array[1] > 0 THEN
		
	    idw_details.SetItem(row , "sc_id" , gstr_parm.long_array[1] )
	    idw_details.Event itemchanged(row , dwo , string(gstr_parm.long_array[1]))
		 
	END IF
	
END IF
  
IF( dwo.name = "b_store")THEN
		
	//	cs = Create n_cst_store
	//	ll_res = cs.of_select_store()
		
		IF Not IsNull(ll_res) THEN
			idw_details.SetItem(row , "store_id" , ll_res)
			idw_details.Event itemchanged(row , dwo , string(ll_res))	
		END IF
		
	//	Destroy cs
		
END IF

IF dwo.name = "b_gui" THEN

	of_generate_gui(is_systempart+"_Details" ,idw_details)

END IF
end subroutine

public subroutine of_initial (ref u_dw dw_filter, ref u_dw dw_result, ref u_dw dw_master, ref u_dw dw_list);
idw_filter = dw_filter
idw_result = dw_result
idw_master = dw_master
idw_list = dw_list
//idw_details = dw_details

of_initial_datastores()
of_initial_datawindow()


of_list_constract() 
//of_detail_constract()
of_master_constract()
of_filter_constract()
of_result_constract()

of_result_design()
of_list_design()
of_master_design()
//of_detail_design()

is_sql = dw_result.getsqlselect( )

of_result_retrieve()
of_master_retrieve()

end subroutine

on n_bll.create
call super::create
end on

on n_bll.destroy
call super::destroy
end on

event constructor;call super::constructor;String ls_FileName , ls_Section

csGui = Create n_cst_guidb
csGui.of_load( is_SystemPart )


IF gs_LAN <> "AR" THEN
	
		ls_FileName 	= gs_LAN+".ini"
		ls_Section 		= "Window"
		
		is_special_btn_title 	= csGui.of_filter( ls_Section, "cb_special.text" 		, "") 
		is_New_btn_title 			= csGui.of_filter( ls_Section, "cb_new.text" 			, "") 
		is_Save_btn_title 		= csGui.of_filter( ls_Section, "cb_save.text" 			, "") 
		is_RollBack_btn_title 	= csGui.of_filter( ls_Section, "cb_undo.text" 			, "") 
		is_Invoice_btn_title 	= csGui.of_filter( ls_Section, "cb_invoice.text" 		, "") 
		is_gb_search_list_title	= csGui.of_filter( ls_Section, "gb_search_list.text" 	, "") 
		is_gb_item_list_title 	= csGui.of_filter( ls_Section, "gb_items.text" 			, "") 
		 
	
END IF

ib_MasterIdentity = of_Check_Identity(is_MasterTable ,is_Master_id_column_nm )
ib_DetailIdentity = of_Check_Identity(is_DetailTable ,is_Detail_id_column_nm )
end event

