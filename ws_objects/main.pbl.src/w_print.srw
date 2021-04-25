$PBExportHeader$w_print.srw
forward
global type w_print from w_response
end type
type pb_2 from u_pb within w_print
end type
type pb_1 from u_pb within w_print
end type
type dw_1 from u_dw within w_print
end type
end forward

global type w_print from w_response
integer width = 3653
integer height = 2888
boolean righttoleft = true
boolean center = true
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
end type
global w_print w_print

type variables
str_pass_parmeters istr_parm
end variables

forward prototypes
public subroutine of_pdf (datastore ds, string as_file_nm)
end prototypes

public subroutine of_pdf (datastore ds, string as_file_nm);str_pass_parmeters lstr_parm
String ls_type
String ls_printer

ls_printer = ProfileString( gnv_app.of_getappinifile( ) , "DataBase" , "DefaultPDFPrinter"    , "Microsoft Print to PDF")

CreateDirectory(gs_AppPath+"PDF")

ds.object.datawindow.print.filename = gs_AppPath+"PDF\"+ds.GetItemString(1 , "payments_id")+"_"+as_file_nm+".pdf"
	
IF ls_printer <> "" THEN
	ds.Object.DataWindow.Printer = ls_printer
END IF

ds.print()


end subroutine

on w_print.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_print.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event open;call super::open;istr_parm = Message.powerobjectparm

dw_1.DataObject = istr_parm.String_parm[1]
dw_1.SetTransObject(SQLCA)
dw_1.Event pfc_retrieve()


dw_1.of_SetPrintPreview(TRUE)
dw_1.Event pfc_PrintPreview()
end event

type pb_2 from u_pb within w_print
integer x = 3424
integer y = 2624
integer width = 183
integer height = 160
integer taborder = 30
string text = ""
boolean cancel = true
boolean originalsize = false
string picturename = "C:\Applications\icons\hot\png\32x32\Turn off.png"
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;call super::clicked;close(Parent)
end event

type pb_1 from u_pb within w_print
integer x = 3227
integer y = 2624
integer width = 183
integer height = 160
integer taborder = 20
string text = ""
boolean default = true
boolean originalsize = false
string picturename = "C:\Applications\icons\hot\png\32x32\Print.png"
alignment htextalign = left!
vtextalign vtextalign = multiline!
long backcolor = 67108864
end type

event clicked;call super::clicked;DataStore ds , ds2

IF istr_parm.string_parm[1] = "d_inv_contract" or istr_parm.string_parm[1] = "d_inv_contract_ii" THEN

	dw_1.modify( "DataWindow.Print.Copies="+ ProfileString(gnv_app.of_getappinifile( ) , "POS", "InvoiceCopies", "1") )
	
	ds = Create DataStore
	ds.DataObject = "d_inv_payment"
	ds.SettransObject(SQLCA)
	ds.retrieve(istr_parm.string_parm[2] )

	ds2 = Create DataStore
	ds2.DataObject =  istr_parm.string_parm[1]
	ds2.SettransObject(SQLCA)
	ds2.retrieve( istr_parm.string_parm[2] )

	ds.modify( "DataWindow.Print.Copies="+ ProfileString(gnv_app.of_getappinifile( ) , "POS", "InvoiceCopies", "1") )
	ds.print( )
	
	ds.modify( "DataWindow.Print.Copies=1")

	of_PDF(ds,"inv")
	of_PDF(ds2,"doc")
	
	Destroy ds
	Destroy ds2
	
END IF

dw_1.print()


end event

type dw_1 from u_dw within w_print
integer width = 3625
integer height = 2624
integer taborder = 10
boolean righttoleft = true
end type

event pfc_retrieve;call super::pfc_retrieve;Choose Case istr_parm.String_parm[1]
	Case "d_inv_contract","d_inv_contract_ii"
			Return This.retrieve( istr_parm.String_parm[2] )
	Case "d_inv_swap_money" , "d_inv_swap_money_a5"	
			Return This.retrieve( istr_parm.String_parm[3] )
End Choose			
end event

