$PBExportHeader$w_user_groups_cd.srw
forward
global type w_user_groups_cd from w_response
end type
type pb_ok from u_pb within w_user_groups_cd
end type
type dw_2 from u_dw within w_user_groups_cd
end type
type dw_access_right from u_dw within w_user_groups_cd
end type
end forward

global type w_user_groups_cd from w_response
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
global w_user_groups_cd w_user_groups_cd

type variables
Long il_user_no = 0

end variables

on w_user_groups_cd.create
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

on w_user_groups_cd.destroy
call super::destroy
destroy(this.pb_ok)
destroy(this.dw_2)
destroy(this.dw_access_right)
end on

event close;call super::close;Close( This )
end event

event open;call super::open;str_pass_parmeters lstr_parm

lstr_parm = Message.PowerObjectParm

il_user_no = lstr_parm.long_parm[1]
end event

type pb_ok from u_pb within w_user_groups_cd
integer x = 1394
integer y = 1856
integer width = 183
integer height = 160
integer taborder = 20
string text = ""
string picturename = "C:\Applications\icons\hot\png\32x32\Apply.png"
string disabledname = "C:\Applications\icons\disabled\png\32x32\Apply.png"
end type

event clicked;call super::clicked;DataStore lds_view , lds_add 
Long ll_row , ll_RowCount ,ll_tmp
Long ll_itr , ll_TotalRows

lds_view = create DataStore	
lds_view.DataObject = "d_all_access_by_group"	
lds_view.SetTransObject(SQLCA)

lds_add = create DataStore	
lds_add.DataObject = "d_access_right"	
lds_add.SetTransObject(SQLCA)
lds_add.retrieve( il_user_no )

ll_RowCount = dw_access_right.RowCount()

FOR ll_row = 1 TO ll_RowCount
		
	IF dw_access_right.GetItemString(ll_row , "SELECTED" ) = 'Y' THEN//Insert
	
		lds_view.retrieve( dw_access_right.GetItemString(ll_row , "id" ) )	
		ll_TotalRows = lds_view.RowCount()
		
		FOR ll_itr = 1 To ll_TotalRows
			
			ll_tmp = lds_add.Find( "ACID = "+ String(lds_view.GetItemNumber(ll_itr , "acid" ) )  ,1, ll_TotalRows) 
			
			IF IsNull(ll_tmp) or ll_tmp < 1 THEN
				
				ll_tmp = lds_add.insertrow( 0 )	
			
				lds_add.SetItem(ll_tmp , "user_no",il_user_no)
				lds_add.SetItem(ll_tmp , "acid" , lds_view.GetItemNumber(ll_itr , "acid"))
				
			END IF
			
		NEXT

	END IF
	
NEXT

lds_add.Update(True , True)
Commit;
Destroy lds_add;

Close(Parent)
end event

type dw_2 from u_dw within w_user_groups_cd
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

type dw_access_right from u_dw within w_user_groups_cd
event keydown pbm_dwnkey
integer y = 144
integer width = 1568
integer height = 1708
integer taborder = 10
string dataobject = "d_user_groups_list"
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

