$PBExportHeader$w_import_list.srw
forward
global type w_import_list from w_response
end type
type dw_hide from u_dw within w_import_list
end type
type dw_list from u_dw within w_import_list
end type
end forward

global type w_import_list from w_response
integer x = 214
integer y = 221
integer width = 2597
integer height = 2412
boolean righttoleft = true
boolean ib_isupdateable = false
dw_hide dw_hide
dw_list dw_list
end type
global w_import_list w_import_list

type variables
String is_import_type = "N"
str_pass_parmeters istr_parm
end variables

forward prototypes
public subroutine of_save_and_close ()
end prototypes

public subroutine of_save_and_close ();Long ll_row , ll_RowCount
Long ll_itr = 1 ,ll_itr2 = 1

ll_RowCount = dw_list.RowCount()
	
FOR ll_row = 1 TO ll_RowCount
			
			IF( dw_list.GetItemString(ll_row , "selected") = "Y" )THEN
				
				istr_parm.long_array[ll_itr] = dw_list.GetItemNumber(ll_row , "sc_id")
				ll_itr++
				istr_parm.long_array[ll_itr] = dw_list.GetItemNumber(ll_row , "qty")
				ll_itr++
				
				IF Not gnv_settings.of_getsyssetup( gnv_settings.indexprice ) THEN
					istr_parm.decimal_array[ll_itr2] = dw_list.GetItemDecimal(ll_row , "price")
					ll_itr2++
				END  IF
				
			END IF
						
NEXT 
	
IF ll_itr > 1 THEN istr_parm.b_parm[1] = True
	
Close( This )
	

end subroutine

on w_import_list.create
int iCurrent
call super::create
this.dw_hide=create dw_hide
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_hide
this.Control[iCurrent+2]=this.dw_list
end on

on w_import_list.destroy
call super::destroy
destroy(this.dw_hide)
destroy(this.dw_list)
end on

event open;call super::open;
istr_parm.b_parm[1] = False

dw_list.SetFocus( )
end event

event close;call super::close;	
CloseWithReturn( This , istr_parm )
end event

type dw_hide from u_dw within w_import_list
boolean visible = false
integer x = 119
integer y = 1224
integer width = 2336
integer height = 912
integer taborder = 20
string dataobject = "d_import_list_price_ii"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_list from u_dw within w_import_list
integer width = 2583
integer height = 2328
integer taborder = 10
string dataobject = "d_import_list_with_price"
borderstyle borderstyle = styleraised!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;Long ll_Row , ll_RowCount ,ll_ins

IF Not gnv_settings.of_getsyssetup( gnv_settings.indexprice ) THEN
	dw_list.DataObject = "d_import_list_with_price"
	dw_hide.DataObject = "d_import_list_price_ii"
ELSE
	dw_list.DataObject = "d_import_list"
	dw_hide.DataObject = "d_import_list_ii"
END IF

dw_List.SetTransObject(SQLCA)
dw_hide.SetTransObject(SQLCA)

dw_hide.ImportClipBoard( )

gnv_services.uf_retrieve_dddw_integer( dw_list , 0 , "sc_id")
gnv_services.uf_retrieve_dddw_integer( dw_hide , 0 , "barcode")

ll_RowCount = dw_hide.RowCount()

FOR ll_Row = 1 TO ll_RowCount
	
	ll_ins = dw_list.InsertRow(0)
	
	dw_list.SetItem( ll_ins , "sc_id" 	, Long(dw_hide.GetItemString(ll_row , "display") ) )
	dw_list.SetItem( ll_ins , "qty" 		, Long(dw_hide.GetItemNumber(ll_row , "qty") ) )
	
	IF Not gnv_settings.of_getsyssetup( gnv_settings.indexprice ) THEN
		dw_list.SetItem( ll_ins , "price" 		, dw_hide.GetItemDecimal(ll_row , "price")  )
	END IF
	
	
NEXT

end event

event buttonclicked;call super::buttonclicked;Long ll_row , ll_RowCount
Long ll_itr = 1 ,ll_itr2 = 1

IF dwo.name = "b_select" THEN
	
	ll_RowCount = This.RowCount()
	
	FOR ll_row = 1 TO ll_RowCount
			
			IF( This.GetItemString(ll_row , "selected") = "Y" )THEN
				
				istr_parm.long_array[ll_itr] = This.GetItemNumber(ll_row , "sc_id")
				ll_itr++
				istr_parm.long_array[ll_itr] = This.GetItemNumber(ll_row , "qty")
				ll_itr++
				
				IF Not gnv_settings.of_getsyssetup( gnv_settings.indexprice ) THEN
					istr_parm.decimal_array[ll_itr2] = This.GetItemDecimal(ll_row , "price")
					ll_itr2++
				END  IF
				
			END IF
						
	NEXT 
	
	IF ll_itr > 1 THEN istr_parm.b_parm[1] = True
	
	CloseWithReturn(Parent , istr_parm)
	
END IF
end event

event bst_keydown;call super::bst_keydown;IF KeyDown(KeyEnter!) THEN
	of_save_and_close()
END IF
end event

