$PBExportHeader$tp_master_details.sru
forward
global type tp_master_details from u_cst_tabpage
end type
type cb_special from u_cb within tp_master_details
end type
type dw_bill_header from u_dw within tp_master_details
end type
type dw_result from u_dw within tp_master_details
end type
type gb_search_list from groupbox within tp_master_details
end type
type gb_header from groupbox within tp_master_details
end type
type hpb_progress from hprogressbar within tp_master_details
end type
type dw_filter from u_dw within tp_master_details
end type
type dw_bill_items from u_dw within tp_master_details
end type
type dw_details from u_dw within tp_master_details
end type
type gb_items from groupbox within tp_master_details
end type
type cb_undo from u_cb within tp_master_details
end type
type cb_add from u_cb within tp_master_details
end type
type cb_save from u_cb within tp_master_details
end type
type cb_invoice from u_cb within tp_master_details
end type
type gb_search from groupbox within tp_master_details
end type
type pb_hlp from bs_u_pb within tp_master_details
end type
end forward

global type tp_master_details from u_cst_tabpage
integer width = 5632
integer height = 2604
string text = ""
string picturename = "C:\Applications\PB 12.5\Tawasul\Lap\cube_config.ico"
event keydown pbm_keyup
cb_special cb_special
dw_bill_header dw_bill_header
dw_result dw_result
gb_search_list gb_search_list
gb_header gb_header
hpb_progress hpb_progress
dw_filter dw_filter
dw_bill_items dw_bill_items
dw_details dw_details
gb_items gb_items
cb_undo cb_undo
cb_add cb_add
cb_save cb_save
cb_invoice cb_invoice
gb_search gb_search
pb_hlp pb_hlp
end type
global tp_master_details tp_master_details

type variables
public:
		n_bll csBLL
		String is_MasterGroupTitle = ""
		
		//Height percentage
		Long il_MasterHeight = 22
 		Long il_ListHeight = 55
		Long il_DetailsHeight = 13
		
		Long il_FilterHeight = 20
		Long il_ResultHeight = 70
		
private:
		CONSTANT Long il_padding = 20
		CONSTANT Long il_top_padding = 68
		CONSTANT Long il_bottom_padding = 200
		//bottom height
		CONSTANT Long il_BottomHeight = 150
		Long il_gb_search_width = 0 
		Long il_dw_result_width = 0
		Long il_NewWidth , il_NewHeight
		n_cst_guidb csGui






end variables

forward prototypes
public subroutine uf_cal_total ()
public subroutine of_control (string ar_action)
public function boolean of_canclose ()
public subroutine of_save ()
public subroutine of_rtl (long newheight, long newwidth)
public subroutine of_ltr (long newheight, long newwidth)
public subroutine of_past ()
end prototypes

event keydown;IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_bill_header.setFocus( )
	Return 1
END IF

IF KeyDown(KeyF3!)  and cb_save.enabled  THEN
	cb_save.event clicked( )
	dw_bill_header.setFocus( )
	Return 1
END IF



Return 0
end event

public subroutine uf_cal_total ();Decimal ld_total,ld_old_total
Long ll_row,ll_RowCount

ll_row = dw_bill_header.GetRow()

ld_old_total = dw_bill_header.GetItemDecimal( ll_row , "total_amount" )

IF IsNull(ld_old_total) Then ld_old_total = 0.0

ld_total = 0.0

ll_RowCount = dw_bill_items.RowCount()

IF( ll_RowCount > 0)Then

	For ll_row=1 To ll_RowCount
		
		ld_total += dw_bill_items.GetItemDecimal(ll_row , "compute_2")
		
	Next

End if

IF ld_old_total = ld_total THEN Return 
	
ll_row = dw_bill_header.GetRow()

dw_bill_header.SetItem(ll_row , "total_amount" , ld_total)
dw_bill_header.SetItem(ll_row , "last_modified_by" , gstr_user_info.login_id )
dw_bill_header.SetItem(ll_row , "last_modified_dt" , datetime(today(),now()) )


end subroutine

