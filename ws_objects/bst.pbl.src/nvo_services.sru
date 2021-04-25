$PBExportHeader$nvo_services.sru
forward
global type nvo_services from n_srv
end type
end forward

global type nvo_services from n_srv
end type
global nvo_services nvo_services

forward prototypes
public function string con_1_digit (integer no)
public function string con_2_digit (integer no)
public function integer count_digit_befor_point (decimal no)
public function string con_3_digit (decimal no, string and_or_not)
public function string con_4_digit (decimal no, string and_or_not)
public function string con_5_digit (decimal no, string and_or_not)
public function string con_6_digit (decimal no, string and_or_not)
public function string con_7_digit (decimal no, string and_or_not)
public function string con_8_digit (decimal no, string and_or_not)
public function string con_9_digit (decimal no, string and_or_not)
public function string convert_number_to_text (long no)
public function string round_up_to_half (decimal fee)
public function long round_up_to_100 (long weight)
public function boolean check_user_id (string ar_user_id)
public function integer count_items (integer ar_cbill_no, string ar_table)
public subroutine delete_kind_card_action (integer ar_sc_id, integer ar_bill_no, datetime ar_dt, string ar_in_or_out, integer ar_store_id)
public function string add_and_arabic (string ar_text_arabic)
public function string four_digit_arabic (decimal no)
public function string three_digit_arabic (decimal no)
public function string five_digit_arabic (decimal no)
public subroutine add_to_store (integer ar_sc_id, integer ar_quantity, real ar_price)
public subroutine update_inventory (integer ar_sc_id, integer ar_store_id, integer ar_quantity, decimal ar_price)
public function boolean char_to_boolean (character y_n_char)
public subroutine add_kind_card_action (datetime ar_dt, integer ar_bill_no, string ar_in_or_out, integer ar_quantity, integer ar_sc_id, integer ar_store_id, integer ar_item_id, decimal ar_price, integer ar_customer_id, string ar_manul_no)
public function integer compute_quantity_all_store (integer ar_sc_id)
public function integer compute_quantity_for_store (integer ar_store_id, integer ar_sc_id)
public function decimal cash_action ()
public function string two_digit_arabic (integer no)
public function integer uf_new_id (string ar_field_nm, string ar_field_type)
public function integer find_title (string ar_title)
public function string pre_convert (decimal no, string a_large_unit, string a_small_unit, integer a_fractions)
public function string one_digit_arabic (integer no)
public function integer uf_get_max_id (string as_tbl_nm)
public function string uf_araoundupquart (decimal fee)
public function string seven_digit (decimal no)
public function string convert_number_to_arabic_text (long no)
public function string six_digit_arabic (decimal no)
public subroutine uf_retrieve_dddw_integer (ref datawindow ar_dw, integer ar_retrieve_value, string field_nm)
public function datetime uf_today ()
public function string uf_get_id (string as_parm_nm, string as_type)
public subroutine retrieve_dddw (ref datawindow ar_dw, integer ar_retrieve_value, string field_nm)
public function string uf_get_id_from_parm_cd (string as_table_nm)
public function str_pass_parmeters uf_insert_dw (ref datawindow ar_dw)
public subroutine uf_retrieve_dddw_string (ref datawindow ar_dw, string ar_retrieve_value, string field_nm)
public function decimal uf_getbuyprice (integer ar_sc_id)
public function string of_remove_extenion (string ar_file_nm)
public function string uf_get_id_from_parm_tbl (string as_tbl_nm)
public function string of_encrypt_password (string as_password)
public function integer of_restore_db (long ar_db_id, string ar_fullname)
public function integer of_restore_db (string ar_database, string ar_fullname)
public subroutine of_setreportdate (ref lol_dp start_dt, ref lol_dp end_dt)
public subroutine of_getreportdate ()
public subroutine of_setreportdate (ref uo_select_dt_neo uo)
public subroutine of_setreportdate (ref uo_small_select_dt_neo uo)
public subroutine of_reorderpointnotification ()
public subroutine of_branchsyncnotification ()
public subroutine of_returnwarrantynotification ()
public subroutine of_vehiclesnotification (string as_dataobject)
public subroutine of_logs (string as_action)
public function string of_getcompanyname ()
public function string of_company_name ()
public subroutine of_applicationpath (ref string as_filename, ref string as_filepath)
private function string of_file_detail (string as_folder, string as_file, string as_detail)
public function str_pass_parmeters of_split (string as_list, string as_spliter)
public function integer of_compar_application_version (string as_first_ver, string as_second_ver)
public function string of_remove_space (string as_val)
public function string of_employee_name (integer al_emid)
public subroutine of_retreivedddw (u_dw ar_dw, string field_nm)
public function string of_convertarraytostring (str_pass_parmeters ar_parm)
public function long of_getkbdlocal ()
public subroutine of_setkbdeng (long ar_lang)
public subroutine of_create_xmlfile (string as_filename, string as_filedata)
public function string of_convertarraytostring (long ar_long[])
public function string of_month_nm (string ar_month_no)
public subroutine of_set_language ()
public subroutine of_user_store_card_family (long ar_uid)
public function date of_week_start_date (date ar_dt)
public function date of_week_end_date (date ar_dt)
public function date of_quarter_start_dt (date ar_dt)
public function date of_quarter_end_dt (date ar_dt)
public function string of_convertarraytostring (string ar_string[])
public function str_pass_parmeters of_backgroundcolor ()
public function boolean of_check_identity (string ar_table, string ar_colmn)
public function long of_timediff (time ar_start, time ar_end)
public subroutine of_color (ref u_dw ar_dw)
public subroutine of_log (string as_filename, string as_action)
public function string of_decrypt (string as_password)
public subroutine of_shortcutstring (str_pass_parmeters lstr_parm)
public function string eight_digit (decimal no)
end prototypes

public function string con_1_digit (integer no);choose case no
			case 1
				return  "one"
			case 2
				return  "two"
			case 3
    			return  "three"
			case 4
				return  "four"
			case 5
			   return  "five"
			case 6
				return  "six"
			case 7
				return  "seven"
			case 8
				return  "eight"
			case 9
				return "nine"
			case 0 
				return ''
		End Choose
end function

public function string con_2_digit (integer no);choose case no
      	case 0 to 9
	         return con_1_digit(no)	
	  		case 10
				return 'ten'
			case 11
				return 'eleven'
			case 12 
				return 'twelve'
			case 13
				return 'thirteen'
			case 14
				return 'Ffourteen'
			case 15
				return 'fifteen'
			case 16
				return 'sixteen'
			case 17
				return 'seventeen'
			case 18
				return 'eightteen'
			case 19 
				return 'ninteen'
			case 20
				return 'twenty '
			case 21 to 29
				return 'twenty-'+con_1_digit(long(MidA(string(no),2,2)))
			case 30
				return 'thirty '
			case 31 to 39	
				return 'thirty-'+con_1_digit(long(MidA(string(no),2,2)))
			case 40
				return 'forty '
			case 41 to 49
				return 'forty-'+con_1_digit(long(MidA(string(no),2,2)))
			case 50	
				return 'fifty '
			case 51 to 59
				return 'fifty-'+con_1_digit(long(MidA(string(no),2,2)))
			case 60
				return 'sixty '
			case 61 to 69
				return 'sixty-'+con_1_digit(long(MidA(string(no),2,2)))
			case 70
				return 'seventy '
			case 71 to 79
				return 'seventy-'+con_1_digit(long(MidA(string(no),2,2)))
			case 80	
				return 'eighty '
			case 81 to 89
				return 'eighty-'+con_1_digit(long(MidA(string(no),2,2)))
			case 90	
				return 'ninety '
			case 91 to 99
				return 'ninety-'+con_1_digit(long(MidA(string(no),2,2)))
			End choose
end function

public function integer count_digit_befor_point (decimal no);long ll_counter,ll_str_len
string ls_number
char lc_char

ls_number  = string(no)
ll_str_len = LenA(ls_number)

For ll_counter = 1 To ll_str_len
	
    lc_char = MidA(ls_number, ll_counter, 1)
    if lc_char = '.' then
		exit;
 	 End if	
Next

return ll_counter
end function

public function string con_3_digit (decimal no, string and_or_not);string ls_text
//if no < 200 then
    ls_text = con_1_digit(long(MidA(string(no),1,1))) +' hundred'+and_or_not
	ls_text = ls_text + convert_number_to_text(long(MidA(string(no),2,3)))
//else
//    ls_text = con_1_digit(long(MidA(string(no),1,1))) +' hundred'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),2,3)))
//End if	

return ls_text
end function

public function string con_4_digit (decimal no, string and_or_not);string ls_text
//if no < 2000 then
    ls_text = con_1_digit(long(MidA(string(no),1,1))) +' thousand'+and_or_not
	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),2,4)))
//else
//    ls_text = con_1_digit(long(MidA(string(no),1,1))) +' Thousands'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),2,4)))
//End if
//
return ls_text
end function

public function string con_5_digit (decimal no, string and_or_not);string ls_text
//if no < 20000 then
    ls_text = con_2_digit(long(MidA(string(no),1,2))) +' thousand'+and_or_not
	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),3,5)))
//else
//    ls_text = con_2_digit(long(MidA(string(no),1,2))) +' Thousands'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),3,5)))
//End if

return ls_text
end function

public function string con_6_digit (decimal no, string and_or_not);string ls_text,ls_and_or_not
if long(MidA(string(no),2,3))	= 0 then
    ls_and_or_not = ''
else
 	 ls_and_or_not = '  '
End if
//if no < 200000 then
    ls_text = con_3_digit(long(MidA(string(no),1,3)),ls_and_or_not) +' thousand'+and_or_not
	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),4,6)))
