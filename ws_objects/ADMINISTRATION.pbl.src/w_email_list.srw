$PBExportHeader$w_email_list.srw
forward
global type w_email_list from window
end type
type dw_nm from u_dw within w_email_list
end type
type dw_group from u_dw within w_email_list
end type
type dw_access from u_dw within w_email_list
end type
type cb_inc from commandbutton within w_email_list
end type
type cb_remove from commandbutton within w_email_list
end type
type dw_access_right from u_dw within w_email_list
end type
type gb_1 from groupbox within w_email_list
end type
type gb_2 from groupbox within w_email_list
end type
end forward

global type w_email_list from window
integer width = 2510
integer height = 2128
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_nm dw_nm
dw_group dw_group
dw_access dw_access
cb_inc cb_inc
cb_remove cb_remove
dw_access_right dw_access_right
gb_1 gb_1
gb_2 gb_2
end type
global w_email_list w_email_list

type variables
Long il_group_id
str_pass_parmeters istr_parm
String is_field = ""
end variables

forward prototypes
public subroutine of_filter ()
end prototypes

public subroutine of_filter ();String ls_filter , ls_nm
Long ll_gid

il_group_id = dw_group.GetItemNumber(1 , "group_id")
ls_nm = dw_nm.GetItemString(1 , "nm")

IF not IsNull(il_group_id) THEN
	dw_access.Event pfc_retrieve()
	dw_access_right.Event pfc_retrieve()
END IF

IF Not IsNull(ls_nm) AND ls_nm <> "البحث" THEN
	
	IF ls_filter = "" THEN
		ls_filter = "match(title , '"+ls_nm+".')"
	ELSE
		ls_filter += " AND match(title , '"+ls_nm+".')"		
	END IF

END IF

dw_access.SetFilter( ls_filter )
dw_access.Filter()

dw_access_right.SetFilter( ls_filter )
dw_access_right.Filter()
end subroutine

on w_email_list.create
this.dw_nm=create dw_nm
this.dw_group=create dw_group
this.dw_access=create dw_access
this.cb_inc=create cb_inc
this.cb_remove=create cb_remove
this.dw_access_right=create dw_access_right
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_nm,&
this.dw_group,&
this.dw_access,&
this.cb_inc,&
this.cb_remove,&
this.dw_access_right,&
this.gb_1,&
this.gb_2}
end on

on w_email_list.destroy
destroy(this.dw_nm)
destroy(this.dw_group)
destroy(this.dw_access)
destroy(this.cb_inc)
destroy(this.cb_remove)
destroy(this.dw_access_right)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;
istr_parm = Message.PowerObjectParm

dw_group.SetTransObject( SQLCA )


dw_group.Modify("group_id.width=1850")
dw_group.Modify("group_id_t.x=1888")

choose case istr_parm.string_parm[1]
	case "mail"
		gb_1.text = "اعضاء المجموعة"
		gb_2.text = "الموظفين"
		dw_access.DataObject = "d_all_empoyee_without_email_group"
		dw_access.SetTransObject(SQLCA)
		dw_access_right.DataObject = "d_all_employee_by_email_list"
		dw_access_right.SetTransObject(SQLCA)
		is_field = "emid"
		dw_group.Modify("group_id.dddw.name=dddw_email_groups")
		
	case "uga"
		gb_1.text = "صلاحيات المجموعة"
		gb_2.text = "الصلاحيات"
		dw_access.DataObject = "d_all_access_not_in_group"
		dw_access.SetTransObject(SQLCA)
		dw_access_right.DataObject = "d_all_access_by_group"
		dw_access_right.SetTransObject(SQLCA)		
		is_field = "acid"
		dw_group.Modify("group_id.dddw.name=dddw_users_group")
		
	case "vg"
		gb_1.text = "مركبات المجموعة" // "صلاحيات المجموعة"
		gb_2.text = "المركبات" //"الصلاحيات"
		dw_access.DataObject = "d_all_vehicle_not_in_group"
		dw_access.SetTransObject(SQLCA)
		dw_access_right.DataObject = "d_all_vehicle_by_group"
		dw_access_right.SetTransObject(SQLCA)		
		is_field = "vid"
		dw_group.Modify("group_id.dddw.name=dddw_vehicle_group_cd")
		
case "hrg"
		gb_1.text = "اعضاء المجموعة"// "صلاحيات المجموعة"
		gb_2.text = "المستخدمين" //"الصلاحيات"
		dw_access.DataObject = "d_all_employees_not_in_group"
		dw_access.SetTransObject(SQLCA)
		dw_access_right.DataObject = "d_all_employees_by_group"
		dw_access_right.SetTransObject(SQLCA)		
		is_field = "group_id"
		dw_group.Modify("group_id.dddw.name=dddw_employee_group_cd")		
		
end choose

dw_group.Modify("group_id.dddw.displaycolumn=title")
dw_group.Modify("group_id.dddw.datacolumn=id")
dw_group.InsertRow(0)

end event