public subroutine of_control (string ar_action);Choose case lower(ar_action)
	case "open"		
		cb_save.enabled        		= False 
		cb_undo.enabled        		= False
		cb_add.enabled         		= True
		cb_invoice.enabled			= True
		cb_special.enabled			= True
	case "newinv"
		cb_save.enabled        		= True 
		cb_undo.enabled        		= True
		cb_add.enabled         		= False
		cb_invoice.enabled			= False
		cb_special.enabled			= False
		dw_result.enabled			= False
	case "newband"		
		cb_add.enabled         		= False
		cb_save.enabled        		= True 
		cb_undo.enabled        		= True
		cb_invoice.enabled			= False
		cb_special.enabled			= False
		dw_result.enabled			= False
		dw_details.setfocus( )
	case "save"
		cb_save.enabled     		= False
		cb_undo.enabled        		= False
		cb_add.enabled      			= True
		cb_invoice.enabled			= True
		cb_special.enabled			= True
		csBLL.ib_change			= False
		dw_result.enabled			= True
//		dw_bill_items.enabled		= True
	case "edit"
		cb_save.enabled 	= True
		cb_undo.enabled		= True	
		cb_add.enabled  		= False
		cb_invoice.enabled	= False
		cb_special.enabled	= False
		dw_result.enabled	= False
//		dw_bill_items.enabled		= False
End choose
end subroutine

public function boolean of_canclose ();Long ll_msg

if(csBLL.ib_change)then
	ll_msg =  gnv_msg.of_message(26) //MessageBox("تنبيه","هل تريد حفظ التغيرات ؟",information!,yesnocancel!) 
	
  	Choose Case ll_msg
		CASE 1 
					IF cb_save.event clicked( ) = csBLL.Success THEN Return True
					Return False
		CASE 2
				Return True
		CASE 3
				Return False
	End Choose
	
Else
	
	Return True
	
End if


end function

public subroutine of_save ();cb_save.event clicked( )
end subroutine

public subroutine of_rtl (long newheight, long newwidth);Long ll_NewHeight

ll_NewHeight = NewHeight - il_BottomHeight

//positioning the seach row
gb_search.move(gb_header.x + gb_header.width + il_padding   , 0)
gb_search.resize(gb_search.width  , Long(csGui.of_filter( "Window", "gb_search.height", String(NewHeight * ( il_FilterHeight / 100)) ) ))

dw_filter.move( gb_search.x + il_padding    , gb_search.y + il_padding * 4)
dw_filter.Resize( gb_search.width - il_padding * 2 , gb_search.height - il_padding * 6)

gb_search_list.move( gb_search.x  , gb_search.y + gb_search.height  + il_padding  * 2   )
dw_result.move( gb_search_list.x + il_padding * 2 , gb_search_list.y + il_padding * 4 )

dw_result.bringtotop = True

//positioning the group header 
gb_header.Move( il_padding , 0 )
gb_header.Resize( NewWidth - il_padding * 3 - gb_search.width ,Long(csGui.of_filter( "Window", "gb_header.height", String( ( ll_NewHeight * ( il_MasterHeight / 100 ) )))))

dw_bill_header.Move( NewWidth - dw_bill_header.width - gb_search.width - il_padding * 3  , il_top_padding )
dw_bill_header.Resize( Long(csGui.of_filter( "Window", "dw_bill_header.width", String(gb_header.width - il_padding * 3))) ,Long(csGui.of_filter( "Window", "dw_bill_header.height", String(gb_header.height - (il_padding * 2) - il_top_padding))))//, gb_header.height - (il_padding * 2) - il_top_padding )

IF il_gb_search_width = 0 THEN
	gb_search_list.resize( gb_search_list.width - il_padding,  NewHeight - gb_search.Height - il_padding ) // ( il_ResultHeight / 100) - il_padding )
	dw_result.resize( gb_search_list.width - il_padding * 4, gb_search_list.height - il_padding * 6)
ELSE
	gb_search_list.resize( il_gb_search_width ,  NewHeight - gb_search.Height - il_padding ) //* ( il_ResultHeight / 100) - il_padding )
	dw_result.resize( il_dw_result_width, gb_search_list.height - il_padding * 6)
END If

//positioning the details
dw_details.resize( Long(csGui.of_filter( "Window", "dw_details.width", String(dw_bill_items.width)))  ,  Long(csGui.of_filter( "Window", "dw_details.height", String(dw_bill_items.height))) ) 