//else
//    ls_text = con_3_digit(long(MidA(string(no),1,3)),ls_and_or_not) +' Thousands'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),4,6)))
//End if

return ls_text
end function

public function string con_7_digit (decimal no, string and_or_not);string ls_text,ls_and_or_not

//if no < 2000000 then
    ls_text = con_1_digit(long(MidA(string(no),1,1))) +' million'+and_or_not
	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),2,6)))
//else
//    ls_text = con_1_digit(long(MidA(string(no),1,1))) +' Millions'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),2,6)))
//End if

return ls_text
end function

public function string con_8_digit (decimal no, string and_or_not);string ls_text,ls_and_or_not

//if no < 20000000 then
    ls_text = con_2_digit(long(MidA(string(no),1,2))) +' million'+and_or_not
	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),3,8)))
//else
//    ls_text = con_2_digit(long(MidA(string(no),1,2))) +' Millions'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),3,8)))
//End if

return ls_text
end function

public function string con_9_digit (decimal no, string and_or_not);string ls_text,ls_and_or_not
if long(MidA(string(no),2,3))	= 0 then
    ls_and_or_not = ''
else
 	 ls_and_or_not = '  '
End if
//if no < 200000000 then
    ls_text = con_3_digit(long(MidA(string(no),1,3)),ls_and_or_not) +' million'+and_or_not
	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),4,9)))
//else
//    ls_text = con_3_digit(long(MidA(string(no),1,3)),ls_and_or_not) +' Millions'+and_or_not
//	 ls_text = ls_text + convert_number_to_text(long(MidA(string(no),4,9)))
//End if

return ls_text
end function

public function string convert_number_to_text (long no);string ls_text,ls_no,ls_number

ls_number  = string( no )

choose case LenA(ls_number)
	case 1
		ls_no = MidA(ls_number , 1 , 1)
		ls_text = con_1_digit(long(ls_no))
	case 2
		ls_no = MidA(ls_number , 1 , 2)
		ls_text = con_2_digit(long(ls_no))
	case 3
      ls_no = MidA(ls_number , 1 , 3)
		if MidA(ls_no , 2 , 3) = '00' then
			ls_text = con_3_digit(long(ls_no),'')
		else
   		ls_text = con_3_digit(long(ls_no),' ')
		End if	
	case 4
      ls_no = MidA(ls_number , 1 , 4)
   	if MidA(ls_no , 2 , 4) = '000' then
    		ls_text = con_4_digit(long(ls_no),'')					
		else
		   ls_text = con_4_digit(long(ls_no),' ')		
		End if	
	case 5
      ls_no = MidA(ls_number , 1 , 5)
   	if MidA(ls_no , 2 , 5) = '0000' then
    		ls_text = con_5_digit(long(ls_no),'')					
		else
		   ls_text = con_5_digit(long(ls_no),' ')		
		End if	

	case 6
      ls_no = MidA(ls_number , 1 , 6)
   	if MidA(ls_no , 2 , 6) = '00000' then
    		ls_text = con_6_digit(long(ls_no),'')					
		else
		   ls_text = con_6_digit(long(ls_no),'  ')		
		End if	

	case 7
      ls_no = MidA(ls_number , 1 , 7)
   	if MidA(ls_no , 2 , 7) = '000000' then
    		ls_text = con_7_digit(long(ls_no),'')					
		else
		   ls_text = con_7_digit(long(ls_no),'  ')		
		End if	

	case 8
      ls_no = MidA(ls_number , 1 , 8)
   	if MidA(ls_no , 2 , 8) = '0000000' then
    		ls_text = con_8_digit(long(ls_no),'')					
		else
		   ls_text = con_8_digit(long(ls_no),'  ')		
		End if	

	case 9
      ls_no = MidA(ls_number , 1 , 9)
   	if MidA(ls_no , 2 , 9) = '00000000' then
    		ls_text = con_9_digit(long(ls_no),'')					
		else
		   ls_text = con_9_digit(long(ls_no),'  ')		
		End if	

		
End choose


return ls_text
end function

public function string round_up_to_half (decimal fee);String ls_fee
Long ll_befor,ll_after,ll_counter

ll_counter = count_digit_befor_point(fee)
ls_fee     = String(fee)

ll_befor = Long(MidA( ls_fee , 1              , ll_counter - 1 ))
ll_after = Long(MidA( ls_fee , ll_counter + 1 , 3 ))

if ll_after < 500 then
	return string(ll_befor)+"."+"500"
else
	ll_befor++	
	return string(ll_befor)+"."+"000"	
end if



end function

public function long round_up_to_100 (long weight);Long li_count,ll_no    
String  ls_weight

ls_weight = string(weight)

ls_weight = ReplaceA(ls_weight,LenA(string(weight))-1,2,"00")

li_count  = LenA(ls_weight) - 2

do while li_count <> 0
	
	if MidA(ls_weight,li_count,1) <> "9" then
		
	   ll_no = long(MidA(ls_weight,li_count,1)) + 1	
	 
	   return long(ReplaceA(ls_weight,li_count,1,string(ll_no)))
	 
  else	  

     ls_weight = ReplaceA(ls_weight,li_count,1,"0")

  End if 
  
  li_count -= 1
  
loop

return -1

end function

public function boolean check_user_id (string ar_user_id);Long   ll_user_no = 0

SELECT user_no
INTO   :ll_user_no
FROM   Users
WHERE  (User_id = :ar_user_id) AND (ACTIVE_FG = "Y") ;

if (ll_user_no = 0) or IsNull(ll_user_no) then 
	
	return False
	
else	

   return True
	
End if
end function

public function integer count_items (integer ar_cbill_no, string ar_table);Long ll_counter

If ar_table = "1" then

  SELECT COUNT(CBILL_NO)
  INTO   :ll_counter
  FROM   CACH_BILL_ITEMS
  WHERE  (CBILL_NO = :ar_cbill_no)AND(ACTIVE_FG = "Y");

Else  
  If ar_table = "2" then
	
	  SELECT COUNT(BILL_NO)
     INTO   :ll_counter
     FROM   CUSTOMER_BILL_ITEMS
     WHERE  (BILL_NO = :ar_cbill_no)AND(ACTIVE_FG = "Y");

  Else
     If ar_table = "3" then
		
		  SELECT COUNT(BILL_NO)
        INTO   :ll_counter
        FROM   INCOME_BILL_ITEM
        WHERE  (BILL_NO = :ar_cbill_no)AND(ACTIVE_FG = "Y");
		  
	Else
		
		  SELECT COUNT(BILL_NO)
        INTO   :ll_counter
        FROM   REMOVE_BILL_ITEMS
        WHERE  (BILL_NO = :ar_cbill_no)AND(ACTIVE_FG = "Y");
		
   End if
	  
	  
  End if
  
End if

  if IsNull(ll_counter) then ll_counter = 0

  Return ll_counter
end function

public subroutine delete_kind_card_action (integer ar_sc_id, integer ar_bill_no, datetime ar_dt, string ar_in_or_out, integer ar_store_id);
delete from kind_card_action 
where ( sc_id = :ar_sc_id ) and (bill_no = :ar_bill_no) and (action_dt = :ar_dt)and(kind = :ar_in_or_out);
end subroutine

public function string add_and_arabic (string ar_text_arabic);String ls_txt

ls_txt = ar_text_arabic + " و "

return ls_txt
end function

public function string four_digit_arabic (decimal no);string ls_text
Long ll_Thousand = 1000

choose case no
		
	case 1000 to 1999
		if (no - 1000) = 0 then
			ls_text = "الف"
		Else
		   ls_text = "الف"+add_and_arabic("")+three_digit_arabic(no - ll_thousand)
		End if
		
	case 2000 to 2999		
   	if (no - 2000) = 0 then		
		   ls_text = "الفان"
		Else
   		ls_text = "الفان"+add_and_arabic("")+three_digit_arabic(no - 2000)		
		End if
	case 3000 to 9999
		
		ll_thousand = ll_thousand * Long( MidA( string( no ) , 1 , 1 ) )
		
		if (no - ll_thousand ) = 0 then
         ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"الاف"
		Else
		   ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+" الاف "+add_and_arabic("")+three_digit_arabic(no - ll_thousand)		
   	End if
end choose

return ls_text
end function

public function string three_digit_arabic (decimal no);string ls_text
Long ll_handred = 100

choose case no
	Case 1 to 9
		ls_text = one_digit_arabic( no )
	Case 10 to 99	
		ls_text = two_digit_arabic( no )
	Case 100 to 199
		
		if (no -100) = 0 then
			ls_text = "مئة"
		ELse
			ls_text = "مئة"+add_and_arabic("")+two_digit_arabic( no - 100)
		End if
		
	Case 200 to 299
		
		if (no - 200) = 0 then
		  ls_text = "مئتان"
		Else
        ls_text = "مئتان"+add_and_arabic("")+two_digit_arabic( no - 200)		
   	ENd if
		
	Case 300 to 399
		
		if (no - 300) = 0 then
			ls_text = "ثلاثمائة"
		Else
        ls_text = "ثلاثمائة"+add_and_arabic("")+two_digit_arabic( no - 300)		
	   End if
		
	Case 400 to 499
		
		if (no - 400) = 0 then
			ls_text = "اربعمائة"
		Else
         ls_text = "اربعمائة"+add_and_arabic("")+two_digit_arabic( no - 400)			
		End if
		
	Case 500 to 599
		
		if (no - 500) = 0 then
   		ls_text = "خمسمائة"
		ELse
         ls_text = "خمسمائة"+add_and_arabic("")+two_digit_arabic( no - 500)		
		End if
		
	Case 600 to 699
		
      if (no - 600) = 0 then		
			ls_text = "ستمائة"
		Else
         ls_text = "ستمائة"+add_and_arabic("")+two_digit_arabic( no - 600)		
   	End if
		
	Case 700 to 799
		
      if (no - 700) = 0 then			
		  ls_text = "سبعمائة"
		ELse
        ls_text = "سبعمائة"+add_and_arabic("")+two_digit_arabic( no - 700)		
	   End if
				
	Case 800 to 899
		
      if (no - 800) = 0 then			
        ls_text = "ثمانمائة"			
		Else
        ls_text = "ثمانمائة"+add_and_arabic("")+two_digit_arabic( no - 800)		
   	ENd if
		
	Case 900 to 999
		
      if (no - 900)  = 0 then			
		  ls_text = "تسعمائة"
		Else
        ls_text = "تسعمائة"+add_and_arabic("")+two_digit_arabic( no - 900)		
	   End if
		
