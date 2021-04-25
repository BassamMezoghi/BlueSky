$PBExportHeader$bs_u_documents_pb.sru
forward
global type bs_u_documents_pb from u_pb
end type
end forward

global type bs_u_documents_pb from u_pb
integer width = 128
integer height = 112
boolean enabled = false
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\20x20\Documents.bmp"
string disabledname = "C:\Applications\icons\disabled\bmp\20x20\Documents.bmp"
end type
global bs_u_documents_pb bs_u_documents_pb

type variables
Public:
String is_System_part
String is_ID
Private:
String is_AppID = "1"
String is_acid = "500"
end variables

on bs_u_documents_pb.create
call super::create
end on

on bs_u_documents_pb.destroy
call super::destroy
end on

event clicked;call super::clicked;nvo_security cs_security

cs_security = Create nvo_security

IF cs_security.of_checkaccessright(is_acid) <= 0 THEN 
	
	Destroy cs_security;
	Return
	
End if

OpenWithParm(w_mng_documents , is_System_part+is_AppID+is_ID)
end event

