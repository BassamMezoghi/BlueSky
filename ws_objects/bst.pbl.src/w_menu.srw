$PBExportHeader$w_menu.srw
forward
global type w_menu from w_main_nocaption
end type
type uo_tabcontrol from u_cst_tabcontrol within w_menu
end type
end forward

global type w_menu from w_main_nocaption
integer width = 5477
integer height = 2104
string title = ""
boolean righttoleft = false
uo_tabcontrol uo_tabcontrol
end type
global w_menu w_menu

type variables
nvo_security ics_security
String is_imgs[]

end variables

forward prototypes
public function boolean of_branchsynccheck ()
public function boolean of_carsnotification (string as_dataobject)
public subroutine of_changecolor ()
public function boolean of_checkreorderpoint ()
public subroutine of_draw_tree_menu ()
public function boolean of_returnwarrentycheck ()
public subroutine uf_open_new_mails ()
public subroutine uf_post_open ()
public function integer triggeritem (menu am_menu, string target_tag)
end prototypes

public function boolean of_branchsynccheck ();//if(m_main.m_8.m_12.m_14.enabled)Then

	DataStore lds_sync
	Long ll_row , ll_count,ll_maxdays
	boolean lb_open = False
	lds_sync = Create DataStore
	lds_sync.DataObject = "d_tri_sync_data_grouped_by_dbid"
	lds_sync.settransobject(SQLCA)
	lds_sync.retrieve( )
	ll_count = lds_sync.RowCount()
	
	SELECT long_value
	INTO :ll_maxdays
	FROM PARAM_CD
	WHERE parm_nm = 'BranchMaxDelay';
	
	if(IsNull(ll_maxdays))Then return False
	
	For ll_row=1 To ll_count
	
		if( lds_sync.GetItemNumber(ll_row , "daysafter") >= ll_maxdays )Then
			Destroy lds_sync;	
			return True
		End if
	
	Next
	Destroy lds_sync;	
	return False
//Else
//	return False
//End if
end function

public function boolean of_carsnotification (string as_dataobject);nvo_security cs_security

cs_security = Create nvo_security

if(cs_security.of_checkaccessright( "339" ) > 0)Then

	DataStore lds
	lds = Create DataStore
	lds.DataObject= as_dataobject
	lds.SetTransObject(SQLCA)
	lds.Retrieve( )
	
	if(lds.RowCount() <= 0)Then
		Destroy lds
		return False
	else
		Destroy lds
		return True
	End if

End if

return False
end function

public subroutine of_changecolor ();//dw_3.modify( "title.color="+dw_3.tag )
//
//if(dw_3.tag = "8388608")Then
//	dw_3.tag = "255"
//	dw_3.modify( "p_1.visible=0" )
//else
// 	dw_3.tag = "8388608"
//	dw_3.modify( "p_1.visible=1" )	 
//end if
end subroutine

public function boolean of_checkreorderpoint ();//if(m_main.m_wm.m_reports.m_reorder.enabled)Then

	DataStore lds
	lds = Create DataStore
	lds.DataObject = "sp_inventory_with_reorder_point"
	lds.settransobject(SQLCA)
	lds.retrieve( )
	if(lds.RowCount() > 0)Then		
		Destroy lds;	
		return True
	else
		Destroy lds;	
		return False
	End if
//Else
//	return False
//End if

end function

public subroutine of_draw_tree_menu ();//n_cst_drawtree cs_tree
//
//cs_tree = Create n_cst_drawtree
//
//cs_tree.is_parentidname			= "PARENT"
//cs_tree.is_childidname			= "ACID"
//cs_tree.is_tablename				= "ACCESS_CD"
//cs_tree.is_titlename				= "TITLE"
//cs_tree.is_where					= " WHERE VISIBLE_FG = 'Y'"
//cs_tree.is_OtherProperties		= " , T.pic as pic_id "
//cs_tree.is_OrderBy					= " Order By Rank ASC"
//
//cs_tree.of_initial(tv_menu)
//
//Destroy cs_tree
//
end subroutine

public function boolean of_returnwarrentycheck ();//if(m_main.m_custom.m_custom_reports.m_warrenty_rpt.enabled)Then

	DataStore lds
	lds = Create DataStore
	lds.DataObject = "d_rpt_warranty_notifications"
	lds.settransobject(SQLCA)
	lds.retrieve( )
	if(lds.RowCount() > 0)Then		
		Destroy lds;	
		return True
	else
		Destroy lds;	
		return False
	End if