End choose



return ls_text
end function

public function string five_digit_arabic (decimal no);string ls_text
Long ll_ten_thousand = 1000

ll_ten_thousand = ll_ten_thousand * Long(MidA(string(no),1,2))
if (no - ll_ten_thousand) = 0 then
	ls_text = two_digit_arabic(Long(MidA(string(no),1,2)))+"الف"
Else
	ls_text = two_digit_arabic(Long(MidA(string(no),1,2)))+" "+"الف"+add_and_arabic("")+three_digit_arabic(no - ll_ten_thousand)
End if
return ls_text
end function

public subroutine add_to_store (integer ar_sc_id, integer ar_quantity, real ar_price);
UPDATE STORE_CARD SET QUANTITY = :ar_quantity  
WHERE SC_ID = :ar_sc_id ;


end subroutine

public subroutine update_inventory (integer ar_sc_id, integer ar_store_id, integer ar_quantity, decimal ar_price);Long ll_inv_id

SELECT INV_ID 
INTO  :ll_inv_id
FROM INVENTORY
WHERE ((STORE_ID = :ar_store_id) AND (SC_ID = :ar_sc_id)) ;

if IsNull(ll_inv_id) or (ll_inv_id = 0)then
	
	INSERT INTO INVENTORY (STORE_ID , SC_ID , QUANTITY )
	VALUES    (:AR_STORE_ID,:AR_SC_ID,:AR_QUANTITY) ;
	
else
	
	UPDATE INVENTORY SET QUANTITY = :AR_QUANTITY 
	WHERE  (STORE_ID = :AR_STORE_ID) AND (SC_ID = :AR_SC_ID) ;
	
End if

return 

end subroutine

public function boolean char_to_boolean (character y_n_char);if y_n_char = "Y" then
	return True
else
	return False
End if	
end function

public subroutine add_kind_card_action (datetime ar_dt, integer ar_bill_no, string ar_in_or_out, integer ar_quantity, integer ar_sc_id, integer ar_store_id, integer ar_item_id, decimal ar_price, integer ar_customer_id, string ar_manul_no);Long ll_quantity,ll_store_id

if ar_in_or_out = "I" then
	
   select income_quantity , store_id
   into  :ll_quantity     , :ll_store_id
   from   kind_card_action
   where ( sc_id = :ar_sc_id ) and ( bill_no = :ar_bill_no ) and ( action_dt = :ar_dt ) and ( kind = :ar_in_or_out ) and ( store_id = :ar_store_id ) ;

   if IsNull(ll_quantity) or ll_quantity = 0  then
			
	  	insert into kind_card_action
	   ( sc_id , action_dt , bill_no , income_quantity , sold_quantity , kind , store_id , item_id , price, customer_id ,manul_no)
    	values ( :ar_sc_id , :ar_dt , :ar_bill_no , :ar_quantity , -1 , :ar_in_or_out , :ar_store_id , :ar_item_id , :ar_price , :ar_customer_id , :ar_manul_no ) ;
		 
	Else
   
     	update kind_card_action set sc_id = :ar_sc_id ,action_dt = :ar_dt , bill_no = :ar_bill_no , income_quantity = :ar_quantity , price = :ar_price, customer_id = :ar_customer_id , manul_no = :ar_manul_no
  		where (sc_id = :ar_sc_id)and(bill_no = :ar_bill_no)and(kind = :ar_in_or_out);
		  
	End if	
	
Else
	
   select sold_quantity   , store_id
   into  :ll_quantity     , :ll_store_id
   from   kind_card_action
   where ( sc_id = :ar_sc_id ) and ( bill_no = :ar_bill_no ) and ( action_dt = :ar_dt ) and ( kind = :ar_in_or_out ) and ( store_id = :ar_store_id ) ;
	
   if IsNull(ll_quantity) or ll_quantity = 0 then
		
   	insert into kind_card_action
	   ( sc_id , action_dt , bill_no , sold_quantity , income_quantity , kind , store_id , item_id , price ,customer_id , manul_no)
    	values ( :ar_sc_id , :ar_dt , :ar_bill_no , :ar_quantity , -1 , :ar_in_or_out , :ar_store_id , :ar_item_id , :ar_price ,:ar_customer_id ,:ar_manul_no ) ;

	Else
		
		update kind_card_action set sc_id = :ar_sc_id ,action_dt = :ar_dt , bill_no = :ar_bill_no , sold_quantity = :ar_quantity , price = :ar_price , customer_id = :ar_customer_id , manul_no = :ar_manul_no
		where (sc_id = :ar_sc_id)and(bill_no = :ar_bill_no)and(kind = :ar_in_or_out);	
		
	ENd if
	
ENd if
end subroutine

public function integer compute_quantity_all_store (integer ar_sc_id);Long ll_client_quantitY , ll_store_quantity

SELECT SUM(QUANTITY)
INTO   :ll_client_quantitY
FROM   CUSTOMER_BILL_ITEMS
WHERE ( SC_ID = :ar_sc_id ) AND (ACTIVE_FG = 'Y');

if IsNull(ll_client_quantitY) then ll_client_quantitY = 0

SELECT SUM(INCOME_BILL_ITEM.QUANTITY)
INTO  :ll_store_quantity
FROM  INCOME_BILL_ITEM,   
      INCOME_STORE_BILL  
WHERE ( INCOME_STORE_BILL.BILL_NO = INCOME_BILL_ITEM.BILL_NO ) AND
      ( ( INCOME_BILL_ITEM.SC_ID = :ar_sc_id ) AND  
        ( INCOME_BILL_ITEM.ACTIVE_FG = 'Y' ) AND  
        ( INCOME_STORE_BILL.ACTIVE_FG = 'Y' ) )   ; 	
   		
if IsNull(ll_store_quantity) then ll_store_quantity = 0

RETURN (ll_store_quantity - ll_client_quantitY )
end function

public function integer compute_quantity_for_store (integer ar_store_id, integer ar_sc_id);Long  ll_client_quantitY , ll_store_quantity


SELECT SUM(QUANTITY)
INTO   :ll_client_quantitY
FROM   CUSTOMER_BILL_ITEMS
WHERE ( STORE_ID = :ar_store_id ) AND ( SC_ID = :ar_sc_id ) AND (ACTIVE_FG = 'Y');

if IsNull(ll_client_quantitY) then ll_client_quantitY = 0

SELECT SUM(INCOME_BILL_ITEM.QUANTITY)
INTO  :ll_store_quantity
FROM  INCOME_BILL_ITEM,   
      INCOME_STORE_BILL  
WHERE ( INCOME_STORE_BILL.BILL_NO = INCOME_BILL_ITEM.BILL_NO ) AND
          (INCOME_STORE_BILL.STORE_ID = :ar_store_id)  AND
        ( ( INCOME_BILL_ITEM.SC_ID = :ar_sc_id ) AND  
        ( INCOME_BILL_ITEM.ACTIVE_FG = 'Y' ) AND  
        ( INCOME_STORE_BILL.ACTIVE_FG = 'Y' ) )   ; 	
   		
if IsNull(ll_store_quantity) then ll_store_quantity = 0

RETURN (ll_store_quantity - ll_client_quantitY  )
end function

public function decimal cash_action ();
Decimal ld_total


SELECT SUM(amount) 
INTO :ld_total
FROM cash_action;

return ld_total
end function

public function string two_digit_arabic (integer no);String ls_text

choose case no
      	case 0 to 9
		      ls_text = one_digit_arabic(no)
      	case 10
				ls_text = 'عشرة'
			case 11
				ls_text = 'احد عشر'
			case 12 
				ls_text = 'إثناعشر'
			case 13 to 19
				
				ls_text = one_digit_arabic(no - 10)+'عشر '
				
			case 20 to 29
				
				if (no - 20) = 0 then
					ls_text = 'عشرون'
				ELse
					ls_text = one_digit_arabic(no - 20)+add_and_arabic("")+" عشرون"
				End if
				
			case 30 to 39	
				
				if (no - 30) = 0 then
               ls_text = 'ثلاثون'					
				Else
				   ls_text = one_digit_arabic(no - 30)+add_and_arabic("")+'ثلاثون'
			   End if
				
			case 40 to 49
				
				if (no - 40) = 0 then				
				   ls_text = 'اربعون'					
				Else
				   ls_text = one_digit_arabic(no - 40)+add_and_arabic("")+'اربعون'
			   End if
				
			case 50 to 59
				
				if (no - 50) = 0 then				
					ls_text = 'خمسون '					
				Else
    				ls_text = one_digit_arabic(no - 50)+add_and_arabic("")+'خمسون '
			   End if
				
			case 60 to 69
				
				if (no - 60) = 0 then								
               ls_text = 'ستون '					
				Else
				   ls_text = one_digit_arabic(no - 60)+add_and_arabic("")+'ستون '
			   End if
				
			case 70 to 79
				
				if (no - 70) = 0 then								
				   ls_text = 'سبعون '					
				Else
				   ls_text = one_digit_arabic(no - 70)+add_and_arabic("")+'سبعون '
			   End if
				
			case 80 to 89
				
				if (no - 80) = 0 then
               ls_text = 'ثمانون '					
				Else
   				ls_text = one_digit_arabic(no - 80)+add_and_arabic("")+'ثمانون '
			   End if
				
			case 90 to 99
				
				if (no - 90) = 0 then
				   ls_text = 'تسعون '					
				Else
				   ls_text = one_digit_arabic(no - 90)+add_and_arabic("")+'تسعون '
   			End if
				
			End choose
			
		return ls_text
