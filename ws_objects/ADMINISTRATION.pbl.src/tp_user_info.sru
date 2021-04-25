$PBExportHeader$tp_user_info.sru
forward
global type tp_user_info from u_cst_tabpage
end type
type dw_filter from u_dw within tp_user_info
end type
type dw_list from u_dw within tp_user_info
end type
type cb_add from u_cb within tp_user_info
end type
type cb_save from u_cb within tp_user_info
end type
type cb_1 from u_cb within tp_user_info
end type
type cb_2 from u_cb within tp_user_info
end type
type uo_tabcontrol from u_cst_tabcontrol within tp_user_info
end type
end forward

global type tp_user_info from u_cst_tabpage
integer width = 4617
integer height = 2596
dw_filter dw_filter
dw_list dw_list
cb_add cb_add
cb_save cb_save
cb_1 cb_1
cb_2 cb_2
uo_tabcontrol uo_tabcontrol
end type
global tp_user_info tp_user_info

type variables
str_pass_parmeters istr_parm
tp_users users
tp_app_parts parts

end variables

forward prototypes
public function boolean of_canclose ()
public function string of_convertarraytostring (str_pass_parmeters ar_parm)
public subroutine of_password_change ()
public subroutine of_color (u_dw ar_dw)
end prototypes

public function boolean of_canclose ();Return True
end function

public function string of_convertarraytostring (str_pass_parmeters ar_parm);Long ll_upperBound,ll_itr
String ls_res=""

ll_upperBound = UPPERBOUND(ar_parm.Long_array )

FOR ll_itr = 1 TO ll_UpperBound 
	IF ll_itr = ll_UpperBound  THEN
		ls_res += String(ar_parm.Long_array[ll_itr])
	ELSE
		ls_res += String(ar_parm.Long_array[ll_itr])+","
	END IF
NEXT

Return ls_res
end function

public subroutine of_password_change ();String ls_password
Long ll_id
	
ll_id  = users.dw_user.GetItemNumber( users.dw_user.GetRow() , "User_no" )
		
users.dw_user.accepttext( )
			
ls_password = gnv_services.of_encrypt_password( "1234" ) 
		
UPDATE USERS 
		SET PASSWORD = :ls_Password , INCOME = 'Y'
		WHERE USER_NO = :ll_id;
			
Commit;

IF SQLCA.sqlcode = 0 THEN
	gnv_msg.of_message( 54 ) // reset success
END IF

Return
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

on tp_user_info.create
int iCurrent
call super::create
this.dw_filter=create dw_filter
this.dw_list=create dw_list
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_tabcontrol=create uo_tabcontrol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.uo_tabcontrol
end on

on tp_user_info.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.dw_list)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_tabcontrol)
end on

event ue_postconstructor;call super::ue_postconstructor;
of_color(dw_list)

uo_tabcontrol.of_AddImage('UserObject5!')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\home.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\cube_config.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\misc_box.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\ico\document-yellow.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\ico\report.ico')
uo_tabcontrol.of_AddImage('C:\Applications\icons\New Folder\ico\red_folder.ico')

//Set the tab style to VS2005
uo_tabcontrol.of_SetStyle(uo_tabcontrol.excel)

//uo_tabcontrol.of_hidearrows( )
uo_tabcontrol.of_SetTheme(uo_tabcontrol.blue )
//uo_tabcontrol.of_hideclosebutton( )

uo_tabcontrol.iw_parent = w_menu

IF gstr_user_info.login_id = "support" THEN
	
	parts = CREATE tp_app_parts
	uo_tabcontrol.of_OpenTab(parts, "اجزاء النظام" , 1)
	uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

END IF

users = CREATE tp_users

uo_tabcontrol.of_OpenTab(users, This.Text , 1)
uo_tabcontrol.of_selecttab( UpperBound( uo_tabcontrol.ist_tabs))

dw_list.sharedata( users.dw_user  )
dw_list.retrieve( gstr_user_info.login_id )
users.dw_access.Event pfc_retrieve( )
users.dw_access_right.Event pfc_retrieve( )




end event

event resize;call super::resize;
uo_tabcontrol.move(0 , 0)
uo_tabcontrol.resize(NewWidth - dw_list.width , NewHeight )

dw_filter.move(NewWidth - dw_list.Width   , 0)

dw_list.Resize(dw_list.width -10  , NewHeight - 128)
dw_list.move(NewWidth - dw_list.Width  , dw_filter.height )



