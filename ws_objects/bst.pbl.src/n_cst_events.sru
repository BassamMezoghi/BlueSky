$PBExportHeader$n_cst_events.sru
forward
global type n_cst_events from n_base
end type
end forward

global type n_cst_events from n_base
event of_8 pbm_open
event of_6 pbm_open
event of_2 pbm_open
event of_18 pbm_open
event of_12 pbm_open
event of_14 pbm_open
event of_13 pbm_open
event of_24 pbm_open
event of_25 pbm_open
event of_22 pbm_open
event of_23 pbm_open
event of_9 pbm_open
event of_16 pbm_open
event of_17 pbm_open
event of_26 pbm_open
event of_4 pbm_open
event of_5 pbm_open
event of_27 pbm_open
event of_28 pbm_open
event of_29 pbm_open
event of_30 pbm_open
end type
global n_cst_events n_cst_events

type variables
String is_title = ""
end variables

forward prototypes
public function long of_duplicity (string as_do)
end prototypes

event of_8;close(w_menu)
end event

event of_6;tp_master page
n_clients csBLL
	
csBLL = Create n_clients

page = Create tp_master

page.csbll = csBLL

w_menu.uo_tabcontrol.Event settabpage( page ,  is_title  , 3 , "6" )

end event

event of_2;tp_master page
n_payments csBLL
	
csBLL = Create n_payments

page = Create tp_master

page.csbll = csBLL

w_menu.uo_tabcontrol.Event settabpage( page ,  is_title  , 3 , "2" )

end event

event of_18;String ls_datawindow = "d_serial_no"
//String ls_title =  is_title//"تسجيل الحاسيب"
long ll_row = 0
cst_index_page uo_index

ll_row = of_duplicity(ls_datawindow)

IF ll_row <= 1 THEN
	//Open userobject as tab
	w_menu.uo_tabcontrol.of_OpenTab(uo_index, is_title, 3)
	uo_index.dw_index.DataObject = ls_datawindow
	uo_index.dw_index.SetTransObject(SQLCA)		
	uo_index.dw_index.retrieve()
	uo_index.tag = uo_index.dw_index.DataObject
	ll_row = upperbound(w_menu.uo_tabcontrol.ist_tabs)
ELSE
	uo_index = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object	
END IF
		
//Select the first tab
w_menu.uo_tabcontrol.of_SelectTab( ll_row )

end event

event of_12;
//open(w_user_info)

//USERS

tp_user_info page
	
page = Create tp_user_info
//"اعطاء الصلاحيات"
w_menu.uo_tabcontrol.Event settabpage( page , is_title , 3 , "12" )
is_title = ""




end event

event of_14;str_pass_parmeters lstr_parm

lstr_parm.string_parm[1] = "uga"

OpenWithParm(w_email_list , lstr_parm)
end event

event of_13;String ls_datawindow = "d_users_groups_cd"
//String ls_title =  is_title//"القوائم المالية"
long ll_row = 0
 
cst_index_page uo_index


ll_row = of_duplicity(ls_datawindow)

IF ll_row <= 1 THEN
	//Open userobject as tab
	w_menu.uo_tabcontrol.of_OpenTab(uo_index, is_title, 3)
	uo_index.dw_index.DataObject = ls_datawindow
	uo_index.dw_index.SetTransObject(SQLCA)		
	uo_index.dw_index.retrieve()
	uo_index.tag = uo_index.dw_index.DataObject
	ll_row = upperbound(w_menu.uo_tabcontrol.ist_tabs)
ELSE
	uo_index = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object	
END IF

uo_index.is_TableName = "USERS_GROUPS_CD"
uo_index.is_KeyColumn = "id"
		
//Select the first tab
w_menu.uo_tabcontrol.of_SelectTab( ll_row )

end event

event of_24;tp_master page
n_clients csBLL
	
csBLL = Create n_clients
csBLL.is_post = "Y"

page = Create tp_master

page.csbll = csBLL

w_menu.uo_tabcontrol.Event settabpage( page ,  is_title  , 3 , "24" )

end event

event of_25;tp_master page
n_payments csBLL
	
csBLL = Create n_payments
csBLL.is_post = "Y"

page = Create tp_master

page.csbll = csBLL

w_menu.uo_tabcontrol.Event settabpage( page ,  is_title  , 3 , "25" )

end event

event of_22;n_transfare_to_archive page

page = CREATE n_transfare_to_archive

page.is_DateColumn = "created_dt"
page.is_dataobject = "d_remove_clients"

w_menu.uo_tabcontrol.Event settabpage(page , is_title , 5,"22")

end event

event of_23;n_transfare_to_archive page

page = CREATE n_transfare_to_archive

page.is_DateColumn = "payment_dt"
page.is_dataobject = "d_remove_payments"

w_menu.uo_tabcontrol.Event settabpage(page , is_title , 5,"23")

end event

event of_9;Open(w_change_password)
end event

event of_16;String ls_datawindow = "d_bank"
String ls_title = "الخزائن"
long ll_row = 0

cst_index_page uo_index

ll_row = of_duplicity(ls_datawindow)

