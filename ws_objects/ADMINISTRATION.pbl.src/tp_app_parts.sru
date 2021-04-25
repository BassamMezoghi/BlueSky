$PBExportHeader$tp_app_parts.sru
forward
global type tp_app_parts from u_cst_tabpage
end type
type tv_tree from u_tvs within tp_app_parts
end type
end forward

global type tp_app_parts from u_cst_tabpage
integer width = 2560
integer height = 2092
tv_tree tv_tree
end type
global tp_app_parts tp_app_parts

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

on tp_app_parts.create
int iCurrent
call super::create
this.tv_tree=create tv_tree
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_tree
end on

on tp_app_parts.destroy
call super::destroy
destroy(this.tv_tree)
end on

event resize;call super::resize;tv_tree.move(0,0)
tv_tree.resize( NewWidth , NewHeight )
end event

event ue_postconstructor;call super::ue_postconstructor;n_cst_drawtree cs_tree

cs_tree = Create n_cst_drawtree

cs_tree.is_parentidname			= "PARENT"
cs_tree.is_childidname				= "ACID"
cs_tree.is_tablename				= "ACCESS_CD"
cs_tree.is_titlename				= "TITLE"
cs_tree.is_where					= " "
cs_tree.is_OtherProperties		= " , T.pic as pic_id "
cs_tree.is_OrderBy					= " Order By Rank ASC"

cs_tree.of_initial(tv_tree)

Destroy cs_tree

end event

type tv_tree from u_tvs within tp_app_parts
integer x = 32
integer y = 56
integer width = 2482
integer height = 2008
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
string picturename[] = {"C:\Applications\icons\New Folder\folder_open_add2.ico","C:\Applications\icons\New Folder\folder_open_accept.ico","C:\Applications\icons\New Folder\cube_config.ico","C:\Applications\icons\New Folder\exit_2.ico","C:\Applications\icons\New Folder\misc_box.ico","C:\Applications\icons\New Folder\ico\Windows 7 (173).ico","C:\Applications\icons\New Folder\kgpg_key3_kopete.ico","C:\Applications\icons\New Folder\ico\Windows 7 (89).ico","C:\Applications\icons\New Folder\ico\Tools.ico","C:\Applications\icons\New Folder\document_export.ico","C:\Applications\icons\New Folder\document_import.ico","C:\Applications\icons\New Folder\ico\Iconshock-Super-Vista-Business-Column-chart.ico","C:\Applications\icons\New Folder\ico\Visualpharm-Finance-Cash-register.ico","C:\Applications\icons\New Folder\ico\Aha-Soft-Software-Reports.ico","C:\Applications\icons\New Folder\ico\App-ark.ico","C:\Applications\icons\New Folder\ico\Wwalczyszyn-Iwindows-Recycle-Bin.ico","C:\Applications\icons\New Folder\ico\Iconshock-Payment-Wire-transfer.ico","C:\Applications\icons\New Folder\ico\archive_2.ico","C:\Applications\icons\New Folder\ico\Tag.ico","C:\Applications\icons\New Folder\ico\advanced.ico","C:\Applications\icons\New Folder\ico\File-Manager.ico","C:\Applications\icons\New Folder\1294065628_user.ico","C:\Applications\icons\New Folder\ico\Meeting-Dark.ico","C:\Applications\icons\New Folder\ico\user-properties.ico","C:\Applications\icons\New Folder\Parcel_win7.ico","C:\Applications\icons\New Folder\ico\Payment.ico","C:\Applications\icons\New Folder\ico\return.ico","C:\Applications\icons\New Folder\ico\discount.ico","C:\Applications\icons\New Folder\ico\money.ico","C:\Applications\icons\New Folder\ico\discount2.ico","C:\Applications\icons\New Folder\ico\Iconshock-Free-Folder-Folder-invoices.ico","C:\Applications\icons\New Folder\ico\Visualpharm-Finance-Invoice.ico","C:\Applications\icons\New Folder\ico\Minus.ico","C:\Applications\icons\New Folder\ico\document.ico","C:\Applications\icons\New Folder\ico\User.ico","C:\Applications\icons\New Folder\ico\Address-book.ico","C:\Applications\icons\New Folder\ico\Apps-file-manager.ico","C:\Applications\icons\New Folder\ico\Board.ico","C:\Applications\icons\New Folder\ico\Iconshock-Payment-Check.ico","C:\Applications\icons\New Folder\ico\document-yellow.ico","C:\Applications\icons\New Folder\ico\contact-new.ico","C:\Applications\icons\New Folder\ico\Finance.ico","C:\Applications\icons\New Folder\ico\PPT-filetype.ico","C:\Applications\icons\New Folder\ico\Business-Safe.ico","C:\Applications\icons\New Folder\ico\exchange.ico","C:\Applications\icons\New Folder\1294065821_School.ico","C:\Applications\icons\New Folder\ico\Dapino-Money-Money-Safe-1.ico","C:\Applications\icons\New Folder\1294064930_shopping_cart.ico","C:\Applications\icons\New Folder\truckyellow.ico","C:\Applications\icons\New Folder\army-officer.ico","C:\Applications\icons\New Folder\ico\Container.ico","C:\Applications\icons\New Folder\ico\Artua-Mac-ISync.ico","C:\Applications\icons\New Folder\ico\Archive.ico","C:\Applications\icons\New Folder\tool-kit.ico","C:\Applications\icons\New Folder\arrow-up.ico","C:\Applications\icons\New Folder\Truck.ico","C:\Applications\icons\New Folder\Insurance.ico","C:\Applications\icons\New Folder\Partnership.ico","C:\Applications\icons\New Folder\Personal-loan.ico","C:\Applications\icons\New Folder\Database-Active.ico","C:\Applications\icons\New Folder\Email-Download.ico","C:\Applications\icons\New Folder\Calendar.ico","C:\Applications\icons\New Folder\ico\Apps-file-manager_1.ico","C:\Applications\icons\New Folder\ico\1426805225_105251.ico","C:\Applications\icons\New Folder\ico\1426805313_2493.ico","C:\Applications\icons\New Folder\ico\1426805582_131975.ico","C:\Applications\icons\New Folder\ico\PC-Reg.ico","C:\Applications\icons\New Folder\png\ht_hardware_hospitality.png","C:\Applications\icons\New Folder\1441474314_document.ico","C:\Applications\icons\New Folder\1441471821_value3d.ico","C:\Applications\icons\New Folder\Omercetin-Pixelophilia2-Target.ico","C:\Applications\icons\New Folder\ico\whitebox.ico","C:\Applications\icons\New Folder\ico\bluezip.ico","C:\Applications\icons\New Folder\ico\ws.ico","C:\Applications\icons\New Folder\ico\Fatcow-Farm-Fresh-Globe-place.ico","C:\Applications\icons\New Folder\ico\Meeting-Dark.ico","C:\Applications\icons\New Folder\Svengraph-I-Love-Lock.ico","C:\Applications\icons\New Folder\ico\Kyo-Tux-Ginux-Extras-Security.ico","C:\Applications\icons\New Folder\ico\Everaldo-Crystal-Clear-App-ark-2.ico","C:\Applications\icons\New Folder\ico\Preferences.ico"}
integer picturewidth = 32
integer pictureheight = 32
string statepicturename[] = {""}
integer statepicturewidth = 32
integer statepictureheight = 32
boolean ib_rmbmenu = false
end type