end event

type dw_filter from u_dw within tp_user_info
integer x = 2766
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

event editchanged;call super::editchanged;dw_list.setfilter( "Match(nm,'^"+data+"')" )
dw_list.filter( )

IF dw_list.RowCount( ) = 0 THEN
	dw_list.setfilter( "Match(user_nm,'^"+data+"')" )
	dw_list.filter( )
END IF	

end event

type dw_list from u_dw within tp_user_info
integer x = 2743
integer y = 128
integer width = 1874
integer height = 2440
integer taborder = 20
string dataobject = "d_user_list"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean righttoleft = true
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event clicked;call super::clicked;
users.of_scrolltorow(dw_list.GetITemString(row , "user_id") )

end event

event constructor;call super::constructor;This.settransobject(SQLCA)

end event

event buttonclicked;call super::buttonclicked;str_pass_parmeters lstr_parm

IF dwo.name = "b_add" THEN
	
	  dw_list.Event pfc_insertrow()
	  users.dw_access.retrieve( -1 )
	  users.dw_access_right.retrieve( -1 )
      cb_add.enabled   = False
      cb_save.enabled  = True

      cb_add.tag       = '1'
		
END IF

IF dwo.name = "b_save" THEN

		IF cb_add.tag = '0' THEN

			
         dw_list.Event pfc_update(True,True)
			Commit;
			//of_password_change()	
			
	      	//cb_add.enabled   = True
			//cb_save.enabled  = False   
			
		ELSEIF NOT gnv_services.check_user_id(users.dw_user.getitemstring(users.dw_user.getrow(),"user_id")) THEN
	
         dw_list.Event pfc_update(True,True)	 
			
			//of_password_change()
			
			Commit;
         cb_add.tag       = '0'
			  
		ELSE
	
         //  MessageBox("Warning","اسم المستخدم موجود مسبقا",StopSign!)
			gnv_msg.of_message( 55 )
	 		 
      End if
		
END IF


IF dwo.name = "b_delete" THEN
	
		dw_list.SetItem(row , "Active_fg" , "N" )
		dw_list.Update()
//		dw_list.Event pfc_retrieve( )
		Commit;
	
END IF

IF dwo.name = "b_repair" THEN

		dw_list.SetItem(row , "Active_fg" , "Y" )
		
		dw_list.Update()
		Commit;
//		dw_list.Event pfc_retrieve( )

END IF

IF dwo.name = "b_reset" THEN
	of_password_change()
END IF


end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_row
String ls_password

ll_row = This.GetRow() 

IF IsNull(This.GetItemNumber(ll_row , "User_no")) THEN

	This.SetItem(ll_row , "User_no" , Long( gnv_services.uf_get_id_from_parm_cd( "USERS" ) ))
	
	ls_password = gnv_services.of_encrypt_password( "1234" ) 
	This.SetItem(ll_row , "password" , ls_password )

END IF

//This.SetItem( ll_row , "user_nm" , This.GetItemString(ll_row , "user_id"))

Return SUCCESS
end event

type cb_add from u_cb within tp_user_info
string tag = "0"
boolean visible = false
integer x = 2354
integer y = 2464
integer height = 104
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إضافة"
end type

event clicked;call super::clicked;//if(Demo and tab_main.tabpage_user_info.dw_user.RowCount() > 1)Then Return
//choose case tab_main.selectedtab
//	case 1
//		tab_main.tabpage_user_info.dw_user.Event pfc_insertrow()
//
//      cb_add.enabled   = False
//      cb_save.enabled  = True
//
//      cb_add.tag       = '1'
//		
//	case 2
//		
//		tab_main.tabpage_access.dw_1.Event pfc_insertrow()
//
//      cb_add.enabled   = False
//      cb_save.enabled  = True
//		
//	case 4
//		Long ll_row
//		ll_row = tab_main.tabpage_1.dw_2.event pfc_insertrow( )
//		if(isnull(ll_row))Then ll_row = 0
//		if( ll_row > 0  )then
//		
//			cb_add.enabled   = False
//      		cb_save.enabled  = True
//			
//		else
//			Messagebox("تنبيه" , "لايمكن اضافة جهاز جديد بسبب استكمال الحد المسموح به")
//		end if
//end choose
//
//
//
//
end event

type cb_save from u_cb within tp_user_info
boolean visible = false
integer x = 1998
integer y = 2464
integer height = 104
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "حفـــظ"
end type

