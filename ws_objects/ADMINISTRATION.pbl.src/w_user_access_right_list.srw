$PBExportHeader$w_user_access_right_list.srw
forward
global type w_user_access_right_list from w_response
end type
type pb_ok from u_pb within w_user_access_right_list
end type
type dw_2 from u_dw within w_user_access_right_list
end type
type dw_access_right from u_dw within w_user_access_right_list
end type
end forward

global type w_user_access_right_list from w_response
integer x = 214
integer y = 221
integer width = 1591
integer height = 2100
boolean righttoleft = true
boolean contexthelp = true
boolean center = true
boolean ib_isupdateable = false
pb_ok pb_ok
dw_2 dw_2
dw_access_right dw_access_right
end type
global w_user_access_right_list w_user_access_right_list

type variables
String is_acid = "-1"
end variables

on w_user_access_right_list.create
int iCurrent
call super::create
this.pb_ok=create pb_ok
this.dw_2=create dw_2
this.dw_access_right=create dw_access_right
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_ok
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_access_right
end on

on w_user_access_right_list.destroy
call super::destroy
destroy(this.pb_ok)
destroy(this.dw_2)
destroy(this.dw_access_right)
end on

event close;call super::close;if(IsNull(is_acid) or Long(is_acid) < 0)Then is_acid = "-"

CloseWithReturn(This , is_acid)
end event

type pb_ok from u_pb within w_user_access_right_list
integer x = 1394
integer y = 1856
integer width = 183
integer height = 160
integer taborder = 20
string text = ""
string picturename = "C:\Applications\icons\hot\png\32x32\Apply.png"
string disabledname = "C:\Applications\icons\disabled\png\32x32\Apply.png"
end type

event clicked;call super::clicked;DataStore lds
Long ll_row , ll_RowCount ,ll_tmp
String ls_old_status , ls_new_status

lds = create DataStore	
lds.DataObject = "d_user_menu"	
lds.SetTransObject(SQLCA)
lds.retrieve( )

ll_RowCount = dw_access_right.RowCount()

FOR ll_row = 1 TO ll_RowCount
	
	ls_old_status = dw_access_right.GetItemString(ll_row , "SELECTED" , Primary! , True)
	ls_new_status = dw_access_right.GetItemString(ll_row , "SELECTED" , Primary! , False)
	
	IF ls_old_status = ls_new_status THEN Continue
	
	IF ls_old_status = 'Y' AND ls_new_status = 'N' THEN//Delete
	
		ll_tmp = lds.Find( " aid = "+String( dw_access_right.GetItemNumber( ll_row , "acid" ) ) , 1 , lds.RowCount() )
		lds.DeleteRow(ll_tmp)
		
	END IF

	IF ls_old_status = 'N' AND ls_new_status = 'Y' THEN//Insert

		ll_tmp = lds.insertrow( 0 )	
		lds.SetItem(ll_tmp , "user_no",Long(gstr_user_info.id))
		lds.SetItem(ll_tmp , "aid" , dw_access_right.GetItemNumber(ll_row , "acid"))

	END IF
	
NEXT

lds.Update(True , True)
Commit;
Destroy lds;

Close(Parent)
end event

type dw_2 from u_dw within w_user_access_right_list
event keydown pbm_dwnkey
integer y = 16
integer width = 1586
integer height = 116
integer taborder = 20
string dataobject = "d_search_access_right"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)
end event

event editchanged;call super::editchanged;String ls_txt

//ls_txt = This.GetItemString(Row , "txt")
if(isnull(data))Then
	return
End if
dw_access_right.SetFilter("match(title,'^"+data+"')")
dw_access_right.filter( )
if(dw_access_right.RowCount() <= 0 )Then
	dw_access_right.SetFilter("match(title,'."+data+"')")
	dw_access_right.filter( )
end if
end event

type dw_access_right from u_dw within w_user_access_right_list
event keydown pbm_dwnkey
integer y = 144
integer width = 1568
integer height = 1708
integer taborder = 10
string dataobject = "d_user_access_rights_lst"
boolean hscrollbar = true
boolean righttoleft = true
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)

This.event pfc_retrieve( )

IF gs_lan <> "AR" THEN
	
	This.righttoleft = False
	This.Modify("title.righttoleft=0")
	dw_2.Modify( "txt.righttoleft=0")
	
END IF


end event

event pfc_retrieve;call super::pfc_retrieve;return This.retrieve(gstr_user_info.id , gs_lan)
end event

