$PBExportHeader$w_mng_documents.srw
forward
global type w_mng_documents from w_child
end type
type pb_rotate from picturebutton within w_mng_documents
end type
type ole_1 from olecustomcontrol within w_mng_documents
end type
type ole_12 from olecustomcontrol within w_mng_documents
end type
type htb_resize from u_htb within w_mng_documents
end type
type dw_list from u_dw within w_mng_documents
end type
end forward

global type w_mng_documents from w_child
integer x = 214
integer y = 221
integer width = 3790
integer height = 2124
boolean righttoleft = true
boolean center = true
boolean ib_isupdateable = false
pb_rotate pb_rotate
ole_1 ole_1
ole_12 ole_12
htb_resize htb_resize
dw_list dw_list
end type
global w_mng_documents w_mng_documents

type prototypes

end prototypes

type variables
Public:
String is_id 
String is_SysPart
Private:
Decimal id_ZoomValue = 1
Long il_pos = 1
n_bitmap in_bitmap

end variables

forward prototypes
public subroutine of_post_scann ()
end prototypes

public subroutine of_post_scann ();ole_1.Object.PasteFromClipboard()
end subroutine

on w_mng_documents.create
int iCurrent
call super::create
this.pb_rotate=create pb_rotate
this.ole_1=create ole_1
this.ole_12=create ole_12
this.htb_resize=create htb_resize
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_rotate
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.ole_12
this.Control[iCurrent+4]=this.htb_resize
this.Control[iCurrent+5]=this.dw_list
end on

on w_mng_documents.destroy
call super::destroy
destroy(this.pb_rotate)
destroy(this.ole_1)
destroy(this.ole_12)
destroy(this.htb_resize)
destroy(this.dw_list)
end on

event open;str_pass_parmeters lstr_parm
TRY
	
	gnv_services.of_color( dw_list )
	ole_1.Object.SetBackgroundColor(rgb(255,255,255))

	lstr_parm = Message.PowerObjectParm
	
	is_syspart = lstr_parm.string_parm[1]
	is_id = lstr_parm.string_parm[2]
	
	dw_list.Event pfc_retrieve()	
	
	ole_1.Object.MouseTrackMode=2

CATCH(PBXRunTimeError ex)
	Messagebox("Error" , ex.getmessage() )
END TRY
end event

event resize;call super::resize;dw_list.move( newwidth - dw_list.width, dw_list.y)
dw_list.resize( dw_list.width, newheight - 150)

ole_1.move(0,0)
ole_1.resize(newwidth - dw_list.width , newheight)

pb_rotate.move(dw_list.x , dw_list.y + dw_list.height)

htb_resize.move(pb_rotate.x + pb_rotate.width + 5, pb_rotate.y )


//pb_1.move( ole_1.x +13 , ole_1.y + ole_1.height - pb_1.height - 12 )



end event

event close;return 
end event

type pb_rotate from picturebutton within w_mng_documents
string tag = "1"
integer x = 2683
integer y = 1856
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\png\32x32\rotate-clockwise.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Long ll_rotate

ll_rotate = Long(This.tag) 

IF ll_rotate = 4 THEN ll_rotate = 0

ole_1.Object.Rotate(0)

This.tag = String(ll_rotate + 1)


end event

type ole_1 from olecustomcontrol within w_mng_documents
event click ( )
event dblclick ( )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event selectionrectdrawn ( long ileft,  long itop,  long iwidth,  long iheight )
event ocrrecognized ( boolean bsuccess )
event loadimagefromurlcompleted ( )
integer width = 2674
integer height = 2020
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_mng_documents.win"
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type ole_12 from olecustomcontrol within w_mng_documents
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
boolean visible = false
integer x = 5
integer y = 4
integer width = 2674
integer height = 1640
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_mng_documents.win"
integer binaryindex = 1
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type htb_resize from u_htb within w_mng_documents
integer x = 2880
integer y = 1848
integer width = 873
integer height = 164
integer minposition = 1
integer maxposition = 40
integer position = 1
integer tickfrequency = 1
htickmarks tickmarks = hticksontop!
end type

event moved;call super::moved;TRY
	//ole_1.Object.View = 8
	//ole_1.Object.ViewSize = ( scrollpos * 10)
	IF ScrollPos > il_pos THEN
		ole_1.Object.ZoomIn()
	ELSE
		ole_1.Object.ZoomOut()
	END IF
	il_pos = ScrollPos
CATCH(PBXRunTimeError er)
	MessageBox("خطاء","حدث خطاء اثناء تحميل الصورة")
END TRY
end event

type dw_list from u_dw within w_mng_documents
string tag = "<NOZOOM>"
integer x = 2693
integer width = 1047
integer height = 1848
integer taborder = 10
string dataobject = "d_list_of_docs"
boolean hsplitscroll = true
boolean righttoleft = true
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

event pfc_retrieve;call super::pfc_retrieve;Return This.retrieve( is_id , is_SysPart )
end event

event buttonclicked;call super::buttonclicked;n_cst_docs cs_docs
Long hdib , ll_id
String ls_FileType
 
IF dwo.name = "b_add" THEN

	This.event pfc_insertrow( )
	Return
	
END IF

IF dwo.name = "b_save" THEN
	
	IF This.event pfc_update( True , True ) > 0 THEN 
		Commit;
	END IF
	
	Return 
	
END IF

ll_id = This.GetItemNumber(row , "ID")

IF IsNull(ll_id) THEN Return

