$PBExportHeader$tp_standard_report.sru
forward
global type tp_standard_report from u_cst_tabpage
end type
type cb_print from u_cb within tp_standard_report
end type
type cb_run from u_cb within tp_standard_report
end type
type cb_export from u_cb within tp_standard_report
end type
type dw_filter from u_dw within tp_standard_report
end type
type uo_tabcontrol from u_cst_tabcontrol within tp_standard_report
end type
type gb_filter from groupbox within tp_standard_report
end type
type pb_1 from picturebutton within tp_standard_report
end type
end forward

global type tp_standard_report from u_cst_tabpage
integer width = 4014
integer height = 2472
event of_120 ( )
event of_74 ( )
event of_317 ( )
event of_315 ( )
event of_114 ( )
event of_77 ( )
event of_71 ( )
event of_408 ( )
event of_63 ( )
event of_35 ( )
event of_37 ( )
event of_116 ( )
event of_84 ( )
event of_81 ( )
event of_82 ( )
event of_54 ( )
event of_96 ( )
event of_17 ( )
event of_346 ( )
event of_342 ( )
event of_343 ( )
event of_95 ( )
event of_357 ( )
event of_341 ( )
event of_1731 ( )
event of_1730 ( )
event of_117 ( )
event of_394 ( )
event of_395 ( )
event of_396 ( )
event of_4 ( )
event of_5 ( )
event of_28 ( )
cb_print cb_print
cb_run cb_run
cb_export cb_export
dw_filter dw_filter
uo_tabcontrol uo_tabcontrol
gb_filter gb_filter
pb_1 pb_1
end type
global tp_standard_report tp_standard_report

type variables
str_pass_parmeters istr_parm, istr_inv_type
n_cst_guidb csGui
Long il_x, il_y
String is_report_type = "wh_Standered_Report"
String is_FilterDataObject = "d_ext_sales_filter_"


end variables

forward prototypes
public function boolean of_canclose ()
public function string of_convertarraytostring (str_pass_parmeters ar_parm)
public subroutine of_rtl (long newwidth, long newheight)
public subroutine of_ltr (long newwidth, long newheight)
public subroutine of_initialvalueadvancepayment ()
end prototypes

