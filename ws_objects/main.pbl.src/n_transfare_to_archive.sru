$PBExportHeader$n_transfare_to_archive.sru
forward
global type n_transfare_to_archive from u_cst_tabpage
end type
type dw_title from u_dw within n_transfare_to_archive
end type
type cb_run from commandbutton within n_transfare_to_archive
end type
type uo_dt from uo_select_dt_neo within n_transfare_to_archive
end type
type dw_dbid from u_dw within n_transfare_to_archive
end type
type dw_archive from u_dw within n_transfare_to_archive
end type
type gb_search from groupbox within n_transfare_to_archive
end type
end forward

global type n_transfare_to_archive from u_cst_tabpage
integer width = 3717
integer height = 1872
dw_title dw_title
cb_run cb_run
uo_dt uo_dt
dw_dbid dw_dbid
dw_archive dw_archive
gb_search gb_search
end type
global n_transfare_to_archive n_transfare_to_archive

type variables
Public :
String is_DataObject = ""
String is_DateColumn = "bill_dt"
String is_TextColumn = ""
Private :
Long il_padding = 20
String is_SQL = ""


end variables

forward prototypes
public function boolean of_canclose ()
end prototypes

public function boolean of_canclose ();Return True
end function

on n_transfare_to_archive.create
int iCurrent
call super::create
this.dw_title=create dw_title
this.cb_run=create cb_run
this.uo_dt=create uo_dt
this.dw_dbid=create dw_dbid
this.dw_archive=create dw_archive
this.gb_search=create gb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_title
this.Control[iCurrent+2]=this.cb_run
this.Control[iCurrent+3]=this.uo_dt
this.Control[iCurrent+4]=this.dw_dbid
this.Control[iCurrent+5]=this.dw_archive
this.Control[iCurrent+6]=this.gb_search
end on

on n_transfare_to_archive.destroy
call super::destroy
destroy(this.dw_title)
destroy(this.cb_run)
destroy(this.uo_dt)
destroy(this.dw_dbid)
destroy(this.dw_archive)
destroy(this.gb_search)
end on

event ue_postconstructor;call super::ue_postconstructor;Long ll_max, ll_cnt
String ls_col, ls_type

dw_archive.dataObject = is_DataObject
dw_archive.SetTransObject(SQLCA)


IF dw_archive.Describe("dbid.coltype") = "?" OR dw_archive.Describe("dbid.coltype") = "!" THEN
 	dw_dbid.visible = False
Else
 	dw_dbid.visible = True
End If

IF dw_archive.Describe(is_DateColumn+".coltype") = "?" OR dw_archive.Describe(is_DateColumn+".coltype") = "!" THEN
 	uo_dt.visible = False
Else
 	uo_dt.visible = True
End If

IF Not uo_dt.visible AND Not dw_dbid.visible  THEN
	
	dw_title.visible = True
	dw_title.Modify("title.width="+String(dw_title.width - 50))
	dw_title.SetTransObject(SQLCA)
	dw_title.InsertRow(0)
	
END IF

