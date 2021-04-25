$PBExportHeader$w_tree_view.srw
forward
global type w_tree_view from w_lol_popup
end type
type cb_search from lol_cb within w_tree_view
end type
type tv_tree from u_tvs within w_tree_view
end type
type st_search from lol_st within w_tree_view
end type
type sle_search from lol_sle within w_tree_view
end type
type gb_search from lol_gb within w_tree_view
end type
type cb_close from lol_cb within w_tree_view
end type
type cb_select from lol_cb within w_tree_view
end type
type gb_tree from lol_gb within w_tree_view
end type
type gb_btn from lol_gb within w_tree_view
end type
end forward

global type w_tree_view from w_lol_popup
integer width = 1792
integer height = 1764
cb_search cb_search
tv_tree tv_tree
st_search st_search
sle_search sle_search
gb_search gb_search
cb_close cb_close
cb_select cb_select
gb_tree gb_tree
gb_btn gb_btn
end type
global w_tree_view w_tree_view

type variables
String is_TableName , is_ChildIDName 
String is_ParentIDName , is_TitleName
String is_DWName = "d_tree_view"
str_stack is_selected_data
DataStore ids_tree_view
lol_stack inv_stack
uo_resize iuo_resize



end variables

forward prototypes
public function string uf_sqlquery ()
public subroutine uf_pushparentintostack (string as_parent_id, integer al_handle)
public subroutine uf_filltree ()
public function long uf_searchitem (string as_data, treeview atv)
public subroutine uf_pushparenttreeitem (long al_handle)
public subroutine uf_redrowtree ()
end prototypes

public function string uf_sqlquery ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
// Function	: uf_SQLQuery																						//
// Object	: w_tree_view																									//
// Author	: Bassam Mezoghi																							//
// Date		:12-03-2007 																												//
//																																//
// Description : This function create query for datawindow d_tree_view.															//
// Modifications: 																											//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

String ls_query

ls_query = "SELECT CAST(T."+is_ChildIDName+" AS varchar(20)) AS child_id,  CASE ISNULL(T."+is_ParentIDName+" , -100) WHEN -100 THEN '-100' WHEN  T."+is_ChildIDName+" THEN '-100' ELSE CAST(T."+is_ParentIDName+" AS Varchar(20) ) END AS parent_id, T."+is_TitleName+" AS Title FROM "+is_TableName+" AS T WHERE T.ACTIVE_FG = 'Y'"

Return ls_query
end function

public subroutine uf_pushparentintostack (string as_parent_id, integer al_handle);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
// Function	: uf_pushparentintostack																						//
// Object	: w_tree_view																									//
// Author	: Bassam Mezoghi																							//
// Date		:12-03-2007 																												//
//																																//
// Description : This function push all parent node into the stack.															//
// Modifications: 																											//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long ll_start , ll_end , ll_return
str_stack lstr_stack

ids_tree_view.setfilter( "parent_id = '"+as_parent_id+"'" )
ids_tree_view.filter( )

ll_end   = ids_tree_view.rowcount()

For ll_start=1 To ll_end

   lstr_stack.as_data		=  ids_tree_view.GetItemString(ll_start,"child_id") 
   lstr_stack.as_title		=  ids_tree_view.GetItemString(ll_start,"title") 
   lstr_stack.as_parent	=  ids_tree_view.GetItemString(ll_start,"parent_id") 
   lstr_stack.al_handle 	=  al_handle
	
   inv_stack.of_push( lstr_stack )
		
Next

end subroutine

public subroutine uf_filltree ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
// Function	: uf_FillTree																						//
// Object	: w_tree_view																									//
// Author	: Bassam Mezoghi																							//
// Date		:12-03-2007 																												//
//																																//
// Description : This function fillout the tree.															//
// Modifications: 																											//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Any la_key
Long ll_parent
str_stack lstr_stack
TreeViewItem ltvi
//push the roots
uf_PushParentIntoStack("-100" , 0)

Do While Not inv_stack.of_isempty( )

   lstr_stack        = inv_stack.of_pop( )