//positioning item datawindow
gb_items.move(gb_header.x , gb_header.y + gb_header.height + il_padding  )
//gb_items.resize( newwidth - il_padding - gb_search.width ,  ( ll_NewHeight * ( il_ListHeight / 100 ) )  - dw_details.height  - gb_header.height - il_bottom_padding )

gb_items.resize( newwidth - il_padding - gb_search.width ,  NewHeight  - dw_details.height  - gb_header.height - il_bottom_padding )

dw_details.move( NewWidth - dw_details.width - gb_search.width - il_padding * 2  , gb_items.y + gb_items.height + il_padding )

dw_bill_items.move( gb_items.x + il_padding * 2 , gb_items.y + il_padding + il_top_padding)
dw_bill_items.resize( gb_items.width - il_padding * 4 , gb_items.height - (il_padding * 2) - il_top_padding )

////positioning buttons
cb_add.move(dw_filter.x - cb_add.width - il_padding , NewHeight - cb_add.height - il_padding   )
cb_save.move(cb_add.x - il_padding - cb_save.width , NewHeight - cb_add.height - il_padding   )
cb_undo.move(cb_save.x - il_padding - cb_undo.width , NewHeight - cb_add.height - il_padding   )
cb_invoice.move(cb_undo.x - il_padding - cb_invoice.width , NewHeight - cb_add.height - il_padding   )
cb_special.move(cb_invoice.x - il_padding - cb_special.width , NewHeight - cb_add.height - il_padding   )

pb_hlp.move( il_padding , NewHeight - pb_hlp.height )

hpb_progress.Move(NewWidth * 0.3 , NewHeight  / 3)
hpb_progress.resize( NewWidth * 0.3  ,hpb_progress.height ) 

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

dw_bill_header.move( gb_header.x + il_padding  , il_top_padding + 10 )
dw_bill_header.resize( gb_header.width - il_padding * 2 , gb_header.height - (il_padding * 2) - il_top_padding )
dw_bill_header.righttoleft = False

//positioning the details
//dw_details.move( gb_header.x + il_padding * 2  , gb_items.y + gb_items.height + il_padding )
dw_details.resize( dw_bill_items.width  , Long(csGui.of_filter( "Window", "dw_details.height", String(ll_NewHeight * ( il_MasterHeight / 100 )) ) ) )//( ll_NewHeight * ( il_DetailsHeight / 100 ) ) )
dw_details.righttoleft = False

//positioning item datawindow
gb_items.move(gb_header.x , gb_header.y + gb_header.height + il_padding  )
gb_items.resize( newwidth - il_padding - gb_search.width , ll_NewHeight - gb_header.height - dw_details.height )//( ll_NewHeight * ( il_ListHeight / 100 ) )  /*- dw_details.height  - gb_header.height - il_bottom_padding */)
gb_items.righttoleft = False

dw_bill_items.move( gb_items.x + il_padding * 2 , gb_items.y + il_padding + il_top_padding)
dw_bill_items.resize( gb_items.width - il_padding * 4 , gb_items.height - (il_padding * 2) - il_top_padding )
dw_bill_items.righttoleft = False

//positioning the details
dw_details.move( gb_header.x + il_padding * 2  , gb_items.y + gb_items.height + il_padding )

////positioning buttons
cb_add.move(gb_header.x + il_padding , NewHeight - cb_add.height - il_padding   )
cb_save.move(cb_add.x + il_padding + cb_save.width , NewHeight - cb_add.height - il_padding   )
cb_undo.move(cb_save.x + il_padding + cb_undo.width , NewHeight - cb_add.height - il_padding   )
cb_invoice.move(cb_undo.x + il_padding + cb_invoice.width , NewHeight - cb_add.height - il_padding   )
cb_special.move(cb_invoice.x + il_padding + cb_special.width , NewHeight - cb_add.height - il_padding   )

pb_hlp.move( NewWidth - pb_hlp.width , NewHeight - pb_hlp.height )

hpb_progress.Move(NewWidth * 0.3 , NewHeight  / 3)
hpb_progress.resize( NewWidth * 0.3  ,hpb_progress.height ) 


end subroutine

public subroutine of_past ();
end subroutine