end function

public function integer uf_new_id (string ar_field_nm, string ar_field_type);Long ll_id = 0 

SELECT INT_VAL
INTO :ll_id
FROM PARAMETERS_CD
WHERE FIELD_NM = :ar_field_nm;

if(IsNull(ll_id))then ll_id = 0


ll_id = ll_id + 1 

UPDATE parameters_cd set int_val = int_val + 1 where field_nm = : ar_field_nm;

return ll_id
end function

public function integer find_title (string ar_title);Long ll_akid = 0 

SELECT AKID
INTO :ll_akid
FROM ASOL_KIND
WHERE title = :ar_title;

if(IsNull(ll_akid))then ll_akid = 1


return ll_akid

end function

public function string pre_convert (decimal no, string a_large_unit, string a_small_unit, integer a_fractions);long   ll_counter
string ls_number,ls_text,ls_arabic_text

no = round(no,a_fractions)
ll_counter = count_digit_befor_point(no)

choose case gs_lan
	case "AR"
		ls_text 	 = convert_number_to_arabic_text(long(MidA(string(no),1,ll_counter - 1)))		
	case "EN"
		ls_text    = convert_number_to_text(long(MidA(string(no),1,ll_counter - 1)))
	case "FR"
		ls_text    = convert_number_to_text(long(MidA(string(no),1,ll_counter - 1)))
	case "SP"
		ls_text    = convert_number_to_text(long(MidA(string(no),1,ll_counter - 1)))
	case "IT"
		ls_text    = convert_number_to_text(long(MidA(string(no),1,ll_counter - 1)))
	case else 
		ls_text    = convert_number_to_arabic_text(long(MidA(string(no),1,ll_counter - 1)))		
end choose

ls_number  = string(no)
ls_number  = MidA(ls_number,ll_counter+1,ll_counter+4)
ls_number  = MidA(ls_number , 1,a_fractions)

if long(ls_number) > 0 then
	if(ls_text = "")then
	
	  Choose Case gs_lan
			Case "AR"
		  		ls_text = ls_text+ convert_number_to_arabic_text(long(MidA(ls_number,1,3)))+ a_small_unit
			case "EN"
				ls_text    = ls_text + convert_number_to_text(long(MidA(ls_number,1,3))) +" "+ a_small_unit+" "
			case "FR"
				ls_text    =ls_text + convert_number_to_text(long(MidA(ls_number,1,3)))+" "+ a_small_unit+" "
			case "SP"
				ls_text    =ls_text + convert_number_to_text(long(MidA(ls_number,1,3)))+" "+ a_small_unit+" "
			case "IT"
				ls_text    = ls_text + convert_number_to_text(long(MidA(ls_number,1,3)))+ " "+a_small_unit+" "
			case else
				ls_text = ls_text+ convert_number_to_arabic_text(long(MidA(ls_number,1,3)))+a_small_unit
		End Choose
   else
		
	 	  Choose Case gs_lan
			Case "AR"
		  		ls_text = ls_text+a_large_unit+" و "
     			ls_text = ls_text+ convert_number_to_arabic_text(long(MidA(ls_number,1,3)))+a_small_unit	
			case "EN"
				ls_text = ls_text+" "+a_large_unit+" and "
				ls_text    = ls_text + convert_number_to_text(long(MidA(ls_number,1,3))) +" "+ a_small_unit+" "
			case "FR"
				ls_text = ls_text+" "+a_large_unit+" e "
				ls_text    =ls_text + convert_number_to_text(long(MidA(ls_number,1,3)))+ " "+a_small_unit+" "
			case "SP"
				ls_text = ls_text+" "+a_large_unit+" e "
				ls_text    =ls_text + convert_number_to_text(long(MidA(ls_number,1,3)))+" "+ a_small_unit+" "
			case "IT"
				ls_text = ls_text+" "+a_large_unit+" e "
				ls_text    = ls_text + convert_number_to_text(long(MidA(ls_number,1,3)))+ " "+ a_small_unit+" "
			case else
				ls_text = ls_text+a_large_unit+" و "
     			ls_text = ls_text+ convert_number_to_arabic_text(long(MidA(ls_number,1,3)))+" درهم"		
		End Choose 
   end if
else
	Choose Case gs_lan
		Case "AR"
			ls_text = ls_text +a_large_unit
		Case "EN"
			ls_text = ls_text +" "+a_large_unit
		Case "FR"
			ls_text = ls_text +" "+a_large_unit
		Case "SP"
			ls_text = ls_text +" "+a_large_unit
		Case "IT"
			ls_text = ls_text +" "+a_large_unit
		case else
			ls_text = ls_text +a_large_unit
	End Choose 
End if

return ls_text

end function

public function string one_digit_arabic (integer no);String ls_text=""
choose case no
			case 1
				ls_text = 'واحد'
			case 2
				ls_text =  'إثنان'
			case 3
    			ls_text =  'ثلاثة'
			case 4
				ls_text =  'اربعة'
			case 5
			   ls_text =  'خمسة'
			case 6
				ls_text =  'ستة'
			case 7
				ls_text =  'سبعة'
			case 8
				ls_text =  'ثمانية'
			case 9
				ls_text = 'تسعة'
			Case 0
				ls_text = ""
		End Choose
		
return ls_text
end function

public function integer uf_get_max_id (string as_tbl_nm);Long ll_max

choose case as_tbl_nm
	case "YEARLY_EVALUATION"
		  SELECT ISNULL(MAX(ID) , 0 )
		  INTO :ll_max
		  FROM YEARLY_EVALUATION ; 
	case "DAILY_EMPLOYEE_EVALUATION"	  
        SELECT IsNull(Max(DEEID),0)		
		  INTO :ll_max
		  FROM DAILY_EMPLOYEE_EVALUATION;
   case "YEARLY_EVALUATION_DETAILS"
	     SELECT IsNull(Max(DID),0)		
   	  INTO :ll_max
		  FROM YEARLY_EVALUATION_DETAILS;
	case "RECOMMENDATIONS"
	     SELECT IsNull(Max(RID),0)		
   	  INTO :ll_max
		  FROM RECOMMENDATIONS;
		
end choose

return ll_max+1
end function

public function string uf_araoundupquart (decimal fee);String ls_fee
Long ll_befor,ll_after,ll_counter , ll_temp
Long ll_times 

ll_counter = count_digit_befor_point(fee)
ls_fee     = String(fee)

ll_befor = Long(MidA( ls_fee , 1              , ll_counter - 1 ))
ll_after = Long(MidA( ls_fee , ll_counter + 1 , 3 ))

ll_temp  = ll_after
ll_times = 1
if(ll_temp = 0)then
  return string(ll_befor)+"."+"000"
Else
  Do While ll_temp >= 250
	
	  ll_temp -= 250
   
	  If(ll_temp <= 0)Then
	   
		  exit;
				
     End if
   
	  ll_times++
	
  Loop
End if

choose case ll_times
	case 1
      return string(ll_befor)+"."+"250"
	case 2
		return string(ll_befor)+"."+"500"
	case 3
		return string(ll_befor)+"."+"750"
	case 4
		  ll_befor++
		  return string(ll_befor)+"."+"000"
	case else 
		  return "-1"
end choose

 


end function

public function string seven_digit (decimal no);string ls_text
Long ll_ten_thousand = 1000000

choose case long(MidA(string(no),1,1))
	case 1
		if( (no - 1000000) = 0)Then
			ls_text = 'مليون'
		else			
			choose case long(MidA(string(no),2,4))
				case is < 10
					ls_text = 'مليون'+add_and_arabic("")+four_digit_arabic(abs(no - 1000000))													
				case is < 100
					ls_text = 'مليون'+add_and_arabic("")+five_digit_arabic(abs(no - 1000000))								
				case else
					ls_text = 'مليون'+add_and_arabic("")+six_digit_arabic(abs(no - 1000000))			
			end choose		
		end if
	case 2
		if( (no - 2000000) = 0)Then
			ls_text = 'مليونين'
		else
			choose case long(MidA(string(no),2,3))
				case is < 10
					ls_text = 'مليونين'+add_and_arabic("")+four_digit_arabic(abs(no - 2000000))																		
				case is < 100
					ls_text = 'مليونين'+add_and_arabic("")+five_digit_arabic(no - 2000000)											
				case else
					ls_text = 'مليونين'+add_and_arabic("")+six_digit_arabic(no - 2000000)			
			end choose					
		end if		
	case else	
		choose case long(MidA(string(no),2,3))
				case is < 10
					ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"ملايين"+add_and_arabic("")+four_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,1))))											
				case is < 100
					ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"ملايين"+add_and_arabic("")+five_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,1))))											
				case else
					ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"ملايين"+add_and_arabic("")+six_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,1))))
			end choose		
		
end choose

return ls_text
end function

