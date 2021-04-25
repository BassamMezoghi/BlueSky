$PBExportHeader$uo_select_dt_neo.sru
forward
global type uo_select_dt_neo from userobject
end type
type st_2 from statictext within uo_select_dt_neo
end type
type st_1 from statictext within uo_select_dt_neo
end type
type dp_2 from datepicker within uo_select_dt_neo
end type
type dp_1 from datepicker within uo_select_dt_neo
end type
end forward

global type uo_select_dt_neo from userobject
integer width = 2043
integer height = 124
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
dp_2 dp_2
dp_1 dp_1
end type
global uo_select_dt_neo uo_select_dt_neo

forward prototypes
public function datetime of_get_end ()
public function datetime of_get_start ()
end prototypes

public function datetime of_get_end ();return datetime(dp_2.datevalue,time("23:59:59"))
end function

public function datetime of_get_start ();return datetime(dp_1.datevalue,time("00:00:00"))
end function

on uo_select_dt_neo.create
this.st_2=create st_2
this.st_1=create st_1
this.dp_2=create dp_2
this.dp_1=create dp_1
this.Control[]={this.st_2,&
this.st_1,&
this.dp_2,&
this.dp_1}
end on

on uo_select_dt_neo.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dp_2)
destroy(this.dp_1)
end on

event constructor;if(IsNull(gstr_user_info.start_dt))Then return
dp_1.value = gstr_user_info.start_dt
if(IsNull(gstr_user_info.end_dt))Then return
dp_2.value = gstr_user_info.end_dt

end event

type st_2 from statictext within uo_select_dt_neo
integer x = 1746
integer y = 16
integer width = 283
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": من تاريخ"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_select_dt_neo
integer x = 768
integer y = 12
integer width = 187
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": الي"
boolean focusrectangle = false
end type

type dp_2 from datepicker within uo_select_dt_neo
integer y = 8
integer width = 754
integer height = 100
integer taborder = 20
boolean dropdownright = true
datetimeformat format = dtfcustom!
string customformat = "dd/MM/yyyy"
date maxdate = Date("2999-12-31")
date mindate = Date("2000-01-01")
datetime value = DateTime(Date("2018-04-01"), Time("15:56:25.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendartextsize = -9
integer calendarfontweight = 400
fontcharset calendarfontcharset = ansi!
fontpitch calendarfontpitch = variable!
fontfamily calendarfontfamily = swiss!
string calendarfontname = "Arial"
weekday firstdayofweek = saturday!
boolean todaysection = true
boolean todaycircle = true
boolean righttoleft = true
end type

type dp_1 from datepicker within uo_select_dt_neo
integer x = 992
integer y = 8
integer width = 754
integer height = 100
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean dropdownright = true
datetimeformat format = dtfcustom!
string customformat = "dd/MM/yyyy"
date maxdate = Date("2999-12-31")
date mindate = Date("2000-01-01")
datetime value = DateTime(Date("2018-04-01"), Time("15:56:25.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendartextsize = -9
integer calendarfontweight = 400
fontcharset calendarfontcharset = ansi!
fontpitch calendarfontpitch = variable!
fontfamily calendarfontfamily = swiss!
string calendarfontname = "Arial"
weekday firstdayofweek = saturday!
boolean todaysection = true
boolean todaycircle = true
boolean righttoleft = true
end type

