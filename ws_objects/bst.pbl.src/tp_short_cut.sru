$PBExportHeader$tp_short_cut.sru
forward
global type tp_short_cut from u_cst_tabpage
end type
type pb_menu from picturebutton within tp_short_cut
end type
type pb_add from picturebutton within tp_short_cut
end type
type uo_btn_list from u_cst_buttonlistbar within tp_short_cut
end type
type sle_fn from singlelineedit within tp_short_cut
end type
type dw_1 from u_dw within tp_short_cut
end type
end forward

global type tp_short_cut from u_cst_tabpage
integer width = 960
integer height = 1364
pb_menu pb_menu
pb_add pb_add
uo_btn_list uo_btn_list
sle_fn sle_fn
dw_1 dw_1
end type
global tp_short_cut tp_short_cut

type variables
Public :
nvo_security ics_security
Long il_btn_count = 0
end variables

on tp_short_cut.create
int iCurrent
call super::create
this.pb_menu=create pb_menu
this.pb_add=create pb_add
this.uo_btn_list=create uo_btn_list
this.sle_fn=create sle_fn
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_menu
this.Control[iCurrent+2]=this.pb_add
this.Control[iCurrent+3]=this.uo_btn_list
this.Control[iCurrent+4]=this.sle_fn
this.Control[iCurrent+5]=this.dw_1
end on

on tp_short_cut.destroy
call super::destroy
destroy(this.pb_menu)
destroy(this.pb_add)
destroy(this.uo_btn_list)
destroy(this.sle_fn)
destroy(this.dw_1)
end on

event resize;call super::resize;//dw_1.move(0				 , 0 )
//dw_1.resize(newwidth , newheight - sle_fn.height)

dw_1.move(0				 , 0 )
dw_1.resize(newwidth , newheight - ( sle_fn.height + 4 ) )

uo_btn_list.move(0				 , 0 )
uo_btn_list.resize(newwidth , newheight - ( sle_fn.height + 4 ) )

sle_fn.resize( newwidth - pb_add.width - pb_menu.width  , sle_fn.height )
sle_fn.move( 0 			,  uo_btn_list.y + uo_btn_list.height + 4)

pb_add.move(sle_fn.width ,sle_fn.y - 4  )
pb_menu.move(pb_add.x + pb_add.width ,sle_fn.y - 4  )

end event

event ue_postconstructor;call super::ue_postconstructor;Long ll_row
str_pass_parmeters lstr_parm

sle_fn.SetFocus( )

il_btn_count = dw_1.RowCount() 

FOR ll_row = 1 To il_btn_count
	lstr_parm = gnv_services.of_split( dw_1.GetItemString(ll_row , "title") , "-")
	
	uo_btn_list.of_AddItem(lstr_parm.String_parm[UPPERBOUND(lstr_parm.String_parm)],  "C:\Applications\icons\New Folder\ico\Tag.ico")

NEXT 


IF ProfileString(gnv_app.of_getappinifile( ) , "DataBase", "ShortCutMenu", "dw") = "dw" THEN

	dw_1.visible = True
	uo_btn_list.visible = False

ELSE

	dw_1.visible = False
	uo_btn_list.visible = True

END IF
end event

type pb_menu from picturebutton within tp_short_cut
integer x = 841
integer y = 1268
integer width = 123
integer height = 100
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Applications\icons\hot\png\16x16\Transfer.png"
alignment htextalign = left!
end type

event clicked;IF uo_btn_list.visible THEN
	
	dw_1.visible = True
	uo_btn_list.visible = False
	SetProfileString(gnv_app.of_getappinifile( ) , "DataBase", "ShortCutMenu", "dw")
	
ELSE
	
	dw_1.visible = False
	uo_btn_list.visible = True	
	SetProfileString(gnv_app.of_getappinifile( ) , "DataBase", "ShortCutMenu", "btn")
	
END IF


end event

type pb_add from picturebutton within tp_short_cut
integer x = 731
integer y = 1268
integer width = 123
integer height = 100
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Applications\icons\hot\png\16x16\Add.png"
alignment htextalign = left!
end type

event clicked;DataStore lds
Long ll_row , ll_RowCount

open(w_user_access_right_list)
dw_1.event pfc_retrieve( )

//uo_btn_list.setredraw( False )


uo_btn_list.deleteitem( ll_row )

il_btn_count = dw_1.RowCount() 

FOR ll_row = 1 To il_btn_count
	
	uo_btn_list.of_AddItem(dw_1.GetItemString(ll_row , "title") ,  "C:\Applications\icons\New Folder\ico\Tag.ico")

