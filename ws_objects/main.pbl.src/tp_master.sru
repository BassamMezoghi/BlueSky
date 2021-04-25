$PBExportHeader$tp_master.sru
forward
global type tp_master from u_cst_tabpage
end type
type cb_undo from u_cb within tp_master
end type
type dw_filter from u_dw within tp_master
end type
type dw_result from u_dw within tp_master
end type
type dw_header from u_dw within tp_master
end type
type cb_add from u_cb within tp_master
end type
type cb_save from u_cb within tp_master
end type
type cb_invoice from u_cb within tp_master
end type
type gb_search_list from groupbox within tp_master
end type
type gb_header from groupbox within tp_master
end type
type gb_search from groupbox within tp_master
end type
end forward

global type tp_master from u_cst_tabpage
integer width = 5499
integer height = 2776
cb_undo cb_undo
dw_filter dw_filter
dw_result dw_result
dw_header dw_header
cb_add cb_add
cb_save cb_save
cb_invoice cb_invoice
gb_search_list gb_search_list
gb_header gb_header
gb_search gb_search
end type
global tp_master tp_master

type variables
public:
		//Height percentage
		Long il_MasterHeight = 22
 		Long il_ListHeight = 55
		Long il_DetailsHeight = 13
		
		Long il_FilterHeight = 20
		Long il_ResultHeight = 70
		
		n_bll csBLL
				
		String is_post = "N"
		
private:
		CONSTANT Long il_padding = 20
		CONSTANT Long il_top_padding = 68
		CONSTANT Long il_bottom_padding = 200
		//bottom height
		CONSTANT Long il_BottomHeight = 150
		Long il_gb_search_width = 0 
		Long il_dw_result_width = 0
		boolean ib_change = False
		String is_sql

		Long il_NewWidth , il_NewHeight
		n_cst_guidb csGui
end variables

forward prototypes
public subroutine of_control (string ar_action)
public subroutine of_rtl (long newheight, long newwidth)
public subroutine of_ltr (long newheight, long newwidth)
public subroutine of_print_options (string ar_option)
end prototypes

public subroutine of_control (string ar_action);Choose case lower(ar_action)
	case "open"		
		cb_save.enabled        		= False 
		cb_undo.enabled        		= False
		cb_add.enabled         		= True
		cb_invoice.enabled			= True
	case "newinv"
		cb_save.enabled        		= True 
		cb_undo.enabled        		= True
		cb_add.enabled         		= False
		cb_invoice.enabled			= False
		dw_result.enabled			= False
	case "newband"		
		cb_add.enabled         		= False
		cb_save.enabled        		= True 
		cb_undo.enabled        		= True
		cb_invoice.enabled			= False
		dw_result.enabled			= False
	case "save"
		cb_save.enabled     		= False
		cb_undo.enabled        		= False
		cb_add.enabled      			= True
		cb_invoice.enabled			= True
		ib_change						= False
		dw_result.enabled			= True
	case "edit"
		cb_save.enabled 	= True
		cb_undo.enabled		= True	
		cb_add.enabled  		= False
		cb_invoice.enabled	= False
		dw_result.enabled	= False
End choose
end subroutine

public subroutine of_rtl (long newheight, long newwidth);Long ll_NewHeight

ll_NewHeight = NewHeight - il_BottomHeight

//positioning the seach row
gb_search.move(gb_header.x + gb_header.width + il_padding   , 0)
gb_search.resize(Long(csGui.of_filter( "Window", "gb_search.width", String( gb_search.width )) )  , Long(csGui.of_filter( "Window", "gb_search.height", String(NewHeight * ( il_FilterHeight / 100)) ) ))

//positioning the group header 
gb_header.Move( il_padding , 0 )
//gb_header.Resize( NewWidth - il_padding - gb_search.width , ( ll_NewHeight * ( il_MasterHeight / 100 ) ) ) /*gb_header.height*/ 
gb_header.Resize( NewWidth - il_padding * 3 - gb_search.width ,Long(csGui.of_filter( "Window", "gb_header.height", String( ( ll_NewHeight * ( il_MasterHeight / 100 ) )))))//, gb_header.height - (il_padding * 2) - il_top_padding //NewWidth - il_padding - gb_search.width , ( ll_NewHeight * ( il_MasterHeight / 100 ) ) ) /*gb_header.height*/ 

dw_header.Move( NewWidth - dw_header.width - gb_search.width - il_padding * 3  , il_top_padding )
dw_header.Resize( Long(csGui.of_filter( "Window", "dw_header.width", String(gb_header.width - il_padding * 3))) ,Long(csGui.of_filter( "Window", "dw_header.height", String(gb_header.height - (il_padding * 2) - il_top_padding))))//, gb_header.height - (il_padding * 2) - il_top_padding )


