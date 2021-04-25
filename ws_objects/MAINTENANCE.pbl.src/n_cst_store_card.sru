$PBExportHeader$n_cst_store_card.sru
forward
global type n_cst_store_card from n_base
end type
end forward

global type n_cst_store_card from n_base
end type
global n_cst_store_card n_cst_store_card

type variables
PRIVATE :
DataStore ids_Stock_info
end variables

forward prototypes
public function string of_getitemname (long al_sc_id, string as_property, string as_type)
public function long of_getitembybarcode (string ar_barcode)
public function long of_get_item_by_en_card_nm (string ar_en_card_nm)
end prototypes

public function string of_getitemname (long al_sc_id, string as_property, string as_type);Long ll_row
String ls_nm

ll_row = ids_Stock_info.Find( "id="+String(al_sc_id) , 1 , ids_Stock_info.RowCount())

IF ll_row > 0 THEN
	
	choose case lower(as_type)
		case "string"
			ls_nm = ids_Stock_info.GetItemString(ll_row , as_property)
		case "long"
			ls_nm = String(ids_Stock_info.GetItemNumber(ll_row , as_property) )
	end choose

ELSE
	ls_nm = ""
END IF

Return ls_nm
end function

public function long of_getitembybarcode (string ar_barcode);Long ll_sc_id

ll_sc_id = ids_Stock_info.Find( "barcode='"+ar_barcode+"'" , 1 , ids_Stock_info.RowCount())

IF ll_sc_id > 0 THEN
	ll_sc_id = ids_Stock_info.GetItemNumber(ll_sc_id , "id")
ELSE
	ll_sc_id = 0
END IF

Return ll_sc_id
end function

public function long of_get_item_by_en_card_nm (string ar_en_card_nm);Long ll_sc_id

ll_sc_id = ids_Stock_info.Find( "en_card_nm='"+ar_en_card_nm+"'" , 1 , ids_Stock_info.RowCount())

IF ll_sc_id > 0 THEN
	ll_sc_id = ids_Stock_info.GetItemNumber(ll_sc_id , "id")
ELSE
	ll_sc_id = 0
END IF

Return ll_sc_id
end function

on n_cst_store_card.create
call super::create
end on

on n_cst_store_card.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_Stock_info = CREATE DataStore

ids_Stock_info.DataObject = "d_search_store_kind_list_pls_hiden"
ids_Stock_info.SetTransobject( SQLCA )
ids_Stock_info.retrieve( )

end event

