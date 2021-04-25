$PBExportHeader$lol_dp.sru
forward
global type lol_dp from datepicker
end type
end forward

global type lol_dp from datepicker
integer width = 686
integer height = 100
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean todaysection = true
boolean todaycircle = true
end type
global lol_dp lol_dp

on lol_dp.create
end on

on lol_dp.destroy
end on

