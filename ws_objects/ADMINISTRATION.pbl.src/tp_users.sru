$PBExportHeader$tp_users.sru
forward
global type tp_users from u_cst_tabpage
end type
type pb_remove_all from picturebutton within tp_users
end type
type pb_add_all from picturebutton within tp_users
end type
type pb_add_group from picturebutton within tp_users
end type
type dw_filter from u_dw within tp_users
end type
type dw_access from u_dw within tp_users
end type
type cb_4 from commandbutton within tp_users
end type
type cb_inc from commandbutton within tp_users
end type
type cb_remove from commandbutton within tp_users
end type
type cb_3 from commandbutton within tp_users
end type
type dw_access_right from u_dw within tp_users
end type
type dw_user from u_dw within tp_users
end type
end forward

global type tp_users from u_cst_tabpage
integer width = 3182
integer height = 2396
pb_remove_all pb_remove_all
pb_add_all pb_add_all
pb_add_group pb_add_group
dw_filter dw_filter
dw_access dw_access
cb_4 cb_4
cb_inc cb_inc
cb_remove cb_remove
cb_3 cb_3
dw_access_right dw_access_right
dw_user dw_user
end type
global tp_users tp_users

type variables
Boolean ib_change = False,ib_change_password = False
Long ll_NewRow = -1
String is_TableName = "ACCESS_CD"
String is_ChildIDName = "ACID"
String is_ParentIDName = "PARENT"
String is_TitleName = "TITLE"
String is_DWName = "d_access_cd_tree_view"
str_stack is_selected_data
DataStore ids_tree_view
lol_stack inv_stack

end variables

forward prototypes
public subroutine of_scrolltorow (string as_user_id)
public subroutine of_color (u_dw ar_dw)
end prototypes

public subroutine of_scrolltorow (string as_user_id);//n_cst_crypto lnv_crypt	
String ls_password
Long row

row = dw_user.find("user_id = '"+as_user_id+"'" , 1 , dw_user.rowCount())

IF Row <= 0 THEN Return

dw_user.ScrollToRow(Row)

dw_access_right.event pfc_retrieve( )
dw_access.event pfc_retrieve( )

//lnv_crypt = Create n_cst_crypto

//ls_password = lnv_crypt.Decryptdata( dw_user.GetItemString(row,"Password") ,  gnv_app.of_getMyKey() )

//Destroy lnv_crypt;

//dw_user.SetItem(row , "Password", ls_password)
end subroutine

public subroutine of_color (u_dw ar_dw);Long ll_max, ll_cnt
String ls_col, ls_type ,ls_color , ls_gr_color
str_pass_parmeters lstr_parm

lstr_parm = gnv_services.of_backGroundColor()

ls_color = mid(lstr_parm.String_parm[1] , pos(lstr_parm.String_parm[1] , "=")+1 ,len(lstr_parm.String_parm[1]) )
ls_gr_color = mid(lstr_parm.String_parm[2] , pos(lstr_parm.String_parm[2] , "=")+1 ,len(lstr_parm.String_parm[2]) )

ar_dw.Modify( "DataWindow.color="+ls_color )
ar_dw.Modify( "DataWindow.brushmode=2" )
ar_dw.Modify( "DataWindow.transparency=11" )
ar_dw.Modify( "DataWindow.gradient.angle=0" )
ar_dw.Modify( "DataWindow.gradient.color='16777215'" )
ar_dw.Modify( "DataWindow.gradient.focus=51" )
ar_dw.Modify( "DataWindow.gradient.scale=86" )
ar_dw.Modify( "DataWindow.gradient.spread=83" )
ar_dw.Modify( "DataWindow.gradient.transparency=0" )


ll_max = Long( ar_dw.Describe("DataWindow.Column.Count") )

