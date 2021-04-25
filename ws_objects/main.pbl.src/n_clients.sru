$PBExportHeader$n_clients.sru
forward
global type n_clients from n_bll
end type
end forward

global type n_clients from n_bll
string is_shareddata = "Y"
string is_systempart = "CLIENTS"
string is_mastertable = "CLIENTS"
string is_master_id_column_nm = "ID"
string is_filter_dataobject = "d_ext_clients_filter"
string is_result_dataobject = "d_search_clients"
string is_master_dataobject = "d_clients"
string is_invoice_btn_title = "طبــاعة"
end type
global n_clients n_clients

forward prototypes
public function integer of_master_validation (long row)
public function boolean of_unique_key (string as_key, string as_indx, string as_id)
public function string of_search ()
end prototypes

public function integer of_master_validation (long row);String ls_name , ls_shid,ls_nid,ls_pass
String ls_pid, ls_address , ls_id , ls_cli_type
Long ll_city

ls_id 		= idw_master.GetItemString(row , "id" )
ls_name 		= idw_master.GetItemString(row , "full_name" )
ls_shid 		= idw_master.GetItemString(row , "shid" )
ls_nid 		= idw_master.GetItemString(row , "nid" )
ls_pass 		= idw_master.GetItemString(row , "passno" )
ls_pid 		= idw_master.GetItemString(row , "pid" )
ls_address 	= idw_master.GetItemString(row , "address" )
ls_cli_type = idw_master.GetItemString(row , "client_type" )

ll_city = idw_master.GetItemNumber(row , "city_id" )

IF IsNull(ls_id) THEN ls_id = ""

IF IsNull(ls_name) or len(trim(ls_name)) < 4 THEN
	
	gnv_msg.of_message( 72 )
	RETURN Failure
	
END IF

IF IsNull(ls_shid) or trim(ls_shid) = "" THEN
	gnv_msg.of_message( 73 )
	RETURN Failure
END IF

IF IsNull(ls_nid) or trim(ls_nid) = "" THEN
	
	IF ls_cli_type = "N" THEN
		gnv_msg.of_message( 74 )
	ELSE
		gnv_msg.of_message( 82 )
	END IF
	
	RETURN Failure
	
END IF

IF ( IsNull(ls_pass) or trim(ls_pass) = "" ) AND (IsNull(ls_pid) or trim(ls_pid) = "") THEN
	
	IF ls_cli_type = "N" THEN
		gnv_msg.of_message( 75 )
	ELSE
		gnv_msg.of_message( 82 )
	END IF
	
	RETURN Failure
	
END IF

IF IsNull(ls_address) or trim(ls_address) = "" THEN
	
	gnv_msg.of_message( 76 )
	RETURN Failure
	
END IF

IF IsNull(ll_city) THEN
	
	gnv_msg.of_message( 77 )
	RETURN Failure
	
END IF

IF Not of_unique_key(ls_shid , "shid" ,ls_id ) THEN
	
	gnv_msg.of_message( 78 )
	RETURN Failure
	
END IF

IF Not of_unique_key(ls_nid , "nid" ,ls_id ) THEN
	
	gnv_msg.of_message( 79 )
	RETURN Failure
	
END IF

RETURN SUCCESS
end function

public function boolean of_unique_key (string as_key, string as_indx, string as_id);Long ll_counter



Choose Case as_indx
	CASE "shid"
		IF as_id <> "" THEN
			
					SELECT COUNT(ID)
					INTO :ll_counter
					FROM CLIENTS
					WHERE shid = :as_key and ID <> :as_id ;	
		ELSE
					SELECT COUNT(ID)
					INTO :ll_counter
					FROM CLIENTS
					WHERE shid = :as_key;			
		END IF
		
	CASE "nid" 
		IF as_id <> "" THEN
			
					SELECT COUNT(ID)
					INTO :ll_counter
					FROM CLIENTS
					WHERE nid = :as_key and ID <> :as_id ;	
		ELSE
					SELECT COUNT(ID)
					INTO :ll_counter
					FROM CLIENTS
					WHERE nid = :as_key;			
		END IF

End Choose

IF ll_Counter > 0 THEN RETURN FALSE

RETURN TRUE
end function

public function string of_search ();String ls_cond
String ls_id , ls_shid , ls_name , ls_nid
String ls_id_op , ls_shid_op , ls_name_op , ls_nid_op

ls_cond = " AND (POST_FG = '"+is_post+"') "

ls_id = idw_filter.GetITemString(1 , "id_list")
ls_id_op = idw_filter.GetITemString(1 , "id_filter")

ls_shid = idw_filter.GetITemString(1 , "posid")
ls_shid_op = idw_filter.GetITemString(1 , "posid_filter")

ls_name = idw_filter.GetITemString(1 , "name")
ls_name_op = idw_filter.GetITemString(1 , "name_filter")

ls_nid = idw_filter.GetITemString(1 , "shop")
ls_nid_op = idw_filter.GetITemString(1 , "shop_filter")

IF Not IsNull(ls_id) THEN
	Choose Case ls_id_op
		Case "2"
			ls_cond += " AND ( CAST(ID as int) > "+ls_id+")"
		Case "3"
			ls_cond += " AND ( CAST(ID as int) < "+ls_id+")"			
		Case Else
			ls_cond += " AND ( ID  = '"+ls_id+"')"
	End Choose
END IF

IF Not IsNull(ls_shid) THEN
	Choose Case ls_shid_op
		Case "3"
			ls_cond += " AND ( SHID like '%"+ls_shid+"%')"
		Case "2"
			ls_cond += " AND ( SHID like '"+ls_shid+"%')"
		Case "4"
			ls_cond += " AND ( SHID like '%"+ls_shid+"')"
		Case Else
			ls_cond += " AND ( SHID = '"+ls_shid+"')"
	End Choose
END IF

IF Not IsNull(ls_name) THEN
	Choose Case ls_name_op
		Case "3"
			ls_cond += " AND ( FULL_NAME like '%"+ls_name+"%')"
		Case "2"
			ls_cond += " AND ( FULL_NAME like '"+ls_name+"%')"
		Case "4"
			ls_cond += " AND ( FULL_NAME like '%"+ls_name+"')"
		Case Else
			ls_cond += " AND ( FULL_NAME = '"+ls_name+"')"
	End Choose
END IF

IF Not IsNull(ls_nid) THEN
	Choose Case ls_nid_op
		Case "3"
			ls_cond += " AND ( NID like '%"+ls_nid+"%')"
		Case "2"
			ls_cond += " AND ( NID like '"+ls_nid+"%')"
		Case "4"
			ls_cond += " AND ( NID like '%"+ls_nid+"')"
		Case Else
			ls_cond += " AND ( NID = '"+ls_nid+"')"
	End Choose
END IF

RETURN is_sql + ls_cond
end function

on n_clients.create
call super::create
end on

on n_clients.destroy
call super::destroy
end on