IF ll_row <= 1 THEN
	//Open userobject as tab
	w_menu.uo_tabcontrol.of_OpenTab(uo_index, is_title, 3)
	uo_index.dw_index.DataObject = ls_datawindow
	uo_index.dw_index.SetTransObject(SQLCA)		
	uo_index.dw_index.retrieve()
	uo_index.tag = uo_index.dw_index.DataObject
	ll_row = upperbound(w_menu.uo_tabcontrol.ist_tabs)
	uo_index.is_tablename = "BANK_CD"
	uo_index.is_keycolumn = "ID"
ELSE
	uo_index = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object	
END IF
		
//Select the first tab
w_menu.uo_tabcontrol.of_SelectTab( ll_row )

end event

event of_17;String ls_datawindow = "d_payment_type_cd"
String ls_title = "انواع المدفوعات"
long ll_row = 0

cst_index_page uo_index

ll_row = of_duplicity(ls_datawindow)

IF ll_row <= 1 THEN
	//Open userobject as tab
	w_menu.uo_tabcontrol.of_OpenTab(uo_index, is_title, 3)
	uo_index.dw_index.DataObject = ls_datawindow
	uo_index.dw_index.SetTransObject(SQLCA)		
	uo_index.dw_index.retrieve()
	uo_index.tag = uo_index.dw_index.DataObject
	ll_row = upperbound(w_menu.uo_tabcontrol.ist_tabs)
	uo_index.is_tablename = "PAYMENT_TYPE_CD"
	uo_index.is_keycolumn = "ID"
ELSE
	uo_index = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object	
END IF
		
//Select the first tab
w_menu.uo_tabcontrol.of_SelectTab( ll_row )

end event

event of_26;String ls_datawindow = "d_city_cd"
String ls_title = "المدن"
long ll_row = 0

cst_index_page uo_index

ll_row = of_duplicity(ls_datawindow)

IF ll_row <= 1 THEN
	//Open userobject as tab
	w_menu.uo_tabcontrol.of_OpenTab(uo_index, is_title, 3)
	uo_index.dw_index.DataObject = ls_datawindow
	uo_index.dw_index.SetTransObject(SQLCA)		
	uo_index.dw_index.retrieve()
	uo_index.tag = uo_index.dw_index.DataObject
	ll_row = upperbound(w_menu.uo_tabcontrol.ist_tabs)
	uo_index.is_tablename = "CITY_CD"
	uo_index.is_keycolumn = "ID"
ELSE
	uo_index = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object	
END IF
		
//Select the first tab
w_menu.uo_tabcontrol.of_SelectTab( ll_row )

end event

event of_4;tp_standard_report page  //  of_4 حركة الخزينة

page = CREATE tp_standard_report

//page.is_post = "N"
page.is_report_type = ""
page.is_filterdataobject = "d_ext_rpt_treasury_movement"
page.tag = "4"
w_menu.uo_tabcontrol.Event settabpage(page , is_title, 4,page.tag)

end event

event of_5;tp_standard_report page   // حركة الاسهم

page = CREATE tp_standard_report

//page.is_post = "N"
page.is_report_type = ""
page.is_filterdataobject = "d_ext_rpt_stock_movement"
page.tag = "5"
w_menu.uo_tabcontrol.Event settabpage(page , is_title, 4,page.tag)
end event

event of_27;//Swap money

tp_master page
n_swap_money csBLL
	
csBLL = Create n_swap_money

page = Create tp_master


//True then print in A5
IF gnv_settings.of_GetSysSetup(gnv_settings.SwapMoneyInvoiceSize) THEN
	csBLL.is_ar_invoice_DataObject 	= "d_inv_swap_money_a5"
	csBLL.is_en_invoice_DataObject 	= "d_inv_swap_money_a5"
ELSE
	csBLL.is_ar_invoice_DataObject 	= "d_inv_swap_money"
	csBLL.is_en_invoice_DataObject 	= "d_inv_swap_money"
END IF

page.csbll = csBLL


w_menu.uo_tabcontrol.Event settabpage( page ,   is_title, 3 , "41" )
end event

event of_28;tp_standard_report page  //  of_28 حركة الخزينة

page = CREATE tp_standard_report

//page.is_post = "N"
page.is_report_type = ""
page.is_filterdataobject = "d_ext_rpt_cash_actions_by_bank"
page.tag = "28"
w_menu.uo_tabcontrol.Event settabpage(page , is_title, 4,page.tag)
end event

event of_29;tp_master page
n_payments_2 csBLL
	
csBLL = Create n_payments_2

page = Create tp_master

page.csbll = csBLL

w_menu.uo_tabcontrol.Event settabpage( page ,  is_title  , 3 , "29" )

end event

event of_30;tp_master page
n_payments_2 csBLL
	
csBLL = Create n_payments_2

page = Create tp_master

csBLL.is_post = 'Y'

page.csbll = csBLL

w_menu.uo_tabcontrol.Event settabpage( page ,  is_title  , 3 , "30" )

end event

public function long of_duplicity (string as_do);Long ll_rowcount,ll_row

ll_rowcount = UpperBound(w_menu.uo_tabcontrol.ist_tabs)
	
For ll_row=1 To ll_rowcount
	
		if(as_do = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object.tag )Then 
			w_menu.uo_tabcontrol.of_selecttab( ll_row )			
			return ll_row
			
		end if
		
Next

Return 1
end function

on n_cst_events.create
call super::create
end on

on n_cst_events.destroy
call super::destroy
end on