IF dwo.name = "b_delete" THEN
	
	This.SetItem(row , "active_fg"	, "N" )
	This.SetItem(row , "deleted_by"	, gstr_user_info.login_id )
	This.SetItem(row , "deleted_dt"	, gnv_services.uf_today( ) )
	This.event pfc_update( True , True )
	
	Commit;
	This.event pfc_retrieve( )
	
END IF

IF dwo.name = "b_load" THEN
	
	cs_docs = CREATE n_cst_docs
	IF cs_docs.of_load_doc( This.GetItemString(row , "PID"), This.GetItemNumber(row , "SEQ") ,ole_1 , is_syspart , ls_FileType) THEN
		This.SetItem(Row , "ftype" 		, ls_FileType)
		This.SetItem(Row , "Modified_by" , gstr_user_info.login_id )
		This.SetItem(Row , "Modified_dt" , gnv_services.uf_today( ) )		
		This.event pfc_update( True , True )
		Commit;
	END IF
	Destroy cs_docs
END IF

IF dwo.name = "b_scann" THEN
	
	
//	cs_docs = Create n_cst_docs
//	cs_docs.TWAIN_SetHideUI(False)
//	cs_docs.TWAIN_SetJpegQuality(73)
//	IF  cs_docs.TWAIN_OpenDefaultSource() THEN//cs_docs.TWAIN_OpenSource("WIA-Epson BX300F/NX300/TX300F/ME ") THEN
//		cs_docs.TWAIN_SetPixelType(2)
////		cs_docs.TWAIN_SetAutoCrop(1)
//		cs_docs.TWAIN_SetAutoDeskew(1)
//		cs_docs.TWAIN_SetPaperSize(2)
//		cs_docs.TWAIN_SetXferCount(1)
//		cs_docs.TWAIN_SetAutoScan(FALSE)
//         // If you can't get a Window handle, use 0:
//		cs_docs.TWAIN_AcquireToClipboard(hdib,4)
//		cs_docs.DIB_Free(hdib)
//		ole_1.Object.PasteFromClipboard()
//		ole_1.Object.SaveAsJpg(gs_AppPath+"images\"+"temp")
//		IF cs_docs.of_load_doc( This.GetItemString(row , "ID"), This.GetItemNumber(row , "SEQ") ,gs_AppPath+"images\"+"temp.jpg" , is_syspart) THEN
//			This.SetItem(Row , "Modified_by" , gstr_user_info.login_id )
//			This.SetItem(Row , "Modified_dt" , gnv_services.uf_today( ) )		
//			This.event pfc_update( True , True )
//			Commit;
//		END IF
//		  
////         cs_docs.TWAIN_AcquireToFilename(handle(Parent), "c:\applications\temp.jpg")
//    END IF
//    IF  cs_docs.TWAIN_LastErrorCode()<>0 THEN
//         cs_docs.TWAIN_ReportLastError("Unable to scan.")
//    END IF
//	 
// Destroy cs_docs	
	
END IF

IF dwo.name = "b_past" THEN
	cs_docs = CREATE n_cst_docs
	ole_1.Object.PasteFromClipboard()
	ole_1.Object.SaveBySize(gs_AppPath+"images\"+"temp" ,"JPG" , 336 ,448)
	IF cs_docs.of_load_doc( This.GetItemString(row , "PID"), This.GetItemNumber(row , "SEQ") ,gs_AppPath+"images\"+"temp.jpg",is_syspart) THEN
			This.SetItem(Row , "Modified_by" , gstr_user_info.login_id )
			This.SetItem(Row , "Modified_dt" , gnv_services.uf_today( ) )		
			This.event pfc_update( True , True )
			Commit;
	END IF
	FileDelete(gs_AppPath+"images\"+"temp.jpg")
	Destroy cs_docs	
END IF
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;This.SetItem( al_row , "PID" 			, is_id )
This.SetItem( al_row , "SEQ" 			, This.RowCount())
This.SetItem( al_row , "SysPart" 	, is_SysPart )
This.SetItem( al_row , "Created_by" , gstr_user_info.login_id )
This.SetItem( al_row , "Created_dt" , gnv_services.uf_today() )
end event

event doubleclicked;call super::doubleclicked;n_cst_docs cs_docs

cs_docs = CREATE n_cst_docs

IF cs_docs.of_view_doc(This.GetItemString(row , "pid") , This.GetItemNumber(row , "seq") ,ole_1 , is_syspart, This.GetItemString(row , "ftype") ) THEN
	ole_1.tag = "1"
ELSE
	ole_1.tag = "0"
END IF


end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_id

ll_id = This.GetItemNumber( This.getRow() , "ID")

IF IsNull(ll_id) THEN
	
	This.SetItem( This.GetRow() , "ID" , Long(gnv_services.uf_get_id_from_parm_cd( "DOCS" ) ) )
	
END IF

Return Success
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_mng_documents.bin 
2300000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000068611e2001d4739a00000003000001800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004e589da784fc5ad4c479eb9b69e6710b10000000068611e2001d4739a68611e2001d4739a000000000000000000000000fffffffe000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0065004400650076006f006c00650070002000720069006c006500630073006e003a0065003600350033003700000000000000000000000000000000000000000000fffe00020206e589da784fc5ad4c479eb9b69e6710b100000001fb8f0821101b01640008ed8413c72e2b00000030000000a4000000050000010000000030000001010000003800000102000000400000010300000048000000000000005000000003000100000000000300003c76000000030000343100000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000003c760000343100000000000001010000000000000000000000006564040000646f6d0000000000000000000001006000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000500000039000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_mng_documents.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