dw_archive.Modify( "DataWindow.color=15780518" )
dw_archive.Modify( "DataWindow.brushmode=2" )
dw_archive.Modify( "DataWindow.transparency=11" )
dw_archive.Modify( "DataWindow.gradient.angle=0" )
dw_archive.Modify( "DataWindow.gradient.color=16777215" )
dw_archive.Modify( "DataWindow.gradient.focus=51" )
dw_archive.Modify( "DataWindow.gradient.scale=86" )
dw_archive.Modify( "DataWindow.gradient.spread=83" )
dw_archive.Modify( "DataWindow.gradient.transparency=0" )
///Header
dw_archive.Modify( "header.color='536870912'" )
dw_archive.Modify( "header.brushmode=0" )
dw_archive.Modify( "header.transparency=0" )
dw_archive.Modify( "header.gradient.angle=0" )
dw_archive.Modify( "header.gradient.color=8421504" )
dw_archive.Modify( "header.gradient.focus=0" )
dw_archive.Modify( "header.gradient.scale=100" )
dw_archive.Modify( "header.gradient.spread=100" )
dw_archive.Modify( "header.gradient.transparency=0" )
///Footer
dw_archive.Modify( "footer.color='536870912'" )
dw_archive.Modify( "footer.brushmode=0" )
dw_archive.Modify( "footer.transparency=0" )
dw_archive.Modify( "footer.gradient.angle=0" )
dw_archive.Modify( "footer.gradient.color=8421504" )
dw_archive.Modify( "footer.gradient.focus=0" )
dw_archive.Modify( "footer.gradient.scale=100" )
dw_archive.Modify( "footer.gradient.spread=100" )
dw_archive.Modify( "footer.gradient.transparency=0" )
///Detail
dw_archive.Modify( "detail.color='536870912~tif( mod(getrow() , 2) = 1 , rgb(176,226,255) , 553648127 )'" )
dw_archive.Modify( "detail.brushmode=0" )
dw_archive.Modify( "detail.transparency=42" )
dw_archive.Modify( "detail.gradient.angle=0" )
dw_archive.Modify( "detail.gradient.color=16777215" )
dw_archive.Modify( "detail.gradient.focus=0" )
dw_archive.Modify( "detail.gradient.scale=100" )
dw_archive.Modify( "detail.gradient.spread=100" )
dw_archive.Modify( "detail.gradient.transparency=0" )

ll_max = Long( dw_archive.Describe("DataWindow.Column.Count") )

For ll_cnt = 1 To ll_max
	
	ls_col = dw_archive.describe( "#"+string(ll_cnt)+".Name" )
	ls_type = dw_archive.describe(ls_col + ".type")

	IF(ls_type = "column")THEN
	
		dw_archive.Modify( ls_col+".color='8388608~tif(currentRow() = getrow() , rgb(176,23,61) , rgb(0,0,128) )'" )
		dw_archive.Modify( ls_col+".background.mode='1'") 
		dw_archive.Modify( ls_col+".background.color='536870912'")
		dw_archive.Modify( ls_col+".background.transparency='0'") 
		dw_archive.Modify( ls_col+".background.gradient.color='15780518'")
		dw_archive.Modify( ls_col+".background.gradient.transparency='0'") 
		dw_archive.Modify( ls_col+".background.gradient.angle='144'") 
		dw_archive.Modify( ls_col+".background.brushmode='1'")
		dw_archive.Modify( ls_col+".background.gradient.repetition.length='50'") 
		dw_archive.Modify( ls_col+".background.gradient.focus='61'")
		dw_archive.Modify( ls_col+".background.gradient.scale='60'") 
		dw_archive.Modify( ls_col+".background.gradient.spread='80'") 
		dw_archive.Modify( ls_col+".font.face='Arial (Arabic)'")
		dw_archive.Modify( ls_col+".font.height='-12'")
		dw_archive.Modify( ls_col+".font.weight='700'")
		dw_archive.Modify( ls_col+".font.family='2'")
		dw_archive.Modify( ls_col+".font.pitch='2'")
		dw_archive.Modify( ls_col+".font.charset='178'")
// background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="15780518" background.gradient.transparency="0" background.gradient.angle="144" background.brushmode="1" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="50" background.gradient.focus="61" background.gradient.scale="60" background.gradient.spread="80" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )

		
	END IF

Next

//dw_archive.retrieve(  )
is_SQL = dw_archive.getsqlselect( )

uo_dt.dp_1.value = datetime(today(),time("000000"))
uo_dt.dp_2.value = datetime(today(),time("000000"))

end event

event resize;call super::resize;//positioning the group box search 
gb_search.move( il_padding , 0 )
gb_search.resize( NewWidth -  il_padding * 2 , gb_search.height )

//positioning the datawindow
uo_dt.move(gb_search.width - uo_dt.width - il_padding , gb_search.y + il_padding * 4 )
dw_dbid.move( uo_dt.x - dw_dbid.width - il_padding * 2 , uo_dt.y )