//Else
//	return False
//End if
end function

public subroutine uf_open_new_mails ();//Open(w_recivied_mail,This)
//
//w_recivied_mail.move(0,0)
//uo_shortcut.move( p_1.width  , 0 )

//Open(w_q_menu,this)
//
//w_q_menu.move(This.workspacewidth( ) - w_recivied_mail.width  , w_menu.x)




end subroutine

public subroutine uf_post_open ();//Long ll_firstpb = 300 , ll_startfrom 
//
//
//uo_Shortcut.Resize(1000 ,This.workspaceheight( ) )
//uo_Shortcut.move( 0 , 0 )
//st_spliter.resize(st_spliter.width ,This.workspaceheight( ) )
//st_spliter.move( uo_Shortcut.width , 0 )
//uo_tabcontrol.move( uo_Shortcut.width + st_spliter.width ,0 )
//uo_tabcontrol.resize( This.workspacewidth( ) - uo_Shortcut.width ,This.workspaceheight( )  )
//
//
end subroutine

public function integer triggeritem (menu am_menu, string target_tag);integer	li_idx, li_num_menus, li_count, li_numset
menu		lm_menu
str_menu	lstr_menu_list[]
boolean	lb_override
	
li_num_menus = 1
lstr_menu_list[li_num_menus].mnu = am_menu
lstr_menu_list[li_num_menus].override = False

Do While li_num_menus > 0
	lm_menu = lstr_menu_list[li_num_menus].mnu
	//li_numset += of_SetMenuStatus(lm_menu, lstr_menu_list[li_num_menus].override)
//		If a menu item is disabled or invisible then make sure that its' child items are disabled as well
//		This is done to make sure that any toolbar items that are on child menu items are not visible
   
//	lb_override =  Not lm_menu.visible Or Not lm_menu.enabled
//	
//	lm_menu.ToolBarItemVisible = lm_menu.enabled
if(lm_menu.tag = Target_Tag )	Then
	lm_menu.triggerevent( clicked!)
	return 1
End if
	li_num_menus = li_num_menus - 1
	li_count = upperbound(lm_menu.item) 
	For li_idx = 1 To li_count
		li_num_menus = li_num_menus + 1
		lstr_menu_list[li_num_menus].mnu = lm_menu.item[li_idx]		
		lstr_menu_list[li_num_menus].override = lb_override
	Next
Loop

Return 0

end function

on w_menu.create
int iCurrent
call super::create
this.uo_tabcontrol=create uo_tabcontrol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_tabcontrol
end on

on w_menu.destroy
call super::destroy
destroy(this.uo_tabcontrol)
end on

event open;String ls_db_nm , ls_db_id,ls_branch_nm
//cs_sync lc_sync

//cst_main_page uo_main
main_tabpage uo_main

ics_security = Create nvo_security

is_imgs[1] = "UserObject5!"
is_imgs[2] = "C:\Applications\icons\New Folder\home.ico"
is_imgs[3] = "C:\Applications\icons\New Folder\cube_config.ico"
is_imgs[4] = "C:\Applications\icons\New Folder\misc_box.ico"
is_imgs[5] = "C:\Applications\icons\New Folder\ico\document-yellow.ico"
is_imgs[6] = "C:\Applications\icons\New Folder\ico\Address-book.ico"
is_imgs[7] = "C:\Applications\icons\New Folder\page.ico"
is_imgs[8] = "C:\Applications\icons\New Folder\ico\document.ico"

uo_tabcontrol.of_AddImage("UserObject5!")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\home.ico")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\cube_config.ico")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\misc_box.ico")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\ico\document-yellow.ico")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\ico\Address-book.ico")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\page.ico")
uo_tabcontrol.of_AddImage("C:\Applications\icons\New Folder\ico\document.ico")

//Set the tab style to VS2005
uo_tabcontrol.of_SetStyle(uo_tabcontrol.VS2005)
Choose Case ProfileString( gnv_app.of_getappinifile( )  , "Database", "BGColor", "Blue")
	Case "Blue"
		uo_tabcontrol.of_SetTheme(uo_tabcontrol.blue )
	Case "Olive"
		uo_tabcontrol.of_SetTheme(uo_tabcontrol.Olive )
	Case "Silver"
		uo_tabcontrol.of_SetTheme(uo_tabcontrol.Silver )