NEXT 

uo_btn_list.triggerevent( "resize")

//uo_btn_list.setredraw( True )




end event

type uo_btn_list from u_cst_buttonlistbar within tp_short_cut
boolean visible = false
integer width = 955
integer height = 1264
integer taborder = 20
end type

on uo_btn_list.destroy
call u_cst_buttonlistbar::destroy
end on

event constructor;call super::constructor;
THIS.of_SetScrollSpeed(20)
THIS.of_SetSize(THIS.small )
//THIS.of_SetStyle(THIS.style )


end event

event selectionchanging;call super::selectionchanging;String ls_title , ls_fn
String ls_event
Long ll_row
n_cst_events cst_events

ls_title = This.of_gettext( newindex )

ls_fn = trim(Mid(ls_title , lastpos(ls_title , " ") , Len(ls_title) ) )



IF  Not IsNull(ls_fn)  THEN
 
IF ls_title =  "عرض قائمة الاختصارات" THEN
	uo_btn_list.visible = False
	dw_1.visible = True
END IF
 
ll_row = ics_security.of_checkaccessright(ls_fn) 

IF((ll_row <= 0)OR(IsNull(ll_row)))THEN RETURN 0

cst_events = CREATE n_cst_events
cst_events.is_title = ls_title
cst_events.triggerevent( "of_"+ls_fn)
cst_events.is_title = ""
DESTROY cst_events

End if

return 1

end event

type sle_fn from singlelineedit within tp_short_cut
event of_keydown pbm_keydown
integer y = 1272
integer width = 731
integer height = 92
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
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
		IF Mid(sle_fn.text , 1 , 1) = "@" THEN
			
			lstr_parm = gnv_services.of_split( Mid(sle_fn.text , 2 , Len(sle_fn.text) ) , "," )
			csB# = CREATE nvo_b#
			
			ll_RowCount = upperbound( lstr_parm.string_parm )
			
			FOR ll_row = 1 To ll_RowCount
				csB#.of_parse( lstr_parm.string_parm[ll_row] )
			NEXT
			
			Destroy csB#
			
		ELSE
	
			lstr_parm = gnv_services.of_split( sle_fn.text , "," )
		
			ll_RowCount = UpperBound(lstr_parm.string_parm)
	
			cst_events = CREATE n_cst_events
	
			FOR ll_itr = 1 To ll_RowCount
			
					ll_row = ics_security.of_CheckAccessRight( lstr_parm.string_parm[ll_itr] ) 
					
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
		
END IF
*/
Return 1
end event

type dw_1 from u_dw within tp_short_cut
integer width = 946
integer height = 1252
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_q_menu"
end type

event constructor;call super::constructor;This.settransobject( SQLCA )
This.event pfc_retrieve( )
end event

event buttonclicked;call super::buttonclicked;DataStore lds
Long ll_row

IF(dwo.name = "b_1")THEN

 	lds = create DataStore
	lds.DataObject = "d_user_menu"
 	lds.SetTransObject( SQLCA )
	lds.retrieve( )
	
	ll_row = lds.find( "user_no="+String(gstr_user_info.id)+" and aid="+String(This.GetItemNumber(row , "aid")) , 0 , lds.RowCount())
	IF(ll_row > 0 )THEN lds.DeleteRow(ll_row)
	lds.update( True , True )
	Commit ;
	dw_1.event pfc_retrieve( )
	
END IF

IF(dwo.name = "b_2")THEN
//	open(w_user_access_right_list)
//	dw_1.event pfc_retrieve( )

	uo_btn_list.visible = True
	dw_1.visible = False

END IF

//IF(dwo.name = "b_3")THEN
////	open(w_user_access_right_list)
//    MessageBox("","Under Constraction")
//	dw_1.event pfc_retrieve( )
//END IF
end event

event pfc_retrieve;call super::pfc_retrieve;return This.retrieve( gstr_user_info.id , gs_lan )
end event

event doubleclicked;call super::doubleclicked;String ls_event
Long ll_row
n_cst_events cst_events

IF  row > 0  THEN
 
ls_event = string(This.GetItemNumber(row , "ACID"))

ll_row = ics_security.of_checkaccessright(ls_event) 

IF((ll_row <= 0)OR(IsNull(ll_row)))THEN RETURN 

cst_events = CREATE n_cst_events
cst_events.is_title = This.GetItemString(row , "title")
cst_events.triggerevent( "of_"+ls_event)
cst_events.is_title = ""
DESTROY cst_events

End if
end event

