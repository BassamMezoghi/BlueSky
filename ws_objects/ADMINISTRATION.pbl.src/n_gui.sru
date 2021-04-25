$PBExportHeader$n_gui.sru
forward
global type n_gui from n_bll
end type
end forward

global type n_gui from n_bll
string is_post = "Y"
string is_shareddata = "Y"
string is_systempart = "gui"
string is_mastertable = "GUI"
string is_master_id_column_nm = "PID"
string is_filter_dataobject = "d_ext_gui_filter"
string is_result_dataobject = "d_gui_result"
string is_master_dataobject = "d_gui_header"
end type
global n_gui n_gui

forward prototypes
public function string of_search ()
public function long of_master_postinsert (long ar_row)
public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data)
end prototypes

public function string of_search ();//String ls_cond
//
//ls_cond = ""
//
//return is_sql + ls_cond
String ls_cond , ls_syspart , ls_section , ls_lang , ls_id , ls_data
string ls_id_op

idw_filter.accepttext( )
ls_syspart = idw_filter.getitemstring(1,"syspart")
ls_section = idw_filter.getitemstring(1,"section")
ls_lang = idw_filter.getitemstring(1,"lang")
ls_id = trim(idw_filter.getitemstring(1,"id"))
ls_id_op =idw_filter.getitemstring(1,"id_op")

ls_cond = "WHERE 1 = 1 "

IF(NOT ISNULL(ls_syspart) AND ls_syspart <> "" )THEN
   ls_cond += "  AND ( SYSPART  =   '"+ ls_syspart +"' ) " 
end if
  IF(NOT ISNULL(ls_section) AND ls_section <> "" )THEN
        ls_cond += "  AND ( SECTION  =   '"+ ls_section +"' ) " 
	end if	 
    IF(NOT ISNULL(ls_lang) AND ls_lang <> "" )THEN		 
       ls_cond += "  AND ( LANG  =   '"+ ls_lang +"' ) " 
	end if
      IF(NOT ISNULL(ls_id) AND ls_id <> "" )THEN
		choose case ls_id_op
			case "1" 
				        ls_cond +=  "  AND (  ID  LIKE  '"+ ls_id +"%') " 
			case "2"
				        ls_cond +=  "  AND (  ID  LIKE  '%"+ ls_id +"%') " 
			 case "3" 
				        ls_cond +=  "  AND (  ID  LIKE  '%"+ ls_id +"') " 
					case else 
				 ls_cond +=  "  AND (  ID  LIKE  '%"+ ls_id +"%') " 		
		end choose
    	  end if

return is_sql + ls_cond
end function

public function long of_master_postinsert (long ar_row);return Success
end function

public subroutine of_master_itemchange (dwobject ar_dwo, long ar_row, string ar_data);ib_change = true
end subroutine

on n_gui.create
call super::create
end on

on n_gui.destroy
call super::destroy
end on

