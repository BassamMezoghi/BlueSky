$PBExportHeader$w_product_mix_items.srw
forward
global type w_product_mix_items from w_response
end type
end forward

global type w_product_mix_items from w_response
integer width = 3305
integer height = 1876
boolean ib_isupdateable = false
end type
global w_product_mix_items w_product_mix_items

on w_product_mix_items.create
call super::create
end on

on w_product_mix_items.destroy
call super::destroy
end on