event of_120();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 			= " WHERE ( h.active_fg = 'Y' ) AND ( d.active_fg <> 'N' )"
ls_group_by 	= ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( h.uh_dt Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_fid				= dw_filter.GetItemNumber(1 , "fid")
ll_cid				= dw_filter.GetItemNumber(1 , "cid")
ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
ls_client_type		= dw_filter.GetItemString(1 , "client_type")
ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 

///////////// in case of user Store card Family required
IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
	
	IF UPPERBOUND(istr_parm.long_array) = 0 THEN
		
//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
//		Throw MyEx
		istr_parm.long_array = gstr_user_info.user_fid
	END IF
	
END IF

IF ls_cost_fg = "Y" THEN
	ls_cost_fg = "1"
ELSE
	ls_cost_fg = "0"
END IF

ls_title = ""
IF Not IsNull(ll_dbid) THEN 
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

/*****Set DataObject****/
IF ls_detail_fg = "Y" THEN
		iuo_is.dw_report.DataObject = "d_rpt_unusable_action"
ELSE
		iuo_is.dw_report.DataObject = "d_rpt_unusable_action_group_by_items"
		ls_group_by 					 = "GROUP BY d.SC_ID"
END IF
	
ls_sql = iuo_is.dw_report.getsqlselect( )

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN

		    ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"

ELSE
		
	IF Not IsNull(ll_sc_id) THEN
		
		ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
		
	END IF
	
END IF

IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
	
	ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
	
END IF

IF Not IsNull(ll_dbid)  THEN
	IF ll_dbid > 0 THEN
		ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
	ELSE
		ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
	END IF
END IF

IF ls_group_by <> "" THEN
	ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
	ls_sql +=   ls_cond + ls_group_by
ELSE
	ls_sql +=   ls_cond
END IF

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_74();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 			= " WHERE ( h.active_fg = 'Y' ) AND ( d.active_fg <> 'N' )"
ls_group_by 	= ""

ls_bill_dt = "ARRIVE_DT"

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( h."+ls_bill_dt+" Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_fid				= dw_filter.GetItemNumber(1 , "fid")
ll_cid				= dw_filter.GetItemNumber(1 , "cid")
ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
ls_client_type		= dw_filter.GetItemString(1 , "client_type")
ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 

///////////// in case of user Store card Family required
IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
	
	IF UPPERBOUND(istr_parm.long_array) = 0 THEN
		
//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
//		Throw MyEx
		istr_parm.long_array = gstr_user_info.user_fid
	END IF
	
END IF

IF ls_cost_fg = "Y" THEN
	ls_cost_fg = "1"
ELSE
	ls_cost_fg = "0"
END IF

ls_title = ""
IF Not IsNull(ll_dbid) THEN 
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

/*****Set DataObject****/
IF ls_detail_fg = "Y" THEN
	iuo_is.dw_report.DataObject = "d_rpt_income_store_card_action_qty"
ELSE
	iuo_is.dw_report.DataObject = "d_rpt_purchase_action_group_by_items"
	ls_group_by = "GROUP BY d.SC_ID"
END IF				
	
ls_sql = iuo_is.dw_report.getsqlselect( )

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF Not IsNull(ll_cid) THEN
	
	ls_cond += " AND ( h.customer_id = "+String(ll_cid)+" ) "
	
END IF

IF ls_client_type <> "0" AND IsNull(ll_cid)THEN
	
	ls_cond += "AND ( c.wholesale = '"+ls_client_type+"') "
	
END IF

IF ls_invoice_type <> "0" THEN
	
		ls_cond += " AND ( h.cash_fg in ( "+istr_inv_type.string_parm[1]+" ) )"

END IF

IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN

		    ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"

ELSE
		
	IF Not IsNull(ll_sc_id) THEN
		
		ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
		
	END IF
	
END IF

IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
	
	ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
	
END IF

IF Not IsNull(ll_dbid)  THEN
	IF ll_dbid > 0 THEN
		ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
	ELSE
		ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
	END IF
END IF

IF ls_group_by <> "" THEN
	ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
	ls_sql +=   ls_cond + ls_group_by
ELSE
	ls_sql +=   ls_cond
END IF

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_317();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_group_by 	= ""

ls_bill_dt = "REGISTER_DT"
ls_cond 			= "  WHERE ( ID > 0 ) "

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( h."+ls_bill_dt+" Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_fid				= dw_filter.GetItemNumber(1 , "fid")
ll_cid				= dw_filter.GetItemNumber(1 , "cid")
ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
ls_client_type		= dw_filter.GetItemString(1 , "client_type")
ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 

///////////// in case of user Store card Family required
IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
	
	IF UPPERBOUND(istr_parm.long_array) = 0 THEN
		
//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
//		Throw MyEx
		istr_parm.long_array = gstr_user_info.user_fid
	END IF
	
END IF

IF ls_cost_fg = "Y" THEN
	ls_cost_fg = "1"
ELSE
	ls_cost_fg = "0"
END IF

ls_title = ""
IF Not IsNull(ll_dbid) THEN 
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

IF gs_Lan = "AR" THEN
	iuo_is.dw_report.DataObject = "d_rpt_cost_price_history"		
ELSE
	iuo_is.dw_report.DataObject = "d_rpt_cost_price_history_"+gs_lan
END IF
	
ls_sql = iuo_is.dw_report.getsqlselect( )

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF Not IsNull(ll_cid) THEN
	
	ls_cond += " AND ( h.customer_id = "+String(ll_cid)+" ) "
	
END IF

IF ls_client_type <> "0" AND IsNull(ll_cid)THEN
	
	ls_cond += "AND ( c.wholesale = '"+ls_client_type+"') "
	
END IF

IF ls_invoice_type <> "0" THEN
	
		ls_cond += " AND ( h.cash_fg in ( "+istr_inv_type.string_parm[1]+" ) )"

END IF

IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN

		    ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"

ELSE
		
	IF Not IsNull(ll_sc_id) THEN
		
		ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
		
	END IF
	
END IF

IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
	
	ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
	
END IF

IF Not IsNull(ll_dbid)  THEN
	IF ll_dbid > 0 THEN
		ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
	ELSE
		ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
	END IF
END IF

IF ls_group_by <> "" THEN
	ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
	ls_sql +=   ls_cond + ls_group_by
ELSE
	ls_sql +=   ls_cond
END IF

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_315();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_group_by 	= ""

ls_bill_dt = "REGISTER_DT"
ls_cond 			= "  WHERE ( ID > 0 ) "

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( h."+ls_bill_dt+" Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_fid				= dw_filter.GetItemNumber(1 , "fid")
ll_cid				= dw_filter.GetItemNumber(1 , "cid")
ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
ls_client_type		= dw_filter.GetItemString(1 , "client_type")
ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 

///////////// in case of user Store card Family required
IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
	
	IF UPPERBOUND(istr_parm.long_array) = 0 THEN
		
//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
//		Throw MyEx
		istr_parm.long_array = gstr_user_info.user_fid
	END IF
	
END IF

IF ls_cost_fg = "Y" THEN
	ls_cost_fg = "1"
ELSE
	ls_cost_fg = "0"
END IF

ls_title = ""
IF Not IsNull(ll_dbid) THEN 
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

				IF gs_Lan = "AR" THEN
					iuo_is.dw_report.DataObject = "d_rpt_cost_price_history"		
				ELSE
					iuo_is.dw_report.DataObject = "d_rpt_cost_price_history_"+gs_lan
				END IF
	
ls_sql = iuo_is.dw_report.getsqlselect( )

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF Not IsNull(ll_cid) THEN
	
	ls_cond += " AND ( h.customer_id = "+String(ll_cid)+" ) "
	
END IF

IF ls_client_type <> "0" AND IsNull(ll_cid)THEN
	
	ls_cond += "AND ( c.wholesale = '"+ls_client_type+"') "
	
END IF

IF ls_invoice_type <> "0" THEN
	
		ls_cond += " AND ( h.cash_fg in ( "+istr_inv_type.string_parm[1]+" ) )"

END IF

IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN

		    ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"

ELSE
		
	IF Not IsNull(ll_sc_id) THEN
		
		ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
		
	END IF
	
END IF

IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
	
	ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
	
END IF

IF Not IsNull(ll_dbid)  THEN
	IF ll_dbid > 0 THEN
		ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
	ELSE
		ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
	END IF
END IF

IF ls_group_by <> "" THEN
	ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
	ls_sql +=   ls_cond + ls_group_by
ELSE
	ls_sql +=   ls_cond
END IF

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

iuo_is.dw_report.Modify("b_1.visible=0")
iuo_is.dw_report.Modify("new_quantity.tabsequence=32766")
iuo_is.dw_report.Modify("old_quantity.tabsequence=32766")
iuo_is.dw_report.Modify("new_cost_price.tabsequence=32766")
iuo_is.dw_report.Modify("old_cost_price.tabsequence=32766")

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_114();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 			= " WHERE ( h.active_fg = 'Y' ) AND ( d.active_fg <> 'N' )"
ls_group_by 	= ""

ls_bill_dt = "Bill_dt"

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( h."+ls_bill_dt+" Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_fid				= dw_filter.GetItemNumber(1 , "fid")
ll_cid				= dw_filter.GetItemNumber(1 , "cid")
ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
ls_client_type		= dw_filter.GetItemString(1 , "client_type")
ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 

///////////// in case of user Store card Family required
IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
	
	IF UPPERBOUND(istr_parm.long_array) = 0 THEN
		
//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
//		Throw MyEx
		istr_parm.long_array = gstr_user_info.user_fid
	END IF
	
END IF

IF ls_cost_fg = "Y" THEN
	ls_cost_fg = "1"
ELSE
	ls_cost_fg = "0"
END IF

ls_title = ""
IF Not IsNull(ll_dbid) THEN 
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

IF ls_detail_fg = "Y" THEN
	iuo_is.dw_report.DataObject = "d_rpt_source_reject_action"
ELSE
	iuo_is.dw_report.DataObject	= "d_rpt_source_reject_action_group_by_item"
	ls_group_by 						= "GROUP BY d.SC_ID"
END IF
	
ls_sql = iuo_is.dw_report.getsqlselect( )

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF Not IsNull(ll_cid) THEN
	
	ls_cond += " AND ( h.customer_id = "+String(ll_cid)+" ) "
	
END IF

IF ls_client_type <> "0" AND IsNull(ll_cid)THEN
	
	ls_cond += "AND ( c.wholesale = '"+ls_client_type+"') "
	
END IF

IF ls_invoice_type <> "0" THEN
	
		ls_cond += " AND ( h.cash_fg in ( "+istr_inv_type.string_parm[1]+" ) )"

END IF

IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN

		    ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"

ELSE
		
	IF Not IsNull(ll_sc_id) THEN
		
		ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
		
	END IF
	
END IF

IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
	
	ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
	
END IF

IF Not IsNull(ll_dbid)  THEN
	IF ll_dbid > 0 THEN
		ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
	ELSE
		ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
	END IF
END IF

IF ls_group_by <> "" THEN
	ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
	ls_sql +=   ls_cond + ls_group_by
ELSE
	ls_sql +=   ls_cond
END IF

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_77();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 			= " WHERE ( h.active_fg = 'Y' ) AND ( d.active_fg <> 'N' )"
ls_group_by 	= ""

ls_bill_dt = "Bill_dt"

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( h."+ls_bill_dt+" Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_fid				= dw_filter.GetItemNumber(1 , "fid")
ll_cid				= dw_filter.GetItemNumber(1 , "cid")
ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
ls_client_type		= dw_filter.GetItemString(1 , "client_type")
ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 

///////////// in case of user Store card Family required
IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
	
	IF UPPERBOUND(istr_parm.long_array) = 0 THEN
		
//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
//		Throw MyEx
		istr_parm.long_array = gstr_user_info.user_fid
	END IF
	
END IF

IF ls_cost_fg = "Y" THEN
	ls_cost_fg = "1"
ELSE
	ls_cost_fg = "0"
END IF

ls_title = ""
IF Not IsNull(ll_dbid) THEN 
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

IF ls_detail_fg = "Y" THEN
	iuo_is.dw_report.DataObject = "d_rpt_sold_store_card_action"
ELSE
	iuo_is.dw_report.DataObject = "d_rpt_sold_store_card_action_group_by_item"
	ls_group_by 						= "GROUP BY d.SC_ID"
END IF			
	
ls_sql = iuo_is.dw_report.getsqlselect( )

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF Not IsNull(ll_cid) THEN
	
	ls_cond += " AND ( h.customer_id = "+String(ll_cid)+" ) "
	
END IF

IF ls_client_type <> "0" AND IsNull(ll_cid)THEN
	
	ls_cond += "AND ( c.wholesale = '"+ls_client_type+"') "
	
END IF

IF ls_invoice_type <> "0" THEN
	
		ls_cond += " AND ( h.cash_fg in ( "+istr_inv_type.string_parm[1]+" ) )"

END IF

IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN

		    ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"

ELSE
		
	IF Not IsNull(ll_sc_id) THEN
		
		ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
		
	END IF
	
END IF

IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
	
	ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
	
END IF

IF Not IsNull(ll_dbid)  THEN
	IF ll_dbid > 0 THEN
		ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
	ELSE
		ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
	END IF
END IF

IF ls_group_by <> "" THEN
	ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
	ls_sql +=   ls_cond + ls_group_by
ELSE
	ls_sql +=   ls_cond
END IF

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_71();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

	ls_cond 		= " WHERE ( h.active_fg = 'Y' ) AND ( d.active_fg <> 'N' )"
	ls_group_by = ""
	
	MyEx = Create Exception
	
	iuo_is = Create u_cst_report_container 
	
	dw_filter.Accepttext( )
	
	ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
	ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")
	
	IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
		MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
		Throw MyEx
	ELSE
		ls_cond += 	" AND ( h.Bill_dt Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
	END IF
	//retrieve data window
	//Open userobject as tab
	
	ll_fid				= dw_filter.GetItemNumber(1 , "fid")
	ll_cid				= dw_filter.GetItemNumber(1 , "cid")
	ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
	ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
	ll_dbid				= dw_filter.GetItemNumber(1 , "dbid")
	ls_invoice_type	= String(UpperBound(istr_inv_type.string_parm)) //dw_filter.GetItemString(1 , "invoice_type")
	ls_client_type		= dw_filter.GetItemString(1 , "client_type")
	ls_cost_fg			= dw_filter.GetItemString(1 , "cost_price_fg")
	ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")
	ls_group_by_dt		= dw_filter.GetItemString(1 , "group_by_dt") 
	
	///////////// in case of user Store card Family required
	IF gstr_user_info.application_parm[gnv_settings.userstorecardfamily] = 1 AND IsNull(ll_sc_id) THEN
		
		IF UPPERBOUND(istr_parm.long_array) = 0 THEN
			
	//		MyEx.SetMessage( "يجب اختبار مجموعة الاصناف" )
	//		Throw MyEx
			istr_parm.long_array = gstr_user_info.user_fid
		END IF
		
	END IF
	
	IF ls_cost_fg = "Y" THEN
		ls_cost_fg = "1"
	ELSE
		ls_cost_fg = "0"
	END IF
	
	ls_title = ""
	IF Not IsNull(ll_dbid) THEN 
		ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
	END IF
	
	uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
	uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
	
	IF ls_detail_fg = "Y" THEN
		iuo_is.dw_report.DataObject = "d_rpt_sold_store_card_action"
	ELSE
		iuo_is.dw_report.DataObject = "d_rpt_sold_store_card_action_group_by_item"
		ls_group_by 					 = "GROUP BY d.SC_ID"
	END IF	
		
	ls_sql = iuo_is.dw_report.getsqlselect( )
	
	iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd mmm yyyy")+"'")
	iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd mmm yyyy")+"'")
	
	IF Not IsNull(ll_cid) THEN
		
		ls_cond += " AND ( h.customer_id = "+String(ll_cid)+" ) "
		
	END IF
	
	IF ls_client_type <> "0" AND IsNull(ll_cid)THEN
		
		ls_cond += "AND ( c.wholesale = '"+ls_client_type+"') "
		
	END IF
	
	IF ls_invoice_type <> "0" THEN
		
			ls_cond += " AND ( h.cash_fg in ( "+istr_inv_type.string_parm[1]+" ) )"
	
	END IF
	
	IF( UPPERBOUND(istr_parm.long_array) > 0 ) THEN
	
				 ls_cond += " AND ( sc.fid in ( "+of_convertarraytostring( istr_parm ) +" ) )"
	
	ELSE
			
		IF Not IsNull(ll_sc_id) THEN
			
			ls_cond += " AND ( sc.sc_id = "+String(ll_sc_id)+" )"
			
		END IF
		
	END IF
	
	IF Not IsNull(ll_brand_id) AND IsNull(ll_sc_id) THEN
		
		ls_cond += "AND ( sc.mid = "+String(ll_brand_id)+" )"
		
	END IF
	
	IF Not IsNull(ll_dbid)  THEN
		IF ll_dbid > 0 THEN
			ls_cond += "AND ( h.dbid = "+String(ll_dbid)+" )"
		ELSE
			ls_cond += "AND ( ( h.dbid is null ) or ( h.dbid = 0 ) )"
		END IF
	END IF
	
	IF ls_group_by <> "" THEN
		ls_sql = Mid(ls_sql , 1 , LastPos(ls_sql,ls_group_by) - 1)
		ls_sql +=   ls_cond + ls_group_by
	ELSE
		ls_sql +=   ls_cond
	END IF
	
	iuo_is.dw_report.SetTransObject( SQLCA )	
	iuo_is.dw_report.setsqlselect( ls_sql )	
	iuo_is.dw_report.SetTransObject( SQLCA )		
	iuo_is.dw_report.retrieve(   )
	
	IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
		
		IF gs_lan = "AR" THEN
			
			iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
			
		ELSE
	
			iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
			iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
			
		END IF
	
	END IF
	
	iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
	iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
	iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_408();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_sc_id,ll_brand_id
String ls_cond  , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 			= ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond = 	" AND ( d.start_dt Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
END IF
//retrieve data window
//Open userobject as tab

ll_sc_id 			= dw_filter.GetItemNumber(1 , "sc_id")
ll_brand_id			= dw_filter.GetItemNumber(1 , "brand_id")
ls_detail_fg		= dw_filter.GetItemString(1 , "detail_fg")

ls_title = ""
IF Not IsNull(ll_sc_id) THEN
	ls_cond += " AND ( h.emid = "+String(ll_sc_id)+" ) "
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(sc_id)', 1 )")+" ::: "
END IF

IF Not IsNull(ll_brand_id) THEN
	ls_cond += " AND ( h.group_id = "+String(ll_brand_id)+" ) "
	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(brand_id)', 1 )")+" ::: "
END IF

IF ls_detail_fg <> "A" THEN
	
	ls_cond += " AND ( d.LEAVE_FG = '"+ls_detail_fg+"' ) "
	
END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

IF gs_Lan = "AR" THEN
	iuo_is.dw_report.DataObject = "d_rpt_all_employee_leave_permit"		
ELSE
	iuo_is.dw_report.DataObject = "d_rpt_all_employee_leave_permit_"+gs_lan
END IF
			
ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond

iuo_is.dw_report.Modify("header_t.text=' من تاريخ "+String(ldt_from,"dd/mm/yyyy")+" الى  "+String(ldt_to,"dd/mm/yyyy")+"'")

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_63();Datetime ldt_from,ldt_to
long ll_fid,ll_cid,ll_person_id,ll_brand_id
String ls_ahad_cond , ls_saraf_cond, ls_state , ls_invoice_type,ls_client_type,ls_cost_fg,ls_detail_fg
String ls_group_by_dt,ls_sql,ls_title , ls_group_by,ls_bill_dt 
String ls_sql_1 , ls_sql_2
Long ll_dbid
u_cst_report_container iuo_is
Exception MyEx

TRY

	
ls_sql_1 = "SELECT AHAD_RETURNED.ARID, &
				AHAD.AID,&
				AHAD_RETURNED.MANUAL_NO,&
				AHAD_RETURNED.AR_DT, &
				AHAD_RETURNED.AMOUNT,  &
				AHAD_RETURNED.BANK_ID, &
				AHAD_RETURNED.NOTES,  &
				AHAD.MANUAL_ID, &
				AHAD.AMOUNT as a_amount, &
				AHAD.A_DT,&
				AHAD.STATE, &
				AHAD.PERSON_ID,&
				AHAD.BANK_ID &
			      FROM  AHAD LEFT JOIN  AHAD_RETURNED  &
					ON ( AHAD.AID = AHAD_RETURNED.AID ) &
	WHERE  ( ( AHAD_RETURNED.ACTIVE_FG = 'Y' ) AND ( AHAD.ACTIVE_FG = 'Y' ) )   "
	
	
 ls_sql_2 = 	"  SELECT SARAF.ADVANCE_PAYMENT_ID ,&
	                   AHAD.AID ,&
                       SARAF.MANULA_ID ,&
                       SARAF.S_DT ,&
 				     SARAF.AMOUNT ,&
					 SARAF.BANK_ID ,&
					 SARAF.DES , &
					 AHAD.MANUAL_ID, &
				     0 as a_amount, &
				     AHAD.A_DT,&
				     AHAD.STATE, &
				     AHAD.PERSON_ID,&
				     AHAD.BANK_ID &
                        FROM SARAF INNER JOIN AHAD ON  (SARAF.ADVANCE_PAYMENT_ID  = AHAD.AID) &
						WHERE   (SARAF.ACTIVE_FG = 'Y' )  "				

	
ls_ahad_cond 			= ""
ls_saraf_cond 			= ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_person_id 		= dw_filter.GetItemNumber(1 , "person_nm")
ls_detail_fg		= dw_filter.GetItemstring(1 , "detail_fg")
ls_state				= dw_filter.GetItemString(1 , "state")
ls_title 			= ""
ldt_from				= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to				= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	     MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	     Throw MyEx
ELSE
	   ls_ahad_cond += " and (A_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
         ls_saraf_cond += " and (S_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

       END IF
       IF Not IsNull(ll_person_id) THEN
     	ls_ahad_cond += " AND ( AHAD.PERSON_ID = "+String(ll_person_id)+" ) "
		ls_saraf_cond += " AND ( AHAD.PERSON_ID = "+String(ll_person_id)+" ) "
   //	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(ll_person_id)', 1 )")+" ::: "
         END IF

        IF ls_state <> "A" THEN
    	
	    ls_ahad_cond += " AND ( AHAD.STATE = '"+ls_state+"' ) "
	    ls_saraf_cond += " AND ( AHAD.STATE = '"+ls_state+"' ) "

       END IF
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

//IF gs_Lan = "AR" THEN
IF ls_detail_fg = '1' THEN
	iuo_is.dw_report.DataObject = "d_rpt_ahad_detail_by_dt"
	ls_sql =  (ls_sql_1 + ls_ahad_cond) + " UNION " + (ls_sql_2 + ls_saraf_cond)
ELSE
	iuo_is.dw_report.DataObject = "d_rpt_all_ahad_by_dt"
     ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_ahad_cond
END IF

iuo_is.dw_report.Modify("t_from_to_dt.text ='من تاريخ"+ " : "+String(ldt_from,"dd/mm/yyyy") +"            الى تاريخ  "+" : "+String(ldt_to,"dd/mm/yyyy") +"'")
iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )
IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_35();Datetime ldt_from,ldt_to
long ll_emid
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_emid 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")
ls_solaf_states_fg 	= dw_filter.getitemstring(1,"detail_fg")

 
IF Not IsNull(ll_emid) THEN
	iuo_is.dw_report.DataObject = "d_rpt_all_salaries_by_employ_and_dt"	// مرتبات مستخدم معين
ELSE
	iuo_is.dw_report.DataObject = "d_rpt_all_salaries_all_employ_and_dt"		// مرتبات كل المستخدمين
END IF


IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond = 	" AND ( SALARY.payment_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF Not IsNull(ll_emid) THEN
	
	ls_cond += "AND (SALARY.emid = "+String(ll_emid)+" ) " 
	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: "

ELSE		 
	ls_title = "كل المستخدمين"+" ::: "
END IF	 
  
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	

iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_37();Datetime ldt_from,ldt_to
long ll_emid
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_emid 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")
ls_solaf_states_fg 	= dw_filter.getitemstring(1,"detail_fg")

 
IF Not IsNull(ll_emid) THEN
		 iuo_is.dw_report.DataObject = "d_rpt_solaf_action_by_emid" // السلف الخاصة بمستخدم معين
ELSE
		 iuo_is.dw_report.DataObject = "d_rpt_all_solaf_action" // عرض كل السلف
END IF

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond = 	" AND (  SOLAF.start_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF Not IsNull(ll_emid) THEN
	
	ls_cond += "AND (SOLAF.emid = "+String(ll_emid)+" ) " 
	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: "

ELSE		 
	ls_title = "كل المستخدمين"+" ::: "
END IF	 
  
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	

iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

if(ls_solaf_states_fg <> "A")then                //  A -->  All solaf -  C --> Closed solaf - O --> Open solaf
    iuo_is.dw_report.setfilter( "sates_fg = '"+ls_solaf_states_fg+"'    ")  // في حالة البحث في السلف بحالة السلفة مغلقة او مفتوحة
    iuo_is.dw_report.filter( )
end if


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_116();Datetime ldt_from,ldt_to
long ll_emid
String ls_sql,ls_title , ls_cond

u_cst_report_container iuo_is
Exception MyEx

TRY


ls_sql = " SELECT EMPLOYEE_ACTION_TYPE_CD.TITLE,&
         EMPLOYEES_DAILY_ACTIONS.EMID,&
         SUM(EMPLOYEES_DAILY_ACTIONS.TIMES) as total_items&
           FROM EMPLOYEES_DAILY_ACTIONS,&
              EMPLOYEE_ACTION_TYPE_CD&
                 WHERE ( EMPLOYEES_DAILY_ACTIONS.EATID = EMPLOYEE_ACTION_TYPE_CD.EATID ) and&
                              ( EMPLOYEES_DAILY_ACTIONS.ACTIVE_FG = 'Y' )"
                

ls_cond 	= ""
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_emid 			= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

 /////          دالة خاصة بالشئون الادارية الخاصة  بالغيابات

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	ls_cond = 	" AND ( EMPLOYEES_DAILY_ACTIONS.ACTION_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF Not IsNull(ll_emid) THEN
	ls_cond += "AND (EMPLOYEES_DAILY_ACTIONS.emid = "+String(ll_emid)+" ) " 
ELSE
	ls_cond += "GROUP BY EMPLOYEE_ACTION_TYPE_CD.TITLE ,   EMPLOYEES_DAILY_ACTIONS.EMID"

END IF


IF Not IsNull(ll_emid) THEN
	
	iuo_is.dw_report.DataObject = "d_rpt_employee_daily_actions" // الشئون الادارية لمستخدم معين
	ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond
	
ELSE
	
	iuo_is.dw_report.DataObject = "d_rpt_employees_total_daily_action"	//	الشئون الادارية لكل المستخدمين
	ls_sql += ls_cond
	
END IF 

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_84();Datetime ldt_from,ldt_to
long ll_band_id , ll_dep_id
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_band_id 					= dw_filter.GetItemNumber(1 , "band_id")
ll_dep_id 					= dw_filter.GetItemNumber(1 , "dep_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.dataobject = "d_rpt_spend"

if(not IsNull(ll_band_id))Then      // في حالة إختار بند صرف
	
	ls_cond += "AND (SARAF.band_id = "+String(ll_band_id)+" ) " 
	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(band_id)', 1 )")+" ::: "
else
	ls_title = "كل  المصروفات"+" ::: "
End if
if(not IsNull(ll_dep_id))Then     // في حالة إختار ادارة
	
	ls_cond += "AND (SARAF.depid = "+String(ll_dep_id)+" ) " 
	if(ls_title = "")then
     	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(depid)', 1 )")+" ::: "
      else
	    ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(dep_id)', 1 )")+" ::: "
	end if
End if
	
IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond += 	" AND ( SARAF.S_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_81();Datetime ldt_from,ldt_to
long ll_band_id , ll_dep_id
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )


ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.dataobject = "d_rpt_sources_dept"


uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(ldt_from, ldt_to )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_82();Datetime ldt_from,ldt_to
long ll_band_id , ll_dep_id
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_solaf_states_fg
str_pass_parmeters lstr_parm

u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )
//messagebox("id",string(lstr_parm.long_array[1]))
//dw_filter.setitem( 1,"sc_id",lstr_parm.long_array[1])
//ll_band_id 					= dw_filter.GetItemNumber(1 , "sc_id")

ll_dep_id 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.dataobject = "d_rpt_all_debtors_by_fid"

  If(isNull(ll_dep_id) or ll_dep_id <= 0 )Then
  
	ll_dep_id = 0
	
  End if
  
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(ldt_from,ldt_to , ll_dep_id)

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_54();Datetime ldt_from,ldt_to
long ll_emid
String ls_sql,ls_title , ls_cond , ls_in_out_fg

u_cst_report_container iuo_is
Exception MyEx

TRY
ls_sql = "SELECT RAS_MAL.RASID,&
         RAS_MAL.bank_id,&
         RAS_MAL.amount,&
         RAS_MAL.inc_dt,&
         RAS_MAL.in_out_fg,&
         RAS_MAL.notes,&
         RAS_MAL.active_fg,&
         RAS_MAL.last_modified_by,&
         RAS_MAL.last_modified_dt&
            FROM RAS_MAL&
              WHERE ( RAS_MAL.active_fg = 'Y' ) "
ls_cond 	= ""
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 
iuo_is.dw_report.DataObject = "d_rpt_ras_mal_action_by_dt"

dw_filter.Accepttext( )


ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")
ls_in_out_fg = dw_filter.getitemstring(1,"in_out_fg")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	ls_cond = 	" AND ( RAS_MAL.inc_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF(ls_in_out_fg = "A") THEN
	
		ls_sql +=  ls_cond
	    
ELSE
	
		ls_sql += ls_cond + "AND ( RAS_MAL.in_out_fg = '"+ls_in_out_fg+"' )  "
	
END IF 
 ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(in_out_fg)', 1 )")+" ::: "
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_96();Datetime ldt_from,ldt_to
long ll_band_id
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_bounos_loses_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_band_id 					= dw_filter.GetItemNumber(1 , "band_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")
ls_bounos_loses_fg 	= dw_filter.getitemstring(1,"in_out_fg")

// messagebox("fg",ls_bounos_loses_fg)
IF Not IsNull(ll_band_id) THEN
		 iuo_is.dw_report.DataObject = "d_rpt_other_bouns_loses_actions_by_band" //  يعرض الارباح و الخسائر لبند معين  
ELSE
		 iuo_is.dw_report.DataObject = "d_rpt_other_bouns_loses_actions" // عرض كل الارباح و الخسائر
END IF

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond = 	" AND (  OTHER_BONUS_LOSES.OB_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF Not IsNull(ll_band_id) THEN
	
	ls_cond += "AND (OTHER_BONUS_LOSES.BANDID  = "+String(ll_band_id)+" ) " 
	ls_title    = dw_filter.Describe("Evaluate('LookUpDisplay(band_id)', 1 )")+" ::: "
END IF	 
  
  if(ls_bounos_loses_fg <> "A") THEN
		
		ls_cond +=  "AND ( OTHER_BONUS_LOSES.BOUNS_LOSES = '"+ls_bounos_loses_fg+"' )  "
		ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(in_out_fg)', 1 )")+" ::: "
ELSE		 
	ls_title += "كل الارباح و الخسائر"+" ::: "
  end if
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
// messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

//if(ls_solaf_states_fg <> "A")then                //  A -->  All solaf -  C --> Closed solaf - O --> Open solaf
//    iuo_is.dw_report.setfilter( "sates_fg = '"+ls_solaf_states_fg+"'    ")  // في حالة البحث في السلف بحالة السلفة مغلقة او مفتوحة
//    iuo_is.dw_report.filter( )
//end if


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_17();Datetime ldt_from,ldt_to
long ll_customer_id , ll_fid
String ls_sql,ls_title , ls_cond, ls_item_group
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= "SELECT     CUSTOMER_BILL.CUSTOMER_ID, STORE_CARD.MASURE ,&
                   SUM(CUSTOMER_BILL_ITEMS.QUANTITY) AS total_quantity,&
                   SUM(CUSTOMER_BILL_ITEMS.QUANTITY * CUSTOMER_BILL_ITEMS.PRICE) AS total_price , STORE_CARD.RANK_NO&
                     FROM         CUSTOMER_BILL  INNER JOIN CUSTOMER_BILL_ITEMS&
					ON ( CUSTOMER_BILL.BILL_NO = CUSTOMER_BILL_ITEMS.BILL_NO )&
			         INNER JOIN STORE_CARD  on (STORE_CARD.SC_ID = CUSTOMER_BILL_ITEMS.SC_ID )&
                          WHERE      (CUSTOMER_BILL.ACTIVE_FG = 'Y')AND(CUSTOMER_BILL_ITEMS.ACTIVE_FG <> 'N') "
                            
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_customer_id 					= dw_filter.GetItemNumber(1 , "cid")
ll_fid 					= dw_filter.GetItemNumber(1 , "fid")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.dataobject = "d_rpt_client_and_sc_family"

 // MAIN IF STETAMENT
IF(not IsNull(ll_customer_id))THEN      // في حالة إختار بند صرف
	
	ls_cond += "AND (CUSTOMER_BILL.CUSTOMER_ID  = "+String(ll_customer_id)+" ) " 
	ls_title =dw_filter.Describe("Evaluate('LookUpDisplay(cid)', 1 )")+" ::: "

if(not IsNull(ll_fid))Then     

	ls_cond += "AND (STORE_CARD.fid =  "+String(ll_fid)+" ) " 
	if(ls_title = "")then
     	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )")+" ::: "      
      else
	    ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )")+" ::: "		
	end if
 ls_item_group = dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )" )
else
	ls_item_group = "كل مجموعات الاصناف" 
	 ls_title += " كل مجموعات الاصناف"+" ::: "
End if
	
IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond += 	" AND (CUSTOMER_BILL.BILL_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF


uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='  من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"    الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql =  ls_cond	+ " GROUP BY STORE_CARD.MASURE, CUSTOMER_BILL.CUSTOMER_ID , STORE_CARD.RANK_NO order by STORE_CARD.RANK_NO"
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )
//	messagebox("str",ls_item_group  )
  if(iuo_is.dw_report.rowcount( ) > 0)then
  iuo_is.dw_report.Modify("t_1.text = '"+ string(ls_item_group)+"'")