on tp_master_details.create
int iCurrent
call super::create
this.cb_special=create cb_special
this.dw_bill_header=create dw_bill_header
this.dw_result=create dw_result
this.gb_search_list=create gb_search_list
this.gb_header=create gb_header
this.hpb_progress=create hpb_progress
this.dw_filter=create dw_filter
this.dw_bill_items=create dw_bill_items
this.dw_details=create dw_details
this.gb_items=create gb_items
this.cb_undo=create cb_undo
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_invoice=create cb_invoice
this.gb_search=create gb_search
this.pb_hlp=create pb_hlp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_special
this.Control[iCurrent+2]=this.dw_bill_header
this.Control[iCurrent+3]=this.dw_result
this.Control[iCurrent+4]=this.gb_search_list
this.Control[iCurrent+5]=this.gb_header
this.Control[iCurrent+6]=this.hpb_progress
this.Control[iCurrent+7]=this.dw_filter
this.Control[iCurrent+8]=this.dw_bill_items
this.Control[iCurrent+9]=this.dw_details
this.Control[iCurrent+10]=this.gb_items
this.Control[iCurrent+11]=this.cb_undo
this.Control[iCurrent+12]=this.cb_add
this.Control[iCurrent+13]=this.cb_save
this.Control[iCurrent+14]=this.cb_invoice
this.Control[iCurrent+15]=this.gb_search
this.Control[iCurrent+16]=this.pb_hlp
end on

on tp_master_details.destroy
call super::destroy
destroy(this.cb_special)
destroy(this.dw_bill_header)
destroy(this.dw_result)
destroy(this.gb_search_list)
destroy(this.gb_header)
destroy(this.hpb_progress)
destroy(this.dw_filter)
destroy(this.dw_bill_items)
destroy(this.dw_details)
destroy(this.gb_items)
destroy(this.cb_undo)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_invoice)
destroy(this.gb_search)
destroy(this.pb_hlp)
end on

event ue_postconstructor;call super::ue_postconstructor;cb_special.visible 	= csBLL.ib_special_btn_visible

hpb_progress.visible = True
IF csbll.is_detail_dataobject = "" THEN
	csBLL.of_initial( dw_filter, dw_result, dw_bill_header, dw_bill_items)
ELSE
	csBLL.of_initial( dw_filter, dw_result, dw_bill_header, dw_bill_items, dw_details , hpb_progress)
END IF
hpb_progress.visible = False

gb_header.text 		= csGui.of_filter("Window" , "gb_header.text" , "بيانات الفاتورة")
gb_search.text 		= csGui.of_filter("Window" , "gb_search.text" , "بيانات البحث")
cb_special.text  		= csGui.of_filter("Window" , "cb_special.text" , "إصدار سند قبض")
cb_Add.text  			= csGui.of_filter("Window" , "cb_add.text" , "إضــافــة")
cb_Save.text  			= csGui.of_filter("Window" , "cb_save.text" , "حفـــظ")
cb_undo.text  			= csGui.of_filter("Window" , "cb_undo.text" , "تراجع")
cb_Invoice.text  		= csGui.of_filter("Window" , "cb_invoice.text" , "فاتـــورة")
gb_search_list.text  = csGui.of_filter("Window" , "gb_search_list.text" , "نتائج البحث")
gb_items.text  		= csGui.of_filter("Window" , "gb_items.text" , "بنود الفاتورة")

dw_filter.SetFocus( )

end event

event resize;call super::resize;il_NewWidth = NewWidth
il_NewHeight = NewHeight


IF gs_Lan = "AR" THEN
	of_rtl(il_NewHeight , il_NewWidth)
ELSE
	of_ltr(il_NewHeight , il_NewWidth)
END IF

//IF gstr_user_info.login_id = "support" THEN
//	pb_1.visible = True
//ELSE
//	pb_1.visible = False
//END IF
end event

event constructor;call super::constructor;csGui = Create n_cst_guidb
csGui.of_load( csBLL.is_SystemPart )

end event

type cb_special from u_cb within tp_master_details
boolean visible = false
integer x = 933
integer y = 2472
integer width = 544
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = ""
end type

event clicked;call super::clicked;IF csBLL.of_special_btn()  <> csBLL.no_action THEN
	//of_control("edit")
END IF
end event

