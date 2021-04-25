$PBExportHeader$tp_initial_stock.sru
forward
global type tp_initial_stock from u_cst_tabpage
end type
type dw_initial_stock from u_dw within tp_initial_stock
end type
end forward

global type tp_initial_stock from u_cst_tabpage
integer width = 4503
integer height = 2348
dw_initial_stock dw_initial_stock
end type
global tp_initial_stock tp_initial_stock

type variables
Public:
DateTime idt_Initial_date
String gs_dataObject
end variables

forward prototypes
public function decimal uf_get_old_cost_price (datetime adt_bill_dt, integer sc_id, integer al_inventory, integer al_income_bill_item_no)
public subroutine uf_cost_price_calculation ()
public function Datetime of_initial_dt ()
end prototypes

public function decimal uf_get_old_cost_price (datetime adt_bill_dt, integer sc_id, integer al_inventory, integer al_income_bill_item_no);Decimal ld_old_price
String ls_store_card_nm

SELECT TOP 1 NEW_PRICE 
INTO :ld_old_price
FROM COST_PRICE_HISTORY
WHERE sc_id = :sc_id and REGISTER_DT < :adt_bill_dt and income_bill_item_no <> :al_income_bill_item_no
ORDER BY REGISTER_DT DESC; 

SELECT MASURE
INTO  :ls_store_card_nm
FROM  STORE_CARD
WHERE SC_ID = :sc_id;


if(IsNull(ld_old_price))then ld_old_price = 0.0 

if(ld_old_price = 0.0 and al_inventory > 0)then

    if(MessageBox( "تنبيه" , "لايوجد سعر تكلفة "+ls_store_card_nm+" الموجودة في المخزن~nهل تريد ادخال السعر القديم؟" ,information!,yesno!) = 1 )then
     
//	   Open(w_old_cost_price)
	   ld_old_price = Message.doubleparm
	  
    else  
	 
      MessageBox("تنبيه","سيتم اختيار السعر الجديد على انه سعر التكلفة القديم")
	
    end if

end if

return ld_old_price
end function

public subroutine uf_cost_price_calculation ();Long ll_sc_id ,ll_bill_item_no ,ll_inventory ,ll_new_quantity,ll_insertrow
Long ll_bill_no
DateTime ldt_income_bill_dt
Decimal ld_new_cost_price , ld_old_cost_price
DataStore lds_cost_price_history , lds_inventory
Long ll_row , ll_rowcount

//define cost_price_history Data Store
lds_cost_price_history = Create DataStore
lds_cost_price_history.DataObject = "d_cost_price_history_list"
lds_cost_price_history.SettransObject( SQLCA )

ll_RowCount = dw_initial_stock.RowCount()

ldt_income_bill_dt = dw_initial_stock.GetItemDateTime(1    , "initial_dt"  )

FOR ll_row = 1 to ll_RowCount

//set varible
ll_bill_no         			= 0
ll_bill_item_no    		= dw_initial_stock.GetItemNumber( ll_row     , "id"         ) * -1
ll_sc_id           		= dw_initial_stock.GetItemNumber( ll_row     , "SC_ID"      )
ll_new_quantity    	= dw_initial_stock.GetItemNumber( ll_row     , "quantity"   )
ld_new_cost_price  	= dw_initial_stock.GetItemDecimal( ll_row     , "buy_price" )

//retrieve datastore cost_price_history

if(lds_cost_price_history.retrieve( ll_bill_item_no , "I" ) > 0 )then

	  //update information
    lds_cost_price_history.SetItem( 1 , "NEW_COST_PRICE"   	, ld_new_cost_price        		)
    lds_cost_price_history.SetItem( 1 , "NEW_QUANTITY"     		, ll_new_quantity          		)
    lds_cost_price_history.SetItem( 1 , "SC_ID"            				, ll_sc_id                 			)
    lds_cost_price_history.SetItem( 1 , "REGISTER_DT"      		, ldt_income_bill_dt       		)
    lds_cost_price_history.SetItem( 1 , "OLD_QUANTITY"     		, 0             			)
    lds_cost_price_history.SetItem( 1 , "OLD_COST_PRICE"   	, 0.0        		)
    lds_cost_price_history.SetItem( 1 , "LAST_MODIFIED_BY" 	, gstr_user_info.login_id  		)
    lds_cost_price_history.SetItem( 1 , "LAST_MODIFIED_DT"	, DateTime(today() , now() )	)
	 
	IF lds_cost_price_history.update() = 1 THEN        
		COMMIT USING SQLCA;
	ELSE        
		ROLLBACK USING SQLCA;
	END IF

	 