/*************************************************/	
//	ltvi.data         = lstr_stack.as_data
	ltvi.data		= lstr_stack
/*************************************************/	

	ltvi.label        = lstr_stack.as_title
   	ltvi.pictureindex = 1
	ltvi.selectedpictureindex = 2
	
	ll_parent         = tv_tree.insertitemsort( lstr_stack.al_handle , ltvi )
	
	uf_PushParentIntoStack(lstr_stack.as_data , ll_parent)
	
Loop
end subroutine

public function long uf_searchitem (string as_data, treeview atv);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
// Function	: uf_searchitem																						//
// Object	: w_tree_view																									//
// Author	: Bassam Mezoghi																							//
// Date		:12-03-2007 																												//
//																																//
// Description : This function search for item using Stack.															//
// Modifications: 																											//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

TreeViewItem ltvi_item 
Long ll_itemhandle ,ll_childhandle
str_stack lstr_stack


if ( isnull(as_data) OR trim(as_data) = "" ) then return -1

uf_pushParenttreeitem(0)

Do While Not inv_stack.of_isempty( )
	
   
	lstr_stack    = inv_stack.of_pop( )
	ll_itemhandle = lstr_stack.al_handle
	
	tv_tree.getitem( ll_itemhandle , ltvi_item )

	if(ltvi_item.label = as_data )then 
	
   	ltvi_item.selectedpictureindex = 2
		tv_tree.setitem( ll_itemhandle , ltvi_item )
  	   tv_tree.selectitem( ll_itemhandle )

	   return ll_itemhandle
		
	else

		ll_childhandle = tv_tree.finditem( ChildTreeItem!, ll_itemhandle)
		
      Do while ll_childhandle > 0
			
			lstr_stack.al_handle = ll_childhandle
			
			inv_stack.of_push( lstr_stack )
			
			ll_childhandle = tv_tree.finditem( NextTreeItem! , ll_childhandle)
			
		Loop
		
	end if
	
	
Loop

return 0
end function

public subroutine uf_pushparenttreeitem (long al_handle);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//																																//
// Function	: uf_pushparentintostack																						//
// Object	: w_tree_view																									//
// Author	: Bassam Mezoghi																							//
// Date		:12-03-2007 																												//
//																																//
// Description : This function push all parent node into the stack.															//
// Modifications: 																											//
//																																//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long ll_childitem 
str_stack lstr_stack
TreeViewItem ltvi

ll_childitem =  tv_tree.finditem( RootTreeItem!	 , 0)

Do while ll_childitem > 0

   lstr_stack.al_handle = ll_childitem
	inv_stack.of_push( lstr_stack )
	ll_childitem =  tv_tree.finditem( NextTreeItem! , ll_childitem)	
		
Loop

end subroutine

public subroutine uf_redrowtree ();long tvi_hdl = 0

ids_tree_view = Create DataStore

ids_tree_view.DataObject = is_DWName
ids_tree_view.SetTransObject(SQLCA)
ids_tree_view.Setsqlselect( uf_SQLQuery() )
ids_tree_view.retrieve( )

inv_stack = Create lol_stack
//empty Tree


DO UNTIL tv_tree.FindItem(RootTreeItem!, 0) = -1

    tv_tree.DeleteItem(tvi_hdl)

LOOP
//fill the tree
uf_FillTree()

return 
end subroutine

on w_tree_view.create
int iCurrent
call super::create
this.cb_search=create cb_search
this.tv_tree=create tv_tree
this.st_search=create st_search
this.sle_search=create sle_search
this.gb_search=create gb_search
this.cb_close=create cb_close
this.cb_select=create cb_select
this.gb_tree=create gb_tree
this.gb_btn=create gb_btn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_search
this.Control[iCurrent+2]=this.tv_tree
this.Control[iCurrent+3]=this.st_search
this.Control[iCurrent+4]=this.sle_search
this.Control[iCurrent+5]=this.gb_search
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_select
this.Control[iCurrent+8]=this.gb_tree
this.Control[iCurrent+9]=this.gb_btn
end on

