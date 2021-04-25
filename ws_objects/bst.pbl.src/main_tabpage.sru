$PBExportHeader$main_tabpage.sru
forward
global type main_tabpage from u_cst_tabpage
end type
type uo_short_cut from tp_short_cut within main_tabpage
end type
type ole_1 from olecustomcontrol within main_tabpage
end type
type tv_menu from u_tv within main_tabpage
end type
type dw_main from u_dw within main_tabpage
end type
type st_1 from u_st_splitbar within main_tabpage
end type
type dw_4 from u_dw within main_tabpage
end type
type uo_shortcut from u_cst_shortcutbar within main_tabpage
end type
type uo_tree from tp_menu_tree within main_tabpage
end type
end forward

global type main_tabpage from u_cst_tabpage
integer width = 4215
integer height = 2172
string picturename = "C:\Applications\PB 12.5\Tawasul\Lap\home.ico"
event ue_sales ( )
event ue_inventory ( )
uo_short_cut uo_short_cut
ole_1 ole_1
tv_menu tv_menu
dw_main dw_main
st_1 st_1
dw_4 dw_4
uo_shortcut uo_shortcut
uo_tree uo_tree
end type
global main_tabpage main_tabpage

type variables
Public :
nvo_security ics_security
String is_URL = "http://www.weather.com/weather/today/l/LYXX0009:1:LY"
end variables

forward prototypes
public subroutine of_create_xmlfile (string as_filename, string as_filedata)
public subroutine of_sales ()
public subroutine of_inventory ()
end prototypes

event ue_sales();//Messagebox("","OK")
////////////////////////////////////////////////////////////
IF( ics_security.of_checkaccessright( "1749" ) > 0 )THEN
	of_sales()
	ole_1.visible = True
END IF
//////////////////////////////////////////////////////////

end event

event ue_inventory();//Messagebox("","OK")
////////////////////////////////////////////////////////////
IF( ics_security.of_checkaccessright( "1748" ) > 0 )THEN
	of_inventory()
	ole_1.visible = True
END IF
//////////////////////////////////////////////////////////

end event

public subroutine of_create_xmlfile (string as_filename, string as_filedata);Long ll_file

// open the file for write
ll_file = FileOpen( as_filename, TextMode!, Write!, LockReadWrite!, Replace! )

// write to the file
FileWriteEx( ll_file, as_filedata )

// close the file
FileClose( ll_file )
 
end subroutine

public subroutine of_sales ();String		ls_xml,ls_tmp
datastore	lds

lds = CREATE datastore

lds.DataObject = "ds_sales_good"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
lds.SaveAs(gs_AppPath+"FusionCharts\BSTCharts\data.xml", XML!, true)
//////////////////////////////////////////////////////////////////////////////////////////
lds.DataObject = "ds_sales_vs_cost"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
lds.object.datawindow.export.xml.usetemplate = "area"
ls_xml = lds.object.datawindow.data.xml
ls_xml = Replace(ls_xml , lastpos(ls_xml , "</graph>") , 8 ,  "") 
lds.object.datawindow.export.xml.usetemplate = "serial_2"
ls_xml += lds.object.datawindow.data.xml
lds.object.datawindow.export.xml.usetemplate = "serial_1"
ls_xml += lds.object.datawindow.data.xml 
ls_xml += "</graph>"
of_create_xmlfile(gs_AppPath+"FusionCharts\BSTCharts\area.xml" , ls_xml)
/////////////////////////////////////////////////////////////////////////////
lds.DataObject = "ds_compare_sales_by_years"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
lds.object.datawindow.export.xml.usetemplate = "categories"
ls_xml = "<?xml version=~"1.0~" encoding=~"UTF-16LE~" standalone=~"no~"?>&
<graph bgSWF=~"img/custom-blue-wallpaper.jpg~" baseFont=~"Arial~" baseFontSize =~"12~" baseFontColor =~"FFFFFF~" canvasBgAlpha=~"20~" canvasBorderColor=~"7B3F00~" caption=~"مبيعات مقارنة~" xaxisname=~"الاشهر~" yaxisname=~"المبلغ~" hovercapbg=~"DEDEBE~" numdivlines=~"9~" rotateNames=~"0~" divLineAlpha=~"80~" divLineColor=~"CCCCCC~" yAxisMaxValue=~"100~" hovercapborder=~"889E6D~" decimalPrecision=~"0~" AlternateHGridAlpha=~"30~" AlternateHGridColor=~"CCCCCC~" showAlternateHGridColor=~"1~">&
<categories font=~"Arial~" fontSize=~"11~" fontColor=~"FFFFFF~">&
<category name=~"Jan~"/>&
<category name=~"Feb~"/>&
<category name=~"Mar~"/>&
<category name=~"Apr~"/>&
<category name=~"May~"/>&
<category name=~"Jun~"/>&
<category name=~"Jul~"/>&
<category name=~"Aug~"/>&
<category name=~"Sep~"/>&
<category name=~"Oct~"/>&
<category name=~"Nov~"/>&
<category name=~"Dec~"/>&
</categories>"
lds.setfilter("year = "+String(year(date(gnv_services.uf_today())) - 2))
lds.filter()
lds.object.datawindow.export.xml.usetemplate = "series_1"
ls_xml += lds.object.datawindow.data.xml
lds.setfilter("year = "+String(year(date(gnv_services.uf_today())) - 1))
lds.filter()
lds.object.datawindow.export.xml.usetemplate = "series_2"
ls_xml += lds.object.datawindow.data.xml 
lds.setfilter("year = "+String(year(date(gnv_services.uf_today())) ))
lds.filter()
lds.object.datawindow.export.xml.usetemplate = "series_3"
ls_xml += lds.object.datawindow.data.xml 
ls_xml += "</graph>"
of_create_xmlfile(gs_AppPath+"FusionCharts\BSTCharts\comparesales.xml" , ls_xml)

