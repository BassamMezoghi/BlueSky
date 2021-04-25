$PBExportHeader$n_cst_hinttext.sru
forward
global type n_cst_hinttext from nonvisualobject
end type
end forward

global type n_cst_hinttext from nonvisualobject
end type
global n_cst_hinttext n_cst_hinttext

type variables
private:
string is_prev_obj_name //store the object name having focus previously
vuo_statusbar ivuo_statusbar //create an instance of the status bar
window iw_statusbar_parent_window //store the window containing the statusbar

end variables

forward prototypes
public subroutine of_set_hinttext (string control_name, string hint_text)
public subroutine of_display_statusbar (window parent_window)
public subroutine of_set_statusbar_pos (integer newwidth, integer newheight)
public subroutine of_set_statusbar_redraw_on ()
end prototypes

public subroutine of_set_hinttext (string control_name, string hint_text);// the if structure prevents the flickering of text in the
// single-line edit (status bar) when this function is fired from a
// mousemove event on a control
if (control_name <> is_prev_obj_name) then
     ivuo_statusbar.setredraw(TRUE)
ivuo_statusbar.text = hint_text
ivuo_statusbar.setredraw(FALSE)
is_prev_obj_name = control_name
end if
end subroutine

public subroutine of_display_statusbar (window parent_window);// create the status bar and add it to the bottom of the window
parent_window.openuserobjectwithparm(ivuo_statusbar,vuo_statusbar)
ivuo_statusbar.bringtotop=TRUE
ivuo_statusbar.x = 1
ivuo_statusbar.y = parent_window.workspaceheight() -  ivuo_statusbar.height
ivuo_statusbar.width = parent_window.workspacewidth()
iw_statusbar_parent_window = parent_window
end subroutine

public subroutine of_set_statusbar_pos (integer newwidth, integer newheight);// set the status bar position
ivuo_statusbar.setredraw(TRUE)
ivuo_statusbar.width = newwidth
ivuo_statusbar.y = newheight - ivuo_statusbar.height
ivuo_statusbar.setredraw(FALSE)
end subroutine

public subroutine of_set_statusbar_redraw_on ();// used in case when the window has lost focus and
// then it regains focus, need to redraw the status bar
ivuo_statusbar.setredraw(TRUE)
end subroutine

on n_cst_hinttext.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_hinttext.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;// destroy the status bar
ivuo_statusbar.setredraw(TRUE)
iw_statusbar_parent_window.closeuserobject(ivuo_statusbar)
end event

