$PBExportHeader$uo_single_select_dt_neo.sru
forward
global type uo_single_select_dt_neo from uo_small_select_dt_neo
end type
end forward

global type uo_single_select_dt_neo from uo_small_select_dt_neo
integer width = 727
end type
global uo_single_select_dt_neo uo_single_select_dt_neo

on uo_single_select_dt_neo.create
call super::create
end on

on uo_single_select_dt_neo.destroy
call super::destroy
end on

type st_2 from uo_small_select_dt_neo`st_2 within uo_single_select_dt_neo
boolean visible = false
end type

type st_1 from uo_small_select_dt_neo`st_1 within uo_single_select_dt_neo
end type

type dp_2 from uo_small_select_dt_neo`dp_2 within uo_single_select_dt_neo
datetimeformat format = dtfcustom!
string customformat = "dd/MM/yyyy"
date mindate = Date("2000-01-01")
end type

type dp_1 from uo_small_select_dt_neo`dp_1 within uo_single_select_dt_neo
boolean visible = false
end type

