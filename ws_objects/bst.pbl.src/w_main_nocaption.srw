$PBExportHeader$w_main_nocaption.srw
forward
global type w_main_nocaption from pfc_w_main
end type
type cb_1 from commandbutton within w_main_nocaption
end type
end forward

global type w_main_nocaption from window
boolean visible = false
integer x = 672
integer y = 268
integer width = 2126
integer height = 1400
boolean titlebar = true
string title = "Test  Window"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 79741120
boolean righttoleft = true
boolean clientedge = true
boolean center = true
event ue_post_open ( )
cb_1 cb_1
end type
global w_main_nocaption w_main_nocaption

type prototypes
Function long GetWindowLongA (long hWindow, integer nIndex) Library "user32.dll"
Function long SetWindowLongA (long hWindow, integer nIndex, long dwNewLong) Library "user32.dll"
FUNCTION ulong GetSystemMenu(ulong hWnd, BOOLEAN bRevert)  Library "USER32"
FUNCTION boolean DeleteMenu( ulong hMenu, uint uPosition, uint uFlags ) LIBRARY "user32.dll"
FUNCTION boolean DrawMenuBar( ulong hWnd ) LIBRARY "user32.dll"

end prototypes

type variables
protected:
CONSTANT int GWL_STYLE  = -16
CONSTANT long  WS_THICKFRAME = 262144
CONSTANT long WS_SYSMENU = 524288
CONSTANT long WS_CAPTION = 12582912
CONSTANT long  WS_MINIMIZEBOX = 131072
CONSTANT long  WS_MAXIMIZEBOX = 65536
CONSTANT long  WS_OVERLAPPED = 0
CONSTANT long WS_BORDER = 8388608
CONSTANT long  WS_OVERLAPPEDWINDOW  = WS_OVERLAPPED + WS_CAPTION + WS_THICKFRAME + WS_SYSMENU + WS_MINIMIZEBOX +  WS_MAXIMIZEBOX
CONSTANT uint SC_SIZE         = 61440
CONSTANT uint SC_MOVE         = 61456
CONSTANT uint SC_MINIMIZE     = 61472
CONSTANT uint SC_MAXIMIZE     = 61488
CONSTANT uint SC_CLOSE        = 61536
CONSTANT uint SC_RESTORE      = 61728
CONSTANT uint MF_BYCOMMAND = 0
CONSTANT uint WM_SYSCOMMAND = 274
CONSTANT uint HTCAPTION = 2
CONSTANT uint WM_NCLBUTTONDOWN = 161
end variables

event ue_post_open();//  Description :            Force repaint etc.

//Resize(width - 100, height -100 )
//Resize(width + 100, height +100 )

Show()
end event

on w_main_nocaption.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_main_nocaption.destroy
destroy(this.cb_1)
end on

event open;ulong ll_style
ll_style = GetWindowLongA(handle(this), gwl_style)

IF ll_style > 0 THEN
      SetWindowLongA(handle(this), gwl_style, ll_style - WS_OVERLAPPEDWINDOW + WS_THICKFRAME)
END IF

// Get the window's menu
ULong    hMenu, hWnd

hWnd = Handle( this )
hMenu = GetSystemMenu( hWnd, FALSE )
IF hMenu > 0 THEN
      // removing the  menu items from the system menu
      
//      DeleteMenu( hMenu, SC_MINIMIZE , MF_BYCOMMAND)
//      DeleteMenu( hMenu, SC_MAXIMIZE , MF_BYCOMMAND)
//      DeleteMenu( hMenu, SC_RESTORE  , MF_BYCOMMAND)
//      DeleteMenu( hMenu, SC_CLOSE  , MF_BYCOMMAND)
      // Force immediate menu update
      DrawMenuBar( hWnd )
      
END IF

event post ue_post_open()

end event

event systemkey;IF key = keyf4! THEN
      message.processed = TRUE
      RETURN 0
END IF
end event

event mousemove;// fake Windows® into thinking that we clicked the title bar area
Post( Handle( this ), WM_NCLBUTTONDOWN, HTCAPTION, Long( xpos, ypos ) )

end event

type cb_1 from commandbutton within w_main_nocaption
integer x = 1751
integer y = 216
integer width = 206
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

