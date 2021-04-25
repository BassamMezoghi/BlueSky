$PBExportHeader$tp_menu_tree.sru
forward
global type tp_menu_tree from u_cst_tabpage
end type
type sle_functions from singlelineedit within tp_menu_tree
end type
type tv_menu from u_tv within tp_menu_tree
end type
end forward

global type tp_menu_tree from u_cst_tabpage
sle_functions sle_functions
tv_menu tv_menu
end type
global tp_menu_tree tp_menu_tree

type variables
Public :
nvo_security ics_security
end variables

on tp_menu_tree.create
int iCurrent
call super::create
this.sle_functions=create sle_functions
this.tv_menu=create tv_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_functions
this.Control[iCurrent+2]=this.tv_menu
end on

on tp_menu_tree.destroy
call super::destroy
destroy(this.sle_functions)
destroy(this.tv_menu)
end on

event resize;call super::resize;tv_menu.move(0				 , 0 )
tv_menu.resize(newwidth , newheight - sle_functions.height)

sle_functions.resize( newwidth  , sle_functions.height )
sle_functions.move( 0 				,  tv_menu.y + tv_menu.height )

end event

event ue_postconstructor;call super::ue_postconstructor;sle_functions.SetFocus( )
end event

type sle_functions from singlelineedit within tp_menu_tree
event of_keydown pbm_keydown
integer y = 804
integer width = 1541
integer height = 92
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event of_keydown;Long ll_row ,ll_RowCount , ll_itr
n_cst_events cst_events
string ls_title
str_pass_parmeters lstr_parm
/*nvo_b# csB#


IF KeyDown(KeyEnter!) THEN
	
	//@Function;ACID:invoice_no1;invoice_no2...inovice_noN|,
	//Functions Prnt , Cng , Opn ,cb
		IF Mid(sle_functions.text , 1 , 1) = "@" THEN
			
			lstr_parm = gnv_services.of_split( Mid(sle_functions.text , 2 , Len(sle_functions.text) ) , "," )
			csB# = CREATE nvo_b#
			
			ll_RowCount = upperbound( lstr_parm.string_parm )
			FOR ll_row = 1 To ll_RowCount
				csB#.of_parse( lstr_parm.string_parm[ll_row] )
			NEXT
			
			Destroy csB#
			
		ELSE
	
		lstr_parm = gnv_services.of_split( sle_functions.text , "," )
	
		ll_RowCount = UpperBound(lstr_parm.string_parm)

		cst_events = CREATE n_cst_events

		FOR ll_itr = 1 To ll_RowCount
		
				ll_row = ics_security.of_checkaccessright( lstr_parm.string_parm[ll_itr] ) 
				
				IF( (ll_row <= 0) OR ( IsNull(ll_row) ) ) THEN 
					gnv_msg.of_message(52)//no access right
					Return 
				END IF
				ls_title = ics_security.of_Get_access_right_title( ll_row ) 
				
				cst_events.is_title = Trim(Mid(ls_title , LastPos(ls_title , '-') + 1 , len(ls_title) ))
				cst_events.triggerevent( "of_"+ lstr_parm.string_parm[ll_itr])
				cst_events.is_title = ""
		
		NEXT
		
		DESTROY cst_events
	END IF
		
END IF*/
Return 1
end event