For ll_cnt = 1 To ll_max
	
	ls_col = ar_dw.describe( "#"+string(ll_cnt)+".Name" )
	ls_type = ar_dw.describe(ls_col + ".type")

	IF(ls_type = "column" or ls_type = "compute")THEN
	
		ar_dw.Modify( ls_col+".color='8388608~tif( currentRow() = getrow() , rgb(128,0,0) , rgb(0,0,128))'" )
		ar_dw.Modify( ls_col+".background.mode='1'") 
		ar_dw.Modify( ls_col+".background.color='553648127'")//+ls_color)//536870912
		ar_dw.Modify( ls_col+".background.transparency='0'") 
		ar_dw.Modify( ls_col+".background.gradient.color="+ls_color)//15780518
		ar_dw.Modify( ls_col+".background.gradient.transparency='0'") 
		ar_dw.Modify( ls_col+".background.gradient.angle='144'") 
		ar_dw.Modify( ls_col+".background.brushmode='1'")
		ar_dw.Modify( ls_col+".background.gradient.repetition.length='50'") 
		ar_dw.Modify( ls_col+".background.gradient.focus='61'")
		ar_dw.Modify( ls_col+".background.gradient.scale='60'") 
		ar_dw.Modify( ls_col+".background.gradient.spread='80'") 
		ar_dw.Modify( ls_col+".font.face='Arial (Arabic)'")
		ar_dw.Modify( ls_col+".font.height='-12'")
		ar_dw.Modify( ls_col+".font.weight='700'")
		ar_dw.Modify( ls_col+".font.family='2'")
		ar_dw.Modify( ls_col+".font.pitch='2'")
		ar_dw.Modify( ls_col+".font.charset='178'")
		
	END IF

Next

end subroutine

on tp_users.create
int iCurrent
call super::create
this.pb_remove_all=create pb_remove_all
this.pb_add_all=create pb_add_all
this.pb_add_group=create pb_add_group
this.dw_filter=create dw_filter
this.dw_access=create dw_access
this.cb_4=create cb_4
this.cb_inc=create cb_inc
this.cb_remove=create cb_remove
this.cb_3=create cb_3
this.dw_access_right=create dw_access_right
this.dw_user=create dw_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_remove_all
this.Control[iCurrent+2]=this.pb_add_all
this.Control[iCurrent+3]=this.pb_add_group
this.Control[iCurrent+4]=this.dw_filter
this.Control[iCurrent+5]=this.dw_access
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_inc
this.Control[iCurrent+8]=this.cb_remove
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.dw_access_right
this.Control[iCurrent+11]=this.dw_user
end on

on tp_users.destroy
call super::destroy
destroy(this.pb_remove_all)
destroy(this.pb_add_all)
destroy(this.pb_add_group)
destroy(this.dw_filter)
destroy(this.dw_access)
destroy(this.cb_4)
destroy(this.cb_inc)
destroy(this.cb_remove)
destroy(this.cb_3)
destroy(this.dw_access_right)
destroy(this.dw_user)
end on

event resize;call super::resize;Long ll_btn_x

dw_user.Move( NewWidth - dw_user.width , 20)

ll_btn_x = ( NewWidth / 2 ) - ( pb_remove_all.width / 2 ) - 15

cb_3.move( ll_btn_x  , cb_3.y)
cb_4.move( ll_btn_x  , cb_4.y)
cb_remove.move( ll_btn_x  , cb_remove.y)
cb_inc.move( ll_btn_x  , cb_inc.y)
pb_add_all.move(ll_btn_x , pb_add_all.y)
pb_remove_all.move(ll_btn_x , pb_remove_all.y)
pb_add_group.move( ll_btn_x  , pb_add_group.y )

dw_filter.move( NewWidth - dw_filter.width , dw_user.height + 10)

dw_access.Move( 0 ,  dw_filter.y + 120  )
dw_access_right.Move( pb_remove_all.x + pb_remove_all.width + 10 ,  dw_filter.y + 120)

dw_access.resize( ( NewWidth /2 ) - ( pb_remove_all.width / 2) - 10 , NewHeight - dw_filter.y - 50)
dw_access_right.resize( ( NewWidth /2 ) - ( pb_remove_all.width / 2) - 10 , NewHeight - dw_filter.y - 50 )

dw_access.modify( "title.width="+string(dw_access.width) )
dw_access_right.modify( "acid.width="+string(dw_access_right.width) )
//st_2.move(dw_access.x + dw_access.width - st_2.width , dw_access.y - st_2.height)
//st_1.move(dw_access_right.x + dw_access_right.width - st_1.width , dw_access_right.y - st_1.height)
end event