event clicked;call super::clicked;Treeviewitem ltvi

This.getitem( handle , ltvi )

is_selected_data = ltvi.data

end event

event doubleclicked;call super::doubleclicked;Long ll_tvi
TreeViewItem ltv
str_stack lstr_stack

tv_tree.GetItem( handle, ltv )

lstr_stack = ltv.data


//if(not ib_RightClick)Then 
//	CloseWithReturn(Parent,lstr_stack)
//else
	OpenWithParm(w_mainance_access_cd , lstr_stack)

	lstr_stack = Message.PowerObjectParm

	ltv.data = lstr_stack

	ltv.label = lstr_stack.as_title

	tv_tree.SetItem( handle , ltv )
//end if

end event

event endlabeledit;call super::endlabeledit;str_stack lstr_stack
Long ll_data
if(trim(newtext) <> "")Then

	treeviewitem l_tv
	This.getitem( handle, l_tv)
	
	lstr_stack 	= l_tv.data
	ll_data 		= Long(lstr_stack.as_data)
	if( ll_data > -1 )Then
	
		UPDATE ACCESS_CD
		SET TITLE = :newtext
		WHERE ACID = :ll_data;	
		commit;
		
	else
		Long ll_handle
		treeviewitem l_tvii
					
		ll_handle = Long(lstr_stack.as_parent)
		
		INSERT INTO 
			ACCESS_CD 
					(
					PARENT , 
					TITLE ) 
					VALUES 
					(
					:ll_handle , 
					:newtext ) ;
			commit;
	end if
End if

This.EditLabels = False
end event

event rightclicked;call super::rightclicked;m_access_tree NewMenu

NewMenu = CREATE m_access_tree

NewMenu.PopMenu(this.PointerX(), this.pointery())
end event

event selectionchanging;call super::selectionchanging;Treeviewitem ltvi

This.getitem( newhandle , ltvi )

is_selected_data = ltvi.data
end event

