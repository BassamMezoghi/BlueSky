$PBExportHeader$w_select_lang.srw
forward
global type w_select_lang from w_popup
end type
type dw_1 from u_dw within w_select_lang
end type
end forward

global type w_select_lang from w_popup
integer x = 214
integer y = 221
integer width = 919
integer height = 836
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean center = true
dw_1 dw_1
end type
global w_select_lang w_select_lang

on w_select_lang.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_select_lang.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;Long ll_RowCount ,ll_row

dw_1.SetTransObject(SQLCA)
dw_1.SetRedraw(False)

dw_1.Retrieve()

ll_RowCount = dw_1.RowCount()

For ll_row = 1 To ll_RowCount
	
	IF dw_1.GetItemString(ll_row , "ID" ) = gs_lan THEN 
		dw_1.SetItem(ll_row , "Selected" , "Y" )
		exit
	End IF
	
Next

dw_1.SetRedraw( True )

end event

type dw_1 from u_dw within w_select_lang
integer width = 901
integer height = 820
integer taborder = 10
string dataobject = "d_select_language"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event doubleclicked;call super::doubleclicked;Long ll_rowCount ,ll_row
This.setredraw( False )

ll_RowCount = This.RowCount()

FOR ll_Row = 1 TO ll_RowCount
	
	This.SetItem(ll_row , "selected" , "N")
	
NEXT

This.SetItem(row , "selected" , "Y")

SetProfileString("store.ini" , "DataBase" , "Lang" , This.GetItemString(row , "ID") )

This.setredraw( True )

gnv_msg.of_message( 24 )//restart the application to change the interface

Close(Parent)
end event