type dw_bill_header from u_dw within tp_master_details
event of_handle_enterkay pbm_dwnprocessenter
event ue_noscroll pbm_vscroll
string tag = "<NOZOOM>"
integer x = 416
integer y = 60
integer width = 3250
integer height = 560
integer taborder = 30
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event of_handle_enterkay;Send(Handle(this),256,9,Long(0,0))
RETURN 1
end event

event ue_noscroll;return 1
end event

event pfc_retrieve;call super::pfc_retrieve;
return csBLL.of_master_retrieve()
end event

event pfc_postupdate;call super::pfc_postupdate;of_control("Save")
Return csBLL.of_master_postupdate()
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;csBLL.of_master_PostInsert( al_row )

of_control("NewInv")
end event

event itemchanged;call super::itemchanged;csBLL.of_master_itemchange(dwo ,row , data)

of_control("Edit")
end event

event pfc_preupdate;call super::pfc_preupdate;Return csBLL.of_master_preUpdate(This.GetRow())
end event

event buttonclicked;call super::buttonclicked;csBLL.of_master_btn_clicked( dwo, row )
end event

event bst_keydown;call super::bst_keydown;DWObject dwo

CHOOSE CASE key
  CASE KeyPageUp!,KeyPageDown!,KeyUpArrow!,KeyDownArrow!
    This.AcceptText()
    RETURN 1
END CHOOSE


IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
END IF

IF KeyDown(KeyF3!)  and cb_save.enabled  THEN
	cb_save.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
END IF


IF KeyDown(KeyControl!) and KeyDown(KeySpaceBar!)  THEN

	dw_bill_items.event pfc_insertrow( )
	dw_details.setFocus( )
	RETURN 1
END IF


IF KeyDown(KeyControl!) and KeyDown(50)  THEN

	IF This.Describe( "b_stocks.visible") <> "!" THEN
		dwo         = this.Object.__get_attribute ("b_stocks", true)
		csBLL.of_master_btn_clicked ( dwo , this.GetRow())
		Return 1
	END IF
	
	IF This.Describe( "b_to_store.visible") <> "!" THEN
		dwo         = this.Object.__get_attribute ("b_to_store", true)
		csBLL.of_master_btn_clicked( dwo , this.GetRow())
		Return 1
	END IF	
	
END IF

IF KeyDown(KeyControl!) and KeyDown(49)  THEN
	
	IF This.Describe( "b_stores.visible") <> "!" THEN
			dwo         = this.Object.__get_attribute ("b_stores", true)
			csBLL.of_master_btn_clicked( dwo , this.GetRow())
			Return 1
	END IF
	
	IF This.Describe( "b_from_store.visible") <> "!" THEN
			dwo         = this.Object.__get_attribute ("b_from_store", true)
			csBLL.of_master_btn_clicked( dwo , this.GetRow())
			Return 1
	END IF
	
	IF This.Describe( "b_clients.visible") <> "!" THEN
			dwo         = this.Object.__get_attribute ("b_clients", true)
			csBLL.of_master_btn_clicked( dwo , this.GetRow())
			Return 1
	END IF
	
	
END IF

IF( KeyDown(KeyControl!) and ( KeyDown(80) or KeyDown(112) )   ) THEN

	csBll.of_print( )
	Return 1
END IF


//IF KeyDown(KeyF3!) THEN //Copy
//	csBLL.of_copy( )
//	Return 1
//END IF
//
//IF KeyDown(KeyF4!) THEN //Past
//	csBLL.of_past()
//	of_control("edit")
//	dw_details.SetFocus( )
//	Return 1
//END IF

IF KeyDown(KeyF1!) THEN
	
	pb_hlp.event clicked( )
	
END IF

RETURN 0
end event

event editchanged;call super::editchanged;of_control("Edit")
end event

type dw_result from u_dw within tp_master_details
integer x = 3785
integer y = 416
integer width = 1755
integer height = 2144
integer taborder = 20
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event rowfocuschanging;call super::rowfocuschanging;IF currentrow <>  newrow AND currentrow > 0 THEN csBLL.of_result_row_change(currentrow , newrow)


end event

event buttonclicked;call super::buttonclicked;
dw_filter.accepttext( )
csBLL.of_result_btn_clicked(dwo,row)
end event

event bst_keydown;call super::bst_keydown;
IF( KeyDown(KeyControl!) and ( KeyDown(80) or KeyDown(112) )   ) THEN

	csBll.of_print( )
	Return 1
