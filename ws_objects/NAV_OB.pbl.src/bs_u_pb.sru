$PBExportHeader$bs_u_pb.sru
forward
global type bs_u_pb from u_pb
end type
end forward

global type bs_u_pb from u_pb
integer width = 128
integer height = 112
string text = ""
string picturename = "C:\Applications\icons\hot\bmp\20x20\Info.bmp"
end type
global bs_u_pb bs_u_pb

type variables
String is_PictureName
end variables

event clicked;call super::clicked;//OpenWithParm(w_diagrams , gs_AppPath+is_PictureName)
end event

on bs_u_pb.create
call super::create
end on

on bs_u_pb.destroy
call super::destroy
end on