event ue_postconstructor;call super::ue_postconstructor;//dw_user.event pfc_retrieve( )
of_color(dw_access_right)
of_color(dw_access)
end event

type pb_remove_all from picturebutton within tp_users
integer x = 1390
integer y = 1044
integer width = 256
integer height = 224
integer taborder = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\png\48x48\Pick.png"
alignment htextalign = left!
string powertiptext = "حذف جميع الصلاحيات"
end type

event clicked;Int li_row,li_rowcount

li_rowcount = dw_access_right.RowCount()

For li_row = 1 To li_RowCount
		
	dw_access_right.deleterow(0)	
	
Next

dw_access_right.update()	
Commit;
dw_access_right.SetRedraw(True)

dw_access.Event pfc_retrieve()
end event

type pb_add_all from picturebutton within tp_users
integer x = 1390
integer y = 1276
integer width = 256
integer height = 224
integer taborder = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\png\48x48\Put away.png"
alignment htextalign = left!
string powertiptext = "اعطاء جميع الصلاحيات"
end type

event clicked;Int li_row,li_rowcount
Int li_ins
Long ll_user_no

ll_user_no = dw_user.GetItemNumber(dw_user.GetRow(),"user_no")

IF IsNull(ll_user_no) THEN 
	gnv_msg.of_message( 51 )//save user info first
	Return
END IF

li_rowcount = dw_access.RowCount()

For li_row = 1 To li_RowCount	

	li_ins = dw_access_right.insertrow(0)
	dw_access_right.SetItem(li_ins ,"acid"		, dw_access.GetItemNumber(li_row,"acid"))
	dw_access_right.SetItem(li_ins ,"user_no"	,ll_user_no)	
	
Next

dw_access_right.update()
COMMIT ;
dw_access.Event pfc_retrieve()
end event

type pb_add_group from picturebutton within tp_users
integer x = 1390
integer y = 1508
integer width = 256
integer height = 224
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\png\48x48\User group.png"
alignment htextalign = left!
string powertiptext = "مجموعات المستخدمين"
end type

event clicked;str_pass_parmeters lstr_parm

lstr_parm.long_parm[1] = dw_user.GetItemNumber(dw_user.getrow(),"user_no")


IF IsNull(lstr_parm.long_parm[1]) THEN 
	gnv_msg.of_message( 51 )//save user info first
	Return
END IF

OpenWithParm(w_user_groups_cd , lstr_parm)

dw_access.Event pfc_retrieve()
dw_access_right.Event pfc_retrieve()

end event

type dw_filter from u_dw within tp_users
integer x = 983
integer y = 608
integer width = 1829
integer height = 116
integer taborder = 20
string dataobject = "d_user_ddlist"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.settransobject( SQLCA )
This.InsertRow( 0)
end event

event editchanged;call super::editchanged;//if(dwo.name = "Title" )Then
//MessageBox("",data)
    dw_access_right.setfilter( "Match(Title,'^"+data+"')" )
    dw_access.setfilter( "Match(Title,'^"+data+"')" )
    dw_access_right.filter( )
    dw_access.filter( )
//End if
end event

event itemchanged;dw_access.retrieve(long(data))
dw_access_right.retrieve(long(data))


end event

type dw_access from u_dw within tp_users
event ue_mousemove pbm_mousemove
integer y = 724
integer width = 1157
integer height = 1576
integer taborder = 20
string dragicon = "C:\Applications\icons\New Folder\Folder_New_win7.ico"
string dataobject = "d_list_of_access_not_for_user"
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

event dragdrop;call super::dragdrop;DragObject l_DragObject

l_DragObject = DraggedObject()
If NOT IsValid( l_DragObject ) Then Return -1

If l_DragObject.TypeOf() = DataWindow! Then
	If l_DragObject.ClassName() = "dw_access_right" Then
		cb_remove.event Clicked()
		
	End If
End If 
end event

event pfc_retrieve;call super::pfc_retrieve;return This.retrieve( dw_user.getitemnumber(dw_user.getrow(),"user_no") )
end event