public function string convert_number_to_arabic_text (long no);string ls_text,ls_no,ls_number

ls_number  = string( no )

choose case LenA(ls_number)
	case 1
		
		ls_no = MidA(ls_number , 1 , 1)
		ls_text = one_digit_arabic(Long(ls_no))
		
	case 2
		
		ls_no = MidA(ls_number , 1 , 2)
		ls_text = two_digit_arabic(Long(ls_no))
		
	case 3
		
      ls_no = MidA(ls_number , 1 , 3)
		ls_text = three_digit_arabic(Long(ls_no))
		
	case 4
		
      ls_no = MidA(ls_number , 1 , 4)
		ls_text = four_digit_arabic(Long(ls_no))
   	
	case 5
		
      ls_no   = MidA(ls_number , 1 , 5)
		ls_text = five_digit_arabic(long(ls_no))

	case 6
      ls_no   = MidA(ls_number , 1 , 6)
      ls_text = six_digit_arabic(Long(ls_no))  

	case 7
      ls_no   = MidA(ls_number , 1 , 7)
      ls_text = seven_digit(Long(ls_no))  

	case 8
      ls_no   = MidA(ls_number , 1 , 8)
      ls_text = eight_digit(Long(ls_no))  
		
End choose


return ls_text
end function

public function string six_digit_arabic (decimal no);string ls_text
Long ll_ten_thousand = 1000

ll_ten_thousand = ll_ten_thousand * Long(MidA(string(no),1,3))
if (no - ll_ten_thousand) = 0 then
	ls_text = three_digit_arabic(Long(MidA(string(no),1,3)))+"الف"
Else
	ls_text = three_digit_arabic(Long(MidA(string(no),1,3)))+" "+"الف"+add_and_arabic("")+three_digit_arabic(no - ll_ten_thousand)
End if
return ls_text
end function

public subroutine uf_retrieve_dddw_integer (ref datawindow ar_dw, integer ar_retrieve_value, string field_nm);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
//	Function	: uf_retrieve_dddw_integer						   																//
// Object	: nvo_services																								//
// Author   : Bassam Mezoghi																							//
// Date		: 04-06-2007																								//
//																																//
// Description : This function retrieve dddw list to refresh it                //
//                                                                                 //
// Modifications: 																										//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_temp

ar_dw.GetChild(field_nm , ldwc_temp)

ldwc_temp.SetTransObject(SQLCA)

ldwc_temp.Retrieve(ar_retrieve_value)

Return 
end subroutine

public function datetime uf_today ();DataStore lds
DateTime ldt

lds = Create DataStore

lds.DataObject = "d_today"
lds.SetTransObject( SQLCA )
lds.Retrieve( )

if(lds.rowcount() > 0)THEN
	ldt = lds.GetItemDateTime(1,"today")
else
	ldt = datetime(today(),now())
END IF

Destroy lds

Return ldt

end function

public function string uf_get_id (string as_parm_nm, string as_type);n_tr MyTran
Long ll_val

MyTran = Create n_tr

gnv_app.uf_fill_transaction( MyTran , gnv_app.of_getappinifile( ) , "Database", False, "RC")



Choose Case Lower(as_type)
	Case "string"
		
	Case "long"
		
		MyTran.of_connect( )
			
Cal:	SELECT int_val
		INTO :ll_val
		FROM PARAMETERS_CD
		WHERE FIELD_NM = :as_parm_nm Using MyTran;
		
		ll_val++
		
		UPDATE PARAMETERS_CD 
			SET int_val = :ll_val
		WHERE FIELD_NM = :as_parm_nm AND int_val = :ll_val - 1 Using MyTran;
		
		If(MyTran.sqlnrows = 0)Then GOTO Cal
			
		MyTran.of_commit( )
		
		MyTran.of_DisConnect()
				
		Destroy MyTran;
		
		Return String(ll_val)
		
End Choose




end function

public subroutine retrieve_dddw (ref datawindow ar_dw, integer ar_retrieve_value, string field_nm);DataWindowChild ldwc_temp

ar_dw.GetChild(field_nm , ldwc_temp)

ldwc_temp.SetTransObject(SQLCA)

ldwc_temp.Retrieve(ar_retrieve_value)

Return 
end subroutine

public function string uf_get_id_from_parm_cd (string as_table_nm);DataStore lds_GetID ,ds 
String ls_id,ls_TableName , ls_KeyName
Long ll_id
Long ll_PointPos

ll_PointPos = Pos(as_table_nm , ".")

IF ll_PointPos > 0 THEN
	ls_TableName = Mid(as_table_nm , 1 , ll_PointPos - 1)
	ls_KeyName = Mid(as_table_nm , ll_PointPos + 1 , Len(as_table_nm))
ELSE
	ls_TableName = as_table_nm
END IF

lds_GetID = Create DataStore
lds_GetID.DataObject  = "sp_get_id_from_parm_cd"
lds_GetID.SetTransObject( SQLCA )

lds_GetID.Retrieve( ls_TableName , "1" )

ls_id = String( lds_GetID.GetItemNumber( 1 , "id" ) )

Destroy lds_GetID

IF ls_id = "1" and ls_TableName <> as_table_nm THEN
	
	ds = CREATE DataStore
	ds.DataObject = "d_max_id"
	ds.SetTransObject(SQLCA)
	ds.SetSqlSelect( "SELECT MAX("+ls_KeyName+") as Max FROM "+ls_TableName)
	ds.retrieve( )
	ll_id = ds.GetItemNumber(1  , "max")
	Destroy ds
	
	IF Not IsNull( ll_id ) and ll_id > 0 THEN 
	
		ll_id++
		UPDATE PARAM_CD SET LONG_VALUE = :ll_id WHERE PARM_NM = :ls_TableName;
		ls_id = String(ll_id)
		
	END IF
	
END IF

Return  ls_id
end function

public function str_pass_parmeters uf_insert_dw (ref datawindow ar_dw);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
//	Function	: uf_insert_dw						   																//
// Object	: nvo_services																								//
// Author   : Bassam Mezoghi																							//
// Date		: 04-06-2007																								//
//																																//
// Description : This function insert new row into datawindow if ib_ds false                                                  //
//               and return str_parm 
// Modifications: 																										//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

str_pass_parmeters lstr_parm
//nvo_msg lnv_msg

//lnv_msg = Create nvo_msg

lstr_parm.long_parm[1] = ar_dw.Insertrow(0)

If( ( lstr_parm.long_parm[1]  > 0 ) and (Not isNull(lstr_parm.long_parm[1]) ) )Then

    ar_dw.ScrollToRow(lstr_parm.long_parm[1])
    ar_dw.SetItem( lstr_parm.long_parm[1] , "Active_fg"         , "Y"                       )
    ar_dw.SetItem( lstr_parm.long_parm[1] , "Created_by"        , gstr_user_info.login_id  )
    ar_dw.SetItem( lstr_parm.long_parm[1] , "Created_dt"        , today())//gnv_services.uf_current_datetime( )  )

    lstr_parm.b_parm[1] = True
	
else
	
   //insert record faild
//  lnv_msg.uf_messages("5" )
   lstr_parm.b_parm[1] = False
	
End If

return lstr_parm
end function

public subroutine uf_retrieve_dddw_string (ref datawindow ar_dw, string ar_retrieve_value, string field_nm);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
//	Function	: uf_retrieve_dddw_string						   																//
// Object	: nvo_services																								//
// Author   : Bassam Mezoghi																							//
// Date		: 04-06-2007																								//
//																																//
// Description : This function retrieve dddw list to refresh it                //
//                                                                                 //
// Modifications: 																										//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DataWindowChild IDWC_Temp

Ar_DW.GetChild(Field_NM , IDWC_Temp)

IDWC_Temp.SetTransObject(SQLCA)

IDWC_Temp.Retrieve(Ar_Retrieve_Value)

Return 
end subroutine

public function decimal uf_getbuyprice (integer ar_sc_id);DataStore lds
Decimal ld_price

lds = Create DataStore

lds.DataObject = "ds_letast_buy_price"
lds.SetTransObject(SQLCA)

//if(IsNull(ar_sc_id))Then MessageBox("Get Price" , "SC is  null")
//
lds.retrieve( ar_sc_id ) 

ld_price = lds.GetItemDecimal(1,"Other_Price")

//MessageBox("Get Price","Price :"+String(ld_price)+"~n SC ID"+string(ar_sc_id))

Destroy lds

return ld_price 
end function

public function string of_remove_extenion (string ar_file_nm);Long ll_len,ll_pos

ll_len = LenA(ar_file_nm)
ll_pos = PosA(ar_file_nm,".") - 1

Return MidA(ar_file_nm , 1, ll_pos )
end function

public function string uf_get_id_from_parm_tbl (string as_tbl_nm);Long ll_long,ll_rc
String ls_str
DataStore lds

lds = Create DataStore
lds.DataObject = "d_int_getidfromparmtbl"
lds.SetTransObject( SQLCA )

Choose Case Lower(as_tbl_nm)
	Case "source_discount_invoice"		
		For ll_rc = 1 To 100
			
			lds.Retrieve( as_tbl_nm ,'Long')					
			ll_long = lds.GetItemNumber( lds.GetRow() , "res" ) 
		
			If(ll_long <> -100)Then exit;
			
		Next	
		Destroy lds
		Return String(ll_long)
	Case "sync_data"
		For ll_rc = 1 To 100
			
			lds.Retrieve( as_tbl_nm ,'Long')					
			ll_long = lds.GetItemNumber( lds.GetRow() , "res" ) 
		
			If(ll_long <> -100)Then exit;
			
		Next	
		Destroy lds
		Return String(ll_long)
		
