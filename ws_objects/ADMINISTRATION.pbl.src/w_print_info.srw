$PBExportHeader$w_print_info.srw
forward
global type w_print_info from window
end type
type cb_2 from u_cb within w_print_info
end type
type cb_1 from u_cb within w_print_info
end type
type cb_close from u_cb within w_print_info
end type
type gb_2 from groupbox within w_print_info
end type
type cb_print from u_cb within w_print_info
end type
type dw_invoice from u_dw within w_print_info
end type
end forward

global type w_print_info from window
integer width = 3753
integer height = 2960
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
cb_2 cb_2
cb_1 cb_1
cb_close cb_close
gb_2 gb_2
cb_print cb_print
dw_invoice dw_invoice
end type
global w_print_info w_print_info

type variables
uo_resize iuo_resize
str_pass_parmeters istr_parm
end variables

on w_print_info.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_close=create cb_close
this.gb_2=create gb_2
this.cb_print=create cb_print
this.dw_invoice=create dw_invoice
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_close,&
this.gb_2,&
this.cb_print,&
this.dw_invoice}
end on

on w_print_info.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.cb_print)
destroy(this.dw_invoice)
end on

event open;iuo_resize = CREATE uo_resize
iuo_resize.of_setTag(this)

istr_parm.string_parm[1] = ""

dw_invoice.dataobject = gstr_parm.string_parm[1]

dw_invoice.SetTransObject( SQLCA )
dw_invoice.Event pfc_retrieve()



IF gstr_parm.string_parm[1] = "d_rpt_price_list" THEN
	
	dw_invoice.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='2633' y='12' height='64' width='489' html.valueishtml='0'  name=t_branch visible='1'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
	dw_invoice.Modify("Create text(band=footer alignment='0' text=': الفرع' border='0' color='33554432' x='3136' y='12' height='64' width='142' html.valueishtml='0'  name=t_branch_title visible='1'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
	dw_invoice.Modify("Create text(band=footer alignment='0' text=': اسم المستخدم' border='0' color='33554432' x='2295' y='12' height='64' width='315' html.valueishtml='0'  name=t_user_nm_title visible='1'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
	dw_invoice.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1883' y='12' height='64' width='398' html.valueishtml='0'  name=t_user_nm visible='1'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
	dw_invoice.Modify("Create text(band=footer alignment='0' text=': اسم الكمبيوتر' border='0' color='33554432' x='1554' y='12' height='64' width='306' html.valueishtml='0'  name=t_pc_nm_title visible='1'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")
	dw_invoice.Modify("Create text(band=footer alignment='1' text='' border='0' color='33554432' x='1143' y='12' height='64' width='398' html.valueishtml='0'  name=t_pc_nm visible='1'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='1073741824' )")

	dw_invoice.Modify( "t_user_nm.text='"+ gnv_services.of_employee_name( gstr_user_info.id )+"'" )
	dw_invoice.Modify( "t_branch.text='"+ gstr_user_info.branch_nm+"'" )
	dw_invoice.Modify( "t_pc_nm.text='"+ gstr_user_info.Computer_name+"'" )

	dw_invoice.retrieve( Long(gstr_parm.string_parm[2] ) )
	

END IF

IF gstr_parm.string_parm[1] = "d_rpt_all_employes" THEN
	
	//MessageBox("" , gstr_parm.string_parm[2])
	dw_invoice.SetFilter( gstr_parm.string_parm[2] )
	dw_invoice.Filter( )
	
END IF




end event

event resize;iuo_resize.of_doResize(this)
end event

type cb_2 from u_cb within w_print_info
integer x = 3017
integer y = 2748
integer height = 112
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "...تصدير"
end type

event clicked;call super::clicked;integer li_ret
String ls_file_nm,ls_path

GetFileSaveName(" حـــفظ", ls_path, ls_file_nm, "xls", "Excel Files (*.xls),*.xls" ,"C:\", 32770)

//li_ret = uf_save_dw_as_excel(dw_invoice, ls_path)
//if li_ret = 1 then
//   //success
//   //...
//else
//   //fail
//   //...
//end if
end event

type cb_1 from u_cb within w_print_info
integer x = 3369
integer y = 2880
integer height = 112
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "طباعة"
end type

type cb_close from u_cb within w_print_info
integer x = 2665
integer y = 2748
integer height = 112
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "خروج"
end type

event clicked;call super::clicked;close(Parent)
end event

type gb_2 from groupbox within w_print_info
integer x = 9
integer width = 3717
integer height = 2728
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_print from u_cb within w_print_info
integer x = 3369
integer y = 2748
integer height = 112
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "طباعة"
end type

event clicked;call super::clicked;dw_invoice.event pfc_print( )
end event

type dw_invoice from u_dw within w_print_info
string tag = "<NOZOOM>"
integer x = 27
integer y = 40
integer width = 3666
integer height = 2660
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean livescroll = false
boolean righttoleft = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;This.settransobject( SQLCA )
end event

event pfc_retrieve;call super::pfc_retrieve;Long ll_rows

Choose Case gstr_parm.string_parm[1]
	Case "d_rpt_swap_money"
		ll_rows = This.retrieve( gstr_parm.long_array[1] , gstr_parm.string_parm[2] )
	Case "d_rpt_buy_asol"
		ll_rows = This.retrieve( gstr_parm.long_array[1] , gstr_parm.string_parm[2] )
	Case "d_rpt_swap_sc_account"
      	ll_rows = This.retrieve(  )		
	Case "d_rpt_assest_purchase_state"
      	ll_rows = This.retrieve( gstr_parm.long_array[1] , gstr_parm.string_parm[2] ) 		
	Case "d_rpt_price_list"
		
		IF gs_AppPath = "" THEN
			
				ll_rows = This.retrieve( Long(gstr_parm.string_parm[2]) ) 
				
		ELSEIF  FileExists( gs_AppPath+"price_list.xml" ) THEN
			
				This.ImportFile( gs_AppPath+"price_list.xml" )
				ll_rows = This.Rowcount( )
				
		ELSE
			
				ll_rows = This.retrieve( Long(gstr_parm.string_parm[2]) )
				This.SaveAs(gs_AppPath+"price_list.xml", XML!, false)
				
		END IF
						
		Return ll_rows
	Case "d_rpt_all_employes"	
		ll_rows = This.retrieve()
	Case else
		
     	ll_rows = This.retrieve( gstr_parm.long_array[1] ) 		
	  
End Choose


if(gstr_parm.string_parm[1] = "d_rpt_employees")then

   This.Object.p_1.Filename = "c:\temp.jpg"

end if

This.of_SetPrintPreview(TRUE)
This.Event pfc_PrintPreview()

return ll_rows
end event

event buttonclicked;call super::buttonclicked;IF(dwo.name = "b_1")Then

	Choose Case gstr_parm.string_parm[1]
		Case "d_rpt_price_list"
				This.setfilter("")
				//OpenWithParm(w_price_list_filter_option,istr_parm)				
				istr_parm = Message.powerobjectparm
			
				This.setfilter(istr_parm.string_parm[1])
				This.filter( )
	End Choose
End if

IF dwo.name = "b_refresh" THEN
	
		Choose Case gstr_parm.string_parm[1]
		Case "d_rpt_price_list"
				This.retrieve( Long(gstr_parm.string_parm[2] ) )
		End Choose	
	
END IF
end event

