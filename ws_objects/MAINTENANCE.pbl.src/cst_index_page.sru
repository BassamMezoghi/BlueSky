$PBExportHeader$cst_index_page.sru
forward
global type cst_index_page from u_cst_tabpage
end type
type st_2 from statictext within cst_index_page
end type
type st_1 from statictext within cst_index_page
end type
type dw_search from u_dw within cst_index_page
end type
type dw_index from u_dw within cst_index_page
end type
type ln_1 from line within cst_index_page
end type
type ln_2 from line within cst_index_page
end type
type ln_3 from line within cst_index_page
end type
type ln_4 from line within cst_index_page
end type
end forward

global type cst_index_page from u_cst_tabpage
integer width = 2930
integer height = 1732
string text = ""
st_2 st_2
st_1 st_1
dw_search dw_search
dw_index dw_index
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global cst_index_page cst_index_page

type variables
Public:
Long il_id = 0
String is_KeyColumn = "-"
String is_TableName = "-"
Boolean ib_Identity = False
end variables

forward prototypes
public function long of_duplicity (string as_do)
end prototypes

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

on cst_index_page.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.dw_search=create dw_search
this.dw_index=create dw_index
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_search
this.Control[iCurrent+4]=this.dw_index
this.Control[iCurrent+5]=this.ln_1
this.Control[iCurrent+6]=this.ln_2
this.Control[iCurrent+7]=this.ln_3
this.Control[iCurrent+8]=this.ln_4
end on

on cst_index_page.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_search)
destroy(this.dw_index)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event resize;call super::resize;dw_index.resize( Newwidth, Newheight - 344)

dw_search.resize( newwidth - 300, 96 )
dw_search.Modify( "title.width="+String(newwidth - 420) )

dw_index.Modify("datawindow.picture.mode=4")

st_1.move( newwidth - 390 , st_1.y )
st_2.move( newwidth - 390 , st_2.y )

ln_1.endx = st_1.x - 40
ln_2.endx = st_1.x - 40

ln_3.endx = st_2.x - 40
ln_4.endx = st_2.x - 40
end event

event ue_postconstructor;call super::ue_postconstructor;
IF is_TableName = "-" THEN
	ib_Identity = True
ELSE
	ib_Identity = gnv_services.of_Check_Identity(is_TableName  , is_KeyColumn )
END IF
end event

type st_2 from statictext within cst_index_page
integer x = 2542
integer y = 28
integer width = 375
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "بيانات البحث"
alignment alignment = center!
boolean focusrectangle = false
boolean righttoleft = true
end type

type st_1 from statictext within cst_index_page
integer x = 2551
integer y = 240
integer width = 366
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "البيانات"
alignment alignment = center!
boolean focusrectangle = false
boolean righttoleft = true
end type

type dw_search from u_dw within cst_index_page
integer x = 165
integer y = 124
integer width = 2766
integer height = 96
integer taborder = 20
string dataobject = "d_ext_edit"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)
end event

event editchanged;call super::editchanged;dw_index.SetFilter( "match(title ,'^"+data+"')" )
dw_index.Filter( )
if(dw_index.RowCount() = 0)Then
dw_index.SetFilter( "match(title ,'."+data+"')" )
dw_index.Filter( )
end if
end event

type dw_index from u_dw within cst_index_page
event ue_keydown pbm_dwnkey
integer x = 14
integer y = 344
integer width = 2907
integer height = 1380
integer taborder = 10
boolean hscrollbar = true
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event ue_keydown;Long ll_row

if(keydown(Keyenter!) and This.GetRow() = This.Rowcount())Then
	This.event pfc_insertrow( )
end if

if(keydown(Keyenter!) and This.GetRow() <> This.Rowcount())Then
	This.event pfc_update( True , True )
	Commit;	
End if

if(keydown(KeyControl!) and keydown(KeyS!))then
	This.event pfc_update( True , True )
	Commit;
end if

if(keydown(KeyControl!) and keydown(KeyD!))Then
	ll_row = this.GetRow()
	This.SetItem(ll_row , "Active_fg" , "N")
	This.SetItem(ll_row , "last_modified_by" , gstr_user_info.id )
	This.SetItem(ll_row , "last_modified_dt" , gnv_services.uf_today( ) )
	This.event pfc_update( True , True )
	Commit;
end if

if(keydown(KeyControl!) and keydown(KeyZ!))then
	ll_row = this.GetRow()
	This.SetItem(ll_row , "Active_fg" , "Y")
	This.SetItem(ll_row , "last_modified_by" , gstr_user_info.id )
	This.SetItem(ll_row , "last_modified_dt" , gnv_services.uf_today( ) )
	This.event pfc_update( True , True )
	Commit;
end if



end event

event buttonclicked;call super::buttonclicked;String ls_hdd
String ls_datawindow = "d_mixer_items_cd"
String ls_title
long ll_row = 0
Long ll_mid
cst_index_page uo_index
str_pass_parmeters lstr_parm