//iuo_is.dw_report.Modify("customer_id.value = '"+string(ll_customer_id)+ "'" )
   end if
	
else
 messagebox("تنبيه","الرجاء إختيار إسم الزبون")
 
End if  // MAIN IF STETAMENT

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_346();Datetime ldt_from,ldt_to
long ll_client_id
String ls_sql,ls_title , ls_cond, ls_daily_action_flag, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_client_id 					= dw_filter.GetItemNumber(1 , "cid")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")
 
IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond = 	" AND ( customer_bill.bill_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF Not IsNull(ll_client_id) THEN
	     iuo_is.dw_report.DataObject = "d_rpt_invoices_period"  //  عرض باسم الزبون و التاريخ
         ls_cond += "AND (CUSTOMER_BILL.CUSTOMER_ID  = "+String(ll_client_id)+" ) " 
	     ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(cid)', 1 )")+" ::: "

ELSE	
	     iuo_is.dw_report.DataObject = "d_rpt_invoices_period_no_clients" // عرض بالتاريخ فقط
	     ls_title = "كل الزبائن"+" ::: "
END IF	 
  
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"         الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_342();Datetime ldt_from,ldt_to
long ll_customer_id , ll_fid
String ls_sql,ls_title , ls_cond, ls_type_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

 ls_cond 	= ""                          
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_customer_id 					= dw_filter.GetItemNumber(1 , "cid")
ll_fid 					= dw_filter.GetItemNumber(1 , "fid")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

