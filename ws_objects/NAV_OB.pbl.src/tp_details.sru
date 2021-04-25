$PBExportHeader$tp_details.sru
forward
global type tp_details from u_cst_tabpage
end type
type dw_details from u_dw within tp_details
end type
type gb_title from groupbox within tp_details
end type
end forward

global type tp_details from u_cst_tabpage
integer width = 2775
integer height = 1280
dw_details dw_details
gb_title gb_title
end type
global tp_details tp_details

type variables
public:
	Long il_id
	String is_DataObject
	String is_title
	String is_type = ""
	String is_type_Column = ""
	String is_MasterKey = "BID"
	u_cst_tabpage MasterPage
end variables

forward prototypes
public subroutine of_desgin ()
end prototypes

public subroutine of_desgin ();Long ll_max, ll_cnt
String ls_col, ls_type

dw_details.Modify( "datawindow.color=15780518" )
dw_details.Modify( "datawindow.brushmode=2" )
dw_details.Modify( "datawindow.transparency=11" )
dw_details.Modify( "datawindow.gradient.angle=0" )
dw_details.Modify( "datawindow.gradient.color=16777215" )
dw_details.Modify( "datawindow.gradient.focus=51" )
dw_details.Modify( "datawindow.gradient.scale=86" )
dw_details.Modify( "datawindow.gradient.spread=83" )
dw_details.Modify( "datawindow.gradient.transparency=0" )

dw_details.Modify( "header.color='536870912'" )
dw_details.Modify( "header.brushmode=0" )
dw_details.Modify( "header.transparency=0" )
dw_details.Modify( "header.gradient.angle=0" )
dw_details.Modify( "header.gradient.color=8421504" )
dw_details.Modify( "header.gradient.focus=0" )
dw_details.Modify( "header.gradient.scale=100" )
dw_details.Modify( "header.gradient.spread=100" )
dw_details.Modify( "header.gradient.transparency=0" )

dw_details.Modify( "footer.color='536870912'" )
dw_details.Modify( "footer.brushmode=0" )
dw_details.Modify( "footer.transparency=0" )
dw_details.Modify( "footer.gradient.angle=0" )
dw_details.Modify( "footer.gradient.color=8421504" )
dw_details.Modify( "footer.gradient.focus=0" )
dw_details.Modify( "footer.gradient.scale=100" )
dw_details.Modify( "footer.gradient.spread=100" )
dw_details.Modify( "footer.gradient.transparency=0" )

dw_details.Modify( "detail.color='536870912~tif( mod(getrow() , 2) = 1 , rgb(176,226,255) , 553648127 )'" )
dw_details.Modify( "detail.brushmode=0" )
dw_details.Modify( "detail.transparency=42" )
dw_details.Modify( "detail.gradient.angle=0" )
dw_details.Modify( "detail.gradient.color=16777215" )
dw_details.Modify( "detail.gradient.focus=0" )
dw_details.Modify( "detail.gradient.scale=100" )
dw_details.Modify( "detail.gradient.spread=100" )
dw_details.Modify( "detail.gradient.transparency=0" )

end subroutine

on tp_details.create
int iCurrent
call super::create
this.dw_details=create dw_details
this.gb_title=create gb_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_details
this.Control[iCurrent+2]=this.gb_title
end on

on tp_details.destroy
call super::destroy
destroy(this.dw_details)
destroy(this.gb_title)
end on

event resize;call super::resize;gb_title.move( 0, 0)
gb_title.resize( newwidth, newheight )

dw_details.move( gb_title.x + 10 , gb_title.y + 10 )
dw_details.resize( gb_title.width , gb_title.height )
end event

event ue_postconstructor;call super::ue_postconstructor;//dw_details.DataObject = is_DataObject
//dw_details.SetTransObject(SQLCA)
////dw_details.retrieve( il_emid )

gb_title.text  = is_title

//of_desgin()

gnv_services.of_color(dw_details)


IF dw_details.tag <> "" THEN
	
	IF dw_details.tag = "d" THEN
		dw_details.Modify( "amount.tabsequence=32766" )
		//dw_details.Modify( "ex_rate.tabsequance=32766" )
		//dw_details.Modify( "amount_local.tabsequance=32766" )
		//dw_details.Modify( "commission.tabsequance=32766" )
		dw_details.Modify( "transaction_dt.tabsequence=32766" )
		dw_details.Modify( "sweft_code.tabsequence=32766" )
		dw_details.Modify( "iban.tabsequence=32766" )
	ELSE
		//dw_details.Modify( "amount.tabsequance=32766" )
		dw_details.Modify( "ex_rate.tabsequence=32766" )
		dw_details.Modify( "amount_local.tabsequence=32766" )
		dw_details.Modify( "commission.tabsequence=32766" )
		//dw_details.Modify( "transaction_dt.tabsequance=32766" )
		//dw_details.Modify( "swift_code.tabsequance=32766" )
		//dw_details.Modify( "iban.tabsequance=32766" )
		
	END IF
END IF
end event

type dw_details from u_dw within tp_details
integer x = 37
integer y = 80
integer width = 2697
integer height = 1148
integer taborder = 20
boolean hscrollbar = true
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;IF dwo.name = "b_add" and this.tag <> "d"  THEN
	dw_details.event pfc_insertrow( )
	MasterPage.triggerevent( "of_control_edit" ) //of_control("edit")
END IF

IF dwo.name = "b_del" and this.tag <> "e" THEN
	
		This.SetItem( row , "Active_fg" 					, "N")
		This.Setitem( row , "Last_modified_by" 		, gstr_user_info.login_id )
		This.Setitem( row , "Last_modified_dt" 		, gnv_services.uf_today( ) )	
	   This.SetFilter("Active_fg = 'Y'")
		This.Filter( )
		MasterPage.triggerevent( "of_control_edit" ) //of_control("edit")
		
END IF
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;
	This.Setitem( al_row , "Active_fg"        			, "Y")
	This.SetItem( al_row , "CREATED_BY" 			, gstr_user_info.login_id )
	This.SetItem( al_row , "CREATED_DT" 			, gnv_services.uf_today( ) )		
	
	IF is_type = "" THEN
	
		This.Setitem( al_row , is_type_Column , is_type)

	END IF

end event

event itemchanged;call super::itemchanged;This.Setitem( row , "Last_modified_by" 		, gstr_user_info.login_id )
This.Setitem( row , "Last_modified_dt" 		, gnv_services.uf_today( ) )	
MasterPage.triggerevent( "of_control_edit" ) //of_control("edit")



end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_row , ll_rowCount

ll_rowCount = This.RowCount()

IF il_id > 0 and ll_rowCount > 0 THEN

	FOR ll_row = 1 To ll_rowCount 
		
		IF IsNull(This.GetItemNumber( ll_row , is_MasterKey ) ) THEN
			This.SetItem( ll_row , is_MasterKey			, il_id)
		END IF
		
		
		
		
	NEXT

END IF

Return Success
end event

type gb_title from groupbox within tp_details
integer x = 9
integer width = 2757
integer height = 1264
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean righttoleft = true
end type

