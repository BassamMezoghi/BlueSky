$PBExportHeader$n_cst_drawtree.sru
forward
global type n_cst_drawtree from n_base
end type
end forward

global type n_cst_drawtree from n_base
end type
global n_cst_drawtree n_cst_drawtree

type variables
Public:
String is_TableName
String is_ChildIDName 
String is_ParentIDName 
String is_TitleName
String is_OrderBy
String is_OtherProperties
String is_Where
Private:
String is_DWName = "d_tree_view"
str_stack is_selected_data
DataStore ids_tree_view
lol_stack inv_stack
end variables

forward prototypes
public subroutine of_initial (ref u_tv tree_view)
public function string of_sqlquery ()
public subroutine of_redrawtree (ref u_tv tv_tree)
public subroutine of_filltree (ref u_tv tv_tree)
public subroutine of_pushparentintostack (string as_parent_id, integer al_handle)
public subroutine of_pushparenttreeitem (long al_handle, ref u_tv tv_tree)
public subroutine of_initial (ref u_tvs tree_view)
public subroutine of_filltree (ref u_tvs tv_tree)
end prototypes

public subroutine of_initial (ref u_tv tree_view);String ls_new_syntax,error_syntaxfromSQL

ids_tree_view = Create DataStore
ids_tree_view.DataObject = is_DWName
ids_tree_view.Setsqlselect( of_SQLQuery()  )
ls_new_syntax = SQLCA.SyntaxFromSQL(of_SQLQuery(), 'Style(Type=Grid)', error_syntaxfromSQL)
ids_tree_view.Create(ls_new_syntax, error_syntaxfromSQL)
ids_tree_view.SetTransObject(SQLCA)

//MessageBox("",uf_SQLQuery())
if( ids_tree_view.retrieve( ) < 0)Then
	Messagebox("","Error")
End if
//MessageBox("",ids_tree_view.Rowcount())
////

inv_stack = Create lol_stack
//fill the tree
of_FillTree(tree_view)


end subroutine

public function string of_sqlquery ();/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

ls_query = "SELECT CAST(T."+is_ChildIDName+" AS varchar(20)) AS child_id,  CASE ISNULL(T."+is_ParentIDName+" , -100) WHEN -100 THEN '-100' WHEN  T."+is_ChildIDName+" THEN '-100' ELSE CAST(T."+is_ParentIDName+" AS Varchar(20) ) END AS parent_id, "+is_TitleName+" AS Title "+is_OtherProperties+",rank FROM "+is_TableName+" AS T  "+is_Where+is_OrderBy

Return ls_query
end function

public subroutine of_redrawtree (ref u_tv tv_tree);long tvi_hdl = 0

ids_tree_view = Create DataStore

ids_tree_view.DataObject = is_DWName
ids_tree_view.SetTransObject(SQLCA)
ids_tree_view.Setsqlselect( of_SQLQuery() )
ids_tree_view.retrieve( )

inv_stack = Create lol_stack
//empty Tree


DO UNTIL tv_tree.FindItem(RootTreeItem!, 0) = -1

    tv_tree.DeleteItem(tvi_hdl)

LOOP
//fill the tree
of_FillTree(tv_tree)

return 
end subroutine

public subroutine of_filltree (ref u_tv tv_tree);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
of_PushParentIntoStack("-100" , 0)

Do While Not inv_stack.of_isempty( )

   lstr_stack        = inv_stack.of_pop( )
/*************************************************/	
//	ltvi.data        = lstr_stack.as_data
	ltvi.data		= lstr_stack
/*************************************************/	

	ltvi.label        			= lstr_stack.as_title
   	ltvi.pictureindex 		= lstr_stack.ai_pic
	ltvi.selectedpictureindex 	= lstr_stack.ai_pic
	
	ll_parent         = tv_tree.insertitemfirst( lstr_stack.al_handle , ltvi )
	
	of_PushParentIntoStack(lstr_stack.as_data , ll_parent)
	
Loop
end subroutine

public subroutine of_pushparentintostack (string as_parent_id, integer al_handle);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
str_pass_parmeters lstr_parm

ids_tree_view.setfilter( "parent_id = '"+as_parent_id+"'" )
ids_tree_view.filter( )
ids_tree_view.setsort( "rank asc")
ids_tree_view.sort( )


ll_end   = ids_tree_view.rowcount()

For ll_start=1 To ll_end

   lstr_stack.as_data		=  ids_tree_view.GetItemString(ll_start,"child_id")
   lstr_parm					=  gnv_services.of_split(  ids_tree_view.GetItemString(ll_start,"title"), "-")
   lstr_stack.as_title		=  lstr_parm.string_parm[UPPERBOUND(lstr_parm.string_parm)] //ids_tree_view.GetItemString(ll_start,"title") 
   lstr_stack.as_parent		=  ids_tree_view.GetItemString(ll_start,"parent_id") 
   lstr_stack.al_handle 	=  al_handle
   lstr_stack.ai_pic			=  ids_tree_view.GetItemNumber(ll_start,"pic_id") 

   inv_stack.of_push( lstr_stack )
		
Next

end subroutine

public subroutine of_pushparenttreeitem (long al_handle, ref u_tv tv_tree);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

public subroutine of_initial (ref u_tvs tree_view);String ls_new_syntax,error_syntaxfromSQL

ids_tree_view = Create DataStore
ids_tree_view.DataObject = is_DWName
ids_tree_view.Setsqlselect( of_SQLQuery()  )
ls_new_syntax = SQLCA.SyntaxFromSQL(of_SQLQuery(), 'Style(Type=Grid)', error_syntaxfromSQL)
ids_tree_view.Create(ls_new_syntax, error_syntaxfromSQL)
ids_tree_view.SetTransObject(SQLCA)

//MessageBox("",uf_SQLQuery())
if( ids_tree_view.retrieve( ) < 0)Then
	Messagebox("","Error")
End if
//MessageBox("",ids_tree_view.Rowcount())
////

inv_stack = Create lol_stack
//fill the tree
of_FillTree(tree_view)


end subroutine

public subroutine of_filltree (ref u_tvs tv_tree);/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
of_PushParentIntoStack("-100" , 0)

Do While Not inv_stack.of_isempty( )

   lstr_stack        = inv_stack.of_pop( )
/*************************************************/	
//	ltvi.data        = lstr_stack.as_data
	ltvi.data		= lstr_stack
/*************************************************/	

	ltvi.label        			= lstr_stack.as_title
   ltvi.pictureindex 			= lstr_stack.ai_pic
	ltvi.selectedpictureindex 	= lstr_stack.ai_pic
	
	ll_parent         = tv_tree.insertitemfirst( lstr_stack.al_handle , ltvi )
	
	of_PushParentIntoStack(lstr_stack.as_data , ll_parent)
	
Loop
end subroutine

on n_cst_drawtree.create
call super::create
end on

on n_cst_drawtree.destroy
call super::destroy
end on