END IF

IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
END IF

IF KeyDown(KeyF3!) and cb_save.enabled THEN

	cb_save.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
END IF

IF KeyDown(KeyControl!) and KeyDown(KeySpaceBar!)  THEN

	dw_details.event pfc_insertrow( )
	dw_details.setFocus( )
	RETURN 1
END IF

//IF KeyDown(KeyF3!) THEN //Copy
//	csBLL.of_copy( )
//	Return 1
//END IF
//
//IF KeyDown(KeyF4!) THEN //Past
//	csBLL.of_past()
//	of_control("edit")
//	dw_details.SetFocus( )
//	Return 1
//END IF

IF KeyDown(KeyF1!) THEN
	
	pb_hlp.event clicked( )
	
END IF
end event

type gb_search_list from groupbox within tp_master_details
integer x = 3749
integer y = 320
integer width = 1847
integer height = 2260
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

type gb_header from groupbox within tp_master_details
integer x = 18
integer width = 3698
integer height = 656
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

type hpb_progress from hprogressbar within tp_master_details
integer x = 2139
integer y = 1020
integer width = 2222
integer height = 208
boolean bringtotop = true
integer transparency = 50
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type dw_filter from u_dw within tp_master_details
event ue_noscroll pbm_vscroll
integer x = 3785
integer y = 84
integer width = 1755
integer height = 192
integer taborder = 10
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event ue_noscroll;return 1
end event

event buttonclicked;call super::buttonclicked;csBLL.of_filter_btn_clicked(dwo , row)
end event

event bst_keydown;call super::bst_keydown;CHOOSE CASE key
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
		dw_result.sharedata( dw_bill_header )
	END IF
	
	csBll.of_result_retrieve( )
	
END IF

IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_bill_header.setFocus( )
	
END IF


IF KeyDown(KeyF3!) and cb_save.enabled THEN

	cb_save.event clicked( )
	dw_bill_header.setFocus( )
	
END IF
//IF KeyDown(KeyF3!) THEN //Copy
//	csBLL.of_copy( )
//	Return 1
//END IF
//
//IF KeyDown(KeyF4!) THEN //Past
//	csBLL.of_past()
//	of_control("edit")
//	dw_details.SetFocus( )
//	Return 1
//END IF

IF KeyDown(KeyF1!) THEN
	
	pb_hlp.event clicked( )
	
END IF
end event

type dw_bill_items from u_dw within tp_master_details
string tag = "<NOZOOM>"
integer x = 64
integer y = 752
integer width = 3621
integer height = 1196
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;Boolean ib_change

ib_change = csBLL.ib_change

csBLL.of_list_btn_clicked( dwo , row )

IF ib_change <> csBLL.ib_change and csBLL.ib_change THEN of_control("edit")

This.bringtotop = True
end event

event clicked;
IF row > 0 THEN
	csBLL.of_list_onclick(row)
END IF
end event

event itemchanged;call super::itemchanged;Boolean ib_change 

ib_change = csBLL.ib_change
csBLL.of_list_itemchange(dwo,row,data)

IF ib_change <> csBLL.ib_change and csBLL.ib_change THEN of_control("Edit")

end event

event pfc_deleterow;Return csBLL.of_list_deleterow( This.GetRow() )
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;csBLL.of_list_PostInsert(al_row)

of_control("NewBand")
end event

event pfc_postupdate;call super::pfc_postupdate;of_control("Save")
Return csBLL.of_list_postupdate()
end event

event pfc_preupdate;call super::pfc_preupdate;Return csBLL.of_list_preupdate()
end event

event rowfocuschanged;call super::rowfocuschanged;dw_details.ScrollToRow( currentrow )
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;of_control("newband")

return SUCCESS
end event

event bst_keydown;call super::bst_keydown;
IF( KeyDown(KeyControl!) and ( KeyDown(80) or KeyDown(112) )   ) THEN

	csBll.of_print( )
	Return 1
END IF

IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
	
END IF

IF ( KeyDown(KeyControl!) and ( KeyDown(115) or KeyDown(83) ) ) and cb_save.enabled  THEN
	
	cb_save.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
	
END IF


