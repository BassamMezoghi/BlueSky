$PBExportHeader$n_cst_sys_setup.sru
forward
global type n_cst_sys_setup from n_base
end type
end forward

global type n_cst_sys_setup from n_base autoinstantiate
end type

type variables
Public :	
	Constant int IndexPrice 						= 1 //Get the price from index
	Constant int InforceSCFamily 					= 2 //Inforce the Store card Family
	Constant int ClientAccInv 						= 3 //print the Client Account on the invoice
	Constant int DealerInforce 					= 4 //Infoce select Dealer in sales
	Constant int InforceBuyPrice 					= 5 //Get the purchase price from indexs
	Constant int ShwClientAccount					= 6 //Show Client Account on sales screen	
	Constant int CostPriceHistory 				= 7 //Use Avg Cost price
	Constant int UpdateSalesInvAfterPrint		= 8 //clolse the update after print the sales invoice
	Constant int UpdateRejectInvAfterPrint		= 9 //clolse the update after print the reject invoice
	Constant int SalesInvoiceSize					= 10 //set the sales invoice to size A5
	Constant int PaymentsInvoiceSize				= 11 //set the payment invoice to size A5
	Constant int ClientRejectInvoiceSize		= 12 //set the client Reject invoice to size A5
	Constant int UpdatePaymentsInvAfterPrint	= 13 //clolse the update after print the Payment invoice
	Constant int SalesDiscountPercent			= 14 //sales discount is percentage	
	Constant int SalesDiscountPercentFixed		= 15 //sales discount is percentage loaded from customer info
	Constant int SalaryByLaw						= 16 //Salary accourding libyan law
	Constant int DisplyLogo							= 17 //load logo from database
	Constant int InforceDeliveryB4Inventory	= 18 //inforce the delivery step befor Inventory	
	Constant int InforceConfirmationCode		= 19 //inforce the confirmation code
	Constant int LiveInventory						= 20 //live inventory
	Constant int OnArchiveCreateJournal			= 21 //create journal when archiveing the data
	Constant int ClientsShared						= 22 //create journal when archiveing the data
	Constant int PriceChangeEmail					= 23 //Auto email price change
	Constant int UserStoreCardFamily				= 24 //Users Store Card Family
	Constant int SwapMoneyInvoiceSize			= 25 //set the Swap invoice to size A5
	Constant int SalesQtyInventory				= 26 //set the Quantity Validation
	Constant int ViewSCWithPrice					= 27 //view only items with price
	
	
Protected:
	Long il_RowCount = 0
	DataStore ids_SysSetup
end variables

forward prototypes
public function boolean of_getsyssetup (long al_id)
end prototypes

public function boolean of_getsyssetup (long al_id);String ls_Value
Long ll_row

IF il_RowCount <= 0 THEN 
	ids_SysSetup = Create DataStore
	ids_SysSetup.DataObject = "d_all_sys_setup"
	ids_SysSetup.SetTransObject(SQLCA)
	ids_SysSetup.retrieve( )
	il_RowCount = ids_SysSetup.RowCount()
	IF il_RowCount <= 0 THEN Return False
END IF

ll_row = ids_sysSetup.Find("id="+String(al_id) , 1 , il_rowcount)

IF ll_row <= 0 THEN Return False

ls_Value = ids_SysSetup.GetItemString( ll_row , "value")

IF ls_value = "0" THEN Return False

Return True
end function

on n_cst_sys_setup.create
call super::create
end on

on n_cst_sys_setup.destroy
call super::destroy
end on

event constructor;call super::constructor;
ids_SysSetup = Create DataStore
ids_SysSetup.DataObject = "d_all_sys_setup"

end event

event destructor;call super::destructor;Destroy ids_SysSetup
end event