dw_filter.move( gb_search.x + il_padding    , gb_search.y + il_padding * 4)
dw_filter.Resize( gb_search.width - il_padding * 4  , gb_search.height - il_padding * 6)

gb_search_list.move( gb_search.x  , gb_search.y + gb_search.height  + il_padding  * 2   )
dw_result.move( gb_search_list.x + il_padding * 2 , gb_search_list.y + il_padding * 4 )

dw_result.bringtotop = True

IF il_gb_search_width = 0 THEN
	gb_search_list.resize( gb_search.width ,  NewHeight - gb_search.Height - il_padding )// ( il_ResultHeight / 100) - il_padding )
	dw_result.resize( gb_search_list.width - il_padding * 4, gb_search_list.height - il_padding * 6)
ELSE
	gb_search_list.resize( il_gb_search_width ,  NewHeight - gb_search.Height - il_padding )//* ( il_ResultHeight / 100) - il_padding )
	dw_result.resize( il_dw_result_width, gb_search_list.height - il_padding * 6)
END If


////positioning buttons
cb_add.move(dw_filter.x - cb_add.width - il_padding , NewHeight - cb_add.height - il_padding   )
cb_save.move(cb_add.x - il_padding - cb_save.width , NewHeight - cb_add.height - il_padding   )
cb_undo.move(cb_save.x - il_padding - cb_undo.width , NewHeight - cb_add.height - il_padding   )
cb_invoice.move(cb_undo.x - il_padding - cb_invoice.width , NewHeight - cb_add.height - il_padding   )

IF il_gb_search_width = 0 THEN il_gb_search_width = gb_search_list.width
IF il_dw_result_width= 0 THEN il_dw_result_width = dw_result.width

end subroutine

public subroutine of_ltr (long newheight, long newwidth);Long ll_NewHeight

ll_NewHeight = NewHeight - il_BottomHeight

//positioning the seach row
gb_search.Move( il_padding , 0 )
gb_search.Resize( gb_search.width , Long(csGui.of_filter( "Window", "gb_search.height", String(NewHeight * ( il_FilterHeight / 100)) ) ) )

dw_filter.Move( gb_search.x + il_padding , gb_search.y + il_padding * 4 )
dw_filter.Resize( gb_search.width - il_padding * 2 , gb_search.height -  il_padding * 6 ) // ( NewHeight * ( il_FilterHeight / 100)) )

gb_search_list.Move( gb_search.x , gb_search.y + gb_search.height + il_padding * 2  )
dw_result.Move( gb_search_list.x + il_padding * 2 , gb_search_list.y + il_padding + il_top_padding )

IF il_gb_search_width = 0 THEN
	gb_search_list.Resize( gb_search_list.width - il_padding,  NewHeight - gb_search.Height - il_padding)//( il_ResultHeight / 100) - il_padding )//newheight - dw_filter.height - il_bottom_padding
	dw_result.Resize( gb_search_list.width - il_padding * 4, gb_search_list.height - il_padding * 6)
ELSE
	gb_search_list.Resize( il_gb_search_width ,  NewHeight - gb_search.Height - il_padding ) //* ( il_ResultHeight / 100) - il_padding )
	dw_result.Resize( il_dw_result_width, gb_search_list.height - il_padding * 6)
END If

IF il_gb_search_width = 0 THEN il_gb_search_width = gb_search_list.width
IF il_dw_result_width= 0 THEN il_dw_result_width = dw_result.width

dw_filter.righttoleft 			= False
dw_result.righttoleft		= False
gb_search_list.righttoleft 	= False
gb_search.righttoleft 		= False

//positioning the group header 
gb_header.move( gb_search.x + gb_search.width + il_padding , 0)
gb_header.resize( newwidth - il_padding * 3 - gb_search.width , Long(csGui.of_filter( "Window", "gb_header.height", String(ll_NewHeight * ( il_MasterHeight / 100 )) ) ) )//( ll_NewHeight * ( il_MasterHeight / 100 ) ) ) /*gb_header.height*/ 
gb_header.righttoleft = False

dw_header.move( gb_header.x + il_padding  , il_top_padding + 10 )
dw_header.resize( gb_header.width - il_padding * 2 , gb_header.height - (il_padding * 2) - il_top_padding )
dw_header.righttoleft = False


////positioning buttons
cb_add.move(gb_header.x + il_padding , NewHeight - cb_add.height - il_padding   )
cb_save.move(cb_add.x + il_padding + cb_save.width , NewHeight - cb_add.height - il_padding   )
cb_undo.move(cb_save.x + il_padding + cb_undo.width , NewHeight - cb_add.height - il_padding   )
cb_invoice.move(cb_undo.x + il_padding + cb_invoice.width , NewHeight - cb_add.height - il_padding   )

end subroutine

public subroutine of_print_options (string ar_option);IF ar_option = "preview" THEN
	
	csBLL.of_invoice( )
	
