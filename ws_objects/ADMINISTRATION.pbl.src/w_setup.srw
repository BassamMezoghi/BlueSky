$PBExportHeader$w_setup.srw
forward
global type w_setup from w_response
end type
type p_1 from picture within w_setup
end type
type cb_cancel from lol_cb within w_setup
end type
type cb_ok from lol_cb within w_setup
end type
type tab_setup from tab within w_setup
end type
type tabpage_database from userobject within tab_setup
end type
type dw_1 from lol_dw within tabpage_database
end type
type tabpage_database from userobject within tab_setup
dw_1 dw_1
end type
type tabpage_app from userobject within tab_setup
end type
type tab_1 from tab within tabpage_app
end type
type tabpage_1 from userobject within tab_1
end type
type cbx_8 from checkbox within tabpage_1
end type
type cbx_invoice from checkbox within tabpage_1
end type
type cbx_7 from checkbox within tabpage_1
end type
type cbx_6 from checkbox within tabpage_1
end type
type cbx_5 from checkbox within tabpage_1
end type
type cbx_4 from checkbox within tabpage_1
end type
type cbx_3 from checkbox within tabpage_1
end type
type cbx_2 from checkbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cbx_8 cbx_8
cbx_invoice cbx_invoice
cbx_7 cbx_7
cbx_6 cbx_6
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
end type
type tabpage_2 from userobject within tab_1
end type
type cbx_1 from checkbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cbx_1 cbx_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
type tabpage_10 from userobject within tab_1
end type
type tabpage_10 from userobject within tab_1
end type
type tab_1 from tab within tabpage_app
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type
type tabpage_app from userobject within tab_setup
tab_1 tab_1
end type
type tab_setup from tab within w_setup
tabpage_database tabpage_database
tabpage_app tabpage_app
end type
end forward

global type w_setup from w_response
integer width = 3854
integer height = 2120
boolean controlmenu = false
boolean center = true
boolean ib_isupdateable = false
p_1 p_1
cb_cancel cb_cancel
cb_ok cb_ok
tab_setup tab_setup
end type
global w_setup w_setup

type variables
Boolean ib_change = False
end variables

forward prototypes
public subroutine of_setcheckboxes ()
end prototypes

public subroutine of_setcheckboxes ();Char lc_char
String is_userinifile

is_userinifile = gnv_app.of_getuserinifile( )

lc_char = ProfileString(is_userinifile , "Sales", "InforceSCFamily","N")
If(lc_char = 'Y')Then
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_3.checked = True
Else
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_3.checked = False
End if

lc_char = ProfileString(is_userinifile , "Sales", "Delivery","N")
If(lc_char = 'Y')Then
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_6.checked = True
Else
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_6.checked = False
End if

lc_char = ProfileString(is_userinifile , "Sales", "ArchiveDelivery","N")
If(lc_char = 'Y')Then
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_7.checked = True
Else
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_7.checked = False
End if

lc_char = ProfileString(is_userinifile , "Sales", "IndexPrice","Y")
If(lc_char = 'Y')Then
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_2.checked = True
Else
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_2.checked = False
End if


lc_char = ProfileString(is_userinifile , "Sales", "ClientAccInv","Y")
If(lc_char = 'Y')Then
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_invoice.checked = True
Else
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_invoice.checked = False
End if

lc_char = ProfileString(is_userinifile , "Sales", "DealerInforce","N")
If(lc_char = 'Y')Then
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_8.checked = True
Else
  tab_setup.tabpage_app.tab_1.tabpage_1.cbx_8.checked = False
End if


end subroutine

on w_setup.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_setup=create tab_setup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.tab_setup
end on

on w_setup.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_setup)
end on

event open;call super::open;Long ll_row
//n_cst_crypto lnv_crypt
string ls_pass , ls_uid
String ls_pass2 , ls_uid2

//lnv_crypt = CREATE n_cst_crypto

ls_pass  = ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBase" ,  "PASS" , "" )
ls_uid   = ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBase" ,  "ID" , "" )

ls_pass2  = ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "PASS" , "" )
ls_uid2   = ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "ID" , "" )

ls_uid  = gnv_services.of_decrypt( ls_uid )//lnv_crypt.DecryptData(ls_uid , gnv_app.of_getmykey( ) ) 
ls_pass = gnv_services.of_decrypt( ls_pass )//lnv_crypt.DecryptData( ls_pass , gnv_app.of_getmykey( ) )

ls_uid2  = gnv_services.of_decrypt( ls_uid2 )//lnv_crypt.DecryptData( ls_uid2 , gnv_app.of_getmykey( ) ) 
ls_pass2 = gnv_services.of_decrypt( ls_pass2 )//lnv_crypt.DecryptData( ls_pass2 , gnv_app.of_getmykey( ) )