IF KeyDown(KeyControl!) and KeyDown(KeySpaceBar!)  THEN

	dw_details.event pfc_insertrow( )
	dw_details.setFocus( )
	RETURN 1
	
END IF

IF KeyDown(KeyF3!) THEN //Copy
	csBLL.of_copy( )
	Return 1
END IF

IF KeyDown(KeyF4!) THEN //Past
	csBLL.of_past()
	of_control("edit")
	Return 1
END IF

IF KeyDown(KeyF1!) THEN
	
	pb_hlp.event clicked( )
	
END IF

RETURN 0
end event

type dw_details from u_dw within tp_master_details
event of_handle_enterkay pbm_dwnprocessenter
event ue_noscroll pbm_vscroll
string tag = "<NOZOOM>"
integer x = 37
integer y = 2016
integer width = 3653
integer height = 444
integer taborder = 50
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event of_handle_enterkay;Send(Handle(this),256,9,Long(0,0))
RETURN 1
end event

event ue_noscroll;IF This.DataObject = "d_order_details_list" THEN
	Return 0
ELSE
	Return 1
END IF
end event

event itemchanged;call super::itemchanged;of_control("Edit")
csBLL.of_detail_itemchange( dwo , row , data )
end event

event buttonclicked;call super::buttonclicked;csBLL.of_detail_btn_clicked( dwo , row )


end event

event pfc_postinsertrow;call super::pfc_postinsertrow;csBLL.of_detail_postinsert(al_row)
of_control("NewBand")
end event

event pfc_postupdate;call super::pfc_postupdate;of_control("Save")
Return csBLL.of_detail_postupdate()
end event

event pfc_preupdate;call super::pfc_preupdate;Return csBLL.of_detail_preupdate( )
end event

event bst_keydown;call super::bst_keydown;dwobject dwo

CHOOSE CASE key
  CASE KeyPageUp!,KeyPageDown!,KeyUpArrow!,KeyDownArrow!
    This.AcceptText()
    RETURN 1
END CHOOSE


IF( KeyDown(KeyControl!) and ( KeyDown(80) or KeyDown(112) )   ) THEN

	csBll.of_print( )
	Return 1
END IF

IF KeyDown(KeyF2!) and cb_add.enabled THEN

	cb_add.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
	
END IF

IF ( KeyDown(KeyControl!) and ( KeyDown(115) or KeyDown(83) ) ) and cb_save.enabled  THEN
	cb_save.event clicked( )
	dw_bill_header.setFocus( )
	RETURN 1
	
END IF


IF KeyDown(KeyControl!) and KeyDown(KeySpaceBar!)  THEN

	//dw_details.event pfc_insertrow( )
	dw_bill_items.event pfc_insertrow( )
	dw_details.setFocus( )
	RETURN 1
	
END IF

IF KeyDown(KeyControl!) and KeyDown(50)  THEN

	IF This.Describe( "b_stocks.visible") <> "!" THEN
		dwo         = this.Object.__get_attribute ("b_stocks", true)
		csBLL.of_detail_btn_clicked( dwo , this.GetRow())
		Return 1
	END IF
END IF

IF KeyDown(KeyControl!) and KeyDown(49)  THEN
	
	IF This.Describe( "b_store.visible") <> "!" THEN
			dwo         = this.Object.__get_attribute ("b_store", true)
			csBLL.of_detail_btn_clicked( dwo , this.GetRow())
			Return 1
	END IF
END IF

IF KeyDown(KeyF1!) THEN
	
	pb_hlp.event clicked( )
	
END IF

RETURN 0
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;Return CSBLL.of_detail_preinsert( )
end event

event editchanged;call super::editchanged;of_control("Edit")
end event

event rowfocuschanging;call super::rowfocuschanging;//IF NewRow > 0 THEN dw_bill_items.ScrollToRow(NewRow)
////MessageBox("change row","current row:"+String(currentrow)+"~n~nNew row:"+String(newrow))
end event

type gb_items from groupbox within tp_master_details
integer x = 18
integer y = 672
integer width = 3698
integer height = 1320
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

type cb_undo from u_cb within tp_master_details
string tag = "تراجع"
integer x = 2048
integer y = 2472
integer width = 544
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = ""
end type

event clicked;call super::clicked;Long ll_row,ll_item_row