ELSE
	
	csBLL.of_print( )
	
END IF
end subroutine

on tp_master.create
int iCurrent
call super::create
this.cb_undo=create cb_undo
this.dw_filter=create dw_filter
this.dw_result=create dw_result
this.dw_header=create dw_header
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_invoice=create cb_invoice
this.gb_search_list=create gb_search_list
this.gb_header=create gb_header
this.gb_search=create gb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_undo
this.Control[iCurrent+2]=this.dw_filter
this.Control[iCurrent+3]=this.dw_result
this.Control[iCurrent+4]=this.dw_header
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_invoice
this.Control[iCurrent+8]=this.gb_search_list
this.Control[iCurrent+9]=this.gb_header
this.Control[iCurrent+10]=this.gb_search
end on

on tp_master.destroy
call super::destroy
destroy(this.cb_undo)
destroy(this.dw_filter)
destroy(this.dw_result)
destroy(this.dw_header)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_invoice)
destroy(this.gb_search_list)
destroy(this.gb_header)
destroy(this.gb_search)
end on

event resize;call super::resize;il_NewWidth = NewWidth
il_NewHeight = NewHeight

IF gs_Lan = "AR" THEN
	of_rtl(il_NewHeight , il_NewWidth)
ELSE
	of_ltr(il_NewHeight , il_NewWidth)
END IF

end event

event ue_postconstructor;call super::ue_postconstructor;
csBLL.of_initial( dw_filter, dw_result, dw_header)


gb_header.text 		= csGui.of_filter("Window" , "gb_header.text" , "بيانات الفاتورة")
gb_search.text 		= csGui.of_filter("Window" , "gb_search.text" , "بيانات البحث")
cb_Add.text  			= csGui.of_filter("Window" , "cb_add.text" , "إضــافــة")
cb_Save.text  			= csGui.of_filter("Window" , "cb_save.text" , "حفـــظ")
cb_undo.text  			= csGui.of_filter("Window" , "cb_undo.text" , "تراجع")
cb_Invoice.text  		= csGui.of_filter("Window" , "cb_invoice.text" , "طبـاعة")
gb_search_list.text  = csGui.of_filter("Window" , "gb_search_list.text" , "نتائج البحث")

end event

event constructor;call super::constructor;csGui = Create n_cst_guidb
csGui.of_load( csBLL.is_SystemPart )
end event

type cb_undo from u_cb within tp_master
integer x = 2171
integer y = 2664
integer width = 466
integer height = 100
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = ""
end type

event clicked;call super::clicked;Long ll_row,ll_item_row

IF MessageBox("تنبيه","سيتم التراجع عن التغيرات التى لم يتم حفظها~n هل انت متأكد من التراجع ؟", information! , yesno!) = 1 THEN

	dw_header.setredraw( False )
	dw_Result.setredraw( False )
	
	ll_row = dw_result.GetRow()
		
	csBll.of_result_retrieve( )
	csBll.of_master_retrieve()
	dw_Result.scrolltorow( ll_row )
	
	ib_change           = False

	of_control("save")
	
	dw_header.setredraw( True )
	dw_Result.setredraw( True )
		
	Return 1
	
ELSE
	
	Return 0
	
END IF
end event

type dw_filter from u_dw within tp_master
event ue_noscroll pbm_vscroll
integer x = 3694
integer y = 88
integer width = 1755
integer height = 808
integer taborder = 50
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event ue_noscroll;return 1
end event

event buttonclicked;call super::buttonclicked;csBLL.of_filter_btn_clicked(dwo , row)
end event

event bst_keydown;CHOOSE CASE key
  CASE KeyPageUp!,KeyPageDown!,KeyUpArrow!,KeyDownArrow!
    This.AcceptText()
    RETURN 1
END CHOOSE

IF( KeyDown(KeyControl!) and ( KeyDown(80) or KeyDown(112) )   ) THEN

	csBll.of_print( )
	Return 1
END IF 

IF( KeyDown(KeyEnter!) )THEN

	dw_filter.Accepttext( )
	dw_result.SetSQLSelect( csBll.of_search() )
	dw_result.SetTransObject(SQLCA)

	dw_result.retrieve( )

	IF csBll.is_shareddata = "Y" THEN
		dw_result.sharedata( dw_header )
	END IF
	
	csBll.of_result_retrieve( )
	
END IF

IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_header.setFocus( )
	
END IF


IF KeyDown(KeyF1!) THEN
	
//	pb_hlp.event clicked( )
	
END IF
end event

type dw_result from u_dw within tp_master
integer x = 3685
integer y = 1060
integer width = 1765
integer height = 1660
integer taborder = 50
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;dw_filter.accepttext( )
csBLL.of_result_btn_clicked(dwo,row)