dw_title.resize( gb_search.width - 100 , dw_dbid.height )
dw_title.Modify("title.width="+String(dw_title.width - 50))

//positioning inventory 
dw_archive.move( il_padding , gb_search.y + gb_search.height + il_padding)
dw_archive.resize( NewWidth - il_padding * 3 , NewHeight - gb_search.height - 200)

//positioning buttons
cb_run.move( NewWidth - cb_run.width - il_padding , NewHeight - cb_run.height - il_padding   )


end event

type dw_title from u_dw within n_transfare_to_archive
string tag = "<NOZOOM>"
boolean visible = false
integer x = 69
integer y = 92
integer width = 3589
integer height = 84
integer taborder = 20
string dataobject = "d_ext_edit"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_run from commandbutton within n_transfare_to_archive
integer x = 3173
integer y = 1720
integer width = 517
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "عرض"
end type

event clicked;Long ll_dbid
Datetime ldt_from,ldt_to
String ls_filter ,ls_title

IF dw_dbid.visible THEN
	ll_dbid 	= dw_dbid.GetItemNumber(1 , "dbid")
ELSE
	SetNull(ll_dbid)
END IF

IF uo_dt.visible THEN
	
	ldt_from	= uo_dt.dp_1.value
	ldt_to	= uo_dt.dp_2.value
	
	IF IsNull(ll_dbid) THEN
		ls_filter = " AND ( "+is_DateColumn+" between '"+String( ldt_from, 'dd mmm yyyy')+"' and '"+String( ldt_to, 'dd mmm yyyy')+"' )" 
	ELSE
		ls_filter = " AND ( "+is_DateColumn+" between '"+String( ldt_from, 'dd mmm yyyy')+"' and '"+String( ldt_to, 'dd mmm yyyy')+"') and ( dbid = "+String(ll_dbid) +" )"
	END IF
	
ELSE
	
	ls_title = dw_title.GetItemString(1 , "title")
	
	IF Not IsNull(ls_title) THEN
		ls_filter = " AND ( "+is_TextColumn+" like '%"+ls_title+"%') "
	END IF	
	
END IF

dw_archive.SetSQLSelect( is_SQL + ls_filter )
dw_archive.Retrieve( )
end event

type uo_dt from uo_select_dt_neo within n_transfare_to_archive
integer x = 1614
integer y = 68
integer height = 112
integer taborder = 50
end type

on uo_dt.destroy
call uo_select_dt_neo::destroy
end on

type dw_dbid from u_dw within n_transfare_to_archive
string tag = "<NOZOOM>"
integer x = 46
integer y = 76
integer width = 1435
integer height = 120
integer taborder = 10
string dataobject = "d_ext_select_branch_id"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )

This.InsertRow( 0 )
end event

type dw_archive from u_dw within n_transfare_to_archive
integer x = 14
integer y = 252
integer width = 3685
integer height = 1448
integer taborder = 10
boolean hscrollbar = true
boolean righttoleft = true
end type

event constructor;call super::constructor;This.settransobject( SQLCA )

This.of_SetSort (TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
end event

event buttonclicked;call super::buttonclicked;Long ll_row ,ll_rowcount

IF( dwo.name = "b_selectall" ) THEN
   
	ll_rowcount = dw_archive.RowCount()
	
	FOR ll_row = 1 TO ll_rowCount 
		
		IF dw_archive.GetItemString(ll_row , "POST_FG" ) = "Y" THEN
			dw_archive.SetItem(ll_row , "POST_FG" , "N")
		ELSE
			dw_archive.SetItem(ll_row , "POST_FG" , "Y")
		END IF
		
	NEXT
	
	dw_archive.accepttext( )
	
End if

IF( dwo.name = "b_apply" )THEN

	dw_archive.event pfc_update( True , True )

	COMMIT;
	
	dw_archive.retrieve( )

END IF

end event

type gb_search from groupbox within n_transfare_to_archive
integer x = 14
integer width = 3685
integer height = 228
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "بيانات البحث"
boolean righttoleft = true
end type