ELSE
  //new row information
    ll_insertrow = lds_cost_price_history.insertrow( 0 )
	 	
    lds_cost_price_history.SetItem( ll_insertrow , "INCOME_BILL_ITEM_NO"	, ll_bill_item_no           		)
    lds_cost_price_history.SetItem( ll_insertrow , "IN_OR_PR"						, "I"           							)	 
    lds_cost_price_history.SetItem( ll_insertrow , "ID"                  						, ll_bill_no                			)
    lds_cost_price_history.SetItem( ll_insertrow , "NEW_COST_PRICE"			, ld_new_cost_price         		)
    lds_cost_price_history.SetItem( ll_insertrow , "NEW_QUANTITY"				, ll_new_quantity           		)
    lds_cost_price_history.SetItem( ll_insertrow , "SC_ID"								, ll_sc_id                  			)
    lds_cost_price_history.SetItem( ll_insertrow , "REGISTER_DT"					, ldt_income_bill_dt        		)
    lds_cost_price_history.SetItem( ll_insertrow , "OLD_QUANTITY"					, 0              			)
    lds_cost_price_history.SetItem( ll_insertrow , "OLD_COST_PRICE"      		, 0.0         		)
    lds_cost_price_history.SetItem( ll_insertrow , "CREATED_BY"          			, gstr_user_info.login_id   	)
    lds_cost_price_history.SetItem( ll_insertrow , "CREATED_DT"          			, DateTime(today() , now())	)

   IF lds_cost_price_history.update() = 1 THEN        
		COMMIT USING SQLCA;
	ELSE        
		ROLLBACK USING SQLCA;
	END IF
	 
end if

NEXT

DESTROY lds_cost_price_history;
end subroutine

public function Datetime of_initial_dt ();DataStore lds

lds = CREATE DATASTORE

lds.DataObject = "d_system_initial_date"
lds.SetTransObject(SQLCA)
lds.retrieve()
lds.SetFilter( " parm_nm =  'INITIAL_DATE'" )
lds.Filter()

IF lds.RowCount() > 0 THEN
	Return lds.GetItemDatetime(1 , "dt_value_1")
ELSE
	Return datetime( date( "01 jan "+String( year( today() ) ) ) , time("00:00:00"))
END IF
end function

on tp_initial_stock.create
int iCurrent
call super::create
this.dw_initial_stock=create dw_initial_stock
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_initial_stock
end on

on tp_initial_stock.destroy
call super::destroy
destroy(this.dw_initial_stock)
end on

event resize;call super::resize;dw_initial_stock.move(0,0)
dw_initial_stock.resize( NewWidth, NewHeight)

end event

event ue_postconstructor;call super::ue_postconstructor;idt_Initial_date = of_initial_dt()
end event

type dw_initial_stock from u_dw within tp_initial_stock
integer x = 27
integer y = 48
integer width = 4448
integer height = 2280
integer taborder = 10
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string ls_ex_fg
str_pass_parmeters lstr_parm

IF dwo.name = "b_find" THEN

	lstr_parm.long_array[1] = 0
	
	//OpenWithParm(w_search_store_card_pls,lstr_parm)

	IF(gstr_parm.long_array[1] > 0 )THEN
	   	This.SetFilter( "sc_id ="+String(gstr_parm.long_array[1]))
	ELSE	
	   	This.SetFilter( "" )
	END IF
	
	This.Filter( )

END IF


IF dwo.name = "b_add" THEN
	
	This.event pfc_insertrow( )
	
END IF

IF dwo.name = "b_del" THEN
	
	This.event pfc_deleterow( )
	
END IF