//str_pass_parmeters lstr_parm
//
//dw_filter.accepttext( )
//
//IF dwo.name = "b_search" THEN
//
//	dw_filter.Accepttext( )
//	dw_result.SetSQLSelect( csBll.of_search() )
//	dw_result.SetTransObject(SQLCA)
//
//	dw_result.retrieve( )
//
//	dw_result.sharedata( dw_header )
//	
//	csBll.of_result_retrieve( )
//
//END IF
//
//IF dwo.name = "b_new" THEN
//
//	dw_filter.retrieve( 0 )
//	dw_filter.scrolltorow( dw_filter.insertrow( 1 ) )
//	
//END IF
//
end event

event rowfocuschanging;call super::rowfocuschanging;IF currentrow <>  newrow AND currentrow > 0 THEN csBLL.of_result_row_change(currentrow , newrow)



end event

type dw_header from u_dw within tp_master
event of_handle_enterkay pbm_dwnprocessenter
event ue_noscroll pbm_vscroll
integer x = 608
integer y = 88
integer width = 2939
integer height = 1776
integer taborder = 50
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean righttoleft = true
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event of_handle_enterkay;Send(Handle(this),256,9,Long(0,0))
RETURN 1
end event

event ue_noscroll;return 1
end event

event buttonclicked;call super::buttonclicked;Long ll_dealer_id
Long ll_bank

str_pass_parmeters lstr_parm
n_cst_bank cs_bank

ll_bank = 0	
	
csBll.of_master_btn_clicked( dwo, row) 

If(dwo.name = "b_bank")Then

		cs_bank = Create n_cst_bank
		ll_bank = cs_bank.of_select_bank()
		if(not IsNull(ll_bank))Then
			This.SetItem(row , "bank_id" , ll_bank)
			of_control("Edit")
		end if
		destroy cs_bank
	
End if

If(dwo.name = "b_bank_")Then

		cs_bank = Create n_cst_bank
		ll_bank = cs_bank.of_select_bank()
		if(not IsNull(ll_bank))Then
			This.SetItem(row , "bank_id_" , ll_bank)
			of_control("Edit")
		end if
		destroy cs_bank
	
End if
end event

event editchanged;call super::editchanged;ib_change = True

of_control("Edit")



end event

event itemchanged;call super::itemchanged;csBLL.of_master_itemchange(dwo ,row , data)

of_control("Edit")
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;csBLL.of_master_PostInsert( al_row )

of_control("NewInv")
end event

event pfc_preupdate;call super::pfc_preupdate;Return csBLL.of_master_preUpdate(This.GetRow())
end event

event pfc_postupdate;call super::pfc_postupdate;csBLL.of_master_postupdate( )

of_control("Save")

Return 1
end event

event bst_keydown;call super::bst_keydown;CHOOSE CASE key
  CASE KeyPageUp!,KeyPageDown!,KeyUpArrow!,KeyDownArrow!
    This.AcceptText()
    RETURN 1
END CHOOSE
RETURN 0
end event

type cb_add from u_cb within tp_master
integer x = 3131
integer y = 2664
integer width = 466
integer height = 100
integer taborder = 120
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = ""
boolean default = true
end type

event clicked;call super::clicked;

dw_header.Event pfc_insertrow()

csBll.ib_change = True

end event

type cb_save from u_cb within tp_master
integer x = 2651
integer y = 2664
integer width = 466
integer height = 100
integer taborder = 110
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = ""
end type

event clicked;call super::clicked;Long ll_row

ll_row = dw_result.GetRow()

IF csBLL.of_master_validation( ll_row ) < 0 THEN Return csBLL.Failure

IF dw_header.event pfc_update( True , False) < 0 THEN Return csBLL.Failure

Commit Using SQLCA;

IF SQLCA.sqlcode = 0 THEN
	
	dw_header.ResetUpdate( )
			
	csBLL.ib_change           = False
	of_control("save")
	Return csBLL.Success

ELSE
	RollBack Using SQLCA;
	Return csBLL.Failure
End if
end event

type cb_invoice from u_cb within tp_master
integer x = 1691
integer y = 2664
integer width = 466
integer height = 100
integer taborder = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = ""
end type

event clicked;call super::clicked;csBLL.of_invoice( )
//m_print_options NewMenu
	
//NewMenu = CREATE m_print_options
//NewMenu.PopMenu(w_menu.PointerX(), w_menu.pointery())
end event

type gb_search_list from groupbox within tp_master
integer x = 3643
integer y = 968
integer width = 1842
integer height = 1784
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "نتيجة البحث"
boolean righttoleft = true
end type

type gb_header from groupbox within tp_master
integer x = 571
integer width = 3026
integer height = 1896
integer taborder = 60
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

type gb_search from groupbox within tp_master
integer x = 3657
integer width = 1833
integer height = 940
integer taborder = 60
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