End Choose

Return "-1"
end function

public function string of_encrypt_password (string as_password);String ls_res
//n_cst_crypto lnv_crypt
n_cryptoapi lnv_crypt
//lnv_crypt = Create n_cst_crypto

ls_res = lnv_crypt.of_encrypthex( gnv_app.of_GetEncryptionAlgorithm( ) , as_password , gnv_app.of_getMyKey() ) //as_password , gnv_app.of_getMyKey())

//Destroy lnv_crypt

Return ls_res
end function

public function integer of_restore_db (long ar_db_id, string ar_fullname);	String ls_fullname,ls_filename
	Long li_open
	Int li_res
	String ls_Syntax , ls_database
	Transaction ll_sqlca
	//cs_sync lc_sync
	
	//lc_sync = Create cs_sync
	 
	SetPointer(HourGlass!)
	
	ll_sqlca = Create Transaction
	
	gnv_app.of_fill_transaction( ll_sqlca , gnv_app.of_getappinifile( ) , "Database", True,"RU")		
	
	gstr_user_info.Restor_status = False
		
	//ls_database = lc_sync.of_dbnm(ar_db_id)
	
	//Destroy lc_sync;
	ll_sqlca.Database = 'master'
	Connect using ll_sqlca;
	
	if(ll_sqlca.sqlcode < 0)Then
		Disconnect USING ll_sqlca;
		Destroy ll_sqlca;
		return -5	
	End if
	
	ls_Syntax = "RESTORE DATABASE "+ls_database+" FROM  DISK = N'"+ar_fullname+"' WITH  FILE = 1, PASSWORD = 'Br@s1l1@', NOUNLOAD,  REPLACE, STATS = 10"

	Execute Immediate :ls_Syntax Using ll_sqlca;

	IF(ll_sqlca.sqldbcode = 0)Then
	
		   SetPointer(Arrow!)		  
		   gstr_user_info.Restor_status = True
		   Disconnect using ll_sqlca;
		   Destroy ll_sqlca;
		   Return 1
			
	Else			
		   Disconnect using ll_sqlca;
		   Destroy ll_sqlca;
		   Return -6
	End if

	SetPointer(Arrow!)


			
end function

public function integer of_restore_db (string ar_database, string ar_fullname);	String ls_fullname,ls_filename
	Long li_open
	Int li_res
	String ls_Syntax , ls_database
	Transaction ll_sqlca
	 
	SetPointer(HourGlass!)
	
	ll_sqlca = Create Transaction
	
	gnv_app.of_fill_transaction( ll_sqlca , gnv_app.of_getappinifile( ) , "Database", True,"RU")		
	
	gstr_user_info.Restor_status = False
		
	ls_database = ar_database//gnv_services.of_dbnm(ar_db_id)
	ll_sqlca.database = 'master'
	Connect using ll_sqlca;
	
	if(ll_sqlca.sqlcode < 0)Then
		Disconnect Using ll_sqlca;
		Destroy ll_sqlca;
		return -5	
	End if
	
	ls_Syntax = "RESTORE DATABASE "+ls_database+" FROM  DISK = N'"+ar_fullname+"' WITH  FILE = 1, PASSWORD = 'Br@s1l1@', NOUNLOAD,  REPLACE, STATS = 10"

	Execute Immediate :ls_Syntax Using ll_sqlca;

	IF(ll_sqlca.sqldbcode = 0)Then
	
		   SetPointer(Arrow!)		  
		   gstr_user_info.Restor_status = True
		   Disconnect using ll_sqlca;
		   Destroy ll_sqlca;
		   Return 1
			
	Else			
		   Disconnect using ll_sqlca;
		   Destroy ll_sqlca;
		   Return -6
	End if

	SetPointer(Arrow!)
end function

public subroutine of_setreportdate (ref lol_dp start_dt, ref lol_dp end_dt);if(IsNull(gstr_user_info.start_dt))Then return
start_dt.value = gstr_user_info.start_dt
if(IsNull(gstr_user_info.end_dt))Then return
end_dt.value = gstr_user_info.end_dt
end subroutine

public subroutine of_getreportdate ();SELECT DT_VALUE
INTO :gstr_user_info.start_dt
FROM PARAM_CD
WHERE PARM_NM = 'START_DT';

IF IsNull(gstr_user_info.start_dt) THEN  gstr_user_info.start_dt = DateTime(Date(uf_today()) , Time("00:00:00"))

SELECT DT_VALUE
INTO :gstr_user_info.end_dt
FROM PARAM_CD
WHERE PARM_NM = 'END_DT';

IF IsNull(gstr_user_info.end_dt) THEN gstr_user_info.end_dt = DateTime(Date(uf_today()) , Time("23:59:59"))
  
end subroutine

public subroutine of_setreportdate (ref uo_select_dt_neo uo);if(IsNull(gstr_user_info.start_dt))Then return
uo.dp_1.value = gstr_user_info.start_dt
if(IsNull(gstr_user_info.end_dt))Then return
uo.dp_1.value = gstr_user_info.end_dt
end subroutine

public subroutine of_setreportdate (ref uo_small_select_dt_neo uo);if(IsNull(gstr_user_info.start_dt))Then return
uo.dp_1.value = gstr_user_info.start_dt
if(IsNull(gstr_user_info.end_dt))Then return
uo.dp_1.value = gstr_user_info.end_dt
end subroutine

public subroutine of_reorderpointnotification ();//m_main.m_wm.m_reports.m_reorder.Event clicked()


end subroutine

public subroutine of_branchsyncnotification ();
	//Open(w_rpt_branch_status)

end subroutine

public subroutine of_returnwarrantynotification ();//m_main.m_custom.m_custom_reports.m_warrenty_rpt.Event clicked()
end subroutine

public subroutine of_vehiclesnotification (string as_dataobject);str_pass_parmeters lstr_parm
lstr_parm.string_parm[1] = as_dataObject
lstr_parm.string_parm[2] = ""
//OpenWithParm(w_rpt_vehicles_notifications,lstr_parm)
end subroutine

public subroutine of_logs (string as_action);Long ll_row
DataStore lds

lds = Create DataStore
lds.DataObject = "d_logs_fg"
lds.settransobject( SQLCA )
lds.retrieve( )

if( lds.GetItemString(1 , "string_value") = "N" )Then Return


lds.DataObject = "d_logs_ii"
lds.settransobject( SQLCA )
ll_row = lds.InsertRow(0)

lds.SetItem( ll_row , "hddno" 				, gstr_user_info.hdd_serial_no )
lds.SetItem( ll_row , "computername" 		, gstr_user_info.computer_name  )
lds.SetItem( ll_row , "ipaddress" 			, gstr_user_info.ip )
lds.SetItem( ll_row , "userid" 				, gstr_user_info.login_id )
lds.SetItem( ll_row , "action_type" 		, as_action )

lds.update()

Commit;

Destroy lds

return 
end subroutine

public function string of_getcompanyname ();String ls_nm

SELECT STRING_VALUE
INTO :ls_nm
FROM PARAM_CD
WHERE PARM_NM = 'COMPANY_NAME';

Return ls_nm
end function

public function string of_company_name ();DataStore lds
String ls_name
lds = Create DataStore

lds.DataObject = "d_system_company_name"
lds.SetTransObject(SQLCA)
lds.Retrieve( )

ls_name = lds.GetItemString( 1 , "string_value_1" )

Destroy lds

return ls_name
end function

public subroutine of_applicationpath (ref string as_filename, ref string as_filepath);string ls_Path
unsignedlong lul_handle

ls_Path = space(1024)

lul_handle = Handle(GetApplication())

GetModuleFilename(lul_handle, ls_Path, 1024)

If(trim(ls_Path) = "")Then return