//messagebox("type_fg",is_report_type)
IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond  = 	" AND (dead_account.g_date between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF(not IsNull(ll_customer_id))THEN      

	ls_cond += "AND (dead_account.customer_id  = "+String(ll_customer_id)+" ) " 
	iuo_is.dw_report.dataobject = "d_rpt_by_client_dead_account"
	ls_title =dw_filter.Describe("Evaluate('LookUpDisplay(cid)', 1 )")+" ::: "
    	 
else

    iuo_is.dw_report.dataobject = "d_rpt_all_client_dead_account"
	  ls_title = "كل الزبائن"+" ::: "
End if  

if(not IsNull(ll_fid))Then     

	ls_cond += "AND (dead_account.fid  =  "+String(ll_fid)+" ) " 
	if(ls_title = "")then
     	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )")+" ::: "      
      else
	    ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )")+" ::: "		
	end if
else
	ls_title += " كل مجموعات الاصناف"+" ::: "
End if
	
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='  من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"    الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")
if(is_report_type = 'D')then
    iuo_is.dw_report.Modify("t_2.text = 'ديون معدومة' ")
else
	  iuo_is.dw_report.Modify("t_2.text = 'تخفيضات' ")
end if
ls_sql = iuo_is.dw_report.getsqlselect( ) +  ls_cond	 
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )
	
IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY

end event

event of_343();Datetime ldt_from,ldt_to
long ll_customer_id , ll_fid
String ls_sql,ls_title , ls_cond, ls_type_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

 ls_cond 	= ""                          
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_customer_id 					= dw_filter.GetItemNumber(1 , "cid")
ll_fid 					= dw_filter.GetItemNumber(1 , "fid")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

//messagebox("type_fg",is_report_type)
IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond  = 	" AND (dead_account.g_date between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

IF(not IsNull(ll_customer_id))THEN      

	ls_cond += "AND (dead_account.customer_id  = "+String(ll_customer_id)+" ) " 
	iuo_is.dw_report.dataobject = "d_rpt_by_client_dead_account"
	ls_title =dw_filter.Describe("Evaluate('LookUpDisplay(cid)', 1 )")+" ::: "
    	 
else

    iuo_is.dw_report.dataobject = "d_rpt_all_client_dead_account"
	  ls_title = "كل الزبائن"+" ::: "
End if  

