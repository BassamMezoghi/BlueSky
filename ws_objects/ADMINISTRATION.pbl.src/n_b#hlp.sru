$PBExportHeader$n_b#hlp.sru
forward
global type n_b#hlp from n_bll
end type
end forward

global type n_b#hlp from n_bll
end type
global n_b#hlp n_b#hlp

forward prototypes
public subroutine of_hlp (ref datawindow ar_dw)
end prototypes

public subroutine of_hlp (ref datawindow ar_dw);Long ll_ins

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "@CB branch Name" )
ar_dw.SetItem( ll_ins , "description" , "تغير الفرع" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "@GBSI Inovice No" )
ar_dw.SetItem( ll_ins , "description" , "الحصول على رقم الفاتورة المبيعات في الفرع" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "@CCT InvoiceNo;New Type" )
ar_dw.SetItem( ll_ins , "description" , "تغير نوع فاتورة المبيعات")

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "@Print S InvoiceNo" )
ar_dw.SetItem( ll_ins , "description" , "طباعة فاتورة المبيعات" )

ll_ins = ar_dw.InsertRow(0)

ar_dw.ScrollToRow(ll_ins)

ar_dw.SetItem( ll_ins , "shortcut" , "@Print P Recipt No." )
ar_dw.SetItem( ll_ins , "description" , "طباعة سند قبض" )

end subroutine

on n_b#hlp.create
call super::create
end on

on n_b#hlp.destroy
call super::destroy
end on

event constructor;call super::constructor;return 
end event