as_FilePath	= MidA(ls_Path , 1,LastPos(ls_Path, "\"))

as_FileName	= MidA(ls_Path , LastPos(ls_Path, "\")+1 , len(ls_Path))

gs_AppVer = of_file_Detail(as_FilePath ,as_FileName,"Product version" )

end subroutine

private function string of_file_detail (string as_folder, string as_file, string as_detail);Long ll_cnt, ll_temp,ll_itr ,i
Long ll_item 
String ls_file
//nvo_file_list lstr_parms, lstr_temp
OLEObject obj_shell, obj_folder, obj_items, obj_item
String ls_temp

as_file  = Lower(as_file)

IF( pos( as_file , ".exe" )  > 0 ) THEN
	as_file = replace( as_file , pos( as_file , ".exe" ) , 4 , "" )
END IF

IF DirectoryExists( as_folder ) THEN
    //initiate the shell object
    obj_shell = CREATE OLEObject
    obj_shell.ConnectToNewObject( 'shell.application' )
 IF not IsValid( obj_shell ) THEN MessageBox("","Not Valid")
    IF IsValid( obj_shell ) THEN
        //assign folder object
        obj_folder = obj_shell.NameSpace( as_folder )
        
        IF IsValid( obj_folder ) THEN
            //assign objects from that folder
            obj_items = obj_folder.Items
            
            IF IsValid( obj_items ) THEN
                //loop through items (zero-indexed)
                FOR ll_cnt = 0 TO obj_items.Count
                    //assign individual item
                    obj_item = obj_items.Item( ll_cnt )
                    obj_item = obj_folder.ParseName(as_file+".exe")
                    IF IsValid( obj_item ) THEN		
							
							ls_file = obj_folder.GetDetailsOf(obj_item, 0)
							ls_file = lower( ls_file )
							
							IF( pos( ls_file , ".exe" )  > 0 ) THEN
								ls_file = replace( ls_file , pos( ls_file , ".exe" ) , 4 , "" )
							END IF
												
							IF(  ls_file  =  as_file)THEN
								    For i = 0 To 300 
        									ls_temp = obj_folder.GetDetailsOf(obj_folder.items, i)
										
       									choose case Lower (ls_temp)
												Case "product version"
													ls_temp = obj_folder.GetDetailsOf(obj_item, i)	
													 //clear memory
													DESTROY obj_shell
													DESTROY obj_folder
													DESTROY obj_items
													DESTROY obj_item

													Return ls_temp

												Case "إصدار المنتج"
							 						ls_temp = obj_folder.GetDetailsOf(obj_item, i)	
													 //clear memory
													DESTROY obj_shell
													DESTROY obj_folder
													DESTROY obj_items
													DESTROY obj_item

													Return ls_temp
												Case "version du produit"
													ls_temp = obj_folder.GetDetailsOf(obj_item, i)	
													 //clear memory
													DESTROY obj_shell
													DESTROY obj_folder
													DESTROY obj_items
													DESTROY obj_item

													Return ls_temp

											end choose
            																            									 
    								Next 									
						END IF					 
                    END IF
                NEXT
            END IF
        END IF
    END IF
END IF

//clear memory
DESTROY obj_shell
DESTROY obj_folder
DESTROY obj_items
DESTROY obj_item

//return list
RETURN "0.0.0.0"

end function

public function str_pass_parmeters of_split (string as_list, string as_spliter);Long ll_len,ll_index
Int li_last_ptr,li_ptr
str_pass_parmeters lstr_parm

ll_index 		= 0
ll_len			= Len(as_list)
li_last_ptr 	= 1

For li_ptr = 1 To ll_len 

	if(li_ptr = ll_len )then
		ll_index += 1
		lstr_parm.string_parm[ll_index] = mid(as_list , li_last_ptr , ( li_ptr - li_last_ptr ) + 1  )	
		exit
	end if
	
	if(mid(as_list,li_ptr,1) = as_spliter)Then
		ll_index += 1
		lstr_parm.string_parm[ll_index] = mid(as_list , li_last_ptr , ( li_ptr - li_last_ptr )  )
		li_last_ptr = li_ptr+1
	end if
	
Next

Return lstr_parm
end function

public function integer of_compar_application_version (string as_first_ver, string as_second_ver);
str_pass_parmeters lstr_1st ,lstr_2nd
Long ll_Count ,ll_itr

lstr_1st	= of_split(as_first_ver,".")
lstr_2nd	= of_split(as_second_ver,".")

ll_Count = UpperBound( lstr_1st.string_parm )

if(ll_count <> Upperbound( lstr_2nd.string_parm ))then
	Return -1
end if

For ll_itr =1 To ll_count
//	Messagebox(String(ll_itr),"1st:"+lstr_1st.string_parm[ll_itr]+"~n2nd:"+lstr_2nd.string_parm[ll_itr])
	if(Long(lstr_1st.string_parm[ll_itr]) <> Long(lstr_2nd.string_parm[ll_itr]))Then
		if(Long(lstr_1st.string_parm[ll_itr]) > Long(lstr_2nd.string_parm[ll_itr]))Then
			return 1
		else
			if(Long(lstr_1st.string_parm[ll_itr]) < Long(lstr_2nd.string_parm[ll_itr]))then
				return 2
			end if
		end if
	end if

Next

Return 0
end function

public function string of_remove_space (string as_val);String ls_res
Long ll_itr,ll_len

ll_len = len(as_val)

For ll_itr=1 To ll_len
	
	if( mid(as_val , ll_itr , 1) <> " ")Then
		ls_res += mid(as_val , ll_itr , 1)
	end if
Next

return ls_res 
end function

public function string of_employee_name (integer al_emid);String ls_name

setnull(ls_name)

SELECT EM_NM
INTO :ls_name
FROM 
	EMPLOYEES  
inner join 
	USERS on ( EMPLOYEES.EMID = USERS.EMID)
WHERE  USER_NO = :al_emid;

if isnull( ls_name ) THEN
	ls_name = gstr_user_info.login_id
end if

return ls_name
end function

public subroutine of_retreivedddw (u_dw ar_dw, string field_nm);DataWindowChild ldwc_temp
Long ll_row

ar_dw.GetChild(field_nm , ldwc_temp)

ldwc_temp.SetTransObject(SQLCA)


IF gs_AppPath = "" THEN
	ll_row = ldwc_temp.Retrieve()
ELSEIF  FileExists( gs_AppPath+mid(field_nm,1,2)+".xml" ) THEN
		ldwc_temp.ImportFile( gs_AppPath+mid(field_nm,1,2)+".xml" )
		ll_row = ldwc_temp.Rowcount( )
	ELSE
		ll_row = ldwc_temp.Retrieve()
		ldwc_temp.SaveAs(gs_AppPath+mid(field_nm,1,2)+".xml", xml!, false)
END IF


//ldwc_temp.Retrieve()

end subroutine

public function string of_convertarraytostring (str_pass_parmeters ar_parm);Long ll_upperBound,ll_itr
String ls_res=""

ll_upperBound = UPPERBOUND(ar_parm.Long_parm )

FOR ll_itr = 1 TO ll_UpperBound
	ls_res += String(ar_parm.Long_parm[ll_itr])+","
NEXT

Return Mid(ls_res , 1,(Len(ls_res) - 1))
end function

public function long of_getkbdlocal ();n_cst_user32 api
Long ll_lan
api = CREATE n_cst_user32
ll_lan = api.getKeyboardlayout( 0 )
Destroy api

Return ll_lan
end function

public subroutine of_setkbdeng (long ar_lang);n_cst_user32 api

api = CREATE n_cst_user32

api.ActivateKeyboardLayout( ar_lang , api.KLF_REORDER )

Destroy api

Return 
end subroutine

public subroutine of_create_xmlfile (string as_filename, string as_filedata);Long ll_file

// open the file for write
ll_file = FileOpen( as_filename, TextMode!, Write!, LockReadWrite!, Replace! )

// write to the file
FileWriteEx( ll_file, as_filedata )

// close the file
FileClose( ll_file )
 
end subroutine

public function string of_convertarraytostring (long ar_long[]);Long ll_RowCount , ll_row , ll_itr
String ls_string = ""

ll_RowCount = UPPERBOUND(ar_long)

FOR ll_Row = 1 TO ll_RowCount
	
	IF ll_row <> ll_RowCount THEN
		ls_string += String(ar_long[ll_row])+","
	ELSE
		ls_string += String(ar_long[ll_row])
	END IF
	
NEXT

Return ls_string
end function

public function string of_month_nm (string ar_month_no);choose case ar_month_no
	case "01" , "1"
				Return "Jan"
	case "02","2"	
		Return "Feb"
	case "03","3"
		Return "Mar"
	case "04" , "4"
		Return "Apr"
	case "05","5"
		Return "May"
	case "06","6"
		Return "Jun"
	case "07","7"
		Return "Jul"
	case "08","8"
		Return "Aug"
	case "09","9"
		Return "Sep"
	case "10"
		Return "Oct"
	case "11"
		Return "Nov"
	case "12"
		Return "Dec"		
end choose
Return ""
end function

public subroutine of_set_language ();Long ll_row ,ll_RowCount
//DataStore lds

//lds = CREATE DataStore
//lds.DataObject = "d_lang"
//lds.SetTransObject(SQLCA)
//lds.retrieve( )
//
//ll_RowCount = lds.RowCount()

gs_Lan	= ProfileString( gnv_app.of_getappinifile( ) , "Database"	, "Lang" , "AR")

//For ll_row = 1 To ll_RowCount
//
//	IF lds.GetItemString(ll_row , "ID") = gs_lan THEN
//	
//		lds.SetItem(ll_Row , "Default" , "Y")	
//
//	ELSE
//		
//		lds.SetItem(ll_Row , "Default" , "N")	
//		
//	END IF
//	
//	
//NEXT 
//
//lds.update( )
//Commit;
end subroutine

public subroutine of_user_store_card_family (long ar_uid);DataStore ds
Long ll_row , ll_RowCount, ll_SCF_Count

SELECT COUNT(FID)
INTO  :ll_SCF_Count
FROM STORE_CARD_FAMILY
WHERE ACTIVE_FG = 'Y' USING SQLCA;

IF isNull(ll_SCF_Count) or ll_SCF_Count = 0 THEN 
	gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 0
	Return
END IF

ds = CREATE DataStore

ds.DataObject = "d_user_store_card_family_by_user_id"
ds.SetTransObject(SQLCA)
ds.Retrieve( ar_uid )

ll_RowCount = ds.RowCount()

IF ll_RowCount = ll_SCF_Count THEN 
	gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 0
	Destroy ds
	Return
END IF

FOR ll_row = 1 To ll_RowCount
	
	gstr_user_info.user_fid[ll_row] = ds.GetItemNumber(ll_row , "fid")
	
NEXT

Destroy ds

Return 
end subroutine

public function date of_week_start_date (date ar_dt);Return RelativeDate(ar_dt , DayNumber(ar_dt) * -1)



end function

public function date of_week_end_date (date ar_dt);choose case  DayNumber(ar_dt)
	case is < 7//sunday
		return RelativeDate(ar_dt , 5 - DayNumber(ar_dt))
	case 7//sat
		return RelativeDate(ar_dt , 5)		
end choose
end function

public function date of_quarter_start_dt (date ar_dt);Long ll_month

ll_month = Month(ar_dt)

choose case ll_month
	case  1 to 3
		return Date("01/01/"+string(Year(ar_dt)))
	case  4 to 6
		return Date("01/04/"+string(Year(ar_dt)))
	case  7 to 9
		return Date("01/07/"+string(Year(ar_dt)))
	case  10 to 12
		return Date("01/10/"+string(Year(ar_dt)))
end choose


end function

public function date of_quarter_end_dt (date ar_dt);Long ll_month

ll_month = Month(ar_dt)

choose case ll_month
	case  1 to 3
		return Date("31/03/"+string(Year(ar_dt)))
	case  4 to 6
		return Date("30/06/"+string(Year(ar_dt)))
	case  7 to 9
		return Date("30/09/"+string(Year(ar_dt)))
	case  10 to 12
		return Date("31/12/"+string(Year(ar_dt)))
end choose


end function

public function string of_convertarraytostring (string ar_string[]);Long ll_RowCount , ll_row , ll_itr
String ls_string = ""

ll_RowCount = UPPERBOUND(ar_string)

FOR ll_Row = 1 TO ll_RowCount
	
	IF ll_row <> ll_RowCount THEN
		ls_string += String(ar_string[ll_row])+","
	ELSE
		ls_string += String(ar_string[ll_row])
	END IF
	
NEXT

Return ls_string
end function

public function str_pass_parmeters of_backgroundcolor ();String ls_color
str_pass_parmeters lstr_parm

ls_color = ProfileString(gnv_app.of_getappinifile( ), "Database", "BGColor", "Blue")

Choose Case ls_color
	Case "Blue"
		lstr_parm.String_parm[1] = "datawindow.gradient.color=15780518"
		lstr_parm.String_parm[2] = "datawindow.color=8388608"
		return lstr_parm
	Case "Olive"
		lstr_parm.String_parm[1] = "datawindow.gradient.color="+string(rgb(162,205,90))//rgb(150,179,0))
		lstr_parm.String_parm[2] = "datawindow.color="+string(rgb(110	,139,61))//107,128,0))
	Case "Silver"
		lstr_parm.String_parm[1] = "datawindow.gradient.color="+string(rgb(200,192,201))
		lstr_parm.String_parm[2] = "datawindow.color="+string(rgb(195,192,201))
End choose

Return lstr_parm
end function

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

public function long of_timediff (time ar_start, time ar_end);Long ll_diff
Datetime ldt_start_dt , ldt_end_dt
DataStore lds

ldt_start_dt = Datetime(Date("01 jan 2018") , Time(ar_start))
ldt_end_dt = Datetime(Date("01 jan 2018") , Time(ar_end))

lds = Create DataStore
lds.dataObject = "d_datediff"
lds.SetTransobject( SQLCA )

lds.retrieve( ldt_start_dt ,ldt_end_dt )
ll_diff = lds.GetITemNumber(1 , "diff")

Destroy lds

Return ll_diff
end function

public subroutine of_color (ref u_dw ar_dw);Long ll_max, ll_cnt
String ls_col, ls_type ,ls_color , ls_gr_color
str_pass_parmeters lstr_parm

lstr_parm = gnv_services.of_backGroundColor()

ls_color = mid(lstr_parm.String_parm[1] , pos(lstr_parm.String_parm[1] , "=")+1 ,len(lstr_parm.String_parm[1]) )
ls_gr_color = mid(lstr_parm.String_parm[2] , pos(lstr_parm.String_parm[2] , "=")+1 ,len(lstr_parm.String_parm[2]) )

ar_dw.Modify( "DataWindow.color="+ls_color )
ar_dw.Modify( "DataWindow.brushmode=2" )
ar_dw.Modify( "DataWindow.transparency=11" )
ar_dw.Modify( "DataWindow.gradient.angle=0" )
ar_dw.Modify( "DataWindow.gradient.color='16777215'" )
ar_dw.Modify( "DataWindow.gradient.focus=51" )
ar_dw.Modify( "DataWindow.gradient.scale=86" )
ar_dw.Modify( "DataWindow.gradient.spread=83" )
ar_dw.Modify( "DataWindow.gradient.transparency=0" )


ll_max = Long( ar_dw.Describe("DataWindow.Column.Count") )

For ll_cnt = 1 To ll_max
	
	ls_col = ar_dw.describe( "#"+string(ll_cnt)+".Name" )
	ls_type = ar_dw.describe(ls_col + ".type")

	IF(ls_type = "column" or ls_type = "compute")THEN
	
		ar_dw.Modify( ls_col+".color='8388608~tif( currentRow() = getrow() , rgb(128,0,0) , rgb(0,0,128))'" )
		ar_dw.Modify( ls_col+".background.mode='1'") 
		ar_dw.Modify( ls_col+".background.color='553648127'")//+ls_color)//536870912
		ar_dw.Modify( ls_col+".background.transparency='0'") 
		ar_dw.Modify( ls_col+".background.gradient.color="+ls_color)//15780518
		ar_dw.Modify( ls_col+".background.gradient.transparency='0'") 
		ar_dw.Modify( ls_col+".background.gradient.angle='144'") 
		ar_dw.Modify( ls_col+".background.brushmode='1'")
		ar_dw.Modify( ls_col+".background.gradient.repetition.length='50'") 
		ar_dw.Modify( ls_col+".background.gradient.focus='61'")
		ar_dw.Modify( ls_col+".background.gradient.scale='60'") 
		ar_dw.Modify( ls_col+".background.gradient.spread='80'") 
		ar_dw.Modify( ls_col+".font.face='Arial (Arabic)'")
		ar_dw.Modify( ls_col+".font.height='-12'")
		ar_dw.Modify( ls_col+".font.weight='700'")
		ar_dw.Modify( ls_col+".font.family='2'")
		ar_dw.Modify( ls_col+".font.pitch='2'")
		ar_dw.Modify( ls_col+".font.charset='178'")
		
	END IF

Next

end subroutine

public subroutine of_log (string as_filename, string as_action);int li_filehandle

li_filehandle=FileOpen(as_filename,Linemode!,Write!,LockWrite!,Append!)
FileWrite(li_filehandle,String(Today(),"dd/mm/yyyy ")+String(now() , "hh:mm:ss")+"~r "+as_action)
FileClose(li_filehandle) 

end subroutine

public function string of_decrypt (string as_password);String ls_res
//n_cst_crypto lnv_crypt
n_cryptoapi lnv_crypt
//lnv_crypt = Create n_cst_crypto

ls_res = lnv_crypt.of_decrypthex( gnv_app.of_GetEncryptionAlgorithm( ) , as_password , gnv_app.of_getMyKey() ) //DecryptData(as_password , gnv_app.of_getMyKey())

//Destroy lnv_crypt


Return ls_res
end function

public subroutine of_shortcutstring (str_pass_parmeters lstr_parm);Long ll_RowCount , ll_itr , ll_row
String ls_title
n_cst_events lnvo_events

ll_RowCount = UpperBound(lstr_parm.string_parm)
			
lnvo_events = CREATE n_cst_events
	
FOR ll_itr = 1 To ll_RowCount
			
	ll_row = gnv_security.of_CheckAccessRight( lstr_parm.string_parm[ll_itr] ) 
					
	IF( (ll_row <= 0) OR ( IsNull(ll_row) ) ) THEN 
			gnv_msg.of_message(52)//no access right
			Return 
	END IF
					
		ls_title = gnv_security.of_Get_access_right_title( ll_row ) 
					
		lnvo_events.is_title = Trim(Mid(ls_title , LastPos(ls_title , '-') + 1 , len(ls_title) ))
		lnvo_events.triggerevent( "of_"+ lstr_parm.string_parm[ll_itr])
		lnvo_events.is_title = ""
			
NEXT
			
DESTROY lnvo_events

end subroutine

public function string eight_digit (decimal no);string ls_text
Long ll_ten_thousand = 1000000


IF Long(MidA(string(no),1,2)) = 10 THEN

	ls_text = two_digit_arabic(Long(MidA(string(no),1,2)))+"ملايين"+add_and_arabic("")+six_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,2))))											