if(not IsNull(ll_fid))Then     

	ls_cond += "AND (dead_account.fid  =  "+String(ll_fid)+" ) " 
	if(ls_title = "")then
     	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )")+" ::: "      
      else
	    ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(fid)', 1 )")+" ::: "		
	end if

End if
	
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='  من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"    الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")
if(is_report_type = 'D')then
    iuo_is.dw_report.Modify("t_2.text = 'ديون معدومة' ")
else
	  iuo_is.dw_report.Modify("t_2.text = 'تخفيضات' ")
end if
ls_sql = iuo_is.dw_report.getsqlselect( ) +  ls_cond	 
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )
	
IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY

end event

event of_95();Datetime ldt_from,ldt_to
long ll_emid
String ls_sql,ls_title , ls_cond

u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= ""
ls_title = "ترحيل الارباح"

MyEx = Create Exception

iuo_is = Create u_cst_report_container 
iuo_is.dw_report.DataObject = "d_rpt_transfar_money_actions"

dw_filter.Accepttext( )


ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	ls_cond = 	" AND ( TRANSFARE_MONEY.trans_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

// ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(in_out_fg)', 1 )")+" ::: "
uo_tabcontrol.of_OpenTab(iuo_is, ls_title+':::'+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_357();Datetime ldt_from,ldt_to
long ll_emid
String ls_sql,ls_title , ls_cond

u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= ""
ls_title = "مؤشرات مالية"

MyEx = Create Exception

iuo_is = Create u_cst_report_container 
iuo_is.dw_report.DataObject = "d_rpt_sp_finance_indicators"

dw_filter.Accepttext( )


ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
    uo_tabcontrol.of_OpenTab(iuo_is, ls_title+':::'+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
    uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
	iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")
	//messagebox("sql",ls_sql)
	iuo_is.dw_report.SetTransObject( SQLCA )	
	iuo_is.dw_report.setsqlselect( ls_sql )	
	iuo_is.dw_report.SetTransObject( SQLCA )		
	iuo_is.dw_report.retrieve(ldt_from,ldt_to)

END IF
IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_341();
long ll_fid , ll_price_id
String ls_title , ls_filter

u_cst_report_container iuo_is
Exception MyEx

TRY


ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_fid 					= dw_filter.GetItemNumber(1 , "fid_nm")
ll_price_id 					= dw_filter.GetItemNumber(1 , "price_list_id")

iuo_is.dw_report.dataobject = "d_rpt_sp_pricing_forcast"

if(not IsNull(ll_fid) AND (not IsNull(ll_price_id)))Then      // يجب إختيار  مجموعة الاصناف و الاسعار
	

    ls_filter =  "fid = "+String(ll_fid)
	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(fid_nm)', 1 )")+" ::: "
	ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(price_list_id)', 1 )")


	uo_tabcontrol.of_OpenTab(iuo_is, ls_title, 1)
	uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
	 
	iuo_is.dw_report.SetTransObject( SQLCA )		
	iuo_is.dw_report.retrieve( ll_price_id  )
	iuo_is.dw_report.setfilter(ls_filter)
	iuo_is.dw_report.filter( )
else
messagebox("تنبية",'الرجاء إدخال  كل البيانات')
End if
    IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_1731();Datetime ldt_from,ldt_to
long ll_sc_id , ll_list_id
String ls_sql,ls_title , ls_cond, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_sc_id 					= dw_filter.GetItemNumber(1 , "sc_id")
ll_list_id 					= dw_filter.GetItemNumber(1 , "list_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.dataobject = "d_rpt_stock_price_history"

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond = 	" AND (stock_price_history.change_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

if(not IsNull(ll_sc_id))Then      // في حالة إختار بند صرف
	
	ls_cond += "AND (stock_price_history.sc_id= "+String(ll_sc_id)+" ) " 
	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: "
else
	ls_title = "كل  الاصناف"+" ::: "
End if
if(not IsNull(ll_list_id))Then     // في حالة إختار الاسعار
	
	ls_cond += "AND (stock_price_history.price_list_id = "+String(ll_list_id)+" ) " 
	if(ls_title = "")then
     	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(list_id)', 1 )")+" ::: "
      else
	    ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(list_id)', 1 )")+" ::: "
	end if
	else
	ls_title += "كل  الاسعار"+" ::: "
End if
	


uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"     الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_1730();Datetime ldt_from,ldt_to
long ll_sc_id 
String ls_sql,ls_title , ls_cond, ls_solaf_states_fg
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_sc_id 					= dw_filter.GetItemNumber(1 , "sc_id")
//ll_dep_id 					= dw_filter.GetItemNumber(1 , "dep_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.dataobject = "d_rpt_follow_purchase_price"

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	
     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ

ELSE
	
	ls_cond = 	" AND ( income_store_bill.arrive_dt between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

if(not IsNull(ll_sc_id))Then      // في حالة إختار بند صرف
	
	ls_cond += "AND (income_bill_item.sc_id= "+String(ll_sc_id)+" ) " 
	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: "
else
	ls_title = "كل  الاصناف"+" ::: "
End if
//if(not IsNull(ll_dep_id))Then     // في حالة إختار ادارة
//	
//	ls_cond += "AND (SARAF.depid = "+String(ll_dep_id)+" ) " 
//	if(ls_title = "")then
//     	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(depid)', 1 )")+" ::: "
//      else
//	    ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(dep_id)', 1 )")+" ::: "
//	end if
//End if
	


uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"     الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )


IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_117();Datetime ldt_from,ldt_to
long ll_car_id , ll_type_id
String ls_sql,ls_title , ls_cond
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_car_id 					= dw_filter.GetItemNumber(1 , "carid")
ll_type_id 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

if(not IsNull(ll_car_id))Then      // في حالة إختار  المركبة 
	
//	CHOOSE CASE ll_type_id
//		CASE 1  // السائقين
//	             ls_cond = "AND (CAR_DRIVERS.CARID = "+String(ll_car_id)+" ) " 
//  			   	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
//				iuo_is.dw_report.dataobject = "d_rpt_car_drivers"
//				 IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
//					 ls_cond += 	" AND ( CAR_DRIVERS.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
//				 END IF
//	   CASE 2  // التأمين
//	             ls_cond = "AND (CAR_INSURANCE.CARID.CARID = "+String(ll_car_id)+" ) " 
//				ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
//                 iuo_is.dw_report.dataobject = "d_rpt_insurace_no_dt"
//				IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
//					ls_cond += 	" AND (CAR_INSURANCE.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
//				 END IF	  
//	   CASE 3  // الفحص الفني
//	             ls_cond = "AND (MECHANICAL_CHECK.CARID = "+String(ll_car_id)+" ) " 
//				ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
//                 iuo_is.dw_report.dataobject = "d_rpt_mechanical_check"
//				IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
//					ls_cond += 	" AND ( MECHANICAL_CHECK.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
//				 END IF	 	  
//	  CASE 4  // دمغة التجول
	             ls_cond = "AND (CAR_TRAVEL_STAMP.CARID = "+String(ll_car_id)+" ) "
				ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
				ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: " 
                 iuo_is.dw_report.dataobject = "d_rpt_travel_stamp_no_dt"
				IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
					ls_cond += 	" AND ( CAR_TRAVEL_STAMP.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
				 END IF	 	  
//	END CHOOSE				  
//   IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 	
//	
//     gnv_msg.of_Message( 18 )// أرجو التاكد من التاريخ
//
//  ELSE
	
//	ls_cond += 	" AND ( CAR_TRAVEL_STAMP.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
//
 uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

//  END IF
else
//	ls_title = "كل  المصروفات"+" ::: "
    messagebox("تنبية"," الرجاء إختيار المركبة ")
End if

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_394();Datetime ldt_from,ldt_to
long ll_car_id , ll_type_id
String ls_sql,ls_title , ls_cond
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ll_car_id 					= dw_filter.GetItemNumber(1 , "carid")
ll_type_id 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

if(not IsNull(ll_car_id))Then      // في حالة إختار  المركبة 
	
                                            // السائقين
	ls_cond = "AND (CAR_DRIVERS.CARID = "+String(ll_car_id)+" ) " 
  	ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
	ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: " 
	iuo_is.dw_report.dataobject = "d_rpt_car_drivers"
	IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
	 ls_cond += 	" AND ( CAR_DRIVERS.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
	END IF

 uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

//  END IF
else
//	ls_title = "كل  المصروفات"+" ::: "
    messagebox("تنبية"," الرجاء إختيار المركبة ")
End if

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_395();Datetime ldt_from,ldt_to
long ll_car_id , ll_type_id
String ls_sql,ls_title , ls_cond
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 
//dw_filter.setitem( 1, "sc_id",is_report_type)
dw_filter.Accepttext( )
//messagebox("type",string(is_report_type))
ll_car_id 					= dw_filter.GetItemNumber(1 , "carid")
ll_type_id 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

if(not IsNull(ll_car_id))Then      // في حالة إختار  المركبة 
	
                                  // الفحص الفني
	             ls_cond = "AND (MECHANICAL_CHECK.CARID = "+String(ll_car_id)+" ) " 
				ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
				ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: " 
                 iuo_is.dw_report.dataobject = "d_rpt_mechanical_check"
				IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
					ls_cond += 	" AND ( MECHANICAL_CHECK.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
				 END IF	 	  

 uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

//  END IF
else
//	ls_title = "كل  المصروفات"+" ::: "
    messagebox("تنبية"," الرجاء إختيار المركبة ")
End if

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_396();Datetime ldt_from,ldt_to
long ll_car_id , ll_type_id
String ls_sql,ls_title , ls_cond
u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 	= " "
ls_title = ""

MyEx = Create Exception

iuo_is = Create u_cst_report_container 
dw_filter.Accepttext( )

ll_car_id 					= dw_filter.GetItemNumber(1 , "carid")
ll_type_id 					= dw_filter.GetItemNumber(1 , "sc_id")
ldt_from					= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to					= dw_filter.GetItemDatetime(1 , "to_dt")

if(not IsNull(ll_car_id))Then      // في حالة إختار  المركبة 
	
                                             // التأمين
	             ls_cond = "AND (CAR_INSURANCE.CARID = "+String(ll_car_id)+" ) " 
				ls_title = dw_filter.Describe("Evaluate('LookUpDisplay(carid)', 1 )")+" ::: "
				ls_title += dw_filter.Describe("Evaluate('LookUpDisplay(sc_id)', 1 )")+" ::: " 
                 iuo_is.dw_report.dataobject = "d_rpt_insurace"
				IF (not IsNull(ldt_from)) or (not IsNull(ldt_to)) THEN 
					ls_cond += 	" AND (CAR_INSURANCE.START_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"
				 END IF	  

 uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))
 
iuo_is.dw_report.Modify("from_to_dt_t.text='    من تاريخ : "+String(ldt_from,"dd/mm/yyyy")+"               الى تاريخ : "+String(ldt_to,"dd/mm/yyyy")+"'")

ls_sql = iuo_is.dw_report.getsqlselect( ) + ls_cond	
//messagebox("sql",ls_sql)
iuo_is.dw_report.SetTransObject( SQLCA )
iuo_is.dw_report.setsqlselect( ls_sql )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

//  END IF
else
//	ls_title = "كل  المصروفات"+" ::: "
    messagebox("تنبية"," الرجاء إختيار المركبة ")
End if

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	
FINALLY 
	Destroy MyEx
END TRY
end event

event of_4();Datetime ldt_from,ldt_to
long ll_from_bank_id ,ll_to_bank_id
String ls_cond , ls_sql , ls_title , ls_bank_nm

u_cst_report_container iuo_is
Exception MyEx

TRY

ls_cond 			= "  SELECT PAYMENTS.ID, PAYMENTS.CID,PAYMENTS.PAYMENT_DT,&
                                         PAYMENTS.BANK_ID,PAYMENTS.AMOUNT, PAYMENTS.BOND, PAYMENTS.TYPE_ID,&
                                         PAYMENTS.FROM_BANK_ID FROM PAYMENTS WHERE (ACTIVE_FG = 'Y' ) "

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )
//messagebox("MSG",string(ls_bank_nm ) )

