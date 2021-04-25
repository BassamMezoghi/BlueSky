$PBExportHeader$uo_st_ms.sru
forward
global type uo_st_ms from u_st
end type
end forward

global type uo_st_ms from u_st
event ue_mousemove pbm_mousemove
end type
global uo_st_ms uo_st_ms

type variables
Boolean ib_change_stat = True
Long il_red,il_blue , il_green
end variables

event ue_mousemove;
if(This.ib_change_stat)then

   This.textcolor   = rgb(il_red,il_blue,il_green)	
   This.border      = True
   This.borderstyle = StyleRaised!
	This.ib_change_stat   = False
	
end if
end event

on uo_st_ms.create
end on

on uo_st_ms.destroy
end on