on w_tree_view.destroy
call super::destroy
destroy(this.cb_search)
destroy(this.tv_tree)
destroy(this.st_search)
destroy(this.sle_search)
destroy(this.gb_search)
destroy(this.cb_close)
destroy(this.cb_select)
destroy(this.gb_tree)
destroy(this.gb_btn)
end on

event open;call super::open;iuo_resize = Create uo_resize
iuo_resize.of_settag( This )
Long ll_ret
ids_tree_view = Create DataStore

ids_tree_view.DataObject = is_DWName
ids_tree_view.SetTransObject(SQLCA)
ids_tree_view.Setsqlselect( uf_SQLQuery() )
//MessageBox("",uf_SQLQuery())
if( ids_tree_view.retrieve( ) < 0)Then
	Messagebox("","Error")
End if
//MessageBox("",ids_tree_view.Rowcount())
////
inv_stack = Create lol_stack
//fill the tree
uf_FillTree()


end event

event resize;call super::resize;iuo_resize.of_doresize( This )
end event

type cb_search from lol_cb within w_tree_view
integer x = 59
integer y = 56
integer width = 251
integer height = 96
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "ب&حــث"
end type

event clicked;call super::clicked;Treeviewitem ltvi
Long ll_handle

ll_handle = uf_searchitem(sle_search.text,tv_tree)

tv_tree.getitem( ll_handle , ltvi )

is_selected_data = ltvi.data 
end event

type tv_tree from u_tvs within w_tree_view
integer x = 50
integer y = 200
integer width = 1650
integer height = 1276
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = arabiccharset!
string facename = "Arial"
long textcolor = 8388608
boolean linesatroot = true
boolean disabledragdrop = false
boolean tooltips = false
boolean trackselect = true
string picturename[] = {"C:\Applications\icons\New Folder\ico\Windows 7 (9).ico","C:\Applications\icons\New Folder\ico\Windows 7 (17).ico"}
integer picturewidth = 32
integer pictureheight = 32
string statepicturename[] = {"C:\Applications\PB 10.0\FAMSII\code\btn\close.gif"}
integer statepicturewidth = 32
integer statepictureheight = 32
boolean ib_rmbmenu = false
end type

event clicked;call super::clicked;Treeviewitem ltvi

This.getitem( handle , ltvi )

is_selected_data = ltvi.data

end event

event doubleclicked;call super::doubleclicked;Treeviewitem ltvi

This.getitem( handle , ltvi )

is_selected_data = ltvi.data

CloseWithReturn(Parent,is_selected_data.as_data)
end event

event selectionchanging;call super::selectionchanging;Treeviewitem ltvi

This.getitem( newhandle , ltvi )

is_selected_data = ltvi.data
end event

type st_search from lol_st within w_tree_view
integer x = 1321
integer y = 64
integer width = 366
integer height = 92
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 67108864
string text = ":  بحث سريـــع"
end type

type sle_search from lol_sle within w_tree_view
integer x = 334
integer y = 60
integer width = 978
integer height = 88
integer taborder = 50
integer textsize = -10
fontcharset fontcharset = ansi!
end type

type gb_search from lol_gb within w_tree_view
integer x = 23
integer width = 1710
integer height = 176
integer taborder = 40
string text = ""
end type

type cb_close from lol_cb within w_tree_view
integer x = 1042
integer y = 1544
integer width = 334
integer height = 96
integer taborder = 80
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "رجـــــوع"
boolean cancel = true
end type

event clicked;call super::clicked;
ClosewithReturn(Parent,"-1")
end event

type cb_select from lol_cb within w_tree_view
integer x = 1371
integer y = 1544
integer width = 343
integer height = 96
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "إختيـــار"
boolean default = true
end type

event clicked;call super::clicked;
ClosewithReturn(Parent,is_selected_data.as_data)
end event

type gb_tree from lol_gb within w_tree_view
integer x = 23
integer y = 156
integer width = 1710
integer height = 1360
integer taborder = 20
string text = ""
end type

type gb_btn from lol_gb within w_tree_view
integer x = 23
integer y = 1496
integer width = 1710
integer height = 156
integer taborder = 30
string text = ""
end type

