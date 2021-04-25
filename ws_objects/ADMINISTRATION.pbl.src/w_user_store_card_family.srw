$PBExportHeader$w_user_store_card_family.srw
forward
global type w_user_store_card_family from window
end type
type dw_access from u_dw within w_user_store_card_family
end type
type cb_inc from commandbutton within w_user_store_card_family
end type
type cb_remove from commandbutton within w_user_store_card_family
end type
type dw_access_right from u_dw within w_user_store_card_family
end type
type gb_1 from groupbox within w_user_store_card_family
end type
type gb_2 from groupbox within w_user_store_card_family
end type
end forward

global type w_user_store_card_family from window
integer width = 2537
integer height = 2140
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
dw_access dw_access
cb_inc cb_inc
cb_remove cb_remove
dw_access_right dw_access_right
gb_1 gb_1
gb_2 gb_2
end type
global w_user_store_card_family w_user_store_card_family

type variables
uo_resize iuo_resize
DataStore ids_cg
Long il_left_row,il_right_row,il_dealer_id
String is_user_FiledName = "USER_ID"
String is_other_FieldName = "fid"
end variables

on w_user_store_card_family.create
this.dw_access=create dw_access
this.cb_inc=create cb_inc
this.cb_remove=create cb_remove
this.dw_access_right=create dw_access_right
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_access,&
this.cb_inc,&
this.cb_remove,&
this.dw_access_right,&
this.gb_1,&
this.gb_2}
end on

on w_user_store_card_family.destroy
destroy(this.dw_access)
destroy(this.cb_inc)
destroy(this.cb_remove)
destroy(this.dw_access_right)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;str_pass_parmeters lstr_parm

lstr_parm = Message.PowerObjectParm

iuo_resize = CREATE uo_resize
iuo_resize.of_setTag(This)

ids_cg = Create DataStore

ids_cg.DataObject = lstr_parm.String_parm[2]
ids_cg.SetTransObject(SQLCA)

il_dealer_id = lstr_parm.long_array[1]
This.Title =  lstr_parm.string_parm[1]

Choose Case lstr_parm.String_parm[2]
	Case "d_user_store_card_family"
		dw_access_right.DataObject = "d_all_store_card_family_by_user"
		dw_access.DataObject = "d_all_scf_not_attached_to_user"
		is_user_FiledName = "user_id"
		is_other_FieldName = "fid"
		gb_2.text = "مجموعة الاصناف"
		gb_1.text = "مجموعة اصناف المستخدم"
	Case "d_user_warehouse"
		dw_access_right.DataObject = "d_all_wh_by_user"
		dw_access.DataObject = "d_all_wh_not_attached_to_user"	
		is_user_FiledName = "user_id"
		is_other_FieldName = "store_id"
		gb_2.text = "المخــــازن"
		gb_1.text ="مخـــازن المستخدم"		
	Case "d_user_aow"
		dw_access_right.DataObject = "d_all_aow_by_user"
		dw_access.DataObject = "d_all_aow_not_attached_to_user"	
		is_user_FiledName = "user_id"
		is_other_FieldName = "OWID"
		gb_2.text = "الشركات"
		gb_1.text ="شركات المستخدم"		
		
End Choose



dw_access_right.SetTransObject(SQLCA)
dw_access.SetTransObject(SQLCA)

dw_access_right.Event pfc_retrieve( )
dw_access.Event pfc_retrieve( )



end event

event resize;iuo_resize.of_doResize(this)
end event

type dw_access from u_dw within w_user_store_card_family
event ue_mousemove pbm_mousemove
integer x = 23
integer y = 80
integer width = 1115
integer height = 1940
integer taborder = 20
string dragicon = "Hand!"
string dataobject = "d_all_scf_not_attached_to_user"
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_rmbmenu = false
end type

event ue_mousemove;IF keydown( KeyLeftButton! ) THEN
	This.Drag( Begin! )
END IF
end event

event constructor;call super::constructor;This.settransobject( SQLCA )
end event

event type long pfc_retrieve();call super::pfc_retrieve;return This.retrieve( il_dealer_id)

end event

event clicked;call super::clicked;il_left_row = row
end event

event dragdrop;call super::dragdrop;DragObject l_DragObject

