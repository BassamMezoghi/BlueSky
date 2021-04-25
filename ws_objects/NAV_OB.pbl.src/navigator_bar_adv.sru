$PBExportHeader$navigator_bar_adv.sru
forward
global type navigator_bar_adv from userobject
end type
type cb_refresh from commandbutton within navigator_bar_adv
end type
type cb_next from commandbutton within navigator_bar_adv
end type
type cb_last from commandbutton within navigator_bar_adv
end type
type cb_pre from commandbutton within navigator_bar_adv
end type
type cb_first from commandbutton within navigator_bar_adv
end type
end forward

global type navigator_bar_adv from userobject
integer width = 622
integer height = 84
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event set_dw_nm ( ref datawindow adw_parent,  ref datawindow adw_child,  boolean ab_have_child )
event onclick ( )
event ue_rowchange ( )
event rowchanged ( long ar_old_row,  long ar_new_row )
event type boolean prerowchange ( )
cb_refresh cb_refresh
cb_next cb_next
cb_last cb_last
cb_pre cb_pre
cb_first cb_first
end type
global navigator_bar_adv navigator_bar_adv

type variables
Public:
DataWindow idw_nav , idw_child
window iw_parent
Boolean ib_have_child
String is_id
Private:
String is_id_field_nm

end variables

forward prototypes
public subroutine uf_rowchange ()
public subroutine uf_rowchange (long ar_old_row, long ar_new_row)
public subroutine of_findkeycolumn ()
end prototypes

event set_dw_nm(ref datawindow adw_parent, ref datawindow adw_child, boolean ab_have_child);/*******

Declare the datawindow in the vo navbar

*/

idw_nav = adw_parent
idw_child = adw_child
ib_have_child = ab_have_child

of_findkeycolumn( )

IF idw_nav.RowCount() > 0 THEN This.event rowchanged( 0 , 1)

return 
end event

event ue_rowchange();return
end event

event rowchanged(long ar_old_row, long ar_new_row);
IF is_id_field_nm <> "" THEN is_id = String(idw_nav.GetItemNumber(ar_new_row , is_id_field_nm))
end event

event type boolean prerowchange();return True
end event

public subroutine uf_rowchange ();return 
end subroutine

public subroutine uf_rowchange (long ar_old_row, long ar_new_row);return
end subroutine

public subroutine of_findkeycolumn ();String ls_objects,ls_object
Long ll_orig_pos,ll_pos


ls_objects = idw_nav.Describe( 'DataWindow.Objects')  
ls_objects = ls_objects + '~t'  
ll_pos = pos(ls_objects, '~t')  
ll_orig_pos = 1  

// loop through objects on datawindow  
DO WHILE ll_pos > 0  
	ls_object = mid(ls_objects, ll_orig_pos, ll_pos -ll_orig_pos)  
	
	IF idw_nav.Describe(ls_object + '.key') = "yes" THEN 
		is_id_field_nm = ls_object
		Return 
	END IF
	
	ll_orig_pos = ll_pos + 1  
	ll_pos = pos(ls_objects, '~t', ll_orig_pos)  
LOOP  

is_id_field_nm = "-"
end subroutine

on navigator_bar_adv.create
this.cb_refresh=create cb_refresh
this.cb_next=create cb_next
this.cb_last=create cb_last
this.cb_pre=create cb_pre
this.cb_first=create cb_first
this.Control[]={this.cb_refresh,&
this.cb_next,&
this.cb_last,&
this.cb_pre,&
this.cb_first}
end on

on navigator_bar_adv.destroy
destroy(this.cb_refresh)
destroy(this.cb_next)
destroy(this.cb_last)
destroy(this.cb_pre)
destroy(this.cb_first)
end on

type cb_refresh from commandbutton within navigator_bar_adv
integer x = 247
integer width = 128
integer height = 84
integer taborder = 50
integer textsize = -14
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "q"
end type

event clicked;Long ll_row
if(not Parent.Event PreRowChange())Then return
idw_nav.SetREdraw( False )
ll_row = idw_nav.GetRow()
idw_nav.Event dynamic pfc_retrieve()
idw_nav.Scrolltorow( ll_row )
idw_nav.SetREdraw( True )

if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

// cb_first.enabled  = False
// cb_pre.enabled    = False
// cb_next.enabled   = True
// cb_last.enabled   = True
end event

type cb_next from commandbutton within navigator_bar_adv
integer x = 123
integer width = 128
integer height = 84
integer taborder = 20
integer textsize = -14
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "3"
end type

event clicked;long ll_old_row,ll_new_row

if(not Parent.Event PreRowChange())Then return

ll_old_row = idw_nav.GetRow()
idw_nav.scrollnextrow( )
ll_new_row = idw_nav.GetRow()

Parent.Event ue_rowchange()
Parent.Event rowchanged(ll_old_row , ll_new_row)

if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()


if(idw_nav.getrow( ) = idw_nav.rowcount( ) )then

   cb_first.enabled  = True
	cb_pre.enabled    = True
	cb_next.enabled   = False
	cb_last.enabled   = False

else
	
   cb_first.enabled  = True
	cb_pre.enabled    = True
	cb_next.enabled   = True
	cb_last.enabled   = True


end if
end event

type cb_last from commandbutton within navigator_bar_adv
integer x = 5
integer width = 128
integer height = 84
integer taborder = 10
integer textsize = -14
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "7"
end type

event clicked;Long ll_old_row,ll_new_row
if(not Parent.Event PreRowChange())Then return
ll_old_row = idw_nav.GetRow()
idw_nav.scrolltorow(idw_nav.rowcount())
ll_new_row = idw_nav.GetRow()

Parent.Event ue_rowchange()
Parent.Event rowchanged(ll_old_row , ll_new_row)

if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

cb_next.enabled = False
cb_last.enabled = False
cb_first.enabled  = True
cb_pre.enabled = True
end event

type cb_pre from commandbutton within navigator_bar_adv
integer x = 370
integer width = 128
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "4"
end type

event clicked;Long ll_old_row , ll_new_row
if(not Parent.Event PreRowChange())Then return
ll_old_row = idw_nav.GetRow()
idw_nav.scrollpriorrow( )
ll_new_row = idw_nav.GetRow()

Parent.Event ue_rowchange()
Parent.Event rowchanged(ll_old_row , ll_new_row)

if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()


if(idw_nav.getrow( ) = 1 )then

   cb_first.enabled  = False
	cb_pre.enabled    = False
	cb_next.enabled   = True
	cb_last.enabled   = True

else
	
   cb_first.enabled  = True
	cb_pre.enabled    = True
	cb_next.enabled   = True
	cb_last.enabled   = True


end if
end event

type cb_first from commandbutton within navigator_bar_adv
integer x = 494
integer width = 128
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "8"
end type

event clicked;Long ll_old_row , ll_new_row
if(not Parent.Event PreRowChange())Then return
ll_old_row = idw_nav.GetRow()
idw_nav.scrolltorow(1)
ll_new_row = idw_nav.GetRow()

Parent.Event ue_rowchange()
Parent.Event rowchanged(ll_old_row , ll_new_row)

if(ib_have_child)then idw_child.Event dynamic pfc_retrieve()

cb_next.enabled  = True
cb_last.enabled  = True
cb_pre.enabled   = False
cb_first.enabled = False

end event