event clicked;call super::clicked;//datawindowchild lcdw_user
//
//choose case tab_main.selectedtab
//	case 1
//		if cb_add.tag = '0' then
//  
//         tab_main.tabpage_user_info.dw_user.Event pfc_update(True,True)
//	
//      	cb_add.enabled   = True
//          cb_save.enabled  = False   
//	
//      else
//
//        if not gnv_services.check_user_id(tab_main.tabpage_user_info.dw_user.getitemstring(tab_main.tabpage_user_info.dw_user.getrow(),"user_id")) then
//	
//           tab_main.tabpage_user_info.dw_user.Event pfc_update(True,True)
//	
//      	  cb_add.enabled   = True
//           cb_save.enabled  = False    
//	  
//           cb_add.tag       = '0'
//			  
//        else
//	
//           MessageBox("Warning","اسم المستخدم موجود مسبقا",StopSign!)
//	
//        End if
//  
//      End if
//		
//		tab_main.tabpage_access_right.dw_user_list.getchild( "user_no" , lcdw_user )
//		lcdw_user.settransobject( SQLCA )
//		lcdw_user.retrieve( )
//		
//		tab_main.tabpage_user_info.dw_list.retrieve( )
//	case 2
//		tab_main.tabpage_access.dw_1.Event pfc_update(True,True)
//		cb_add.enabled   = True
//      	cb_save.enabled  = False 
//	case 3
//		tab_main.tabpage_1.dw_2.Accepttext( )
//		tab_main.tabpage_1.dw_2.Event pfc_update(True,True)
//		cb_add.enabled   = True
//      	cb_save.enabled  = False 
//		
//end choose
//
//tab_main.tabpage_1.dw_3.Event pfc_update(True , True)
//
end event

type cb_1 from u_cb within tp_user_info
boolean visible = false
integer x = 1641
integer y = 2464
integer height = 104
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "توقيف"
end type

event clicked;call super::clicked;//Long ll_row
//Choose Case tab_main.selectedtab
//	Case 1
//		ll_row = tab_main.tabpage_user_info.dw_user.GetRow()
//		tab_main.tabpage_user_info.dw_user.SetItem(ll_row , "Active_fg" , "N" )
//		tab_main.tabpage_user_info.dw_user.Update()
//		tab_main.tabpage_user_info.dw_list.Event pfc_retrieve( )
//	Case 4
//		ll_row = tab_main.tabpage_1.dw_2.GetRow()
//		tab_main.tabpage_1.dw_2.SetItem(ll_row , "SUSPEND_FG" , "Y" )
//		tab_main.tabpage_1.dw_2.Update()
//		tab_main.tabpage_1.dw_2.Event pfc_retrieve( )
//		
//End Choose

end event

type cb_2 from u_cb within tp_user_info
boolean visible = false
integer x = 1285
integer y = 2464
integer height = 104
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "تفعيل"
end type

event clicked;call super::clicked;//Long ll_row,ll_update
//Choose Case tab_main.selectedtab
//	Case 1
//		
//		ll_row = tab_main.tabpage_user_info.dw_user.GetRow()
//		tab_main.tabpage_user_info.dw_user.SetItem(ll_row , "Active_fg" , "Y" )
//		tab_main.tabpage_user_info.dw_user.Update()
//		tab_main.tabpage_user_info.dw_list.Event pfc_retrieve( )
//	Case 4
//		ll_row = tab_main.tabpage_1.dw_2.GetRow()
//		This.SetRedraw( False )		
//		tab_main.tabpage_1.dw_2.SetItem(ll_row , "SUSPEND_FG" , "N" )
//		ll_update = tab_main.tabpage_1.dw_2.event pfc_update( True , True )
//		if(ll_update = -1)Then
//			Messagebox("تنبيه" , "لايمكن تفعيل جهاز جديد بسبب استكمال الحد المسموح به")
//			tab_main.tabpage_1.dw_2.SetItem(ll_row , "SUSPEND_FG" , "Y" )					
//		end if
//		this.SetRedraw( True ) 
//		tab_main.tabpage_1.dw_2.Event pfc_retrieve( )		
//End Choose
//
end event

type uo_tabcontrol from u_cst_tabcontrol within tp_user_info
event destroy ( )
integer width = 2715
integer height = 2576
integer taborder = 41
end type

on uo_tabcontrol.destroy
call u_cst_tabcontrol::destroy
end on

