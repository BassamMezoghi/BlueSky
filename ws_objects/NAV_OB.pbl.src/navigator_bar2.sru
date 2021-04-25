$PBExportHeader$navigator_bar2.sru
forward
global type navigator_bar2 from userobject
end type
type cb_first from commandbutton within navigator_bar2
end type
type em_2 from editmask within navigator_bar2
end type
type em_1 from editmask within navigator_bar2
end type
type cb_last from commandbutton within navigator_bar2
end type
type cb_refresh from commandbutton within navigator_bar2
end type
type cb_next from commandbutton within navigator_bar2
end type
type cb_next_by_n from commandbutton within navigator_bar2
end type
type cb_pre from commandbutton within navigator_bar2
end type
type cb_pre_by_n from commandbutton within navigator_bar2
end type
end forward

global type navigator_bar2 from userobject
integer width = 1207
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event set_dw_nm ( ref datawindow adw_parent,  ref datawindow adw_child,  boolean ab_have_child )
event onclick ( )
event ue_rowchange ( )
cb_first cb_first
em_2 em_2
em_1 em_1
cb_last cb_last
cb_refresh cb_refresh
cb_next cb_next
cb_next_by_n cb_next_by_n
cb_pre cb_pre
cb_pre_by_n cb_pre_by_n
end type
global navigator_bar2 navigator_bar2

type variables
DataWindow idw_nav , idw_child

Boolean ib_have_child
end variables

event set_dw_nm(ref datawindow adw_parent, ref datawindow adw_child, boolean ab_have_child);/*******

Declare the datawindow in the vo navbar

*/

idw_nav = adw_parent
idw_child = adw_child
ib_have_child = ab_have_child

return 
end event

event ue_rowchange();return
end event

on navigator_bar2.create
this.cb_first=create cb_first
this.em_2=create em_2
this.em_1=create em_1
this.cb_last=create cb_last
this.cb_refresh=create cb_refresh
this.cb_next=create cb_next
this.cb_next_by_n=create cb_next_by_n
this.cb_pre=create cb_pre
this.cb_pre_by_n=create cb_pre_by_n
this.Control[]={this.cb_first,&
this.em_2,&
this.em_1,&
this.cb_last,&
this.cb_refresh,&
this.cb_next,&
this.cb_next_by_n,&
this.cb_pre,&
this.cb_pre_by_n}
end on

on navigator_bar2.destroy
destroy(this.cb_first)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.cb_last)
destroy(this.cb_refresh)
destroy(this.cb_next)
destroy(this.cb_next_by_n)
destroy(this.cb_pre)
destroy(this.cb_pre_by_n)
end on

type cb_first from commandbutton within navigator_bar2
integer x = 1074
integer width = 133
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = ":"
end type

event clicked;idw_nav.scrolltorow(1)
Parent.event ue_rowchange( )
if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

cb_next.enabled  = True
cb_last.enabled  = True
cb_pre.enabled   = False
cb_first.enabled = False
cb_pre_by_n.enabled = False
cb_next_by_n.enabled = True

end event

type em_2 from editmask within navigator_bar2
integer x = 782
integer width = 160
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Fixedsys"
long textcolor = 33554432
string text = "5"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
double increment = 10
string minmax = "1~~1000"
end type

type em_1 from editmask within navigator_bar2
integer x = 256
integer width = 160
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = arabiccharset!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Fixedsys"
long textcolor = 33554432
string text = "5"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
double increment = 10
string minmax = "1~~1000"
end type

type cb_last from commandbutton within navigator_bar2
integer width = 133
integer height = 100
integer taborder = 60
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "9"
end type

event clicked;idw_nav.scrolltorow(idw_nav.rowcount())
Parent.event ue_rowchange( )
if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

cb_next.enabled = False
cb_last.enabled = False
cb_first.enabled  = True
cb_pre.enabled = True
cb_pre_by_n.enabled = True
cb_next_by_n.enabled = False

end event

type cb_refresh from commandbutton within navigator_bar2
integer x = 530
integer width = 128
integer height = 100
integer taborder = 50
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "q"
end type

event clicked;idw_nav.Event dynamic pfc_retrieve()

if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

 cb_first.enabled  = False
 cb_pre.enabled    = False
 cb_next.enabled   = True
 cb_last.enabled   = True
end event

type cb_next from commandbutton within navigator_bar2
integer x = 407
integer width = 128
integer height = 100
integer taborder = 20
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "3"
end type

event clicked;idw_nav.scrollnextrow( )
Parent.event ue_rowchange( )
if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

if idw_nav.getrow() = idw_nav.rowcount( ) then
	
	cb_pre.enabled   = True
	cb_first.enabled = True
	cb_next.enabled  = False
	cb_last.enabled  = False
	cb_pre_by_n.enabled     = True
   cb_next_by_n.enabled     = False
	
Else
	
	cb_pre.enabled   = True
	cb_next.enabled  = True
	cb_last.enabled  = True
	cb_first.enabled = True
	cb_pre_by_n.enabled     = True
   cb_next_by_n.enabled     = True
	
End if
end event

type cb_next_by_n from commandbutton within navigator_bar2
integer x = 128
integer width = 128
integer height = 100
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "7"
end type

event clicked;Long ll_current_row

 ll_current_row = idw_nav.getrow( ) + Long(em_1.text)
Parent.event ue_rowchange( )
if(ll_current_row >= idw_nav.rowcount())then
   
	idw_nav.scrolltorow(idw_nav.rowcount())
	cb_next.enabled  = False
   cb_last.enabled  = False
   cb_first.enabled = True
   cb_pre.enabled   = True
	cb_pre_by_n.enabled     = True
   cb_next_by_n.enabled     = False
	
else
	
	idw_nav.scrolltorow(ll_current_row)
	cb_next.enabled  = True
   cb_last.enabled  = True
   cb_first.enabled = True
   cb_pre.enabled   = True
	cb_pre_by_n.enabled     = True 
   cb_next.enabled     = True

end if



if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()


end event

type cb_pre from commandbutton within navigator_bar2
integer x = 654
integer width = 128
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "4"
end type

event clicked;
idw_nav.scrollpriorrow( )
Parent.event ue_rowchange( )
if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()


if(idw_nav.getrow( ) = 1 )then

   cb_first.enabled  = False
	cb_pre.enabled    = False
	cb_next.enabled   = True
	cb_last.enabled   = True
	cb_pre_by_n.enabled = False
   cb_next_by_n.enabled = True


else
	
   cb_first.enabled  = True
	cb_pre.enabled    = True
	cb_next.enabled   = True
	cb_last.enabled   = True
   cb_pre_by_n.enabled = True
   cb_next_by_n.enabled = True


end if
end event

type cb_pre_by_n from commandbutton within navigator_bar2
integer x = 946
integer width = 128
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "8"
end type

event clicked;Long ll_current_row

 ll_current_row = idw_nav.getrow( ) - Long(em_2.text)
Parent.event ue_rowchange( )
if(ll_current_row <= 1)then
   
	idw_nav.scrolltorow(1)
	cb_next.enabled  = True
   cb_last.enabled  = True
   cb_first.enabled = False
   cb_pre.enabled   = False
	cb_pre_by_n.enabled = False
   cb_next_by_n.enabled = True
	
else
	
	idw_nav.scrolltorow(ll_current_row)
	cb_next.enabled  = True
   cb_last.enabled  = True
   cb_first.enabled = True
   cb_pre.enabled   = True
	cb_pre_by_n.enabled = True
   cb_next_by_n.enabled = True
	
end if



if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

end event

