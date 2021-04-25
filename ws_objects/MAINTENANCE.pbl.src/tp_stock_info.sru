$PBExportHeader$tp_stock_info.sru
forward
global type tp_stock_info from u_cst_tabpage
end type
type cb_print from u_cb within tp_stock_info
end type
type cb_import from u_cb within tp_stock_info
end type
type cb_export from u_cb within tp_stock_info
end type
type cb_add from u_cb within tp_stock_info
end type
type cb_save from u_cb within tp_stock_info
end type
type cb_download from u_cb within tp_stock_info
end type
type dw_details from u_dw within tp_stock_info
end type
type dw_stock from u_dw within tp_stock_info
end type
type dw_result from u_dw within tp_stock_info
end type
type dw_filter from u_dw within tp_stock_info
end type
end forward

global type tp_stock_info from u_cst_tabpage
integer width = 5893
integer height = 3228
cb_print cb_print
cb_import cb_import
cb_export cb_export
cb_add cb_add
cb_save cb_save
cb_download cb_download
dw_details dw_details
dw_stock dw_stock
dw_result dw_result
dw_filter dw_filter
end type
global tp_stock_info tp_stock_info

type variables
Long il_padding = 10
end variables

forward prototypes
public subroutine of_getfiled_name ()
public subroutine of_filter (dwobject dwo, long row, string data)
end prototypes

public subroutine of_getfiled_name ();String ls_info

SELECT STRING_VALUE
INTO :ls_info
FROM PARAM_CD
WHERE PARM_NM = 'INFO_1';

dw_stock.Modify( "t_info_1.text=': "+ls_info+"'" )
dw_filter.Modify( "t_info_1.text=': "+ls_info+"'" )
SELECT STRING_VALUE
INTO :ls_info
FROM PARAM_CD
WHERE PARM_NM = 'INFO_2';

dw_stock.Modify( "t_info_2.text=': "+ls_info+"'" )
dw_filter.Modify( "t_info_2.text=': "+ls_info+"'" )
SELECT STRING_VALUE
INTO :ls_info
FROM PARAM_CD
WHERE PARM_NM = 'INFO_3';

dw_stock.Modify( "t_info_3.text=': "+ls_info+"'" )
dw_filter.Modify( "t_info_3.text=': "+ls_info+"'" )
end subroutine

public subroutine of_filter (dwobject dwo, long row, string data);Long ll_id
String ls_sql , ls_data
char lc_type

dw_filter.accepttext( )

ls_sql = ""

IF dw_filter.GetITemString(row , "card_nm" ) <> "" THEN
 
  	 ls_sql =  " match( nm , '"+dw_filter.GetItemString(row , "card_nm" )+".' ) "
		
END IF

ll_id = dw_filter.GetItemNumber(row , "fid" )

IF not IsNull(ll_id) THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += " fid = "+String(ll_id)
	
END IF


IF not IsNull(dw_filter.GetItemString(row , "id" )) THEN

	IF ls_sql <> "" THEN
		ls_sql += " and " 
	END IF
	
	ls_sql += " match( string(id) , '"+dw_filter.GetItemString(row , "id" ) +".' ) "
	
END IF

ll_id = dw_filter.GetItemNumber(row , "mid" )

IF not IsNull(ll_id) THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += " mid = "+String(ll_id)
	
END IF

IF dw_filter.GetITemString(row , "info_1" ) <> "" THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += " match( info_1 , '"+dw_filter.GetITemString(row , "info_1" ) +".' ) "
	
END IF

IF dw_filter.GetITemString(row , "info_2" ) <> "" THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += " match( info_2 , '"+dw_filter.GetITemString(row , "info_2" ) +".' ) "
	
END IF

IF dw_filter.GetITemString(row , "info_3" ) <> "" THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += " match( info_3 , '"+dw_filter.GetITemString(row , "info_3" )+".' ) "
	
END IF

IF dw_filter.GetITemString(row , "familycode" ) <> "" THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += " match( family_code , '"+dw_filter.GetITemString(row , "familycode" )+".' ) "
	
END IF

