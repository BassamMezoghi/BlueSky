$PBExportHeader$n_cst_msg.sru
forward
global type n_cst_msg from n_base
end type
end forward

global type n_cst_msg from n_base
end type
global n_cst_msg n_cst_msg

type variables
DataStore ids
end variables

forward prototypes
public subroutine of_ar_static_messages (long ar_id)
public subroutine of_en_static_messages (long ar_id)
public subroutine of_fr_static_messages (long ar_id)
public function integer of_message (long ar_id)
private function long of_download_messages ()
public function integer of_message (long ar_id, string ar_extra)
end prototypes

public subroutine of_ar_static_messages (long ar_id);	Choose Case ar_id
		Case -1
			MessageBox("تنبيه","تعذر الحصول على رقم النسخة"+"~n~n"+"لايمكن تشغيل المنظومة دون التعرف على رقم النسخة ",StopSign!)
		Case -2
			Messagebox("تنبيه","إدخال خاطئ")
		Case -3
			MessageBox("خطأ قاعدة البيانات" , "تعذر الاتصال بقاعدة البيانات" , StopSign!)
		Case -4
			MessageBox("تنبيه" , "لايوجد اتصال بالخادم" +"~n~n"+ "ارجو التاكد من اعدادات الشبكة", StopSign! )
		Case -5
			MessageBox("تنبيه" ,"حدث خطاء في المنظومة ارجو الاتصال بمشرف النظام" , StopSign! )
		Case Else
			Messagebox("تنبيه" , "إدخال خاطئ" , StopSign!)
	End Choose
end subroutine

public subroutine of_en_static_messages (long ar_id);	Choose Case ar_id
		Case -1
			MessageBox("Warning","Could not get the version number"+"~n~n"+"You can not run the system without identifying the version number.",StopSign!)
		Case -2
			Messagebox("Warning","Wrong entry" , StopSign!)
		Case -3
			MessageBox("Database Error" , "Unable to connect to the database." , StopSign!)
		Case -4 
			MessageBox("Warning" , "Server Disconnected~n~nPlease check network settings")
		Case -5
			MessageBox("Warning" , "The application has encountered a critical error~n~nPlease contact system administrator" , StopSign! )
		Case Else
			Messagebox("Warning" , "Unknown error occurred" , StopSign!)
	End Choose
end subroutine

public subroutine of_fr_static_messages (long ar_id);	Choose Case ar_id
		Case -1
			MessageBox("Attention","Could not get the version number" + "~ n ~ n" + "You can not run the system without identifying the version number.",StopSign!)
		Case -2
			Messagebox("Attention","Mauvaise entrée"  , StopSign!)
		Case -3
			MessageBox("Erreur de la base de données" , "Impossible de se connecter à la base de donnée." , StopSign!)
		Case -4 
			MessageBox("Attention" , "Serveur déconnecté~n~nVeuillez vérifier les paramètres réseau")
		Case -5
			MessageBox("Attention" ,"L'application a rencontré une erreur critique~n~nVeuillez contacter l'administrateur du système" , StopSign! )
		Case Else
			Messagebox("Attention" , "Une erreur inconnue s'est produite" , StopSign!)
	End Choose
end subroutine

public function integer of_message (long ar_id);Long ll_row
String ls_Title , ls_msg , ls_icon , ls_btn
icon l_icon
button l_btn

IF ids.RowCount() = 0 THEN of_download_Messages()

ll_row = ids.find(" id = "+string(ar_id) + " and lan = '"+gs_lan+"'" , 1 , ids.RowCount() ) 

IF IsNull(ll_row) THEN Return 0

IF ll_row > 0 THEN
	
	ls_title = ids.getitemString(ll_row , "title")
	ls_msg = ids.getitemString(ll_row , "msg")
	ls_icon = ids.getitemString(ll_row , "icon")
	ls_btn = ids.getitemString(ll_row , "btn")
	
	Choose Case upper(ls_icon)
		Case "I"
			l_icon = Information!
		Case "S"
			l_icon = StopSign!
		Case "E"
			l_icon = Exclamation!
		Case "Q"
			l_icon = Question!
		Case ELSE
			l_icon = None!
	End Choose

	Choose Case ls_btn
		Case "1"
			l_btn = OK!
		Case "2"
			l_btn = OKCancel! 
		Case "3"
			l_btn = YesNo!
		Case "4"
			l_btn = YesNoCancel!
		Case "5"
			l_btn = RetryCancel! 
		Case "6"
			l_btn =	AbortRetryIgnore!
		Case 	ELSE
			l_btn = OK!
	End Choose
	
	Return of_MessageBox(String(ar_id) , ls_title , ls_msg,l_icon , l_btn , 1)  //MessageBox(ls_Title , ls_msg , l_icon , l_btn ) 
	
ELSE
	
	Choose Case gs_lan
		Case "AR"
			of_Ar_Static_Messages(ar_id)
		Case "EN"
			of_en_Static_Messages(ar_id)
		Case "FR"
			of_fr_Static_Messages(ar_id)
	End Choose

END IF



end function

private function long of_download_messages ();
ids.DataObject = "d_msg"
ids.SetTransobject( SQLCA )

ids.retrieve( gs_lan )

return ids.RowCount()
end function

public function integer of_message (long ar_id, string ar_extra);Long ll_row
String ls_Title , ls_msg , ls_icon , ls_btn
icon l_icon
button l_btn

IF ids.RowCount() = 0 THEN of_download_Messages()

ll_row = ids.find(" id = "+string(ar_id) + " and lan = '"+gs_lan+"'" , 1 , ids.RowCount() ) 

IF IsNull(ll_row) THEN Return 0

IF ll_row > 0 THEN
	
	ls_title = ids.getitemString(ll_row , "title")
	ls_msg = ids.getitemString(ll_row , "msg")+" "+ar_extra
	ls_icon = ids.getitemString(ll_row , "icon")
	ls_btn = ids.getitemString(ll_row , "btn")
	
	Choose Case upper(ls_icon)
		Case "I"
			l_icon = Information!
		Case "S"
			l_icon = StopSign!
		Case "E"
			l_icon = Exclamation!
		Case "Q"
			l_icon = Question!
		Case ELSE
			l_icon = None!
	End Choose

	Choose Case ls_btn
		Case "1"
			l_btn = OK!
		Case "2"
			l_btn = OKCancel! 
		Case "3"
			l_btn = YesNo!
		Case "4"
			l_btn = YesNoCancel!
		Case "5"
			l_btn = RetryCancel! 
		Case "5"
			l_btn =	AbortRetryIgnore!
		Case 	ELSE
			l_btn = OK!
	End Choose
	
	Return of_MessageBox(String(ar_id) , ls_title , ls_msg,l_icon , l_btn , 1)  //MessageBox(ls_Title , ls_msg , l_icon , l_btn ) 
	
ELSE
	
	Choose Case gs_lan
		Case "AR"
			of_Ar_Static_Messages(ar_id)
		Case "EN"
			of_en_Static_Messages(ar_id)
		Case "FR"
			of_fr_Static_Messages(ar_id)
	End Choose

END IF



end function

on n_cst_msg.create
call super::create
end on

on n_cst_msg.destroy
call super::destroy
end on

event constructor;call super::constructor;ids = Create DataStore



end event

