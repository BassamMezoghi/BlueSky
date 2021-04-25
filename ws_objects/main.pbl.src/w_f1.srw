$PBExportHeader$w_f1.srw
forward
global type w_f1 from w_response
end type
type dw_info from u_dw within w_f1
end type
end forward

global type w_f1 from w_response
integer width = 3081
boolean righttoleft = true
boolean center = true
boolean ib_isupdateable = false
dw_info dw_info
end type
global w_f1 w_f1

type variables

end variables

on w_f1.create
int iCurrent
call super::create
this.dw_info=create dw_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_info
end on

on w_f1.destroy
call super::destroy
destroy(this.dw_info)
end on

event open;call super::open;Long ll_ins
n_BLL csBLL

csBLL = Message.Powerobjectparm

dw_info.SetTransObject(SQLCA)

gnv_services.of_color( dw_info )

csBLL.of_hlp(dw_info)


end event

type dw_info from u_dw within w_f1
integer width = 3067
integer height = 1404
integer taborder = 10
string dataobject = "d_short_cut_info"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event bst_keydown;call super::bst_keydown;IF KeyDown(KeyEnter!) THEN
	Close(Parent)
END IF
end event