IF dw_filter.GetITemString(row , "barcode" ) <> "" THEN

	IF ls_sql <> "" THEN
	ls_sql += " and " 
	END IF
	
	ls_sql += "match( no , '"+dw_filter.GetITemString(row , "barcode" )+".' )"
	
END IF

dw_result.setfilter(ls_sql)
dw_result.filter( )


end subroutine

on tp_stock_info.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_import=create cb_import
this.cb_export=create cb_export
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_download=create cb_download
this.dw_details=create dw_details
this.dw_stock=create dw_stock
this.dw_result=create dw_result
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_import
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_download
this.Control[iCurrent+7]=this.dw_details
this.Control[iCurrent+8]=this.dw_stock
this.Control[iCurrent+9]=this.dw_result
this.Control[iCurrent+10]=this.dw_filter
end on

on tp_stock_info.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_import)
destroy(this.cb_export)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_download)
destroy(this.dw_details)
destroy(this.dw_stock)
destroy(this.dw_result)
destroy(this.dw_filter)
end on

event resize;call super::resize;dw_filter.move( NewWidth - dw_result.width ,  0 )

dw_result.resize( dw_result.width , NewHeight - dw_filter.Height )
dw_result.move( NewWidth - dw_result.width ,  dw_filter.Height + 10)

dw_stock.move( NewWidth - dw_stock.width - dw_filter.width  , 0 )

dw_details.move( 0 , dw_stock.height + 10 )
dw_details.resize( NewWidth - dw_result.width , NewHeight - dw_stock.height - cb_add.height - 30 )

cb_add.move(dw_filter.x - cb_add.width - il_padding , NewHeight - cb_add.height - il_padding   )
cb_save.move(cb_add.x - il_padding - cb_save.width , NewHeight - cb_add.height - il_padding   )
cb_download.move(cb_save.x - il_padding - cb_download.width , NewHeight - cb_add.height - il_padding   )
cb_export.move(cb_download.x - il_padding - cb_export.width , NewHeight - cb_add.height - il_padding   )
cb_import.move(cb_export.x - il_padding - cb_import.width , NewHeight - cb_add.height - il_padding   )
cb_print.move(cb_import.x - il_padding - cb_print.width , NewHeight - cb_add.height - il_padding   )

end event

event ue_postconstructor;call super::ue_postconstructor;dw_result.event pfc_retrieve( )
dw_details.event pfc_retrieve( )
of_getfiled_name( )
end event

type cb_print from u_cb within tp_stock_info
integer x = 1842
integer y = 3092
integer width = 389
integer height = 104
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "...طباعة"
boolean cancel = true
end type

event clicked;call super::clicked;gstr_parm.string_parm[1] = "d_rpt_stock"
gstr_parm.string_parm[2] = "d_rpt_stock"
gstr_parm.long_parm[1]    = dw_stock.getitemnumber( dw_stock.getrow() , "SC_ID")
//open(w_invoices)
end event

type cb_import from u_cb within tp_stock_info
integer x = 2240
integer y = 3092
integer width = 389
integer height = 104
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "...توريد"
boolean cancel = true
end type

event clicked;Long ll_row,ll_rowcount
Long ll_itr ,ll_sc_rowcount,ll_res
Long ll_rank,ll_dw_rank
Long ll_fid,ll_mid,ll_dw_fid,ll_dw_mid
String ls_file_nm,ls_path,ls_item,ls_en_item
String ls_dw_item,ls_dw_en_nm
String ls_code,ls_dw_code
String ls_family_code , ls_info_1,ls_info_2,ls_info_3
String ls_dw_family_code , ls_dw_info_1,ls_dw_info_2,ls_dw_info_3
Datetime ldt_to_day
Pointer oldpointer
DataStore lds_source ,lds_dest