type cb_4 from commandbutton within tp_users
boolean visible = false
integer x = 1385
integer y = 1520
integer width = 233
integer height = 104
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
string text = ">>"
end type

event clicked;Int li_row,li_rowcount
Int li_ins
Long ll_user_no

ll_user_no = dw_user.GetItemNumber(dw_user.GetRow(),"user_no")

li_rowcount = dw_access.RowCount()

For li_row = 1 To li_RowCount	

	li_ins = dw_access_right.insertrow(0)
	dw_access_right.SetItem(li_ins ,"acid"		, dw_access.GetItemNumber(li_row,"acid"))
	dw_access_right.SetItem(li_ins ,"user_no"	,ll_user_no)	
	
Next

dw_access_right.update()
COMMIT ;
dw_access.Event pfc_retrieve()

end event

type cb_inc from commandbutton within tp_users
boolean visible = false
integer x = 1385
integer y = 1400
integer width = 233
integer height = 104
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
string text = ">"
end type

event clicked;Long ll_row
ll_row = dw_access_right.insertrow(0)
dw_access_right.SetItem(ll_row ,"acid"    , dw_access.GetItemNumber(dw_access.getrow(),"acid"))
dw_access_right.SetItem(ll_row ,"user_no" ,dw_user.GetItemNumber(dw_user.getrow(),"user_no"))
dw_user.GetItemNumber(dw_user.getrow(),"user_no")
dw_access_right.update()
COMMIT ;
dw_access.Event pfc_retrieve()
end event

type cb_remove from commandbutton within tp_users
boolean visible = false
integer x = 1385
integer y = 1276
integer width = 233
integer height = 104
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial (Arabic)"
string text = "<"
end type

event clicked;dw_access_right.accepttext()
dw_access_right.deleterow(dw_access_right.getrow())
dw_access_right.update()
dw_access.Event pfc_retrieve()
end event

type cb_3 from commandbutton within tp_users
boolean visible = false
integer x = 1385
integer y = 1148
integer width = 233
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

event clicked;Int li_row,li_rowcount

li_rowcount = dw_access_right.RowCount()

For li_row = 1 To li_RowCount
		
	dw_access_right.deleterow(0)	
	
Next

dw_access_right.update()	
Commit;
dw_access_right.SetRedraw(True)

dw_access.Event pfc_retrieve()
end event

type dw_access_right from u_dw within tp_users
event ue_mousemove pbm_mousemove
integer x = 1641
integer y = 724
integer width = 1157
integer height = 1656
integer taborder = 20
string dragicon = "Hand!"
string dataobject = "d_access_right"
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

event dragdrop;call super::dragdrop;DragObject l_DragObject

l_DragObject = DraggedObject()
If NOT IsValid( l_DragObject ) Then Return -1

If l_DragObject.TypeOf() = DataWindow! Then
If l_DragObject.ClassName() = "dw_access" Then
cb_inc.event Clicked()
End If
End If 
end event

event pfc_retrieve;call super::pfc_retrieve;return This.retrieve( dw_user.getitemnumber(dw_user.getrow(),"user_no") )
end event

type dw_user from u_dw within tp_users
event ue_noscroll pbm_vscroll
integer x = 46
integer y = 12
integer width = 3049
integer height = 600
integer taborder = 10
string dataobject = "d_user_info"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event ue_noscroll;IF This.DataObject = "d_order_details_list" THEN
	Return 0
ELSE
	Return 1
END IF
end event

event constructor;call super::constructor;This.settransobject( SQLCA )
end event

event itemchanged;call super::itemchanged;
This.setitem( row , "last_modified_by" , gstr_user_info.login_id )
This.setitem( row , "last_modified_dt" , datetime(today(),Now()) )


end event

event type long pfc_insertrow();Long ll_row

ll_row = This.insertrow(0)

if IsNull(ll_row) or ( ll_row = -1 ) then
	
	MessageBox('Error' , 'Can not add new record')
	return 0
	