Destroy lds

ole_1.object.navigate("file:\\\"+gs_AppPath+"FusionCharts\BSTCharts\sales.html")

end subroutine

public subroutine of_inventory ();String		ls_xml,ls_tmp
datastore	lds

lds = CREATE datastore
/////////////////////////////////////////////////////////////////////////////
ls_xml = "<?xml version=~"1.0~" encoding=~"UTF-16LE~" standalone=~"no~"?><graph bgSWF=~"img/custom-blue-wallpaper.jpg~" canvasBgAlpha=~"20~" baseFont=~"Arial~" baseFontSize =~"12~" baseFontColor =~"FFFFFF~" canvasBorderColor=~"7B3F00~"  xAxisName=~"الاسابيع~" yAxisName=~"الكمية~" caption=~"جرد اخر 7 اسابيع~" subCaption=~"~" decimalPrecision=~"0~" rotateNames=~"0~" numDivLines=~"3~" numberPrefix=~"~" showValues=~"0~" formatNumberScale=~"0~">"
lds.DataObject = "ds_wkno"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
ls_xml += lds.object.datawindow.data.xml 

lds.DataObject = "ds_inv_per_week_by_fid"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
ls_tmp = replace(lds.object.datawindow.data.xml,1 , 6 , "") 
ls_tmp = replace(ls_tmp,len(ls_tmp) - 7 , 7 , "")
ls_xml += ls_tmp
ls_xml += "</graph>"

of_create_xmlfile(gs_AppPath+"FusionCharts\BSTCharts\bar3ds.xml" , ls_xml)
//////////////////////////////////////////////////////////////////////////////////////////////////

lds.DataObject = "ds_inv_by_fid"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
lds.SaveAs(gs_AppPath+"FusionCharts\BSTCharts\invpie2d.xml", XML!, true)

////////////////////////////////////////////////////////////////////////////////////////////////
lds.DataObject = "ds_inv_value_by_fid"
lds.SetTransObject( SQLCA)
lds.Retrieve( )
lds.SaveAs(gs_AppPath+"FusionCharts\BSTCharts\invpie2dvalue.xml", XML!, true)

Destroy lds

ole_1.object.navigate("file:\\\"+gs_AppPath+"FusionCharts\BSTCharts\inv.html")

end subroutine

on main_tabpage.create
int iCurrent
call super::create
this.uo_short_cut=create uo_short_cut
this.ole_1=create ole_1
this.tv_menu=create tv_menu
this.dw_main=create dw_main
this.st_1=create st_1
this.dw_4=create dw_4
this.uo_shortcut=create uo_shortcut
this.uo_tree=create uo_tree
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_short_cut
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.tv_menu
this.Control[iCurrent+4]=this.dw_main
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.uo_shortcut
this.Control[iCurrent+8]=this.uo_tree
end on

on main_tabpage.destroy
call super::destroy
destroy(this.uo_short_cut)
destroy(this.ole_1)
destroy(this.tv_menu)
destroy(this.dw_main)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.uo_shortcut)
destroy(this.uo_tree)
end on

event resize;call super::resize;	uo_shortcut.move( 0 , 0 )
	uo_shortcut.resize( uo_shortcut.width , newheight )
	
	st_1.move( uo_shortcut.x + uo_shortcut.width,0)
	st_1.resize( st_1.width , newheight )
	
	dw_main.move( st_1.x + st_1.width  , 0 )
	dw_main.resize( newwidth - uo_shortcut.width - st_1.width , newheight )
	ole_1.move( st_1.x + st_1.width  , 0 )
	ole_1.resize( newwidth - uo_shortcut.width - st_1.width , newheight )
end event

event ue_postconstructor;call super::ue_postconstructor;String ls_db_nm , ls_db_id,ls_branch_nm
String ls_db_nm_II , ls_last_shortcut
str_pass_parmeters lstr_parm
//cs_sync lc_sync

st_1.of_register( uo_shortcut, st_1.left )
st_1.of_register( dw_main, st_1.right )
st_1.of_register( ole_1, st_1.right )

IF gs_lan <> "AR" THEN
	
	uo_short_cut.dw_1.righttoleft = False
	uo_short_cut.dw_1.Modify( "title.righttoleft=0" )
	
END IF

uo_tree.ics_security = ics_security

uo_short_cut.ics_security = ics_security

uo_Shortcut.of_additem( uo_short_cut	, /*gnv_Lan.of_get_title(gs_lan , "Main" , "ShortCutTitle")		*/ "إختصـــارات"	, "Custom079!")
//uo_Shortcut.of_additem( dw_3			 	, gnv_Lan.of_get_title(gs_lan , "Main" , "MessagesTitle")			, "BrowseClasses!")
//uo_Shortcut.of_additem( dw_2			   , gnv_Lan.of_get_title(gs_lan , "Main" , "MailTitle")					, "NestedReport!")
uo_Shortcut.of_additem( uo_tree			, /*gnv_Lan.of_get_title(gs_lan , "Main" , "MainMenuTitle") */	"القائمة الرئيسية"	, "C:\Applications\icons\New Folder\home.ico")

ls_last_shortcut = ProfileString( gnv_app.of_getappinifile( )  , "Database", "LastShortCut", gnv_Lan.of_get_title(gs_lan , "Main" , "MainTabTitle"))

uo_Shortcut.of_SelectItem( ls_last_shortcut )

uo_Shortcut.of_SetSize( uo_Shortcut.small )
uo_Shortcut.of_SetStyle(uo_Shortcut.vistaoriginal)
uo_Shortcut.of_DisplayCloseButton(FALSE)
uo_Shortcut.of_DisplayHeaderImage(TRUE)
uo_Shortcut.of_SetShadowText(FALSE)

lstr_parm = gnv_services.of_BackgroundColor()

dw_main.modify(lstr_parm.String_parm[1] ) 
dw_main.modify(lstr_parm.String_parm[2]) 
uo_short_cut.dw_1.modify(lstr_parm.String_parm[1] ) 
//dw_2.modify(lstr_parm.String_parm[1] ) 
//dw_3.modify(lstr_parm.String_parm[1] ) 

Choose Case ProfileString( gnv_app.of_getappinifile( )  , "Database", "BGColor", "Blue")
	Case "Blue"
		uo_Shortcut.of_SetTheme( uo_Shortcut.Blue )
		uo_Short_cut.uo_btn_list.of_Settheme( uo_Short_cut.uo_btn_list.blue )
	Case "Olive"
		uo_Shortcut.of_SetTheme( uo_Shortcut.Olive )
		uo_Short_cut.uo_btn_list.of_Settheme( uo_Short_cut.uo_btn_list.Olive )
	Case "Silver"
		uo_Shortcut.of_SetTheme( uo_Shortcut.silver )
		uo_Short_cut.uo_btn_list.of_Settheme( uo_Short_cut.uo_btn_list.silver )		
End Choose

n_cst_drawtree cs_tree

cs_tree = Create n_cst_drawtree

cs_tree.is_parentidname		= "PARENT"
cs_tree.is_childidname		= "ACID"
cs_tree.is_tablename			= "ACCESS_CD"

IF gs_Lan = "AR" THEN
	cs_tree.is_titlename		= "TITLE"
ELSE
	cs_tree.is_titlename		= "( SELECT MENU_LAN.TITLE FROM MENU_LAN WHERE MENU_LAN.ID = '"+gs_lan+"'+CAST(ACID as varchar(5)) )"
END IF

cs_tree.is_where					= "WHERE VISIBLE_FG = 'Y'"
cs_tree.is_OtherProperties		= " , T.pic as pic_id "
cs_tree.is_OrderBy				= " Order By Rank ASC"

cs_tree.of_initial(uo_tree.tv_menu)

Destroy cs_tree

//IF( ProfileString( gnv_app.uf_get_ini_file()  , "Database"		, "WEATHER"       		, "0") = "1" )THEN
//
//	ole_1.visible = True
//	ole_1.object.navigate(is_URL)
//
//ELSE
//	
	ole_1.visible = FALSE
//
//END IF
end event

event constructor;call super::constructor;String ls_id

ls_id= "1"
end event

type uo_short_cut from tp_short_cut within main_tabpage
integer x = 238
integer y = 228
integer width = 955
integer height = 784
integer taborder = 30
end type

on uo_short_cut.destroy
call tp_short_cut::destroy
end on

type ole_1 from olecustomcontrol within main_tabpage
event statustextchange ( string as_text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string as_text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( boolean activedocument,  ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
event setphishingfilterstatus ( long phishingfilterstatus )
event newprocess ( long lcauseflag,  oleobject pwb2,  ref boolean ab_cancel )
event redirectxdomainblocked ( oleobject pdisp,  any starturl,  any redirecturl,  any frame,  any statuscode )
event beforescriptexecute ( oleobject pdispwindow )
boolean visible = false
integer x = 1504
integer y = 672
integer width = 2103
integer height = 1156
integer taborder = 30
borderstyle borderstyle = stylelowered!
long backcolor = 553648127
boolean focusrectangle = false
string binarykey = "main_tabpage.udo"
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type tv_menu from u_tv within main_tabpage
boolean visible = false
integer x = 69
integer y = 1268
integer width = 1271
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = arabiccharset!
string facename = "Arial"
long backcolor = 16777215
boolean linesatroot = true
boolean trackselect = true
string picturename[] = {"C:\Applications\icons\New Folder\folder_open_add2.ico","C:\Applications\icons\New Folder\folder_open_accept.ico","C:\Applications\icons\New Folder\cube_config.ico","C:\Applications\icons\New Folder\exit_2.ico","C:\Applications\icons\New Folder\misc_box.ico","C:\Applications\icons\New Folder\ico\Windows 7 (173).ico","C:\Applications\icons\New Folder\kgpg_key3_kopete.ico","C:\Applications\icons\New Folder\ico\Windows 7 (89).ico","C:\Applications\icons\New Folder\ico\Tools.ico","C:\Applications\icons\New Folder\document_export.ico","C:\Applications\icons\New Folder\document_import.ico","C:\Applications\icons\New Folder\ico\Iconshock-Super-Vista-Business-Column-chart.ico","C:\Applications\icons\New Folder\ico\Visualpharm-Finance-Cash-register.ico","C:\Applications\icons\New Folder\ico\Aha-Soft-Software-Reports.ico","C:\Applications\icons\New Folder\ico\App-ark.ico","C:\Applications\icons\New Folder\ico\Wwalczyszyn-Iwindows-Recycle-Bin.ico","C:\Applications\icons\New Folder\ico\Iconshock-Payment-Wire-transfer.ico","C:\Applications\icons\New Folder\ico\archive_2.ico","C:\Applications\icons\New Folder\ico\Tag.ico","C:\Applications\icons\New Folder\ico\advanced.ico","C:\Applications\icons\New Folder\ico\File-Manager.ico","C:\Applications\icons\New Folder\1294065628_user.ico","C:\Applications\icons\New Folder\ico\Meeting-Dark.ico","C:\Applications\icons\New Folder\ico\user-properties.ico","C:\Applications\icons\New Folder\Parcel_win7.ico","C:\Applications\icons\New Folder\ico\Payment.ico","C:\Applications\icons\New Folder\ico\return.ico","C:\Applications\icons\New Folder\ico\discount.ico","C:\Applications\icons\New Folder\ico\money.ico","C:\Applications\icons\New Folder\ico\discount2.ico","C:\Applications\icons\New Folder\ico\Iconshock-Free-Folder-Folder-invoices.ico","C:\Applications\icons\New Folder\ico\Visualpharm-Finance-Invoice.ico","C:\Applications\icons\New Folder\ico\Minus.ico","C:\Applications\icons\New Folder\ico\document.ico","C:\Applications\icons\New Folder\ico\User.ico","C:\Applications\icons\New Folder\ico\Address-book.ico","C:\Applications\icons\New Folder\ico\Apps-file-manager.ico","C:\Applications\icons\New Folder\ico\Board.ico","C:\Applications\icons\New Folder\ico\Iconshock-Payment-Check.ico","C:\Applications\icons\New Folder\ico\document-yellow.ico","C:\Applications\icons\New Folder\ico\contact-new.ico","C:\Applications\icons\New Folder\ico\Finance.ico","C:\Applications\icons\New Folder\ico\PPT-filetype.ico","C:\Applications\icons\New Folder\ico\Business-Safe.ico","C:\Applications\icons\New Folder\ico\exchange.ico","C:\Applications\icons\New Folder\1294065821_School.ico","C:\Applications\icons\New Folder\ico\Dapino-Money-Money-Safe-1.ico","C:\Applications\icons\New Folder\1294064930_shopping_cart.ico","C:\Applications\icons\New Folder\truckyellow.ico","C:\Applications\icons\New Folder\army-officer.ico","C:\Applications\icons\New Folder\ico\Container.ico","C:\Applications\icons\New Folder\ico\Artua-Mac-ISync.ico","C:\Applications\icons\New Folder\ico\Archive.ico","C:\Applications\icons\New Folder\tool-kit.ico","C:\Applications\icons\New Folder\arrow-up.ico","C:\Applications\icons\New Folder\Truck.ico","C:\Applications\icons\New Folder\Insurance.ico","C:\Applications\icons\New Folder\Partnership.ico","C:\Applications\icons\New Folder\Personal-loan.ico","C:\Applications\icons\New Folder\Database-Active.ico","C:\Applications\icons\New Folder\Email-Download.ico","C:\Applications\icons\New Folder\Calendar.ico","C:\Applications\icons\New Folder\ico\Apps-file-manager_1.ico","C:\Applications\icons\New Folder\ico\1426805225_105251.ico","C:\Applications\icons\New Folder\ico\1426805313_2493.ico","C:\Applications\icons\New Folder\ico\1426805582_131975.ico","C:\Applications\icons\New Folder\ico\PC-Reg.ico","C:\Applications\icons\New Folder\png\ht_hardware_hospitality.png","C:\Applications\icons\New Folder\1441474314_document.ico","C:\Applications\icons\New Folder\1441471821_value3d.ico","C:\Applications\icons\New Folder\Omercetin-Pixelophilia2-Target.ico","C:\Applications\icons\New Folder\ico\whitebox.ico","C:\Applications\icons\New Folder\ico\bluezip.ico","C:\Applications\icons\New Folder\ico\ws.ico","C:\Applications\icons\New Folder\ico\Fatcow-Farm-Fresh-Globe-place.ico","C:\Applications\icons\New Folder\ico\Meeting-Dark.ico","C:\Applications\icons\New Folder\Svengraph-I-Love-Lock.ico","C:\Applications\icons\New Folder\ico\Kyo-Tux-Ginux-Extras-Security.ico","C:\Applications\icons\New Folder\ico\Everaldo-Crystal-Clear-App-ark-2.ico"}
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
cst_events.is_title = lstr_stack.as_title
cst_events.triggerevent( "of_"+lstr_stack.as_data)
cst_events.is_title = ""
DESTROY cst_events
end event

event key;call super::key;IF Keydown(KeyEnter!) THEN

	This.event doubleclicked(	This.FindItem(currenttreeitem! , 0) )
	
END IF
end event

type dw_main from u_dw within main_tabpage
integer x = 1426
integer width = 2761
integer height = 2164
integer taborder = 40
string dataobject = "d_ext_main_screen"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;
dw_main.SetTransObject(SQLCA)

dw_main.SetItem( dw_main.insertrow( 0 ) , "pc", gstr_user_info.computer_name )

end event

event buttonclicked;call super::buttonclicked;str_pass_parmeters lstr_parm

IF dwo.name = "b_1" THEN
	
	uo_Shortcut.of_SetTheme( uo_Shortcut.Blue )
	SetProfileString( gnv_app.of_getappinifile( ), "Database", "BGColor", "Blue")	
	w_menu.uo_tabcontrol.of_SetTheme( w_menu.uo_tabcontrol.blue )
	uo_short_cut.uo_btn_list.of_settheme( uo_short_cut.uo_btn_list.blue )
	
END IF

IF dwo.name = "b_2" THEN
	
	uo_Shortcut.of_SetTheme( uo_Shortcut.Olive )
	SetProfileString( gnv_app.of_getappinifile( ), "Database", "BGColor", "Olive")
	uo_short_cut.uo_btn_list.of_settheme( uo_short_cut.uo_btn_list.Olive )
	w_menu.uo_tabcontrol.of_SetTheme( w_menu.uo_tabcontrol.olive )

END IF

IF dwo.name = "b_3" THEN
		
	uo_Shortcut.of_SetTheme( uo_Shortcut.silver )
	SetProfileString( gnv_app.of_getappinifile( ), "Database", "BGColor", "Silver" )
	uo_short_cut.uo_btn_list.of_settheme( uo_short_cut.uo_btn_list.silver )
	w_menu.uo_tabcontrol.of_SetTheme( w_menu.uo_tabcontrol.silver )

END IF

lstr_parm = gnv_services.of_BackgroundColor()

This.modify(lstr_parm.String_parm[1] )
This.modify(lstr_parm.String_parm[2] )
uo_short_cut.dw_1.modify( lstr_parm.String_parm[1] ) 

//dw_2.modify(lstr_parm.String_parm[1] ) 
//dw_3.modify(lstr_parm.String_parm[1] ) 
//
end event

type st_1 from u_st_splitbar within main_tabpage
integer x = 1390
integer width = 32
integer height = 1824
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_4 from u_dw within main_tabpage
boolean visible = false
integer x = 55
integer y = 304
integer width = 1239
integer height = 1312
integer taborder = 10
string dataobject = "d_confirmation_list"
boolean hscrollbar = true
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;str_pass_parmeters lstr_parm 
//w_view_invoice w_win

if(dwo.name = "b_ok")Then

	This.SetItem(row , "approval_fg" , "Y")
	This.SetItem(row , "reply_dt" , gnv_services.uf_today( ) )
	
	This.Update( )
	
	COMMIT;
	
 	This.retrieve( gstr_user_info.id)
	
end if


if(dwo.name = "b_view")Then
	
	lstr_parm.long_array[1] = This.GetItemNumber(row , "bill_no")	
	
//	OpenWithParm(w_win,lstr_parm,w_menu)
	
//	w_win.bringtotop = True
	
end if


if(dwo.name = "b_1")Then
	This.retrieve( gstr_user_info.id)
end if
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)

//This.retrieve( gstr_user_info.id)
end event

type uo_shortcut from u_cst_shortcutbar within main_tabpage
event destroy ( )
integer width = 1399
integer height = 1812
integer taborder = 30
end type

on uo_shortcut.destroy
call u_cst_shortcutbar::destroy
end on

event ue_selectionchanged;call super::ue_selectionchanged;SetProfileString(gnv_app.of_getappinifile( ) , "DataBase", "LastShortCut", as_text)
end event

type uo_tree from tp_menu_tree within main_tabpage
integer x = 238
integer y = 880
integer width = 795
integer taborder = 30
boolean bringtotop = true
end type

on uo_tree.destroy
call tp_menu_tree::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fmain_tabpage.bin 
2200000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000003323e1f001d4a66e00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000332393d001d4a66e332393d001d4a66e000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00002f8b00001dde0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00002f8b00001dde0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fmain_tabpage.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
