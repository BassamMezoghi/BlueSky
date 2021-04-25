$PBExportHeader$nvo_ftp.sru
forward
global type nvo_ftp from n_base
end type
end forward

global type nvo_ftp from n_base
end type
global nvo_ftp nvo_ftp

type variables
String is_server, is_userid, is_password , is_currentdir
Boolean ib_anonymous, ib_passive
Integer ii_port
n_wininet in_ftp
end variables

forward prototypes
public function boolean of_connect ()
public subroutine of_uploadfile (string as_file_name)
public subroutine of_download (string as_file_name)
public subroutine of_disconnect ()
end prototypes

public function boolean of_connect ();TRY
String ls_result

//Connect to FTP server
ls_result = in_ftp.of_ftp_InternetConnect(is_server, is_userid, is_password, ii_port, ib_passive)

If Len(ls_result) > 0 Then
	Return False
End If

in_ftp.of_ftp_SetCurrentDirectory("/"+AppCode)

Return True

CATCH(PBXRuntimeError re)	

END TRY
end function

public subroutine of_uploadfile (string as_file_name);if(in_ftp.of_getsession( ) <=0 )then
	Return
end if

in_ftp.of_ftp_writefile( gs_AppPath+as_file_name , as_file_name )

end subroutine

public subroutine of_download (string as_file_name);String ls_result
if(in_ftp.of_getsession( ) <=0 )then
	Return
end if

ls_result = in_ftp.of_Ftp_ReadFile(as_file_name, gs_AppPath+as_file_name, Handle(This), 1024)



end subroutine

public subroutine of_disconnect ();// disconnect from session
in_ftp.of_Disconnect_Session()
end subroutine

on nvo_ftp.create
call super::create
end on

on nvo_ftp.destroy
call super::destroy
end on

event constructor;call super::constructor;
//SetPointer(HourGlass!)
//FTP ini
is_currentdir = gs_AppPath+"ftp.ini"

//FTP Information
is_server  		= ProfileString(is_currentdir , "ftp" ,  "server" , "ns1.onlydomains.net" )
is_userid   		= ProfileString(is_currentdir, "ftp" ,  "username" , "bassam" )
is_password	= ProfileString(is_currentdir, "ftp" ,  "password" , "er8AgPywA7nB" )
ii_port 			= 21
ib_passive 	= True


end event