//DESTROY lnv_crypt



This.x = 0 
This.y = 700

ll_row = tab_setup.tabpage_database.dw_1.InsertRow(0)

tab_setup.tabpage_database.dw_1.SetItem(ll_row , "server_nm" , ProfileString(gnv_app.of_GetAppIniFile( )  , "DataBase" ,  "SERVERNAME"   , "HOME\SQL2005DEV"  ))
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "database_nm" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBase" ,  "database" , "FAMS" ))
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "user_nm" , ls_uid )
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "password" , ls_pass )
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "Provider" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBase" ,  "Provider" , "OLEDB" ))

tab_setup.tabpage_database.dw_1.SetItem(ll_row , "Run" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBase" ,  "DbSetUp" , "Y" ))
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "OneLogin" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBase" ,  "OneLogin" , "Y" ))

tab_setup.tabpage_database.dw_1.SetItem(ll_row , "rserver_nm" , ProfileString(gnv_app.of_GetAppIniFile( )  , "DataBaseRPT" ,  "SERVERNAME"   , "HOME\SQL2005DEV"  ))
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "report_db" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "database" , "FAMS" ))
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "ruser_nm" , ls_uid2 )
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "rpassword" , ls_pass2 )
tab_setup.tabpage_database.dw_1.SetItem(ll_row , "rProvider" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "Provider" , "OLEDB" ))

of_SetCheckBoxes()






end event

type p_1 from picture within w_setup
integer x = 3045
integer y = 8
integer width = 791
integer height = 1988
string picturename = "C:\Applications\PB 9.0\SMS V3\code\netcaNam.gif"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cancel from lol_cb within w_setup
integer x = 361
integer y = 1892
integer taborder = 40
string text = "Cancel"
boolean cancel = true
end type

event clicked;close(Parent)
end event

type cb_ok from lol_cb within w_setup
integer y = 1892
integer taborder = 30
string text = "OK"
boolean default = true
end type

event clicked;String  ls_password , ls_uid
String  ls_password2 , ls_uid2
//n_cst_crypto lnv_crypt 

tab_setup.tabpage_database.dw_1.accepttext( )

IF( ib_change )Then


  // lnv_crypt = CREATE n_cst_crypto

   ls_password  = tab_setup.tabpage_database.dw_1.GetItemString(1 , "password" )
   ls_password  = gnv_services.of_encrypt_password(ls_password)//lnv_crypt.EncryptData( ls_password , gnv_app.of_getmykey( ) )
   ls_uid       = tab_setup.tabpage_database.dw_1.GetItemString(1 , "user_nm" )
   ls_uid       = gnv_services.of_encrypt_password(ls_uid)//lnv_crypt.EncryptData( ls_uid  , gnv_app.of_getmykey( ) )

   ls_password2  = tab_setup.tabpage_database.dw_1.GetItemString(1 , "rpassword" )
   ls_password2  = gnv_services.of_encrypt_password(ls_password2)//lnv_crypt.EncryptData( ls_password2 , gnv_app.of_getmykey( ) )
   ls_uid2       = tab_setup.tabpage_database.dw_1.GetItemString(1 , "ruser_nm" )
   ls_uid2       = gnv_services.of_encrypt_password(ls_uid2)//lnv_crypt.EncryptData( ls_uid2  , gnv_app.of_getmykey( ) )


  // DESTROY lnv_crypt

   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "ServerName"   , tab_setup.tabpage_database.dw_1.GetItemString(1 , "server_nm" ) )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "Database" ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "database_nm" ) )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "ID"       ,  ls_uid )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "PASS"     ,  ls_password )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "Provider" ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "provider" ) )		
   
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "DbSetUp"  ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "run" ) )		
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "OneLogin" ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "OneLogin" ) )		

   SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "ServerName" , tab_setup.tabpage_database.dw_1.GetItemString(1 , "rserver_nm" ) )
   SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "Database"   ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "report_db" ) )
   SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "ID"         ,  ls_uid2 )
   SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "PASS"       ,  ls_password2 )
   SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "Provider"   ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "rprovider" ) )		


End if


close(Parent)
end event

type tab_setup from tab within w_setup
integer width = 3035
integer height = 1872
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_database tabpage_database
tabpage_app tabpage_app
end type

on tab_setup.create
this.tabpage_database=create tabpage_database
this.tabpage_app=create tabpage_app
this.Control[]={this.tabpage_database,&
this.tabpage_app}
end on

