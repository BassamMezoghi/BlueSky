$PBExportHeader$xu_icontray.sru
forward
global type xu_icontray from nonvisualobject
end type
end forward

global type xu_icontray from nonvisualobject
end type
global xu_icontray xu_icontray

type prototypes
function long Shell_NotifyIcon ( long dwMessage, ref notifyicondata lpData ) library "shell32.dll" alias for "Shell_NotifyIcon;Ansi"
function long LoadImageA ( long hInstance, string lpszName, uint uType, int a, int b, uint l ) library "user32.dll" alias for "LoadImageA;Ansi"
function long ExtractIconA ( long hInst, string lpszExeFileName, uint nIconIndex) library "shell32.dll" alias for "ExtractIconA;Ansi"
function int  GetModuleFileNameA( long hinst, ref string lpszFilename, uint cbFileName ) library "kernel32.dll" alias for "GetModuleFileNameA;Ansi"
end prototypes

type variables
Protected:

notifyicondata lpdata
window i_win
boolean ib_SystemTrayExists

CONSTANT long NIF_MESSAGE=1
CONSTANT long NIF_ICON=2
CONSTANT long NIF_TIP=4

CONSTANT long NIM_ADD=0
CONSTANT long NIM_MODIFY=1
CONSTANT long NIM_DELETE=2

CONSTANT int IMAGE_BITMAP=0
CONSTANT int IMAGE_ICON=1
CONSTANT int iMAGE_CURSOR=2
end variables

forward prototypes
public subroutine add_icon (string icon_name, string tip_text, window win)
public subroutine del_icon ()
public subroutine modify_icon (string icon_name)
public subroutine modify_tip (string tip_text)
public function boolean trayexists ()
public function long ufp_get_hicon (ref string a_icon_name)
public function notifyicondata notifyicondata ()
end prototypes

public subroutine add_icon (string icon_name, string tip_text, window win);if not ib_SystemTrayExists then Return

i_win = win
lpData.szTip = tip_text + CharA ( 0 )
lpData.uFlags = NIF_ICON + NIF_TIP + NIF_MESSAGE
lpData.uID = 100
lpData.cbSize = 88
lpData.hwnd = Handle ( i_win )
lpData.uCallbackMessage = 1024
lpData.hIcon = ufp_Get_HIcon ( icon_name )
shell_notifyicon ( NIM_ADD, lpData )

end subroutine

public subroutine del_icon ();if not ib_SystemTrayExists then Return

lpData.uID = 100
lpData.cbSize = 88
lpData.hwnd = Handle ( i_win )

shell_notifyicon ( NIM_DELETE, lpData )

end subroutine

public subroutine modify_icon (string icon_name);if not ib_SystemTrayExists then Return

lpData.hIcon = ufp_Get_HIcon ( icon_name )
lpData.uFlags = NIF_ICON

shell_notifyicon ( NIM_MODIFY, lpData )

end subroutine

public subroutine modify_tip (string tip_text);if not ib_SystemTrayExists then Return

lpData.szTip = tip_text + CharA ( 0 )
lpData.uFlags = NIF_TIP

shell_notifyicon ( NIM_MODIFY, lpData )

end subroutine

public function boolean trayexists ();Return ib_SystemTrayExists
end function

public function long ufp_get_hicon (ref string a_icon_name);int li_pos, li_idx
Long ll_handle = 0
String ls_file

If a_icon_name > "" Then
	Choose case Lower ( RightA ( a_icon_name, 4 ) ) 
		case ".ico"
			ll_handle = LoadImageA ( 0, a_icon_name, IMAGE_ICON, 0, 0, 80 )
		case ".cur", ".ani"
			ll_handle = LoadImageA ( 0, a_icon_name, IMAGE_CURSOR, 0, 0, 80 )
		case else
			li_pos = PosA ( a_icon_name, "," )
			if li_pos > 0 then
				li_idx = Integer ( MidA ( a_icon_name, li_pos + 1 ) )
				a_icon_name = LeftA ( a_icon_name, li_pos - 1 )
			end if
			ll_handle = ExtractIconA ( 0, a_icon_name, li_idx )
	end choose
End If

If ll_handle <= 0 Then
	ls_file = Space(255)
	GetModuleFileNameA ( Handle ( GetApplication() ), ls_file, LenA(ls_file) )
	ll_handle = ExtractIconA ( 0, ls_file, 0 )
End If

Return ll_handle
end function

public function notifyicondata notifyicondata ();return this.lpdata
end function

on xu_icontray.create
call super::create
TriggerEvent( this, "constructor" )
end on

on xu_icontray.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;del_icon()
end event

event constructor;environment l_env

if GetEnvironment ( l_env ) = 1 then
	Choose case l_env.OSType
		case Windows!, WindowsNT!
			ib_SystemTrayExists = l_env.OSMajorRevision >= 4
	end choose
end if
end event