else
	
	This.setitem( ll_row , "active_fg" , "Y")
	This.setitem( ll_row , "last_modified_by", gstr_user_info.login_id )
   This.setitem( ll_row , "last_modiife_dt", datetime(today(),Now()) )
	
   This.scrolltorow( ll_row )	
	
	ib_change = True
	
   return 	1
	
End if
	
	
end event

event pfc_retrieve;Long ll_res,ll_row


ll_res = This.retrieve( )

//if(ll_res > 0)then

//	if(This.RowCount() > 0)Then		
//		This.SetItem(1 , "Password", of_Decrypt(This.GetItemString(1,"Password")))
//	End if
	
//End if

Return ll_res
end event

event pfc_update;Long ll_update
int li_row
String ls_user_nm

li_row = This.GetRow()

ls_user_nm = This.GetItemString( li_row, "user_id" )
//This.SetItem(li_row , "user_nm" , This.GetItemString( li_row, "user_id" ) )
//This.AcceptText( )

//Messagebox("",ls_user_nm)

ll_update = This.update( )

if ll_update = -1 or IsNull(ll_update) then
	
	ROLLBACK ;
	
	//MessageBox("Error","Can not Update Your Data")
	
	return 0
	
else
	
	COMMIT ;
	
//	if(ib_change_password)Then

		String ls_password
		Long ll_id
	
		ll_id  = This.GetItemNumber( This.GetRow() , "User_no" )
	
		//n_cst_crypto lnv_crypt	
		//lnv_crypt = Create n_cst_crypto
		ls_password = gnv_services.of_encrypt_password(This.GetItemString(This.GetRow(),"Password")) //lnv_crypt.Encryptdata( This.GetItemString(This.GetRow(),"Password") , gnv_app.of_getMyKey() )
			
		//Destroy lnv_crypt;
		
		UPDATE USERS 
			SET PASSWORD = :ls_Password,
					USER_NM = :ls_user_nm
			WHERE USER_NO = :ll_id;
		
		Commit;	


	ib_change = False
	
	return 1
	
End if
end event

event buttonclicked;call super::buttonclicked;str_pass_parmeters lstr_parm


IF dwo.name = "b_emp" THEN

	//Open(w_search_employees)	
	lstr_parm = Message.powerobjectparm

  	IF not IsNull(lstr_parm.long_array[1]) AND lstr_parm.long_array[1] > 0  THEN
		This.setitem( row , "emid"      	, lstr_parm.long_array[1] ) 
     	This.setitem( row , "Last_modified_by" , gstr_user_info.login_id )
     	This.setitem( row , "Last_modified_dt" 	, datetime(today(),Now())) 
	ELSE
		SetNull(lstr_parm.long_array[1])
		This.setitem( row , "emid"      	, lstr_parm.long_array[1] ) 
     	This.setitem( row , "Last_modified_by" , gstr_user_info.login_id )
     	This.setitem( row , "Last_modified_dt" 	, datetime(today(),Now())) 
		
	End if
  
End if


IF IsNull(This.GetItemNumber(row , "User_no")) THEN Return 


IF dwo.name = "b_fsc" THEN
	
	lstr_parm.long_array[1]   = This.GetItemNumber(row,"user_no")
	lstr_parm.string_parm[1] = This.GetItemString(row,"user_nm")
	lstr_parm.string_parm[2] = "d_user_store_card_family"
	
	OpenWithParm( w_user_store_card_family   , lstr_parm )
	
END IF

IF dwo.name = "b_wh" THEN
	
	lstr_parm.long_array[1]   = This.GetItemNumber(row,"user_no")
	lstr_parm.string_parm[1] = This.GetItemString(row,"user_nm")
	lstr_parm.string_parm[2] = "d_user_warehouse"
	
	OpenWithParm( w_user_store_card_family   , lstr_parm )
	
END IF


IF dwo.name = "b_aow" THEN
	
	lstr_parm.long_array[1]  = This.GetItemNumber(row,"user_no")
	lstr_parm.string_parm[1] = This.GetItemString(row,"user_nm")
	lstr_parm.string_parm[2] = "d_user_aow"
	
	OpenWithParm( w_user_store_card_family   , lstr_parm )
	
END IF


end event