ELSE
	
	ls_text = two_digit_arabic(Long(MidA(string(no),1,2)))+"مليون"+add_and_arabic("")+six_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,2))))											

END IF
/*
	choose case long(MidA(string(no),2,3))
				case is < 10
					ls_text = 'مليون'+add_and_arabic("")+four_digit_arabic(abs(no - 1000000))													
				case is < 100
					ls_text = 'مليون'+add_and_arabic("")+five_digit_arabic(abs(no - 1000000))								
				case else
					ls_text = 'مليون'+add_and_arabic("")+six_digit_arabic(abs(no - 1000000))			
			end choose		
		end if
	case 2
		if( (no - 2000000) = 0)Then
			ls_text = 'مليونين'
		else
			choose case long(MidA(string(no),2,3))
				case is < 10
					ls_text = 'مليونين'+add_and_arabic("")+four_digit_arabic(abs(no - 2000000))																		
				case is < 100
					ls_text = 'مليونين'+add_and_arabic("")+five_digit_arabic(no - 2000000)											
				case else
					ls_text = 'مليونين'+add_and_arabic("")+six_digit_arabic(no - 2000000)			
			end choose					
		end if		
	case else	
		choose case long(MidA(string(no),2,3))
				case is < 100
					ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"ملايين"+add_and_arabic("")+four_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,1))))											
				case is < 100
					ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"ملايين"+add_and_arabic("")+five_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,1))))											
				case else
					ls_text = one_digit_arabic(Long(MidA(string(no),1,1)))+"ملايين"+add_and_arabic("")+six_digit_arabic(no - (ll_ten_thousand * long(MidA(string(no),1,1))))
			end choose		
		
end choose
*/
return ls_text
end function

on nvo_services.create
call super::create
end on

on nvo_services.destroy
call super::destroy
end on