type dw_nm from u_dw within w_email_list
integer x = 18
integer y = 124
integer width = 2478
integer height = 108
integer taborder = 40
string dataobject = "ext_customer_nm"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)

This.SetItem(This.InsertRow(0) , "nm" ,"البحث")

This.Modify("b_1.visible=0")
This.Modify("nm.width=2220")



end event

event editchanged;call super::editchanged;This.accepttext( )
of_filter()
//String ls_filter
//Long ll_pos
//
//This.accepttext( )
//
//ll_pos = Pos(data ,  "للبحث عن زبون")
//
//if(ll_pos > 0 and len(data) > 13)Then 
//	data = Replace(data, ll_pos, 13, "")	
//	This.SetItem(row , "nm" , data)
//	This.SelectText (2, 1 )
//end if
//
//if(trim(data) = "")then
//	ls_filter = ""
//	This.SetItem(row , "nm" , "للبحث عن زبون")
//else
//	ls_filter = "Match(customer_nm, '^"+data+"')"
//end if
//
//dw_access_right.setfilter( ls_filter )
//dw_access_right.filter()
//
//dw_access.setfilter( ls_filter )
//dw_access.filter()
end event

event getfocus;call super::getfocus;This.SetItem(This.GetRow() , "nm" , "")
end event

type dw_group from u_dw within w_email_list
integer x = 23
integer y = 4
integer width = 2473
integer height = 108
integer taborder = 30
string dataobject = "d_ext_group_nm"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;This.accepttext( )

il_group_id = Long(data)

of_filter()
end event

type dw_access from u_dw within w_email_list
event ue_mousemove pbm_mousemove
integer x = 27
integer y = 340
integer width = 1088
integer height = 1664
integer taborder = 20
string dragicon = "CreateLibrary5!"
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_rmbmenu = false
end type

event ue_mousemove;IF keydown( KeyLeftButton! ) THEN
	This.Drag( Begin! )
END IF
end event

event constructor;call super::constructor;//This.settransobject( SQLCA )

end event

event pfc_retrieve;call super::pfc_retrieve;IF istr_parm.string_parm[1]  = "mail" or istr_parm.string_parm[1]  = "hrg" THEN
	return This.retrieve( il_group_id )
ELSE
	return This.retrieve( String(il_group_id ) )
END IF

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

type cb_inc from commandbutton within w_email_list
integer x = 1170
integer y = 1048
integer width = 155
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

il_group_id = dw_group.GetItemNumber(1 , "group_id")

IF istr_parm.string_parm[1] = "hrg" THEN
	
	dw_access.SetItem(dw_access.GetRow() , is_field ,il_group_id )
	dw_access.update()
	
ELSE
	
ll_row = dw_access_right.insertrow(0)

dw_access_right.SetItem( ll_row , is_field   , dw_access.GetItemNumber(dw_access.GetRow() , is_field))

IF istr_parm.string_parm[1] = "mail" THEN
	dw_access_right.SetItem( ll_row , "id"       , il_group_id )
	
	ELSEIF( istr_parm.string_parm[1] = "vg") THEN
		dw_access_right.SetItem( ll_row , "id"       , il_group_id )
	ELSE
		dw_access_right.SetItem( ll_row , "id"       , string(il_group_id ))
END IF

dw_access_right.update()

END IF


COMMIT ;

dw_access.Event pfc_retrieve()
dw_access_right.Event pfc_retrieve()
end event

type cb_remove from commandbutton within w_email_list
integer x = 1170
integer y = 932
integer width = 155
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

event clicked;Long ll_gid

IF istr_parm.string_parm[1] = "hrg" THEN
	
	setnull(ll_gid)	
	
	dw_access_right.SetItem(dw_access_right.GetRow() , is_field ,ll_gid )
	
ELSE
	
	dw_access_right.DeleteRow( dw_access_right.GetRow() )

END IF


dw_access_right.Update()
	

COMMIT;

dw_access.Event pfc_retrieve()
dw_access_right.Event pfc_retrieve()
end event

type dw_access_right from u_dw within w_email_list
event ue_mousemove pbm_mousemove
integer x = 1390
integer y = 336
integer width = 1083
integer height = 1664
integer taborder = 20
string dragicon = "Hand!"
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_rmbmenu = false
end type

event ue_mousemove;IF keydown( KeyLeftButton! ) THEN
	This.Drag( Begin! )
END IF
end event

event constructor;call super::constructor;//This.settransobject( SQLCA )
end event

event pfc_retrieve;call super::pfc_retrieve;IF istr_parm.string_parm[1]  = "mail" or istr_parm.string_parm[1]  = "hrg" THEN
	return This.retrieve( il_group_id )
ELSE
	return This.retrieve( String(il_group_id ) )
END IF


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

type gb_1 from groupbox within w_email_list
integer x = 1353
integer y = 268
integer width = 1138
integer height = 1756
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

type gb_2 from groupbox within w_email_list
integer y = 268
integer width = 1138
integer height = 1756
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