GetFileOpenName("تحميل", ls_path, ls_file_nm, "csv", "CSV Files (*.csv),*.csv" ,"C:\", 32770)

ldt_to_day = gnv_services.uf_today( )
 
oldpointer = SetPointer(HourGlass!)

lds_source = create DataStore

lds_source.DataObject = "d_store_card_rank_export_"
IF lds_source.ImportFile(ls_path) < 0 THEN 
	MessageBox("تنبيه","فشل توريد البيانات "+"~n"+"البيانات غير مطابقة للنمط المطلوب")
	Destroy lds_source
	return 
END IF


lds_dest = create DataStore

lds_dest.DataObject = "d_store_card_rank_"
lds_dest.SetTransObject( SQLCA )
lds_dest.Retrieve( )

ll_rowcount = lds_source.RowCount()



ll_sc_rowcount = lds_dest.RowCount()

FOR ll_itr = 1 to ll_rowcount
	
	ll_rank 				= lds_source.GetItemNumber(ll_itr , "rank")
	ls_item 				= lds_source.GetItemString(ll_itr , "masure")
	ls_en_item			= lds_source.GetItemString(ll_itr , "en_card_nm")
	ls_code 				= lds_source.GetItemString(ll_itr , "made_in")
	ll_fid 					= lds_source.GetItemNumber(ll_itr , "fid")
	ll_mid 				= lds_source.GetItemNumber(ll_itr , "mid")
	ls_family_code	=	lds_source.GetItemString(ll_itr , "family_code")
	ls_info_1			=	lds_source.GetItemString(ll_itr , "info_1")
	ls_info_2			=	lds_source.GetItemString(ll_itr , "info_2")
	ls_info_3			=	lds_source.GetItemString(ll_itr , "info_3")
	
	ll_row = lds_dest.find( "sc_id = "+String( lds_source.GetItemNumber( ll_itr , "sc_id" ) ) , 1,ll_sc_rowcount )	

	IF ll_row > 0 THEN
		
			ls_dw_item				= lds_dest.GetItemString(ll_row , "masure")
			ll_dw_rank				= lds_dest.GetItemNumber(ll_row , "rank")
			ls_dw_en_nm			= lds_dest.GetItemString(ll_row , "en_card_nm")
			ls_dw_code 			= lds_dest.GetItemString(ll_row , "made_in")
			ll_dw_fid 				= lds_dest.GetItemNumber(ll_row , "fid")
			ll_dw_mid 				= lds_dest.GetItemNumber(ll_row , "mid")
			ls_dw_family_code	=	lds_dest.GetItemString(ll_row , "family_code")
			ls_dw_info_1			=	lds_dest.GetItemString(ll_row , "info_1")
			ls_dw_info_2			=	lds_dest.GetItemString(ll_row , "info_2")
			ls_dw_info_3			=	lds_dest.GetItemString(ll_row , "info_3")
			
		IF ll_dw_rank <> ll_rank  or IsNull(ll_dw_rank)THEN 
			ll_res = lds_dest.SetItem(ll_row , "rank" , ll_rank )	
		END IF
		IF ls_dw_item <> ls_item or IsNull(ls_dw_item) THEN 
			ll_res = lds_dest.SetItem(ll_row , "masure" , ls_item )
		END IF
		IF ls_dw_en_nm <> ls_en_item or IsNull(ls_dw_en_nm) THEN 
			ll_res = lds_dest.SetItem(ll_row , "en_card_nm" , ls_en_item )
		END IF
		IF ls_dw_code <> ls_code or IsNull(ls_dw_code) THEN 
			ll_res = lds_dest.SetItem(ll_row , "made_in" , ls_code )
		END IF
		IF ll_dw_fid <> ll_fid or IsNull(ll_dw_fid) THEN 
			ll_res = lds_dest.SetItem(ll_row , "fid" , ll_fid )
		END IF
		IF ll_dw_mid <> ll_mid or IsNull(ll_dw_mid) THEN 
			ll_res = lds_dest.SetItem(ll_row , "mid" , ll_mid )
		END IF
		IF ls_dw_family_code <> ls_family_code or IsNull(ls_dw_family_code) THEN 
			ll_res = lds_dest.SetItem(ll_row , "family_code" , ls_family_code )
		END IF
		IF ls_dw_info_1 <> ls_info_1 or IsNull(ls_dw_info_1) THEN 
			ll_res = lds_dest.SetItem(ll_row , "info_1" , ls_info_1 )
		END IF
		IF ls_dw_info_2 <> ls_info_2 or IsNull(ls_dw_info_2) THEN 
			ll_res = lds_dest.SetItem(ll_row , "info_2" , ls_info_2 )
		END IF
		IF ls_dw_info_3 <> ls_info_3 or IsNull(ls_dw_info_3) THEN 
			ll_res = lds_dest.SetItem(ll_row , "info_3" , ls_info_3 )
		END IF
		
		lds_dest.SetItem(ll_row , "LAST_MODIFIED_BY" ,	gstr_user_info.login_id )
		lds_dest.SetItem(ll_row , "LAST_MODIFIED_DT" ,  	ldt_to_day)
		
	ELSE
		
		IF Not IsNull(ls_item) or Trim(ls_item) <> "" THEN
			ll_row = lds_dest.InsertRow( 0 )
		
			ll_res = 	lds_dest.SetItem(ll_row , "sc_id" 	, Long(gnv_services.uf_get_id_from_parm_cd("STORE_CARD.SC_ID") ) ) 
			ll_res = 	lds_dest.SetItem(ll_row , "rank" 	, ll_rank )	
			ll_res = 	lds_dest.SetItem(ll_row , "masure" , ls_item )
			ll_res = 	lds_dest.SetItem(ll_row , "en_card_nm" , ls_en_item )
			ll_res = 	lds_dest.SetItem(ll_row , "made_in" , ls_code )
			ll_res = 	lds_dest.SetItem(ll_row , "fid" , ll_fid )
			ll_res = 	lds_dest.SetItem(ll_row , "mid" , ll_mid )
			ll_res = 	lds_dest.SetItem(ll_row , "family_code" , ls_family_code )
			ll_res = 	lds_dest.SetItem(ll_row , "info_1" , ls_info_1 )
			ll_res = 	lds_dest.SetItem(ll_row , "info_2" , ls_info_2 )
			ll_res = 	lds_dest.SetItem(ll_row , "info_3" , ls_info_3 )
			ll_res = 	lds_dest.SetItem(ll_row , "ACTIVE_FG" , 'Y' )
			ll_res = 	lds_dest.SetItem(ll_row , "LAST_MODIFIED_BY" ,	gstr_user_info.login_id )
			ll_res = 	lds_dest.SetItem(ll_row , "LAST_MODIFIED_DT" ,  ldt_to_day)
			
		END IF
	END IF
	
NEXT

//dw_result.SetRedraw( True )

IF lds_dest.update( True, True) = 1 THEN
	Commit;
	Messagebox("توريد","تم التوريد بنجاح")
ELSE
	MessageBox("توريد","فشل التوريد")
END IF

Destroy lds_source
Destroy lds_dest

dw_result.retrieve(gs_AppPath)

SetPointer(oldpointer)
end event

type cb_export from u_cb within tp_stock_info
integer x = 2651
integer y = 3092
integer width = 389
integer height = 104
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "...تصدير"
boolean cancel = true
end type

event clicked;call super::clicked;String ls_file_nm,ls_path
DataStore lds_source 
 
lds_source = create DataStore

lds_source.DataObject = "d_store_card_rank_export_"
lds_source.settransobject( SQLCA )
lds_source.retrieve( )

GetFileSaveName(" حـــفظ", ls_path, ls_file_nm, "CSV", "CSV Files (*.csv),*.csv" ,"C:\", 32770)

IF lds_source.SaveAs(ls_path , CSV! , False) = 1 THEN Messagebox("تصدير","تم التصدير بنجاح")
end event

type cb_add from u_cb within tp_stock_info
integer x = 3813
integer y = 3092
integer width = 343
integer height = 104
integer taborder = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إضافة"
boolean default = true
end type

event clicked;call super::clicked;if(Demo and dw_stock.RowCount() > MaxRows)Then Return
dw_stock.Event pfc_insertrow( )
dw_result.enabled = False
cb_add.enabled = False
cb_save.enabled = True
//dw_price_list.retrieve(-1)
//uf_control(dw_stock,"New")

end event

type cb_save from u_cb within tp_stock_info
integer x = 3465
integer y = 3092
integer width = 334
integer height = 104
integer taborder = 90
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "حفـــظ"
end type

event clicked;call super::clicked;if(dw_stock.event pfc_update( True , False)>0)Then

		dw_stock.resetupdate( )
		Commit;
//		uf_control(dw_stock,"Save")
		dw_result.enabled = True
		cb_save.enabled = False
		cb_add.enabled = True
Else
		Rollback;
End if


end event

type cb_download from u_cb within tp_stock_info
integer x = 3054
integer y = 3092
integer width = 389
integer height = 104
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "تنزيل الصور"
boolean cancel = true
end type

event clicked;call super::clicked;String ls_fullname , ls_filename
integer li_open
Long ll_sc_id
Long ll_rowcount , ll_row
blob lb_img
DataStore ds

unvo_load_save_images uo_image

uo_image = Create unvo_load_save_images
ds = CREATE DataStore
ds.DataObject = "dddw_pos_items"
ds.SetTransObject(SQLCA)
ds.Retrieve( )

ll_rowcount = ds.RowCount()

//MessageBox("",ll_rowcount)

FOR ll_row = 1 TO ll_rowcount

	setnull(lb_img)
	ll_sc_id = ds.GetItemNumber(ll_row , "sc_id" )

	IF IsNull(ll_sc_id) THEN continue
	
//	MessageBox("",ll_sc_id)
//	IF ds.GetItemString(ll_row , "Active_fg") = "N" THEN continue
	
	lb_img = uo_image.uf_load_pic( "STORE_CARD", "ITEM_IMG" ,"sc_id", String(ll_sc_id)) 

	IF Not IsNull(lb_img)  THEN
		uo_image.uf_write_to_file( gs_AppPath +"img\"+String(ll_sc_id)+".jpg", "jpg", lb_img)		 
	END IF
	
NEXT

Destroy ds
Destroy uo_image;
end event

type dw_details from u_dw within tp_stock_info
integer x = 18
integer y = 2148
integer width = 4160
integer height = 928
integer taborder = 30
string dataobject = "d_price_list_lnk"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean righttoleft = true
end type

event constructor;call super::constructor;this.SetTransobject( SQLCA )

end event

event pfc_retrieve;call super::pfc_retrieve;
IF dw_stock.RowCount() >  0 THEN

	Return This.Retrieve( dw_stock.GetItemNumber( dw_stock.GetRow() , "sc_id") )
	
END IF

Return 0
end event

type dw_stock from u_dw within tp_stock_info
integer width = 4183
integer height = 2116
integer taborder = 20
string dataobject = "d_stock_"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationalways!
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;dw_stock.SetItem( row  , "last_modified_by" , gstr_user_info.login_id )
dw_stock.SetItem( row  , "last_modified_dt" , today() )

dw_result.enabled = False
cb_save.enabled = True
cb_add.enabled = False
end event

event pfc_rowchanged;call super::pfc_rowchanged;dw_details.event pfc_retrieve( )
end event

event buttonclicked;call super::buttonclicked;String ls_fullname , ls_filename
integer li_open
Long ll_emid, ll_scid
str_pass_parmeters lstr_parm

unvo_load_save_images uo_image

IF(dwo.name = "b_new")THEN
		uo_image = Create unvo_load_save_images

		ll_emid = dw_stock.GetItemNumber(dw_stock.GetRow() , "sc_id" )

		if(IsNull(ll_emid))Then return 0

			if(uo_image.uf_add_blob( "STORE_CARD", "ITEM_IMG", "sc_id", String(ll_emid),"" ) = 1 )then
	     		//p_1.setpicture(uo_image.uf_load_pic( "STORE_CARD", "ITEM_IMG", "sc_id", String(ll_emid)))
//			  	filecopy(ls_fullname , gs_AppPath+"img\"+string(ll_emid)+".jpg" ,true)
				MessageBox("تنبيه","تم حذف الصورة بنجاح")
			Else
				MessageBox("تنبيه","حدث خطاء اثناء تحميل الصورة")
     		End if
	 
		Destroy uo_image;
	
END IF

IF dwo.name = "b_upload" THEN

		uo_image = Create unvo_load_save_images

		ll_emid = dw_stock.GetItemNumber(dw_stock.GetRow() , "sc_id" )

		if(IsNull(ll_emid))Then return 0

		li_open = GetFileOpenName("تحميل صورة", ls_fullname, ls_filename, "jpg", "ملف صورة (*.jpg),*.jpg,ملف صورة (*.gif),*.gif" )

		if li_open  < 1 then 
		
			MessageBox("تنبيه","حدث خطاء اثناء تحميل الصورة")
			return
	
		else
	
			if(uo_image.uf_add_blob( "STORE_CARD", "ITEM_IMG", "sc_id", String(ll_emid),ls_fullname ) = 1 )then
	     		//p_1.setpicture(uo_image.uf_load_pic( "STORE_CARD", "ITEM_IMG", "sc_id", String(ll_emid)))
			  	filecopy(ls_fullname , gs_AppPath+"img\"+string(ll_emid)+".jpg" ,true)
			  MessageBox("تنبيه","ثم تحميل الصورة بنجاح")
			Else
				MessageBox("تنبيه","حدث خطاء اثناء تحميل الصورة")
     		End if
	
		end if
 
		Destroy uo_image;

END IF

IF(dwo.name = "b_rank")Then
	Open(w_store_card_rank)	
End if

If(dwo.name = "b_1")Then

	ll_scid = This.GetItemNumber(row , "sc_id")
	
	if(IsNull(ll_scid))Then Return 
	
	lstr_parm.Long_array[1] = ll_scid
	
	OpenWithParm(w_store_card_batches,lstr_parm)
	
	dw_result.SetRedraw( False )	
	dw_result.Update(True,True)
	Commit;
	dw_result.retrieve()
	dw_result.ScrollToRow(row)
	
	dw_result.SetRedraw( True )	

End if

end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_id ,ll_row

ll_row = dw_stock.GetRow()

ll_id = dw_stock.GetItemNumber(ll_row , "sc_id")

IF IsNull(ll_id) THEN
	dw_stock.SetItem(  ll_row , "sc_id" , Long(gnv_services.uf_get_id_from_parm_cd("STORE_CARD.SC_ID") ) ) 
END IF

Return SUCCESS
	
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;dw_stock.SetItem( al_row  , "active_fg" 			, "Y" )
dw_stock.SetItem( al_row  , "last_modified_by" 	, gstr_user_info.login_id )
dw_stock.SetItem( al_row  , "last_modified_dt" 	, today() )
end event

event constructor;call super::constructor;This.SetTransobject( SQLCA )
end event

type dw_result from u_dw within tp_stock_info
integer x = 4201
integer y = 1076
integer width = 1678
integer height = 2116
integer taborder = 20
string dataobject = "d_store_card_list"
boolean hscrollbar = true
boolean livescroll = false
boolean righttoleft = true
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
end event

event pfc_retrieve;call super::pfc_retrieve;Long ll_rows


ll_rows = This.retrieve( gs_AppPath )

IF ll_rows > 0 THEN
	This.sharedata( dw_stock )
END IF

Return ll_rows
end event

event clicked;call super::clicked;dw_stock.scrolltorow( row )
dw_details.event pfc_retrieve( )

end event

event buttonclicked;call super::buttonclicked;IF(dwo.name = "b_delete")THEN

	This.SetItem(row , "Active_fg" , "N")
	This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
	This.SetItem(row , "last_modified_dt" , gnv_services.uf_today() )

	This.update()
	commit;
	
END IF


IF(dwo.name = "b_repair")THEN

	This.SetItem(row , "Active_fg" , "Y")
	This.SetItem(row , "last_modified_by" , gstr_user_info.login_id )
	This.SetItem(row , "last_modified_dt" , gnv_services.uf_today() )

	This.update()
	commit;
	
END IF
end event

type dw_filter from u_dw within tp_stock_info
integer x = 4155
integer width = 1723
integer height = 1080
integer taborder = 10
string dataobject = "d_ext_price_list_filter"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransobject( SQLCA )
This.InsertRow(0)

This.Modify( "op.visible=0" )
This.Modify( "card_nm.x=55" )
This.Modify( "card_nm.width=1138" )
end event

event itemchanged;call super::itemchanged;of_filter(dwo , row , data)
end event

event editchanged;call super::editchanged;of_filter(dwo , row , data)
end event

