$PBExportHeader$u_cst_report_container.sru
forward
global type u_cst_report_container from u_cst_tabpage
end type
type dw_report from u_dw within u_cst_report_container
end type
end forward

global type u_cst_report_container from u_cst_tabpage
integer width = 3182
integer height = 1648
dw_report dw_report
end type
global u_cst_report_container u_cst_report_container

type variables
Public :
String is_dataObject
str_pass_parmeters istr_parm
String is_Type = "none"
end variables

on u_cst_report_container.create
int iCurrent
call super::create
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
end on

on u_cst_report_container.destroy
call super::destroy
destroy(this.dw_report)
end on

event resize;call super::resize;//gb_2.resize( newwidth , newheight )
//gb_2.move( 0, 0)

dw_report.resize(newwidth - 10 , newheight - 10)
dw_report.move(0,0)
end event

type dw_report from u_dw within u_cst_report_container
event ue_leftbuttonup pbm_dwnlbuttonup
string tag = "<NOZOOM>"
integer x = 23
integer y = 40
integer width = 3127
integer height = 1568
integer taborder = 10
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;This.settransobject( SQLCA )


end event

event doubleclicked;call super::doubleclicked;n_cst_report_tabpage_services cs_service

IF is_Type <> "none" THEN

cs_service = CREATE n_cst_report_tabpage_services
choose case is_Type
	case "inventory"
			
			cs_service.of_dbclicked_inventory( row , dw_report)

	case "inv_stdy"
			
			cs_service.of_dbclick_inv_stdy( row , dw_report)
	case "inventory_"
		cs_service.of_dbclicked_inventory_( row , dw_report)
end choose

Destroy cs_service

END If
end event

event buttonclicked;call super::buttonclicked;u_cst_tabpage page

IF row <= 0 THEN Return

IF dwo.name = "b_view_tb" THEN

	page = w_menu.uo_tabcontrol.event gettabpage("387")
	page.dynamic of_detailed_tb(this.getItemString(row , "da_items_adid") , this.getItemString(row , "account_code"))
	
	
END IF
end event