IF dwo.name = "b_1" THEN

	this.event pfc_insertrow( )

END IF

if(dwo.name = "b_2")then
	This.event pfc_update( True , True )
	Commit ;
end if

IF dwo.name = "b_3" THEN

	IF This.Describe( "Active_fg.visible") <> "!" THEN 
		This.SetItem(row , "Active_fg" , "N")
	END IF

	IF This.Describe( "suspend_fg.visible") <> "!" THEN 
		This.SetItem(row , "suspend_fg" , "N")
	END IF

	IF This.Describe( "last_modified_by.visible") <> "!" THEN 
		This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
	END IF

	IF This.Describe( "last_modified_dt.visible") <> "!" THEN 
		This.SetItem(row , "last_modified_dt" , Datetime(today(),now()) )
	END IF

//	This.SetItem(row , "Active_fg" , "N")
//	This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
//	This.SetItem(row , "last_modified_dt" , gnv_services.uf_today( ) )
	This.event pfc_update( True , True )
	Commit;
	
END IF

IF dwo.name = "b_4" THEN

	IF This.Describe( "Active_fg.visible") <> "!" THEN 
		This.SetItem(row , "Active_fg" , "Y")
	END IF
	
	IF This.Describe( "suspend_fg.visible") <> "!" THEN 
		This.SetItem(row , "suspend_fg" , "Y")
	END IF
	
	IF This.Describe( "last_modified_by.visible") <> "!" THEN 
		This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
	END IF

	IF This.Describe( "last_modified_dt.visible") <> "!" THEN 
		This.SetItem(row , "last_modified_dt" , Datetime(today(),now()) )
	END IF

//	This.SetItem(row , "Active_fg" , "Y")
//	This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
//	This.SetItem(row , "last_modified_by" , gnv_services.uf_today( ) )
	This.event pfc_update( True , True )
	Commit;
END IF



IF dwo.name = "b_log" THEN
	
	IF row <= 0  THEN return 
		ls_hdd = This.GetItemString(row , "hdserial_no")

		This.DataObject = "d_logs"
		This.SetTransobject( SQLCA )
		This.retrieve( ls_hdd )
		return
		
END IF

IF dwo.name = "b_back" THEN

	This.DataObject = "d_serial_no"
	This.SetTRansObject(SQLCA)
	This.Retrieve( )
	
END IF

IF dwo.name = "b_mixer_items" THEN

ll_mid = This.GetItemNumber(row ,"mid")
ls_title = This.GetItemString( row , "mixer_nm" )

IF IsNull(ll_mid) THEN 

	MessageBox("تنبيه","يجب حفظ البيانات")
	
END IF

ll_row = of_duplicity(ls_datawindow+String(ll_mid))

IF ll_row <= 1 THEN
	//Open userobject as tab
	w_menu.uo_tabcontrol.of_OpenTab(uo_index, ls_title, 3)
	uo_index.il_id = ll_mid
	uo_index.dw_index.DataObject = ls_datawindow
	uo_index.dw_index.SetTransObject(SQLCA)	
	uo_index.dw_index.of_setsort( True )
	uo_index.dw_index.inv_sort.of_setcolumnheader( True )
	uo_index.dw_index.retrieve(ll_mid)
	uo_index.tag = uo_index.dw_index.DataObject
	ll_row = upperbound(w_menu.uo_tabcontrol.ist_tabs)
ELSE
	uo_index = w_menu.uo_tabcontrol.ist_tabs[ll_row].ado_object	
END IF

//Select the first tab
w_menu.uo_tabcontrol.of_SelectTab( ll_row )
	
END IF

IF dwo.name = "b_items" THEN
	 lstr_parm.long_array[1] = 0
    // Openwithparm(w_search_store_card_pls , lstr_parm)
	 IF gstr_parm.long_array[1] > 0 THEN
	    This.SetItem(row , "sc_id" , gstr_parm.long_array[1] )
	    This.Event itemchanged(row , dwo , string(gstr_parm.long_array[1]))
	END IF
END IF


IF dwo.name = "b_list" THEN
	
	lstr_parm.long_array[1] = This.GetItemNumber(row , "id" )
	
	//OpenWithParm(w_finance_list_accounts_lnk , lstr_parm)
	
		
END IF
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;
IF il_id > 0 THEN 
	This.SetItem( al_row , "mid", il_id)
END IF
IF This.Describe( "Active_fg.visible") <> "!" THEN 
	This.SetItem(al_row , "Active_fg" , "Y")
END IF

IF This.Describe( "Created_by.visible") <> "!" THEN 
	This.SetItem(al_row , "Created_by" , gstr_user_info.login_id )
END IF

IF This.Describe( "Created_dt.visible") <> "!" THEN 
	This.SetItem(al_row , "Created_dt" , Datetime(today(),now()) )