on tab_setup.destroy
destroy(this.tabpage_database)
destroy(this.tabpage_app)
end on

type tabpage_database from userobject within tab_setup
integer x = 18
integer y = 124
integer width = 2999
integer height = 1732
long backcolor = 79741120
string text = "Database"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "ConfigODBC!"
long picturemaskcolor = 536870912
string powertiptext = "Database"
dw_1 dw_1
end type

on tabpage_database.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_database.destroy
destroy(this.dw_1)
end on

type dw_1 from lol_dw within tabpage_database
integer x = 9
integer width = 2848
integer height = 1716
integer taborder = 20
string dataobject = "d_database_setup"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;This.accepttext( )
ib_change = True
end event

event editchanged;call super::editchanged;ib_change = True
end event

type tabpage_app from userobject within tab_setup
integer x = 18
integer y = 124
integer width = 2999
integer height = 1732
long backcolor = 79741120
string text = "Application"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Application5!"
long picturemaskcolor = 536870912
tab_1 tab_1
end type

on tabpage_app.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on tabpage_app.destroy
destroy(this.tab_1)
end on

type tab_1 from tab within tabpage_app
integer width = 2999
integer height = 1732
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Sales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cbx_8 cbx_8
cbx_invoice cbx_invoice
cbx_7 cbx_7
cbx_6 cbx_6
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
end type

on tabpage_1.create
this.cbx_8=create cbx_8
this.cbx_invoice=create cbx_invoice
this.cbx_7=create cbx_7
this.cbx_6=create cbx_6
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.Control[]={this.cbx_8,&
this.cbx_invoice,&
this.cbx_7,&
this.cbx_6,&
this.cbx_5,&
this.cbx_4,&
this.cbx_3,&
this.cbx_2}
end on

on tabpage_1.destroy
destroy(this.cbx_8)
destroy(this.cbx_invoice)
destroy(this.cbx_7)
destroy(this.cbx_6)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
end on

type cbx_8 from checkbox within tabpage_1
integer x = 96
integer y = 936
integer width = 1390
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inforce Dealer"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "DealerInforce"   , "Y" )
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "DealerInforce"   , "N" )	
End if
end event

type cbx_invoice from checkbox within tabpage_1
integer x = 96
integer y = 824
integer width = 1390
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Client Account on invoice"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "ClientAccInv"   , "Y" )
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "ClientAccInv"   , "N" )	
End if

end event

type cbx_7 from checkbox within tabpage_1
integer x = 96
integer y = 712
integer width = 1390
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inforce the Delivery Bill to archive bill"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "ArchiveDelivery"   , "Y" )
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "ArchiveDelivery"   , "N" )	
End if

end event

type cbx_6 from checkbox within tabpage_1
integer x = 96
integer y = 592
integer width = 1198
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inforce Delivery Bill"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "Delivery"   , "Y" )
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "Delivery"   , "N" )	
End if

end event

type cbx_5 from checkbox within tabpage_1
integer x = 201
integer y = 492
integer width = 1239
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Inforce the Export to Delivery bill"
end type

type cbx_4 from checkbox within tabpage_1
integer x = 96
integer y = 400
integer width = 1198
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Export the sales to delivery"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "Allowexport"   , "Y" )
	cbx_5.enabled = True
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "Allowexport"   , "N" )	
	cbx_5.checked = False
	cbx_5.Event clicked()
	cbx_5.enabled = False
End if

end event

type cbx_3 from checkbox within tabpage_1
integer x = 96
integer y = 304
integer width = 1198
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inforce Store Card Family"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "InforceSCFamily"   , "Y" )
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "InforceSCFamily"   , "N" )	
End if

end event

type cbx_2 from checkbox within tabpage_1
integer x = 96
integer y = 208
integer width = 1198
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Get Sale price from Indexs"
end type

event clicked;If(This.checked)Then
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "IndexPrice"   , "Y" )
Else
   SetProfileString(gnv_app.of_getuserinifile( )  , "Sales", "IndexPrice"   , "N" )	
End if


end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Purchase"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cbx_1 cbx_1
end type

on tabpage_2.create
this.cbx_1=create cbx_1
this.Control[]={this.cbx_1}
end on

on tabpage_2.destroy
destroy(this.cbx_1)
end on

type cbx_1 from checkbox within tabpage_2
integer x = 123
integer y = 196
integer width = 1198
integer height = 96
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Get purchase price from Indexs"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Reject"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Transfare Goods"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Expencess"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Payed"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Unusable Goods"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Swap"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Order"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_10 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 2962
integer height = 1592
long backcolor = 79741120
string text = "Delivery"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