ll_from_bank_id	= dw_filter.GetItemNumber(1 , "from_bank_id")
ll_to_bank_id			= dw_filter.GetItemNumber(1 , "to_bank_id")
ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

iuo_is.dw_report.DataObject = "d_rpt_treasury_movement"

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( PAYMENT_DT Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) " 
    //ls_cond += 	" AND ( PAYMENT_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

ls_title = "حركة الخزينة :: "
//IF Not IsNull(ll_dbid) THEN 
//	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
//END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")

IF Not IsNull(ll_from_bank_id) THEN
	
	ls_cond += "AND ( FROM_BANK_ID = "+String(ll_from_bank_id)+" )"
	
END IF

IF  Not IsNull(ll_to_bank_id) THEN
	
	ls_cond += "AND ( BANK_ID = "+String(ll_to_bank_id)+" )"
	
END IF

//ls_sql = iuo_is.dw_report.getsqlselect( )
//	ls_sql +=   ls_cond
//messagebox("sql",string(ls_cond))
iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_cond )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_5();Datetime ldt_from,ldt_to
long ll_from_bank_id ,ll_to_bank_id , ll_price_fg
String ls_cond_price , ls_cond , ls_sql , ls_title , ls_all_fg
String ls_filter

u_cst_report_container iuo_is
Exception MyEx

TRY

MyEx = Create Exception

iuo_is = Create u_cst_report_container 

dw_filter.Accepttext( )

ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")
ll_price_fg = dw_filter.GetItemnumber(1 , "price_fg")
ls_all_fg 	= dw_filter.GetItemString(1 , "all_fg")

ls_filter	= ""

IF ll_price_fg = 1 THEN
     iuo_is.dw_report.DataObject = "d_rpt_stock_movement_price"
	 ls_title = "حركة قيمة الأسهم :: " 
	 IF ls_all_fg = "N" THEN
	
		ls_filter= " ( ( closed_amount + opened_amount ) > 0  ) "

	 END IF	 
ELSE
	 iuo_is.dw_report.DataObject = "d_rpt_stock_movement"
	 ls_title = "حركة الأسهم :: " 
	 IF ls_all_fg = "N" THEN
	
		ls_filter= " ( ( closed_shares + opened_shares ) > 0  ) "

	 END IF
END IF

IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
END IF


uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")


iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(ldt_from, ldt_to)
iuo_is.dw_report.SetFilter( ls_filter )
iuo_is.dw_report.Filter()

IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

event of_28();Datetime ldt_from,ldt_to
long ll_from_bank_id ,ll_to_bank_id
String ls_cond , ls_sql , ls_title , ls_bank_nm

u_cst_report_container iuo_is
Exception MyEx

TRY
	
	MyEx = Create Exception

iuo_is = Create u_cst_report_container 
iuo_is.dw_report.DataObject = "d_rpt_cash_actions_by_bank"

dw_filter.Accepttext( )


ll_from_bank_id	= dw_filter.GetItemNumber(1 , "from_bank_id")
//ll_to_bank_id			= dw_filter.GetItemNumber(1 , "to_bank_id")
ldt_from		= dw_filter.GetItemDatetime(1 , "from_dt")
ldt_to		= dw_filter.GetItemDatetime(1 , "to_dt")

//messagebox("MSG",string(ll_from_bank_id ) )

ls_cond 	= "  SELECT vBankTransactions.ID AS CC_ID,&
			     	vBankTransactions.BT_DT,&
					vBankTransactions.AMOUNT,&
					vBankTransactions.T_TYPE AS CC_KIND,&
					vBankTransactions.BILL_NO AS MANUL_NO,&
					vBankTransactions.NOTE as des,&
					vBankTransactions.BANK,&
                      (Select isnull(sum(amount),0) from vBankTransactions where (BT_DT < '"+string(ldt_from,"dd mmm yyyy")+"') and (bank = "+string(ll_from_bank_id)+" ) )  as old_account&
                       FROM vBankTransactions  "

IF IsNull(ll_from_bank_id) THEN
//	MyEx.setmessage( "53" )// "ارجو التاكد من الخزينة" )
	gnv_msg.of_Message(53)
//messagebox("تنبيه","أرجو إختيار الخزينة" )
//	Throw MyEx
ELSE
	ls_cond += "WHERE ( BANK = "+String(ll_from_bank_id)+" )"


IF IsNull(ldt_from) or IsNull(ldt_to) THEN 	
	MyEx.setmessage( "18" )// "ارجو التاكد من تاريخ" )
	Throw MyEx
ELSE
	ls_cond += 	" AND ( BT_DT Between '"+string(ldt_from,"dd mmm yyyy")+"' AND '"+string(ldt_to,"dd mmm yyyy")+"' ) ORDER BY BT_DT DESC" 
    //ls_cond += 	" AND ( PAYMENT_DT between '"+String(ldt_from, "dd mmm yyyy")+ " 00:00:00' and '"+string(ldt_to , "dd mmm yyyy")+" 23:59:59')"

END IF

ls_title = "حركة الخزينة :: "
//IF Not IsNull(ll_dbid) THEN 
//	ls_title = dw_filter.Describe("Evaluate( 'lookupdisplay(dbid)', 1 )")+" ::: "
//END IF

