﻿$PBExportHeader$w_wmp.srw
forward
global type w_wmp from w_response
end type
type ole_wmp from olecontrol within w_wmp
end type
end forward

global type w_wmp from w_response
integer width = 4677
integer height = 2288
boolean righttoleft = true
boolean center = true
ole_wmp ole_wmp
end type
global w_wmp w_wmp

forward prototypes
public function string of_replace (string as_str)
end prototypes

public function string of_replace (string as_str);Long ll_len,ll_pos

ll_len = len(as_str)

For ll_pos = 1 To ll_len
	
	if(mid(as_str,ll_pos , 1) = "\")Then
		replace(as_str,ll_pos , 1 ,"\\")
	end if
	
Next


return as_str
end function

on w_wmp.create
int iCurrent
call super::create
this.ole_wmp=create ole_wmp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_wmp
end on

on w_wmp.destroy
call super::destroy
destroy(this.ole_wmp)
end on

event open;call super::open;
ole_wmp.Activate(InPlace!)

ole_wmp.object.URL = of_replace(Message.stringparm)
ole_wmp.object.controls.Play()



end event

type ole_wmp from olecontrol within w_wmp
event openstatechange ( long newstate )
event playstatechange ( long newstate )
event audiolanguagechange ( long langid )
event statuschange ( )
event scriptcommand ( string sctype,  string param )
event newstream ( )
event ocx_disconnect ( long result )
event buffering ( boolean start )
event ocx_error ( )
event warning ( long warningtype,  long param,  string description )
event endofstream ( long result )
event positionchange ( double oldposition,  double newposition )
event markerhit ( long markernum )
event durationunitchange ( long newdurationunit )
event cdrommediachange ( long cdromnum )
event playlistchange ( oleobject playlist,  integer change )
event currentplaylistchange ( integer change )
event currentplaylistitemavailable ( string bstritemname )
event mediachange ( oleobject item )
event currentmediaitemavailable ( string bstritemname )
event currentitemchange ( oleobject pdispmedia )
event mediacollectionchange ( )
event mediacollectionattributestringadded ( string bstrattribname,  string bstrattribval )
event mediacollectionattributestringremoved ( string bstrattribname,  string bstrattribval )
event mediacollectionattributestringchanged ( string bstrattribname,  string bstroldattribval,  string bstrnewattribval )
event playlistcollectionchange ( )
event playlistcollectionplaylistadded ( string bstrplaylistname )
event playlistcollectionplaylistremoved ( string bstrplaylistname )
event playlistcollectionplaylistsetasdeleted ( string bstrplaylistname,  boolean varfisdeleted )
event modechange ( string modename,  boolean newvalue )
event mediaerror ( oleobject pmediaobject )
event openplaylistswitch ( oleobject pitem )
event domainchange ( string strdomain )
event switchedtoplayerapplication ( )
event switchedtocontrol ( )
event playerdockedstatechange ( )
event playerreconnect ( )
event click ( integer nbutton,  integer nshiftstate,  long fx,  long fy )
event doubleclick ( integer nbutton,  integer nshiftstate,  long fx,  long fy )
event keydown ( integer nkeycode,  integer nshiftstate )
event keypress ( integer nkeyascii )
event keyup ( integer nkeycode,  integer nshiftstate )
event mousedown ( integer nbutton,  integer nshiftstate,  long fx,  long fy )
event mousemove ( integer nbutton,  integer nshiftstate,  long fx,  long fy )
event mouseup ( integer nbutton,  integer nshiftstate,  long fx,  long fy )
event deviceconnect ( oleobject pdevice )
event devicedisconnect ( oleobject pdevice )
event devicestatuschange ( oleobject pdevice,  integer newstatus )
event devicesyncstatechange ( oleobject pdevice,  integer newstate )
event devicesyncerror ( oleobject pdevice,  oleobject pmedia )
event cdromripstatechange ( oleobject pcdromrip,  integer wmprs )
event cdromripmediaerror ( oleobject pcdromrip,  oleobject pmedia )
event cdromburnstatechange ( oleobject pcdromburn,  integer wmpbs )
event cdromburnmediaerror ( oleobject pcdromburn,  oleobject pmedia )
event libraryconnect ( oleobject plibrary )
event librarydisconnect ( oleobject plibrary )
event folderscanstatechange ( integer wmpfss )
event stringcollectionchange ( oleobject pdispstringcollection,  integer change,  long lcollectionindex )
event mediacollectionmediaadded ( oleobject pdispmedia )
event mediacollectionmediaremoved ( oleobject pdispmedia )
integer y = 12
integer width = 4663
integer height = 2192
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_wmp.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_wmp.bin 
2C00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000016bf52a5211d3394ac00053b1a6fa794f0000000000000000000000003749c1e001cd904b00000003000000c000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000a2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000002fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000003000000000800050000000000003ff0000000000003000500000000000000000000000200080000000000010003000b00000003ffff00000000ffff000b000200080000000000320003000b0000000800000000000a00750066006c006c000b0000000b0000000b0000000bffff000bffff0008000000000002000800000000000200080000000000020008000000000002000b00001952000018ce000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_wmp.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
