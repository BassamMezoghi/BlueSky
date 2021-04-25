$PBExportHeader$shms.sra
$PBExportComments$Generated Application Object
forward
global type shms from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
/*  Application Manager  */
nvo_appmanager 		gnv_app 
nvo_services 				gnv_services 
nvo_security 				gnv_security
n_cst_sqlspy 				gnv_sqlspy
n_cst_debug 				gnv_debug
n_cst_sys_setup			gnv_settings
n_cst_msg					gnv_msg
nvo_multi_languages  	gnv_Lan
n_smtp 						gn_smtp

str_user_info 				gstr_user_info
str_pass_parmeters 	gstr_parm

String 						gs_dbid = "-"
String 						gs_AppPath
String 						gs_FileName
String						gs_UpdateFile = "-"
String						gs_AppVer = "1.0.0.0"
String 						gs_Lan = "EN"

//Long Current_Lang 		= 67699721
Long SplashTimer		= 2

Constant int MAXIMIZED 		= 3
Constant int MINIMIZED 			= 2
Constant int NORMAL 			= 1
Constant boolean WAIT 			= TRUE
Constant boolean NOWAIT		= FALSE

Constant int General 					= 0
Constant int Sales 						= 1
Constant int Clients 					= 2
Constant int SalesReturn 				= 3
Constant int Discount 					= 4
Constant int Payment 					= 5
Constant int GeneralExpense 			= 6
Constant int Vender 						= 7
Constant int Purchase 					= 8
Constant int PurchaseReturn 			= 9
Constant int Capital 					= 10
Constant int DeadAccount				= 11
Constant int VehicleExpense			= 12
Constant int TransfareBouns			= 13
Constant int OtherBouns					= 14
Constant int OtherLoses					= 15
Constant int CustomServices			= 16
Constant int PurchaseExpense			= 17
Constant int PurchasePayments			= 18
Constant int SwapMoney					= 19
Constant int InitialStock				= 20
Constant int SalesCost					= 21
Constant int Warehouse					= 22
Constant int Dealer						= 23
Constant int Topup						= 24
Constant int ReturnCash					= 25
Constant int ShareVactor				= 1

Constant int Licenses					= 25
Constant String gs_password 		= "@staLav1sT@"
Constant Boolean Demo 				= False
Constant Long MaxRows 			= 5
Constant Long MaxLogin 			= 300

//Access right
//the ability to change the branch dropdown in logon screen
Constant ulong  ChangeBranch	= 374 

//Constant long lang_US_English = 67699721

///////////////////////////////////////////////////////
Constant String AppCode = "gfeu-iw38-jshd-bmal"

end variables

global type shms from application
string appname = "shms"
string appruntimeversion = "19.2.0.2703"
end type
global shms shms

type prototypes
//FUNCTION int GetModuleFileNameA(ulong hinstModule, REF string lpszPath, ulong cchPath) LIBRARY "kernel32" alias for "GetModuleFileNameA;Ansi"
FUNCTION ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath )  &
   LIBRARY "KERNEL32.DLL" &
   ALIAS FOR "GetModuleFileNameA;ansi"  // ;ansi  required for PB10 or better


FUNCTION long GetVolumeInformation & 
  (string lpRootPathName, REF string lpVolumeNameBuffer, &
   long nVolumeNameSize, & 
   REF long lpVolumeSerialNumber, REF long lpMaximumComponentLength, & 
   REF long lpFileSystemFlags, REF string lpFileSystemNameBuffer, & 
   long nFileSystemNameSize) & 
   LIBRARY "Kernel32.dll" ALIAS FOR "GetVolumeInformationA"


////code to flip objects to RTL: 
//FUNCTION long SetWindowLongA(Handle(object), GWL_EXSTYLE, WS_EX_LAYOUTRTL) 
//
////code to flip objects back to LTR: 
//FUNCTION long SetWindowLongA(Handle(object), GWL_EXSTYLE, WS_EX_LEFT) 
end prototypes

on shms.create
appname="shms"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on shms.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gnv_app = create nvo_appmanager

//This.ToolBarUserControl = FALSE
Idle(300)
gnv_app.Event pfc_open ( commandline )
end event

event idle;gnv_app.Event pfc_idle (  )
end event

event close;String ls_provider
String ls_Commandline
ls_provider = ProfileString(gnv_app.of_getappinifile( ) ,"Database" , "Provider" , "SQLNCLI10" )

gnv_app.Event pfc_close ( )

Destroy gnv_app

//"OLE DB|Demo|MARS\MSSQL08|RU|sa|aqswde
//|SQLNCLI10|C:\Applications\PB 11.0\Alata\History\1.0.4.9(cr)\|1.0.4.9.bst|B@sS@m77|erp.exe"

ls_Commandline = SQLCA.dbms+"|"+SQLCA.Database+"|"+SQLCA.servername+"|"+SQLCA.lock+"|"+SQLCA.logid+"|"+SQLCA.logpass+"|"+ls_provider&
+"|"+gs_AppPath+"|"+gs_UpdateFile+"|"+gs_password+"|"+gs_FileName

//MessageBox("",ls_Commandline)

if(gs_UpdateFile <> "-")Then

	Run("extractor.exe "+ls_Commandline )

end if
end event

event connectionbegin;Return gnv_app.Event pfc_connectionbegin ( userid, password, connectstring )
end event

event connectionend;gnv_app.Event pfc_connectionend (  )
end event

event systemerror;gnv_app.Event pfc_systemerror ( )
end event