IF gnv_msg.of_Message(25) /*MessageBox("تنبيه","سيتم التراجع عن التغيرات التى لم يتم حفظها~n هل انت متأكد من التراجع ؟", information! , yesno!)*/ = 1 THEN

	dw_details.setredraw( False )
	dw_bill_header.setredraw( False )
	dw_Result.setredraw( False )
	dw_bill_items.setredraw( False )
	
	ll_row = dw_result.GetRow()
	ll_item_row = dw_bill_items.GetRow()
	
	csBLL.of_result_retrieve( )
	csBLL.of_master_retrieve()
	dw_Result.scrolltorow( ll_row )
	dw_bill_items.ScrollToRow(ll_item_row)
	
	csBLL.ib_change           = False

	of_control("save")
	
	dw_details.setredraw( True )
	dw_bill_header.setredraw( True )
	dw_Result.setredraw( True )
	dw_bill_items.setredraw( True )
	
	Return csBLL.Success
	
ELSE
	
	Return csBLL.Failure
	
END IF
end event

type cb_add from u_cb within tp_master_details
string tag = "إضــافـــة"
integer x = 3163
integer y = 2468
integer width = 544
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = ""
end type

event clicked;call super::clicked;String  ls_coltype

IF(Demo and dw_bill_header.RowCount() > MaxRows)Then Return

dw_bill_header.Event pfc_insertrow()

ls_coltype = dw_bill_items.Describe( csBLL.is_Detail_id_column_nm+".ColType" )
		
IF Pos( ls_coltype , "char") > 0 THEN

	dw_bill_items.retrieve( "-1" )
	dw_details.retrieve( "-1" )
	
ELSE

	dw_bill_items.retrieve( -1 )
	dw_details.retrieve( -1 )
	
END IF
		

csBLL.ib_change       = True



end event

type cb_save from u_cb within tp_master_details
string tag = "حفـــــظ"
integer x = 2606
integer y = 2472
integer width = 544
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = ""
end type

event clicked;call super::clicked;Long ll_row

//TRY
	
	ll_row = dw_result.GetRow()

	IF csBLL.of_master_validation( ll_row ) < 0 THEN Return csBLL.Failure
	IF csBLL.of_detail_validation( ) < 0 THEN Return csBLL.Failure

	IF dw_bill_header.event pfc_update( True , False) < 0 THEN Return csBLL.Failure
	IF dw_bill_items.event pfc_update( True , False) < 0  THEN Return csBLL.Failure
	
	csBLL.of_list_retrieve( ll_row )
	csBLL.of_Total()
	
	Commit Using SQLCA;

	IF SQLCA.sqlcode = 0 THEN
	
		dw_bill_header.ResetUpdate( )
		dw_bill_items.ResetUpdate( )
		
		//csBLL.of_list_retrieve( ll_row )
		
		csBLL.ib_change           = False
		of_control("save")
		Return csBLL.Success

	ELSE
	
		RollBack Using SQLCA;
		Return csBLL.Failure
	
	END IF
//CATCH (PBXRuntimeError re )
//	MessageBox( "Caught error", re.getMessage() )
//	Return csBLL.Failure
//END TRY
end event

type cb_invoice from u_cb within tp_master_details
string tag = "فــــــاتورة"
integer x = 1490
integer y = 2472
integer width = 544
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = ""
end type

event clicked;call super::clicked;
csBLL.of_invoice()
end event

type gb_search from groupbox within tp_master_details
integer x = 3749
integer width = 1847
integer height = 304
integer taborder = 40
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

type pb_hlp from bs_u_pb within tp_master_details
integer y = 2492
integer taborder = 110
boolean bringtotop = true
boolean originalsize = false
string picturename = "C:\Applications\icons\hot\png\20x20\Info.png"
string is_picturename = "images\Expired_goods.jpg"
end type

event clicked;w_f1 win
//IF gstr_user_info.login_id = "support" THEN
//	csBLL.of_generate_gui( "Header", dw_bill_header )
//	csBLL.of_generate_gui( "Items", dw_bill_items )
//	csBLL.of_generate_gui( "Filter", dw_filter )
//	csBLL.of_generate_gui( "Result", dw_Result )
//	csBLL.of_generate_gui( "Details", dw_details )
//ELSE
	

OpenWithParm(w_f1 , csBll)
	
//END IF
end event