IF dwo.name = "b_cost" THEN
	
   	uf_cost_price_calculation()    
	MessageBox("تنبيه","تمت عملية حساب سعر التكلفة لكل الاصناف بنجاح")
	
END IF

IF dwo.name = "b_save" THEN
	
	This.event pfc_update( True , True )
	Commit;
	
END IF

IF dwo.name = "b_stocks" THEN
	
	lstr_parm.long_array[1] = 0
	
	//OpenWithParm(w_search_store_card_pls,lstr_parm)

	if(gstr_parm.long_array[1] > 0 )then
	   	This.setitem( row , "sc_id", gstr_parm.long_array[1])
	
		SELECT Expiry_fg 
		INTO :ls_ex_fg 
		FROM STORE_CARD 
		WHERE sc_id = :gstr_parm.long_array[1];
	
		if(ls_ex_fg = "Y")Then
			OpenWithParm(w_select_store_card_batche , gstr_parm.long_array[1] )
		End if
	
	
	end if

end if
end event

event constructor;call super::constructor;str_pass_parmeters lstr_parm
String ls_color

lstr_parm = gnv_services.of_backGroundColor()

IF gs_lan = "AR" THEN
	This.DataObject = gs_dataObject
ELSE
	This.DataObject = gs_dataObject+"_ltr"
END IF

This.SetTransObject(SQLCA)

ls_color = mid(lstr_parm.String_parm[1] , pos(lstr_parm.String_parm[1] , "=")+1 ,len(lstr_parm.String_parm[1]) )
//ls_gr_color = mid(lstr_parm.String_parm[2] , pos(lstr_parm.String_parm[2] , "=")+1 ,len(lstr_parm.String_parm[2]) )

This.Modify( "DataWindow.brushmode=2" )
This.Modify( "DataWindow.color="+ls_color )
This.Modify( "DataWindow.transparency=11" )
This.Modify( "DataWindow.gradient.angle=0" )
This.Modify( "DataWindow.gradient.color='16777215'" )
This.Modify( "DataWindow.gradient.focus=51" )
This.Modify( "DataWindow.gradient.scale=86" )
This.Modify( "DataWindow.gradient.spread=83" )
This.Modify( "DataWindow.gradient.transparency=0" )


IF gs_lan <> "AR" THEN
	
	This.Modify( "sc_id_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "sc_id_t.text" , "")+"'" )
	This.Modify( "store_id_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "store_id_t.text", "")+"'" )
	This.Modify( "expiry_dt_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "expiry_dt_t.text", "")+"'" )
	This.Modify( "batch_no_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "batch_no_t.text", "")+"'" )
	This.Modify( "quantity_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "quantity_t.text", "")+"'" )
	This.Modify( "buy_price_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "buy_price_t.text", "")+"'" )
	This.Modify( "total_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "total_t.text", "")+"'" )
	This.Modify( "initial_dt_t.text='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "initial_dt_t.text", "")+"'" )
	This.Modify( "b_del.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_del.tooltip.tip", "")+"'" )
	This.Modify( "b_stocks.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_stocks.tooltip.tip", "")+"'" )
	This.Modify( "b_add.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_add.tooltip.tip", "")+"'" )
	This.Modify( "b_save.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_save.tooltip.tip", "")+"'" )
	This.Modify( "b_cost.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_cost.tooltip.tip", "")+"'" )
	This.Modify( "b_export.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_export.tooltip.tip", "")+"'" )
	This.Modify( "b_find.tooltip.tip='"+ProfileString(gs_lan+".ini" , "Initial_stock" , "b_find.tooltip.tip", "")+"'" )
	
END IF

This.Retrieve( )


end event

event type integer pfc_update(boolean ab_accepttext, boolean ab_resetflag);Long ll_update

This.accepttext( )


ll_update = This.update( )

if ll_update = -1 or IsNull(ll_update) then
	
	ROLLBACK ;
	MessageBox("Error","Can not save data !",Stopsign!)
	return 0
	
Else
	
	COMMIT ; 
	
	return 1
	
End if

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;This.SetItem(al_row , "initial_dt" , idt_Initial_date)

end event

