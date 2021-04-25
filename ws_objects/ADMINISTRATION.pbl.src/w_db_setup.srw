$PBExportHeader$w_db_setup.srw
forward
global type w_db_setup from w_response
end type
type p_1 from picture within w_db_setup
end type
type cb_cancel from lol_cb within w_db_setup
end type
type cb_ok from lol_cb within w_db_setup
end type
type tab_setup from tab within w_db_setup
end type
type tabpage_database from userobject within tab_setup
end type
type dw_1 from lol_dw within tabpage_database
end type
type tabpage_database from userobject within tab_setup
dw_1 dw_1
end type
type tab_setup from tab within w_db_setup
tabpage_database tabpage_database
end type
end forward

global type w_db_setup from w_response
integer x = 214
integer y = 221
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
global w_db_setup w_db_setup

type variables
Boolean ib_change = False
end variables

forward prototypes
public subroutine of_setcheckboxes ()
end prototypes

public subroutine of_setcheckboxes ();Char lc_char
String is_userinifile

is_userinifile = gnv_app.of_getuserinifile( )


end subroutine

on w_db_setup.create
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

on w_db_setup.destroy
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

//ls_pass2  = ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "PASS" , "" )
//ls_uid2   = ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "ID" , "" )

ls_uid  = gnv_services.of_decrypt(ls_uid)//lnv_crypt.DecryptData(ls_uid , gnv_app.of_getmykey( ) ) 
ls_pass = gnv_services.of_decrypt(ls_pass)//lnv_crypt.DecryptData( ls_pass , gnv_app.of_getmykey( ) )

//ls_uid2  = lnv_crypt.DecryptData( ls_uid2 , gnv_app.of_getmykey( ) ) 
//ls_pass2 = lnv_crypt.DecryptData( ls_pass2 , gnv_app.of_getmykey( ) )

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

//tab_setup.tabpage_database.dw_1.SetItem(ll_row , "rserver_nm" , ProfileString(gnv_app.of_GetAppIniFile( )  , "DataBaseRPT" ,  "SERVERNAME"   , "HOME\SQL2005DEV"  ))
//tab_setup.tabpage_database.dw_1.SetItem(ll_row , "report_db" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "database" , "FAMS" ))
//tab_setup.tabpage_database.dw_1.SetItem(ll_row , "ruser_nm" , ls_uid2 )
//tab_setup.tabpage_database.dw_1.SetItem(ll_row , "rpassword" , ls_pass2 )
//tab_setup.tabpage_database.dw_1.SetItem(ll_row , "rProvider" , ProfileString(gnv_app.of_GetAppIniFile( ) , "DataBaseRPT" ,  "Provider" , "OLEDB" ))

of_SetCheckBoxes()






end event

type p_1 from picture within w_db_setup
integer x = 3045
integer y = 8
integer width = 791
integer height = 1988
string picturename = "C:\Applications\PB 8.0\SYSTEM\code\netcaNam.gif"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cancel from lol_cb within w_db_setup
integer x = 361
integer y = 1892
integer taborder = 40
string text = "Cancel"
boolean cancel = true
end type

event clicked;close(Parent)
end event

type cb_ok from lol_cb within w_db_setup
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

   ls_password  	= tab_setup.tabpage_database.dw_1.GetItemString(1 , "password" )
   ls_password  	= gnv_services.of_encrypt_password(ls_password)//lnv_crypt.EncryptData( ls_password , lnv_crypt.of_getmykey( ) )
   ls_uid       	= tab_setup.tabpage_database.dw_1.GetItemString(1 , "user_nm" )
   ls_uid       	= gnv_services.of_encrypt_password(ls_uid)//lnv_crypt.EncryptData( ls_uid  , gnv_app.of_getmykey( ) )

  // ls_password2  	= tab_setup.tabpage_database.dw_1.GetItemString(1 , "rpassword" )
  // ls_password2  	= lnv_crypt.EncryptData( ls_password2 , lnv_crypt.of_getmykey( ) )
  // ls_uid2       		= tab_setup.tabpage_database.dw_1.GetItemString(1 , "ruser_nm" )
  // ls_uid2       		= lnv_crypt.EncryptData( ls_uid2  , lnv_crypt.of_getmykey( ) )

  // DESTROY lnv_crypt

   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "ServerName"   , tab_setup.tabpage_database.dw_1.GetItemString(1 , "server_nm" ) )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "Database" ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "database_nm" ) )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "ID"       ,  ls_uid )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "PASS"     ,  ls_password )
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "Provider" ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "provider" ) )		
   
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "DbSetUp"  ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "run" ) )		
   SetProfileString(gnv_app.of_getappinifile( )  , "DataBase", "OneLogin" ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "OneLogin" ) )		

   //SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "ServerName" , tab_setup.tabpage_database.dw_1.GetItemString(1 , "rserver_nm" ) )
   //SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "Database"   ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "report_db" ) )
   //SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "ID"         ,  ls_uid2 )
   //SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "PASS"       ,  ls_password2 )
   //SetProfileString(gnv_app.of_getappinifile( )  , "DatabaseRPT", "Provider"   ,  tab_setup.tabpage_database.dw_1.GetItemString(1 , "rprovider" ) )		

End if

Close(Parent)
end event

type tab_setup from tab within w_db_setup
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
end type

on tab_setup.create
this.tabpage_database=create tabpage_database
this.Control[]={this.tabpage_database}
end on

on tab_setup.destroy
destroy(this.tabpage_database)
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