type tv_menu from u_tv within tp_menu_tree
integer width = 1541
integer height = 804
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
string facename = "Arial"
long backcolor = 16777215
boolean linesatroot = true
boolean trackselect = true
string picturename[] = {"C:\Applications\icons\New Folder\folder_open_add2.ico","C:\Applications\icons\New Folder\folder_open_accept.ico","C:\Applications\icons\New Folder\cube_config.ico","C:\Applications\icons\New Folder\exit_2.ico","C:\Applications\icons\New Folder\misc_box.ico","C:\Applications\icons\New Folder\ico\Windows 7 (173).ico","C:\Applications\icons\New Folder\kgpg_key3_kopete.ico","C:\Applications\icons\New Folder\ico\Windows 7 (89).ico","C:\Applications\icons\New Folder\ico\Tools.ico","C:\Applications\icons\New Folder\document_export.ico","C:\Applications\icons\New Folder\document_import.ico","C:\Applications\icons\New Folder\ico\Iconshock-Super-Vista-Business-Column-chart.ico","C:\Applications\icons\New Folder\ico\Visualpharm-Finance-Cash-register.ico","C:\Applications\icons\New Folder\ico\Aha-Soft-Software-Reports.ico","C:\Applications\icons\New Folder\ico\App-ark.ico","C:\Applications\icons\New Folder\ico\Wwalczyszyn-Iwindows-Recycle-Bin.ico","C:\Applications\icons\New Folder\ico\Iconshock-Payment-Wire-transfer.ico","C:\Applications\icons\New Folder\ico\archive_2.ico","C:\Applications\icons\New Folder\ico\Tag.ico","C:\Applications\icons\New Folder\ico\advanced.ico","C:\Applications\icons\New Folder\ico\File-Manager.ico","C:\Applications\icons\New Folder\1294065628_user.ico","C:\Applications\icons\New Folder\ico\Meeting-Dark.ico","C:\Applications\icons\New Folder\ico\user-properties.ico","C:\Applications\icons\New Folder\Parcel_win7.ico","C:\Applications\icons\New Folder\ico\Payment.ico","C:\Applications\icons\New Folder\ico\return.ico","C:\Applications\icons\New Folder\ico\discount.ico","C:\Applications\icons\New Folder\ico\money.ico","C:\Applications\icons\New Folder\ico\discount2.ico","C:\Applications\icons\New Folder\ico\Iconshock-Free-Folder-Folder-invoices.ico","C:\Applications\icons\New Folder\ico\Visualpharm-Finance-Invoice.ico","C:\Applications\icons\New Folder\ico\Minus.ico","C:\Applications\icons\New Folder\ico\document.ico","C:\Applications\icons\New Folder\ico\User.ico","C:\Applications\icons\New Folder\ico\Address-book.ico","C:\Applications\icons\New Folder\ico\Apps-file-manager.ico","C:\Applications\icons\New Folder\ico\Board.ico","C:\Applications\icons\New Folder\ico\Iconshock-Payment-Check.ico","C:\Applications\icons\New Folder\ico\document-yellow.ico","C:\Applications\icons\New Folder\ico\contact-new.ico","C:\Applications\icons\New Folder\ico\Finance.ico","C:\Applications\icons\New Folder\ico\PPT-filetype.ico","C:\Applications\icons\New Folder\ico\Business-Safe.ico","C:\Applications\icons\New Folder\ico\exchange.ico","C:\Applications\icons\New Folder\1294065821_School.ico","C:\Applications\icons\New Folder\ico\Dapino-Money-Money-Safe-1.ico","C:\Applications\icons\New Folder\1294064930_shopping_cart.ico","C:\Applications\icons\New Folder\truckyellow.ico","C:\Applications\icons\New Folder\army-officer.ico","C:\Applications\icons\New Folder\ico\Container.ico","C:\Applications\icons\New Folder\ico\Artua-Mac-ISync.ico","C:\Applications\icons\New Folder\ico\Archive.ico","C:\Applications\icons\New Folder\tool-kit.ico","C:\Applications\icons\New Folder\arrow-up.ico","C:\Applications\icons\New Folder\Truck.ico","C:\Applications\icons\New Folder\Insurance.ico","C:\Applications\icons\New Folder\Partnership.ico","C:\Applications\icons\New Folder\Personal-loan.ico","C:\Applications\icons\New Folder\Database-Active.ico","C:\Applications\icons\New Folder\Email-Download.ico","C:\Applications\icons\New Folder\Calendar.ico","C:\Applications\icons\New Folder\ico\Apps-file-manager_1.ico","C:\Applications\icons\New Folder\ico\1426805225_105251.ico","C:\Applications\icons\New Folder\ico\1426805313_2493.ico","C:\Applications\icons\New Folder\ico\1426805582_131975.ico","C:\Applications\icons\New Folder\ico\PC-Reg.ico","C:\Applications\icons\New Folder\png\ht_hardware_hospitality.png","C:\Applications\icons\New Folder\1441474314_document.ico","C:\Applications\icons\New Folder\1441471821_value3d.ico","C:\Applications\icons\New Folder\Omercetin-Pixelophilia2-Target.ico","C:\Applications\icons\New Folder\ico\whitebox.ico","C:\Applications\icons\New Folder\ico\bluezip.ico","C:\Applications\icons\New Folder\ico\ws.ico","C:\Applications\icons\New Folder\ico\Fatcow-Farm-Fresh-Globe-place.ico","C:\Applications\icons\New Folder\ico\Meeting-Dark.ico","C:\Applications\icons\New Folder\Svengraph-I-Love-Lock.ico","C:\Applications\icons\New Folder\ico\Kyo-Tux-Ginux-Extras-Security.ico","C:\Applications\icons\New Folder\ico\Everaldo-Crystal-Clear-App-ark-2.ico","C:\Applications\icons\New Folder\ico\Preferences.ico","C:\Applications\icons\New Folder\ico\Fingerprint-2.ico"}
integer picturewidth = 32
integer pictureheight = 32
string statepicturename[] = {"",""}
integer statepicturewidth = 32
integer statepictureheight = 32
boolean righttoleft = true
end type

event doubleclicked;call super::doubleclicked;str_stack lstr_stack
n_cst_events cst_events
treeviewitem tvi
Long ll_row

This.getitem( handle , tvi)

lstr_stack = tvi.data

ll_row = ics_security.of_checkaccessright(lstr_stack.as_data) 

IF( (ll_row <= 0) OR ( IsNull(ll_row) ) ) THEN Return 

cst_events = CREATE n_cst_events
cst_events.is_title = lstr_stack.as_title+"::"+lstr_stack.as_data
cst_events.triggerevent( "of_"+lstr_stack.as_data)
cst_events.is_title = ""
DESTROY cst_events
end event

event key;call super::key;IF Keydown(KeyEnter!) THEN

	This.event doubleclicked(	This.FindItem(currenttreeitem! , 0) )
	
END IF
end event

