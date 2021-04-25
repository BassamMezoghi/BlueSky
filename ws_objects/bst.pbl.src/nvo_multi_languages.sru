$PBExportHeader$nvo_multi_languages.sru
forward
global type nvo_multi_languages from n_base
end type
end forward

global type nvo_multi_languages from n_base autoinstantiate
end type

forward prototypes
public function string of_get_title (string ar_lan, string ar_screen, string ar_part)
end prototypes

public function string of_get_title (string ar_lan, string ar_screen, string ar_part);Return ProfileString(ar_lan+".ini" , 	ar_Screen	, ar_Part , "")
end function

on nvo_multi_languages.create
call super::create
end on

on nvo_multi_languages.destroy
call super::destroy
end on