l_DragObject = DraggedObject()
If NOT IsValid( l_DragObject ) Then Return -1

If l_DragObject.TypeOf() = DataWindow! Then
	If l_DragObject.ClassName() = "dw_access_right" Then
		cb_remove.event Clicked()
		
	End If
End If 
end event

type cb_inc from commandbutton within w_user_store_card_family
integer x = 1179
integer y = 848
integer width = 142
integer height = 104
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
string text = ">>"
end type

event clicked;Long ll_row
Long ll_result

IF dw_access.RowCount() = 0 THEN Return

ll_row = ids_cg.insertrow(0)

IF is_other_FieldName = "OWID" THEN
	ids_cg.SetItem( ll_row , is_other_FieldName ,dw_access.GetItemString(il_left_row,is_other_FieldName) )
ELSE
	ids_cg.SetItem( ll_row , is_other_FieldName ,dw_access.GetItemNumber(il_left_row,is_other_FieldName) )
END IF

ids_cg.SetItem( ll_row , is_user_FiledName  , il_dealer_id)
ids_cg.SetItem( ll_row , "ACTIVE_FG"        , "Y")
ids_cg.SetItem( ll_row , "CREATED_BY"       , gstr_user_info.login_id )
ids_cg.SetItem( ll_row , "CREATED_DT"       , gnv_services.uf_today( ) )

ids_cg.update()

COMMIT ;

IF( dw_access.Event pfc_retrieve() > 0 ) THEN

  il_left_row = il_left_row 
  
  IF( il_left_row > dw_access.RowCount() )THEN
    	il_left_row = dw_access.RowCount()
  END IF

END IF

dw_access_right.Event pfc_retrieve()
end event

type cb_remove from commandbutton within w_user_store_card_family
integer x = 1179
integer y = 728
integer width = 142
integer height = 104
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
string text = "<<"
end type

event clicked;Long ll_result

IF dw_access_right.RowCount() = 0 THEN Return

IF is_other_FieldName = "OWID" THEN
	ll_result = ids_cg.retrieve(dw_access_right.GetItemString(il_right_row,is_other_FieldName),il_dealer_id)
ELSE
	ll_result = ids_cg.retrieve(dw_access_right.GetItemNumber(il_right_row,is_other_FieldName),il_dealer_id)
END IF

IF( ll_result > 0 ) THEN
   ids_cg.SetItem(1 ,"ACTIVE_FG" , "N")
   ids_cg.SetItem(1 ,"DELETED_BY" , gstr_user_info.login_id )
   ids_cg.SetItem(1 ,"DELETED_DT" , gnv_services.uf_today( ) )
   ids_cg.update()
   COMMIT;
END IF

dw_access.Event pfc_retrieve()

if( dw_access_right.Event pfc_retrieve() > 0 )then
   if( il_right_row > dw_access_right.RowCount() )then
    il_right_row = dw_access_right.RowCount()
  end if
end if
end event

type dw_access_right from u_dw within w_user_store_card_family
event ue_mousemove pbm_mousemove
integer x = 1362
integer y = 80
integer width = 1129
integer height = 1940
integer taborder = 20
string dragicon = "CreateLibrary5!"
string dataobject = "d_all_store_card_family_by_user"
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_rmbmenu = false
end type

event ue_mousemove;IF keydown( KeyLeftButton! ) THEN
	This.Drag( Begin! )
END IF
end event

event constructor;call super::constructor;This.settransobject( SQLCA )
end event

event type long pfc_retrieve();call super::pfc_retrieve;return This.retrieve( il_dealer_id )

end event

event clicked;call super::clicked;il_right_row = row
end event

event dragdrop;call super::dragdrop;DragObject l_DragObject

l_DragObject = DraggedObject()
If NOT IsValid( l_DragObject ) Then Return -1

If l_DragObject.TypeOf() = DataWindow! Then
If l_DragObject.ClassName() = "dw_access" Then
cb_inc.event Clicked()
End If
End If 
end event

type gb_1 from groupbox within w_user_store_card_family
integer x = 1349
integer width = 1170
integer height = 2036
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean righttoleft = true
end type

type gb_2 from groupbox within w_user_store_card_family
integer width = 1157
integer height = 2036
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean righttoleft = true
end type