End Choose

uo_tabcontrol.of_OpenTab(uo_main, "الشاشة الرئيسية"/*gnv_Lan.of_get_title(gs_lan , "Main" , "MainTabTitle")*/ , 2)
////Select the first tab
uo_tabcontrol.of_SelectTab( 1 )

uo_main.ics_security = ics_security
//////////////////////////////////////////

//lc_sync = Create cs_sync

//lc_sync.of_curent_db_info( ls_db_nm , ls_db_id,ls_branch_nm)

This.Title  = gnv_app.iapp_object.DisplayName +" ::: "+gstr_user_info.branch_nm+ " ::: "+gs_AppVer

Timer(500)

Event post ue_post_open()
end event

event ue_post_open;call super::ue_post_open;POST uf_post_open()
POST uf_open_new_mails()


//tv_menu.setfocus( )
end event

event timer;call super::timer;IF gstr_user_info.teamviewer = "Y" THEN
	IF Not gnv_app.of_findwindow( "teamviewer") THEN 
			MessageBox("تنبيه","يجب تشغيل برنامج تيم فيور للتشغيل المنظومة",StopSign!)
			gnv_app.event pfc_exit( )
	END IF
End if
end event

event resize;call super::resize;
uo_tabcontrol.move(0,0)

uo_tabcontrol.Resize(Newwidth , NewHeight)
end event

event key;call super::key;
//n_pos pos
Long ll_idx

ll_idx = uo_tabcontrol.of_getselectedtab( )

IF keydown( KeyEnter! ) THEN
IF uo_tabcontrol.ist_tabs[ll_idx].ado_object.tag = "319" THEN
	//pos = uo_tabcontrol.ist_tabs[ll_idx].ado_object
	//pos.dw_info.setfocus( )
END IF
END IF

end event

type cb_1 from w_main_nocaption`cb_1 within w_menu
boolean visible = false
end type

type uo_tabcontrol from u_cst_tabcontrol within w_menu
event destroy ( )
event settabpage ( u_cst_tabpage tabpage,  string ar_title,  integer ai_index,  string ar_tag )
event type long of_duplicity ( string as_do )
event type u_cst_tabpage gettabpage ( string as_do )
event bst_keydown pbm_keydown
integer x = 5
integer width = 5422
integer height = 1972
integer taborder = 30
boolean bringtotop = true
end type

on uo_tabcontrol.destroy
call u_cst_tabcontrol::destroy
end on

event settabpage(u_cst_tabpage tabpage, string ar_title, integer ai_index, string ar_tag);Long ll_row,ll_count
//u_cst_tabpage tabpage

ll_row = this.event of_duplicity( ar_tag )

IF(ll_row = 0)Then
	tabpage.tag = ar_tag
	tabpage.text = ar_title
	This.of_opentab( tabpage, ar_title ,ai_index )
	ll_row = upperbound(This.ist_tabs)
END IF

//tabpage = This.ist_tabs[ll_row].ado_object	

 This.of_SelectTab( ll_row )		
 
 return 
end event

event type long of_duplicity(string as_do);Long ll_rowcount,ll_row

ll_rowcount = UpperBound(This.ist_tabs)
	
For ll_row=1 To ll_rowcount
	
		if(as_do = This.ist_tabs[ll_row].ado_object.tag )Then 
			This.of_selecttab( ll_row )			
			Return ll_row
		end if
		
Next

Return 0
end event

event type u_cst_tabpage gettabpage(string as_do);Long ll_rowcount,ll_row
u_cst_tabpage tabpage

tabpage = Create u_cst_tabpage

ll_rowcount = UpperBound(This.ist_tabs)
	
For ll_row=1 To ll_rowcount
	
		if(as_do = This.ist_tabs[ll_row].ado_object.tag )Then 
			This.of_selecttab( ll_row )
			tabpage = This.ist_tabs[ll_row].ado_object
			Return tabpage
		end if
		
Next

Return tabpage
end event

event tabclosing;call super::tabclosing;IF index = 1 THEN Return 0
Return 1
end event

