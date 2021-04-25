$PBExportHeader$n_msg_errors.sru
forward
global type n_msg_errors from n_bll
end type
end forward

global type n_msg_errors from n_bll
string is_shareddata = "Y"
string is_systempart = "msg"
string is_mastertable = "messages"
string is_master_id_column_nm = "id"
string is_filter_dataobject = "d_ext_msg_error_filter"
string is_result_dataobject = "d_msg_error_result"
string is_master_dataobject = "d_msg_error_header"
end type
global n_msg_errors n_msg_errors

type variables

end variables

forward prototypes
public function string of_search ()
public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data)
public function long of_master_postinsert (long ar_row)
end prototypes

public function string of_search ();String ls_cond , ls_data

idw_filter.accepttext( )
ls_data = trim(idw_filter.getitemstring(1,"title"))

ls_cond = ""
IF(NOT ISNULL(ls_data) AND ls_data <> "" )THEN

  IF(IsNumber(ls_data) )then
  //  messagebox("num",ls_data)
    ls_cond = "  WHERE ( ID  = "+ ls_data +" ) " 
  else
//	messagebox("str",ls_data)
   ls_cond =  "  WHERE (  MSG  LIKE  '%"+ ls_data +"%') " 
  end if
end if 
return is_sql + ls_cond



//ls_cond = " AND (POST_FG = '"+is_post+"') "
end function

public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data);ib_change = true
end subroutine

public function long of_master_postinsert (long ar_row);return Success
end function

on n_msg_errors.create
call super::create
end on

on n_msg_errors.destroy
call super::destroy
end on

