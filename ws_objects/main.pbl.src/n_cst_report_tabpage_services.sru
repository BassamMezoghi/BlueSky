$PBExportHeader$n_cst_report_tabpage_services.sru
forward
global type n_cst_report_tabpage_services from n_base
end type
end forward

global type n_cst_report_tabpage_services from n_base
end type
global n_cst_report_tabpage_services n_cst_report_tabpage_services

forward prototypes
public subroutine of_dbclicked_inventory (long row, ref u_dw dw)
public subroutine of_dbclick_inv_stdy (long row, u_dw ar_dw)
public subroutine of_dbclicked_inventory_ (long row, ref u_dw dw)
end prototypes

public subroutine of_dbclicked_inventory (long row, ref u_dw dw);str_pass_parmeters lstr_parm

IF dw.DataObject = "d_inv_by_many_store" or dw.DataObject = "d_inv_by_many_store_" or dw.DataObject = "d_inv_by_many_store_en" or dw.DataObject = "d_inv_by_many_store_en_" THEN
	Return 
END IF

IF dw.DataObject = "sp_all_store_inventory" or dw.DataObject = "sp_all_store_inventory_qty" or  dw.DataObject = "sp_all_store_inventory_en" or dw.DataObject = "sp_all_store_inventory_qty_en" THEN
	
	lstr_parm.long_array[1] 		= dw.GetItemNumber(row , "sc_id")
	lstr_parm.datetime_array[1] = datetime(today()) //datetime(date(dp_1.value),time("00:00:00"))
	lstr_parm.long_array[2] 		= -1
	IF gs_lan <> "AR" THEN
		lstr_parm.string_parm[1] 		= "d_rpt_sc_by_stores_ltr"	
	ELSE
		lstr_parm.string_parm[1] 		= "d_rpt_sc_by_stores"	
	END IF
	lstr_parm.string_parm[2] 			= "A-"

ELSE
	
	lstr_parm.long_array[1] 			= dw.GetItemNumber(row , "sc_id")
	lstr_parm.datetime_array[1] 	= datetime(today()) //dw.GetItemDatetime(row , "end_dt")
	lstr_parm.long_array[2] 			= dw.GetItemNumber(row , "store_id")
	IF gs_lan <> "AR" THEN
		lstr_parm.string_parm[1] 		= "d_rpt_inventory_followup_ltr"
	ELSE
		lstr_parm.string_parm[1] 		= "d_rpt_inventory_followup"	
	END IF	
		
	lstr_parm.string_parm[2] 		= "S-"	
	
END If

//OpenWithParm(w_inventory_followup , lstr_parm)

Return 
end subroutine

public subroutine of_dbclick_inv_stdy (long row, u_dw ar_dw);str_pass_parmeters lstr_parm

IF row > 0 THEN

	lstr_parm.long_array[1] 		= ar_dw.GetItemNumber(row , "sc_id")
	IF gs_lan <> "AR" THEN
		lstr_parm.string_parm[1] 		= "d_rpt_sc_by_stores_ltr"	
	ELSE
		lstr_parm.string_parm[1] 		= "d_rpt_sc_by_stores"	
	END IF
	//OpenWithParm(w_inventory_followup , lstr_parm)
	
END IF
end subroutine

public subroutine of_dbclicked_inventory_ (long row, ref u_dw dw);str_pass_parmeters lstr_parm

//return

IF dw.DataObject = "d_gd_inv_by_many_store" or dw.DataObject = "d_gd_inv_by_many_store_" or dw.DataObject = "d_inv_by_many_store_en" or dw.DataObject = "d_inv_by_many_store_en_" THEN
	Return 
END IF

IF dw.DataObject = "sp_gd_all_store_inventory" or dw.DataObject = "sp_gd_all_store_inventory_qty" or  dw.DataObject = "sp_gd_all_store_inventory_en" or dw.DataObject = "sp_gd_all_store_inventory_qty_en" THEN
	
	lstr_parm.long_array[1] 		= dw.GetItemNumber(row , "sc_id")
	lstr_parm.datetime_array[1] = datetime(today()) //datetime(date(dp_1.value),time("00:00:00"))
	lstr_parm.long_array[2] 		= -1
	IF gs_lan <> "AR" THEN
		lstr_parm.string_parm[1] 		= "d_rpt_dg_sc_by_stores_ltr"	
	ELSE
		lstr_parm.string_parm[1] 		= "d_rpt_dg_sc_by_stores"	
	END IF
	lstr_parm.string_parm[2] 			= "A-"

ELSE
	return 
	lstr_parm.long_array[1] 			= dw.GetItemNumber(row , "sc_id")
	lstr_parm.datetime_array[1] 	= datetime(today()) //dw.GetItemDatetime(row , "end_dt")
	lstr_parm.long_array[2] 			= dw.GetItemNumber(row , "store_id")
	IF gs_lan <> "AR" THEN
		lstr_parm.string_parm[1] 		= "d_rpt_inventory_followup_ltr"
	ELSE
		lstr_parm.string_parm[1] 		= "d_rpt_inventory_followup"	
	END IF	
		
	lstr_parm.string_parm[2] 		= "S-"	
	
END If

//OpenWithParm(w_inventory_followup , lstr_parm)

Return 
end subroutine

on n_cst_report_tabpage_services.create
call super::create
end on

on n_cst_report_tabpage_services.destroy
call super::destroy
end on