uo_tabcontrol.of_OpenTab(iuo_is, ls_title+String(ldt_from,"dd/mm/yyyy")+" - "+String(ldt_to,"dd/mm/yyyy"), 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

iuo_is.dw_report.Modify("t_from_dt.text='"+String(ldt_from,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_to_dt.text='"+String(ldt_to,"dd/mm/yyyy")+"'")
iuo_is.dw_report.Modify("t_bank_nm.text='"+string(ll_from_bank_id)+"'")

//IF  Not IsNull(ll_to_bank_id) THEN
//	
//	ls_cond += "AND ( BANK_ID = "+String(ll_to_bank_id)+" )"
//	
//END IF

//ls_sql = iuo_is.dw_report.getsqlselect( )
//	ls_sql +=   ls_cond
//messagebox("sql",string(ls_cond))
iuo_is.dw_report.SetTransObject( SQLCA )	
iuo_is.dw_report.setsqlselect( ls_cond )	
iuo_is.dw_report.SetTransObject( SQLCA )		
iuo_is.dw_report.retrieve(   )

END IF
IF iuo_is.dw_report.Describe( "t_user_nm.enabled" ) = "!" THEN
	
	IF gs_lan = "AR" THEN
		
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
		
	ELSE

		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_branch_title.text" , "Branch" ) +"' border=~"0~" color=~"33554432~" x=~"517~" y=~"16~" height=~"56~" width=~"375~" html.valueishtml=~"0~"  name=t_branch_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"923~" y=~"16~" height=~"56~" width=~"357~" html.valueishtml=~"0~"  name=t_branch visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_pc_nm_title.text" , "Computer Name" ) +"' border=~"0~" color=~"33554432~" x=~"1403~" y=~"16~" height=~"56~" width=~"366~" html.valueishtml=~"0~"  name=t_pc_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"1787~" y=~"20~" height=~"56~" width=~"393~" html.valueishtml=~"0~"  name=t_pc_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text='"+csGUI.of_filter( "ReportFooter" , "t_user_nm_title.text" , "User Name" ) +"' border=~"0~" color=~"33554432~" x=~"2272~" y=~"20~" height=~"56~" width=~"279~" html.valueishtml=~"0~"  name=t_user_nm_title visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		iuo_is.dw_report.Modify("Create text(band=footer alignment=~"0~" text=~"~" border=~"0~" color=~"33554432~" x=~"2578~" y=~"20~" height=~"56~" width=~"466~" html.valueishtml=~"0~"  name=t_user_nm visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" font.italic=~"1~" background.mode=~"2~" background.color=~"1073741824~" background.transparency=~"0~" background.gradient.color=~"8421504~" background.gradient.transparency=~"0~" background.gradient.angle=~"0~" background.brushmode=~"0~" background.gradient.repetition.mode=~"0~" background.gradient.repetition.count=~"0~" background.gradient.repetition.length=~"100~" background.gradient.focus=~"0~" background.gradient.scale=~"100~" background.gradient.spread=~"100~" tooltip.backcolor=~"134217752~" tooltip.delay.initial=~"0~" tooltip.delay.visible=~"32000~" tooltip.enabled=~"0~" tooltip.hasclosebutton=~"0~" tooltip.icon=~"0~" tooltip.isbubble=~"0~" tooltip.maxwidth=~"0~" tooltip.textcolor=~"134217751~" tooltip.transparency=~"0~" transparency=~"0~" )")
		
	END IF

END IF

iuo_is.dw_report.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
iuo_is.dw_report.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
iuo_is.dw_report.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

CATCH(RunTimeError rte_ex)
	MessageBox("",rte_ex.getmessage(),Exclamation! )
CATCH(Exception ex)
	
		IF ex.getmessage() = "18" THEN
			gnv_msg.of_Message( 18 )
		END IF
	//MessageBox("تنبيه",ex.getmessage(),Exclamation! )
FINALLY 
	Destroy MyEx
END TRY
end event

public function boolean of_canclose ();Return True
end function

public function string of_convertarraytostring (str_pass_parmeters ar_parm);Long ll_upperBound,ll_itr
String ls_res=""

ll_upperBound = UPPERBOUND(ar_parm.Long_array )

FOR ll_itr = 1 TO ll_UpperBound 
	IF ll_itr = ll_UpperBound  THEN
		ls_res += String(ar_parm.Long_array[ll_itr])
	ELSE
		ls_res += String(ar_parm.Long_array[ll_itr])+","
	END IF
NEXT

Return ls_res
end function

public subroutine of_rtl (long newwidth, long newheight);Long ll_padding = 20

gb_filter.move(ll_padding ,ll_padding)
gb_filter.resize( Newwidth - ll_padding , gb_filter.height  )

gb_filter.righttoleft = True

dw_filter.move(NewWidth - dw_filter.width - ll_padding , gb_filter.y + ll_padding * 4 )

uo_tabcontrol.resize( Newwidth , Newheight - gb_filter.height - cb_run.height - ll_padding * 2)
uo_tabcontrol.move( 0 , gb_filter.height + ll_padding )

//positioning buttons
cb_run.move(NewWidth - cb_run.width - ll_padding , NewHeight - cb_run.height - ll_padding   )
cb_print.move(cb_run.x - ll_padding - cb_print.width , NewHeight - cb_run.height - ll_padding   )
cb_export.move(cb_print.x - ll_padding - cb_export.width , NewHeight - cb_run.height - ll_padding   )





end subroutine

public subroutine of_ltr (long newwidth, long newheight);Long ll_padding = 20

gb_filter.move(ll_padding ,ll_padding)
//gb_filter.resize( Newwidth - ll_padding , gb_filter.height  )
//
//gb_filter.righttoleft = False
//
dw_filter.move(gb_filter.x + ll_padding , gb_filter.y + ll_padding * 4 )

uo_tabcontrol.resize( Newwidth , Newheight - gb_filter.height - cb_run.height - ll_padding * 2)
uo_tabcontrol.move( 0 , gb_filter.height + ll_padding )

//positioning buttons
cb_run.move(gb_filter.x + ll_padding , NewHeight - cb_run.height - ll_padding   )
cb_print.move(cb_run.x + ll_padding + cb_print.width , cb_run.y   )
cb_export.move(cb_print.x + ll_padding + cb_export.width , cb_run.y  )







end subroutine

public subroutine of_initialvalueadvancepayment ();
end subroutine

on tp_standard_report.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_run=create cb_run
this.cb_export=create cb_export
this.dw_filter=create dw_filter
this.uo_tabcontrol=create uo_tabcontrol
this.gb_filter=create gb_filter
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_run
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.dw_filter
this.Control[iCurrent+5]=this.uo_tabcontrol
this.Control[iCurrent+6]=this.gb_filter
this.Control[iCurrent+7]=this.pb_1
end on

on tp_standard_report.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_run)
destroy(this.cb_export)
destroy(this.dw_filter)
destroy(this.uo_tabcontrol)
destroy(this.gb_filter)
destroy(this.pb_1)
end on

event ue_postconstructor;call super::ue_postconstructor;dw_filter.DataObject = is_FilterDataObject
dw_filter.SetTransObject(SQLCA)
dw_filter.ScrollToRow(dw_filter.InsertRow(1))

dw_filter.SetItem(1 , "from_dt" 			, today() )
dw_filter.SetItem(1 , "to_dt" 			, RelativeDate(today() , 15) )
//messagebox("date",string(gstr_user_info.login_id))
//IF ( (long(is_report_type) >= 1) and (long(is_report_type) <= 4) )then
//	
//     dw_filter.SetItem(1 , "sc_id", long(is_report_type)  ) // هذا المتغير خاص بتقارير السائقين و التأمين و الفحص الفني و دمغة التجول للمركبات
//end if
//IF dw_filter.describe( "client_type.ColType" ) <> '?' and dw_filter.describe( "client_type.ColType" ) <> '!' THEN
//	dw_filter.SetItem(1 , "client_type" 		, "0" )
//END IF
//
//IF dw_filter.describe( "cost_price_fg.ColType" ) <> '?' and dw_filter.describe( "cost_price_fg.ColType" ) <> '!' THEN
//	dw_filter.SetItem(1 , "cost_price_fg" 	, "Y" )
//END IF
//
//IF dw_filter.describe( "detail_fg.ColType" ) <> '?' and dw_filter.describe( "detail_fg.ColType" ) <> '!' THEN
//	dw_filter.SetItem(1 , "detail_fg" 			, "Y" )
//END IF

//IF dw_filter.describe( "from_dt.ColType" ) <> '?' and dw_filter.describe( "from_dt.ColType" ) <> '!' THEN
//	dw_filter.SetItem(1 ,"from_dt" , DateTime("00/00/0000",Time("00:00:00")) )
//END IF
//IF dw_filter.describe( "to_dt.ColType" ) <> '?' and dw_filter.describe( "to_dt.ColType" ) <> '!' THEN
//	dw_filter.SetItem(1 ,"to_dt" , DateTime("00/00/0000",Time("00:00:00")) )
//END IF
//IF dw_filter.describe( "detail_fg.ColType" ) <> '?' and dw_filter.describe( "detail_fg.ColType" ) <> '!' THEN

//	IF This.tag = "37" THEN
//		dw_filter.SetItem(1 , "detail_fg"		, "A" )
//		
//	END IF
//END IF

//IF dw_filter.describe( "in_out_fg.ColType" ) <> '?' and dw_filter.describe( "in_out_fg.ColType" ) <> '!' THEN
//
//        IF This.tag = "96" THEN
//		dw_filter.SetItem(1 , "in_out_fg"		, "A" )
//	    END IF
//END IF

IF Long(gstr_user_info.dbid) > 0 THEN
	
	dw_filter.Modify( "dbid.tabsequence=32766" )
	dw_filter.Modify( "dbid.background.color='67108864'" )
		
END IF

IF This.tag = "72" THEN
	
	dw_filter.Modify( "invoice_type.tabsequence=32766" )
	dw_filter.Modify( "invoice_type.background.color='67108864'" )

END IF

IF gstr_user_info.application_parm[gnv_Settings.UserStoreCardFamily] = 1 THEN
	
	dw_filter.Modify( "sc_id.tabsequence=32766" )
	dw_filter.Modify( "sc_id.background.color='67108864'" )
	dw_filter.Modify( "sc_id_1.tabsequence=32766" )
	dw_filter.Modify( "sc_id_1.background.color='67108864'" )
	dw_filter.Modify( "brand_id.tabsequence=32766" )
	dw_filter.Modify( "brand_id.background.color='67108864'" )
	
END IF

uo_tabcontrol.of_AddImage('UserObject5!')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\home.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\cube_config.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\misc_box.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\ico\document-yellow.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\ico\report.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\ico\red_folder.ico')

//Set the tab style to VS2005
uo_tabcontrol.of_SetStyle(uo_tabcontrol.excel)

//uo_tabcontrol.of_hidearrows( )
uo_tabcontrol.of_SetTheme(uo_tabcontrol.blue )
//uo_tabcontrol.of_hideclosebutton( )

uo_tabcontrol.iw_parent = w_menu

//IF gstr_user_info.login_id = "Support" THEN
//	pb_1.VIsible = True
//END IF
//
//IF gstr_user_info.login_id = "support" THEN	
//	dw_filter.Modify( "b_gui.visible=1" )
//ELSE
//	dw_filter.Modify( "b_gui.visible=0" )
//END IF


end event

event resize;csGui.of_Apply_gui( is_report_type , "Filter" , dw_filter )

gb_filter.text 	= csGui.of_filter( "Window" , "gb_filter.text" , "بيانات البحث" ) 
gb_filter.Height	= Long(csGui.of_filter( "Window" , "gb_filter.Height" , "424" ) )
dw_filter.Height	= Long(csGui.of_filter( "Window" , "dw_filter.Height" , "340" ) )
dw_filter.width	= Long(csGui.of_filter( "Window" , "dw_filter.width" , "3858" ) )

cb_run.text 		= csGui.of_filter( "Window" ,"cb_run.text" , "عرض" )
cb_print.text 		= csGui.of_filter( "Window" , "cb_print.text" ,"طباعة" )
cb_export.text 	= csGui.of_filter( "Window" ,"cb_export.text" , "...تصدير" )

IF gs_Lan = "AR" THEN
	of_rtl(NewWidth , NewHeight)
ELSE
	of_ltr(NewWidth , NewHeight)
END IF
end event

event constructor;call super::constructor;
csGui = Create n_cst_guidb

csGui.is_systempart = is_report_type
csGui.of_load( is_report_type )





end event

type cb_print from u_cb within tp_standard_report
integer x = 3273
integer y = 2348
integer height = 100
integer taborder = 61
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "طباعة"
end type

event clicked;call super::clicked;u_cst_report_container uo
uo = uo_tabcontrol.ist_tabs[uo_tabcontrol.il_selected ].ado_object
uo.dw_report.Event pfc_print()
end event

type cb_run from u_cb within tp_standard_report
integer x = 3630
integer y = 2348
integer height = 100
integer taborder = 61
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "عرض"
end type

event clicked;call super::clicked;
Parent.triggerevent( "of_"+Parent.tag)
end event

type cb_export from u_cb within tp_standard_report
integer x = 2917
integer y = 2348
integer height = 100
integer taborder = 51
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "...تصدير"
end type

event clicked;call super::clicked;u_cst_report_container uo

uo = uo_tabcontrol.ist_tabs[uo_tabcontrol.of_getselectedtab( )].ado_object

integer li_ret
String ls_file_nm,ls_path

GetFileSaveName(" حـــفظ", ls_path, ls_file_nm, "xls", "Excel Files (*.xls),*.xls" ,"C:\", 32770)

//li_ret = uf_save_dw_as_excel(uo.dw_report, ls_path)
//if li_ret = 1 then
//   //success
//   //...
//else
//   //fail
//   //...
//end if
end event

type dw_filter from u_dw within tp_standard_report
event ue_noscroll pbm_vscroll
string tag = "<NOZOOM>"
integer x = 41
integer y = 84
integer width = 3913
integer height = 316
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event ue_noscroll;return 1
end event

event buttonclicked;call super::buttonclicked;str_pass_parmeters lstr_parm
Long ll_idx , ll_array_count , ll_itr ,ll_id ,ll_bank


IF(dwo.name = "b_from_banks")Then

//	lstr_parm.string_parm[1] = "d_search_from_banks"
lstr_parm.string_parm[1] = "d_search_casher"
	OpenWithParm(w_search_banks , lstr_parm)
	
	lstr_parm = message.powerobjectparm

	IF(lstr_parm.long_array[1] > 0 )Then

     	dw_filter.SetItem( row , "from_bank_id" , lstr_parm.long_array[1] ) 
//		idw_master.SetItem( row , "modified_by" , gstr_user_info.login_id )
//     	idw_master.SetItem( row , "modified_dt" , gnv_services.uf_today() )

	End if
end if
//n_cst_client cs_client

//IF(dwo.name = "b_gui")THEN
//
//	csGui.of_generate_gui( is_report_type , "Filter", dw_filter)
//
//END IF
//
//if(dwo.name = "b_client")then
//
//	cs_client = Create n_cst_client
//
//	cs_client.il_x = w_menu.PointerX()
//	cs_client.il_y = w_menu.pointery()
//
//	lstr_parm = cs_client.of_select_client( ) 
//
//	Destroy cs_client 
//
//	IF lstr_parm.long_array[1] > 0 THEN
//
//   	This.SetItem( row , "cid" , lstr_parm.long_array[1] ) 
//			
//	ELSE
//
//		SetNull(ll_itr)
//   		This.SetItem( row , "cid" , ll_itr ) 
//			
//	End if
	
//End if

IF(dwo.name = "b_vehicles") THEN
 
		lstr_parm.string_parm[1] = "d_search_from_banks"
		lstr_parm.string_parm[2] = "-"
		/*************************************/
//		OpenWithParm(w_search_vehicles,lstr_parm)
		
		lstr_parm = Message.powerobjectparm
		
		IF lstr_parm.Long_array[1] = -1  THEN
			SetNull(ll_id)
		ELSE
//			ll_id = lstr_parm.Long_array[1]
			This.SetItem(1 , "carid" , lstr_parm.Long_array[1] )
		End if
		

END IF

IF(dwo.name = "b_sc") THEN

	lstr_parm.long_array[1] = 0

//	OpenWithParm(w_search_store_card_pls , lstr_parm)

	IF(gstr_parm.long_array[1] > 0 ) THEN

		    This.SetItem(1 , "sc_id" , gstr_parm.long_array[1] )
			 
	ELSE
			SetNull(gstr_parm.long_array[1] )
			This.SetItem(1 , "sc_id" , gstr_parm.long_array[1] )
	END IF
	
END IF

IF(dwo.name = "b_fid") THEN

	ll_idx = UpperBound( istr_parm.Long_parm )
	
	IF(ll_idx = 0) THEN

		istr_parm.Long_parm[1] = w_menu.pointerx( )
		istr_parm.Long_parm[2] = w_menu.pointery( )
		
	END IF
	
//	OpenWithParm( w_search_sc_family ,istr_parm)

	istr_parm = Message.PowerObjectParm
//	messagebox("",istr_parm.string_parm[1])
	IF upperbound(istr_parm.Long_array) > 0 THEN

		This.Modify( "b_2.enabled=0" )
		This.Modify( "fid_nm.background.color='553648127'" )
		This.SetItem(1 , "fid_nm" , istr_parm.string_parm[1] )
		
	ELSE

		This.Modify( "b_2.enabled=1" )
		This.Modify( "fid_nm.background.color='553648127'" )
		This.SetItem(1 , "fid_nm" , '')
		
	END IF
	
END IF

IF dwo.name = "b_inv_type" THEN
	
	ll_idx = UpperBound( istr_inv_type.string_parm )
	
//	IF(ll_idx = 0) THEN

		istr_inv_type.Long_parm[1] = w_menu.pointerx( )//il_x
		istr_inv_type.Long_parm[2] = w_menu.pointery( )//il_y
		
//	END IF
	
//	OpenWithParm( w_lookups ,istr_inv_type)

	istr_inv_type = Message.PowerObjectParm
	
	IF upperbound(istr_inv_type.str_array) > 0 THEN

//		This.Modify( "invoice_type.text='"+istr_inv_type.string_parm[2]+"'" )
	//	This.Modify( "fid_nm.background.color='553648127'" )
		This.SetItem(1 , "invoice_type" , Mid(istr_inv_type.string_parm[2] ,1 , Len(istr_inv_type.string_parm[2]) - 1) )
		
	ELSE

	This.Modify( "invoice_type.text=''" )
	//	This.Modify( "fid_nm.background.color='553648127'" )
		This.SetItem(1 , "invoice_type" , "" )
		
	END IF
END IF


IF dwo.Name = "b_emp" THEN
	SetNull(ll_id)
	
//	Open(w_search_employees)
	
	lstr_parm = Message.powerobjectparm

  	IF not IsNull(lstr_parm.long_array[1]) AND lstr_parm.long_array[1] > 0  THEN
		
		This.Modify( "brand_id.tabsequence=32766")
		This.Modify( "brand_id.background.color='553648127'" )
		This.Setitem( 1 , "sc_id"      		, lstr_parm.long_array[1] ) 
		This.SetItem( 1 , "brand_id" , ll_id )
	ELSE
		
		 
		This.Modify( "brand_id.background.color='"+String(rgb(255,255,255))+"'" )
		This.Modify( "brand_id.tabsequence=20")
		This.SetItem(1 , "brand_id" , ll_id )
		This.SetItem(1 , "sc_id" , ll_id )
		
	END IF	
END IF


IF dwo.name = "b_search_person" THEN
	
	SetNull(ll_id)
	
//	 open(w_search_person)
	
//	lstr_parm = Message.powerobjectparm

  	IF not IsNull(gstr_parm.long_array[1]) AND gstr_parm.long_array[1] > 0  THEN
		
		This.Modify( "brand_id.tabsequence=32766")
		This.Modify( "brand_id.background.color='553648127'" )
		This.Setitem( 1 , "person_nm"      		, gstr_parm.long_array[1] ) 
//		This.SetItem( 1 , "brand_id" , ll_id )
	ELSE
		
		 
		This.Modify( "brand_id.background.color='"+String(rgb(255,255,255))+"'" )
		This.Modify( "brand_id.tabsequence=20")
//		This.SetItem(1 , "brand_id" , ll_id )
		This.SetItem(1 , "person_nm" , ll_id )
		
	END IF
	
END IF
end event

event itemchanged;call super::itemchanged;
IF dwo.name = "date_op" THEN
	choose case Long(data)
		case 1
			This.SetItem( row , "from_dt" , Datetime(date(today()),time("00:00:00")) )
			This.SetItem( row , "to_dt" , Datetime(date(today()),time("23:59:59")))
		case 2
			This.SetItem( row , "from_dt" , Datetime(RelativeDate(date(today()),-1),time("00:00:00")) )
			This.SetItem( row , "to_dt" , Datetime(RelativeDate(date(today()),-1),time("23:59:59")))
		case 3
			This.SetItem( row , "from_dt" , Datetime(gnv_services. of_week_start_date(date(today())) ,time("00:00:00")) )
			This.SetItem( row , "to_dt" , Datetime(gnv_services.of_week_end_date(date(today())),time("23:59:59")))
		case 4
			This.SetItem( row , "from_dt" , Datetime(date("01/"+string(Month(today()))+"/"+String(year(today())) ),time("00:00:00")) )
			This.SetItem( row , "to_dt" , Datetime(RelativeDate(date("01/"+string(1 + Month(today()))+"/"+String(year(today())) ),-1),time("23:59:59")))
		case 5
			This.SetItem( row , "from_dt" , Datetime(gnv_services.of_Quarter_start_dt(today()) ,time("00:00:00")) )
			This.SetItem( row , "to_dt" , Datetime(gnv_services.of_Quarter_end_dt(today()),time("23:59:59")))
		case else
			This.SetItem( row , "from_dt" , Datetime(date(gstr_user_info.start_dt) ,time("00:00:00")) )
			This.SetItem( row , "to_dt" , Datetime(date(gstr_user_info.end_dt) ,time("23:59:59")))			
	end choose

END IF
end event

event lbuttondown;call super::lbuttondown;il_x = xpos
il_y = ypos
end event

event constructor;call super::constructor;This.DataObject = is_FilterDataObject
This.SetTransObject(SQLCA)



end event

type uo_tabcontrol from u_cst_tabcontrol within tp_standard_report
event destroy ( )
integer x = 14
integer y = 444
integer width = 3977
integer height = 1896
integer taborder = 41
end type

on uo_tabcontrol.destroy
call u_cst_tabcontrol::destroy
end on

type gb_filter from groupbox within tp_standard_report
integer x = 9
integer width = 3982
integer height = 424
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "بيانات البحث"
boolean righttoleft = true
end type

type pb_1 from picturebutton within tp_standard_report
boolean visible = false
integer x = 2487
integer y = 268
integer width = 123
integer height = 108
integer taborder = 71
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Applications\icons\hot\png\24x24\Info.png"
alignment htextalign = left!
end type

event clicked;n_cst_guidb lcs_csGUI

lcs_csGUI = Create n_cst_guidb
lcs_csGUI.of_load( is_report_type)
//lcs_csGUI.of_generate_gui( is_report_type , "Filter", dw_filter)
Destroy lcs_csGUI

end event