END IF

IF This.Describe( "last_modified_by.visible") <> "!" THEN 
	This.SetItem(al_row , "last_modified_by" , gstr_user_info.login_id )
END IF

IF This.Describe( "last_modified_dt.visible") <> "!" THEN 
	This.SetItem(al_row , "last_modified_dt" , Datetime(today(),now()) )
END IF

This.SetRow( al_row )
end event

event itemchanged;call super::itemchanged;IF This.Describe( "last_modified_by.visible") <> "!" THEN 
	This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
END IF

IF This.Describe( "last_modified_dt.visible") <> "!" THEN 
	This.SetItem(row , "last_modified_dt" , Datetime(today(),now()) )
END IF

//This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
//This.SetItem(row , "last_modified_dt" , gnv_services.uf_today( ) )
end event

event pfc_insertrow;//////////////////////////////////////////////////////////////////////////////
//	Event:			pfc_insertrow
//	Arguments:		None
//	Returns:			long - number of the new row that was inserted
//	 					0 = No row was added.
//						-1 = error
//	Description:		Inserts a new row into the DataWindow before the current row
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0		Enhanced with Pre Insert funcitonality.
// 						7.0		Enhanced with Post Insert funcitonality.
// 						7.0		Linkage service should not fire events when querymode is enabled
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
long	ll_currow
long	ll_rc
boolean lb_disablelinkage

// Allow for pre functionality.
if this.Event pfc_preinsertrow() <= PREVENT_ACTION then return NO_ACTION

// Get current row
ll_currow = this.GetRow()
if ll_currow < 0 then ll_currow = 0

// Is Querymode enabled?
if IsValid(inv_QueryMode) then lb_disablelinkage = inv_QueryMode.of_GetEnabled()
		
if not lb_disablelinkage then		
	// Notify that a new row is about to be added.
	if IsValid ( inv_Linkage ) then inv_Linkage.Event pfc_InsertRow (0) 
end if

// Insert row.
if IsValid (inv_RowManager) then
	ll_rc = inv_RowManager.event pfc_insertrow (0)
else
	ll_rc = this.InsertRow (0) 
end if

if not lb_disablelinkage then		
	// Notify that a new row has been added.
	if IsValid ( inv_Linkage ) then inv_Linkage.Event pfc_InsertRow (ll_rc) 
end if

// Allow for post functionality.
this.Post Event pfc_postinsertrow(ll_rc)

return ll_rc
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;if(Demo and This.RowCount() >= MaxRows)Then return PREVENT_ACTION
return CONTINUE_ACTION
end event

event pfc_preupdate;call super::pfc_preupdate;String ls_total_in_letter
Decimal ld_total_amount , ld_total_amount_
Long ll_row , ll_id
String ls_id , ls_ColType

//IF This.DataObject = "d_users_groups_cd" THEN
//	
//	ls_id = This.GetItemString(this.Getrow() , "id")
//	
//	IF Isnull(ls_id) THEN
//		
//		This.SetItem(this.Getrow() , "id" , gnv_services.uf_get_id_from_parm_cd("users_groups_cd") )
//		
//	END IF
//	
//END IF

IF Not ib_Identity THEN
			
		ll_row = This.Getrow()
		
		ls_ColType = This.Describe( is_KeyColumn+".ColType" )
		
		This.Modify( is_KeyColumn+".identity='no'")
		
		Choose Case ls_ColType
			Case "long"
				
				ll_id = This.GetItemNumber( ll_row , is_KeyColumn )
				
				IF IsNull(ll_id) THEN
			
					This.SetItem( ll_row  , is_KeyColumn , Long(gnv_services.uf_get_id_from_parm_cd(is_TableName+"."+is_KeyColumn ) ) ) 
					
				END IF
			Case Else 
				
				ls_id = This.GetItemString( ll_row , is_KeyColumn )
				IF IsNull( ls_id ) THEN
			
					This.SetItem( ll_row  , is_KeyColumn , gnv_services.uf_get_id_from_parm_cd(is_TableName) ) 
					
				END IF
		End Choose
		
END IF


Return SUCCESS
end event

type ln_1 from line within cst_index_page
long linecolor = 134217750
integer linethickness = 6
integer beginx = 201
integer beginy = 68
integer endx = 2501
integer endy = 68
end type

type ln_2 from line within cst_index_page
long linecolor = 16777215
integer linethickness = 6
integer beginx = 201
integer beginy = 72
integer endx = 2501
integer endy = 72
end type

type ln_3 from line within cst_index_page
long linecolor = 134217750
integer linethickness = 6
integer beginx = 229
integer beginy = 276
integer endx = 2528
integer endy = 276
end type

type ln_4 from line within cst_index_page
long linecolor = 16777215
integer linethickness = 6
integer beginx = 229
integer beginy = 280
integer endx = 2528
integer endy = 280
end type

