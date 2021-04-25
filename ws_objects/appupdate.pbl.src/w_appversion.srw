$PBExportHeader$w_appversion.srw
forward
global type w_appversion from w_response
end type
type pb_1 from u_pb within w_appversion
end type
type dw_1 from u_dw within w_appversion
end type
end forward

global type w_appversion from w_response
integer width = 2994
integer height = 1788
boolean titlebar = false
boolean controlmenu = false
windowtype windowtype = popup!
boolean righttoleft = true
boolean center = true
integer transparency = 20
windowanimationstyle openanimation = centeranimation!
boolean ib_isupdateable = false
pb_1 pb_1
dw_1 dw_1
end type
global w_appversion w_appversion

forward prototypes
public subroutine of_1_0_3_85 ()
public subroutine of_1_0_3_86 ()
public subroutine of_1_0_3_84 ()
public subroutine of_pre_versions ()
public subroutine of_1_0_3_87 ()
public subroutine of_1_0_3_88 ()
public subroutine of_1_0_3_89 ()
public subroutine of_1_0_3_90 ()
public subroutine of_1_0_3_91 ()
public subroutine of_1_0_3_92 ()
public subroutine of_1_0_3_93 ()
public subroutine of_1_0_3_94 ()
public subroutine of_1_0_3_95 ()
public subroutine of_1_0_3_96 ()
public subroutine of_1_0_3_97 ()
public subroutine of_1_0_3_98 ()
public subroutine of_1_0_3_99 ()
public subroutine of_1_0_4_0 ()
public subroutine of_1_0_4_1 ()
public subroutine of_1_0_4_2 ()
public subroutine of_1_0_4_3 ()
public subroutine of_1_0_4_4 ()
public subroutine of_1_0_4_5 ()
public subroutine of_1_0_4_6 ()
public subroutine of_1_0_4_7 ()
public subroutine of_1_0_4_8 ()
public subroutine of_1_0_4_9 ()
public subroutine of_1_0_4_10 ()
public subroutine of_1_0_4_11 ()
public subroutine of_1_0_4_12 ()
public subroutine of_1_0_4_13 ()
public subroutine of_1_0_4_14 ()
public subroutine of_1_0_4_15 ()
public subroutine of_1_0_4_16 ()
public subroutine of_1_0_4_17 ()
public subroutine of_1_0_4_18 ()
public subroutine of_1_0_4_19 ()
public subroutine of_1_0_4_20 ()
public subroutine of_1_0_4_21 ()
public subroutine of_1_0_4_22 ()
public subroutine of_1_0_4_23 ()
public subroutine of_1_0_4_24 ()
public subroutine of_1_0_4_25 ()
public subroutine of_1_0_4_26 ()
public subroutine of_1_0_4_27 ()
public subroutine of_1_0_4_28 ()
public subroutine of_1_0_4_29 ()
public subroutine of_1_0_4_30 ()
public subroutine of_1_0_4_31 ()
public subroutine of_1_0_4_32 ()
public subroutine of_1_0_4_33 ()
public subroutine of_1_0_4_34 ()
end prototypes

public subroutine of_1_0_3_85 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.85'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.85")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل التصدير في جرد تكلفة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.85")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل المخزن الافتراضي في المبيعات اليومية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.85")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير اعداد المرتبات" )	

END IF
end subroutine

public subroutine of_1_0_3_86 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.86'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.86")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية نسخ مجموعة حسابات  في الدليل المحاسبي" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.86")
	dw_1.SetItem( ll_row , "notes" 	, "اظهار اسم القيد عند فتح الدليل بالاختصار في القيود اليومية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.86")
	dw_1.SetItem( ll_row , "notes" 	, "إمكانية إخفاء إسم المعد و إسم المعتمد من الطباعة القيود اليومية")	

END IF

Return 
end subroutine

public subroutine of_1_0_3_84 ();Long ll_row

IF dw_1.Find(  "version = '1.0.3.84'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.84")
	dw_1.SetItem( ll_row , "notes" 	, "بحث برقم القيد في القيود اليومية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.84")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل ترحيل القيود" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.84")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة امكانية  ارسال بريد الكتروني  بعد تعديل الاسعار" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.84")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة البريد الإلكتروني في بيانات الموظفين" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.84")
	dw_1.SetItem( ll_row , "notes" 	, "إدارة البريد الالكتروني  و التحكم بمن يصلهم تنبيه من قاعدة البيانات" )	


END IF
end subroutine

public subroutine of_pre_versions ();Long ll_row

IF dw_1.Find(  "version = '1.0.3.53'", 1, dw_1.rowcount( ) ) = 0 THEN
ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.53")
dw_1.SetItem( ll_row , "notes" , "تعديل ارشيف المقبوضات" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.53")
dw_1.SetItem( ll_row , "notes" , "اضافة الطباعة في فواتير المبيعات اليومية" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.53")
dw_1.SetItem( ll_row , "notes" , "إضافة إمكانية الطباعة بإستخدام الطابعة الحرارية" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.53")
dw_1.SetItem( ll_row , "notes" , "فصل تسجيل الاجهزة عن اعطاء الصلاحيات" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.53")
dw_1.SetItem( ll_row , "notes" , "تعديل تصميم شاشة اعطاء الصلاحيات" )
END IF
///////////////////////////////////////////////////////////////////////////////////////////
IF dw_1.Find(  "version = '1.0.3.54'", 1, dw_1.rowcount( ) ) = 0 THEN
ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تغير طريقة عمل شاشة استلام نقدية")

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تعديل تقرير متابعة الاصول")

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تعديل طريقة عمل العهد")

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تغير اسم الموزعين الى المسوقين في التقارير")

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تعديل طريقة عمل استلام نقدية" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" ,"تعديل طريقة عمل اذن صرف نقدية" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تعديل شاشة بيانات الزبائن" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" ,"امكانية توقيف و اعادة تنشيط الزبائن" )

ll_row = dw_1.insertrow( 0 )
dw_1.SetItem( ll_row , "version" , "1.0.3.54")
dw_1.SetItem( ll_row , "notes" , "تعديل لوحة التحكم" )

END IF

IF dw_1.Find(  "version = '1.0.3.55'", 1, dw_1.rowcount( ) ) = 0 THEN
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.55")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة البحث في الزبائن بستخدام المفاتيح دون الحاجة الى الفارة" )
	ll_row = dw_1.insertrow( 0 )	
	dw_1.SetItem( ll_row , "version" , "1.0.3.55")
	dw_1.SetItem( ll_row , "notes" , "تعديل البحث في قائمة الاصناف بستخدام  لوحة المفاتيح دون الحاجة للفارة" )
	ll_row = dw_1.insertrow( 0 )	
	dw_1.SetItem( ll_row , "version" , "1.0.3.55")
	dw_1.SetItem( ll_row , "notes" , "تعديل تصدير الزبائن" )
	ll_row = dw_1.insertrow( 0 )	
	dw_1.SetItem( ll_row , "version" , "1.0.3.55")
	dw_1.SetItem( ll_row , "notes" , "تعديل لوحة الحركة" )

END IF

IF dw_1.Find(  "version = '1.0.3.56'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.56")
	dw_1.SetItem( ll_row , "notes" , "تعديل البحث في الاصناف عن طريق البار كود في المبيعات اليومية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.56")
	dw_1.SetItem( ll_row , "notes" ,"تعديل ارشيف المقبوضات" )

END IF

IF dw_1.Find(  "version = '1.0.3.57'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.57")
	dw_1.SetItem( ll_row , "notes" , "تعديل شاشة المبيعات اليومية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.57")
	dw_1.SetItem( ll_row , "notes" , "تحديث شاشة المسوقين لتاخد بيانات المسوق من شاشة شئون المستخدمين" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.57")
	dw_1.SetItem( ll_row , "notes" , "تحديث شاشة شئون المستخدمين" )


END IF


IF dw_1.Find(  "version = '1.0.3.58'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.58")
	dw_1.SetItem( ll_row , "notes" , "تعديل التخفيض و حساب المبلغ بالحروف في المبيعات و الترجيع" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.58")
	dw_1.SetItem( ll_row , "notes" , "تعديل تقرير الزبائن و الاصناف" )

	
END IF

IF dw_1.Find(  "version = '1.0.3.59'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.59")
	dw_1.SetItem( ll_row , "notes" , "تعديل تقرير التسويق")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.59")
	dw_1.SetItem( ll_row , "notes" , "تعديل   بيانات المستخدمين")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.59")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة حساب المرتبات")

	
END IF


IF dw_1.Find(  "version = '1.0.3.60'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.60")
	dw_1.SetItem( ll_row , "notes" , "إظهار رقم المورد في بيانات الموردين" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.60")
	dw_1.SetItem( ll_row , "notes" , "إمكانية اظهار شاشة باسم الصنف المباع في المبيعات اليومية" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.60")
	dw_1.SetItem( ll_row , "notes" , "تعديل شاشة إنتاج" )

	
END IF

IF dw_1.Find(  "version = '1.0.3.61'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.61")
	dw_1.SetItem( ll_row , "notes" ,"تعديل شاشة بضاعة اول مدة" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.61")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة حساب المرتبات" )

END IF


IF dw_1.Find(  "version = '1.0.3.62'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.62")
	dw_1.SetItem( ll_row , "notes" , "اضافة التخفيض في الترجيع" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.62")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة حساب المرتبات" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.62")
	dw_1.SetItem( ll_row , "notes" , "اضافة الصيانة في فواتير الفاقد" )

END IF

IF dw_1.Find(  "version = '1.0.3.63'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.63")
	dw_1.SetItem( ll_row , "notes" , "الغاء دمج الاصناف في استلام بضاعة" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.63")
	dw_1.SetItem( ll_row , "notes" , "تعديل حساب تكلفة الاصناف في استلام بضاعة" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.63")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة حساب المرتبات" )


END IF


IF dw_1.Find(  "version = '1.0.3.64'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.64")
	dw_1.SetItem( ll_row , "notes" , "إضافة الاعتمادات" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.64")
	dw_1.SetItem( ll_row , "notes" , "ربط الاعتمادات بطلب التوريد" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.64")
	dw_1.SetItem( ll_row , "notes" , "إمكانية توقيف و تنشيط موظف" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.64")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة حساب الكمية المطلوبة في طلب توريد")

		ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.64")
	dw_1.SetItem( ll_row , "notes" , "تعديل طريقة ربط طلب التوريد مع استلام بضاعة")

END IF

IF dw_1.Find(  "version = '1.0.3.65'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.65")
	dw_1.SetItem( ll_row , "notes" , "اضافة تقرير التغير في المرتبات" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.65")
	dw_1.SetItem( ll_row , "notes" , "اضافة المجاميع في اعداد الفواتير" )

END IF

IF dw_1.Find(  "version = '1.0.3.66'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.66")
	dw_1.SetItem( ll_row , "notes" ,"تعديل تقرير الاصول")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.66")
	dw_1.SetItem( ll_row , "notes" , "اضافة التصدير في إعداد مرتبات")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.66")
	dw_1.SetItem( ll_row , "notes" , "تعديل تقرير المرتبات")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.66")
	dw_1.SetItem( ll_row , "notes" , "تعديل المجموع في اعداد المرتبات")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.66")
	dw_1.SetItem( ll_row , "notes" , "تعديل احصائية الجرد و المبيعات اليومية" )


END IF

IF dw_1.Find(  "version = '1.0.3.67'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.67")
	dw_1.SetItem( ll_row , "notes" , "اضافة الاعفاء القانوني عند احتساب المرتبات" )
	
END IF

IF dw_1.Find(  "version = '1.0.3.68'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.68")
	dw_1.SetItem( ll_row , "notes" , "إضافة تقرير ضرائب المرتبات" )
		ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.68")
	dw_1.SetItem( ll_row , "notes" , "إضافة تقرير الضمان المرتبات" )

	
END IF

IF dw_1.Find(  "version = '1.0.3.69'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.69")
	dw_1.SetItem( ll_row , "notes" , "اضافة الادارة في تقرير الضرائب و الضمان في المرتبات" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.69")
	dw_1.SetItem( ll_row , "notes" , "اضافة خانة لسعر البضاعة بالعملة الاجنبية في طلب التوريد" )
		ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.69")
	dw_1.SetItem( ll_row , "notes" , "اضافة تبويب خاص بمؤشرات الاداء  المبيعات و المخزون" )
	
END IF

IF dw_1.Find(  "version = '1.0.3.70'", 1, dw_1.rowcount( ) ) = 0 THEN

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.70")
	dw_1.SetItem( ll_row , "notes" , "اضافة البحث في بضاعة اول مدة" )
	
END IF

IF dw_1.Find(  "version = '1.0.3.71'", 1, dw_1.rowcount( ) ) = 0 THEN

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.71")
	dw_1.SetItem( ll_row , "notes" , "توسيع خانة  رقم الصنف في تقرير تسعير بضاعة" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.71")
	dw_1.SetItem( ll_row , "notes" , "تعديل خانة المبلغ في شاشة راس المال" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.71")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة إعداد مرتب" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.71")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة الخدمات الجمركية" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.71")
	dw_1.SetItem( ll_row , "notes" , "تطوير تقرير  مصاريف المركبات" )
	
END IF

IF dw_1.Find(  "version = '1.0.3.72'", 1, dw_1.rowcount( ) ) = 0 THEN
		ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.72")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة المبيعات")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.72")
	dw_1.SetItem( ll_row , "notes" , "تحديث شاشة تحليل الحظور و الانصراف")
	
END IF

IF dw_1.Find(  "version = '1.0.3.73'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.73")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة المسوقين و اضافة ملاحظات الى المبيعات المستهدفة" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.73")
	dw_1.SetItem( ll_row , "notes" , "تعديل الترتيب في تقرير جرد مجموعة مخازن كمية فقط و كمية و تكلفة")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.73")
	dw_1.SetItem( ll_row , "notes" , "اضافة مقارنة المبيعات كمية فقط الى مؤشرات الاداء")

END IF

IF dw_1.Find(  "version = '1.0.3.74'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "تعديل الدمغة في تقرير ضرائب المرتبات")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "تطوير تقرير مبيعات الفروع")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "تطوير تقرير مقبوضات  الفروع")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "تطوير تقرير الاصناف و الفروع")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "تطوير تقرير العائد على المبيعات")
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "الغاء تقرير احصائيات و استبداله بتقرير احصائية مجموعة اصناف" )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.74")
	dw_1.SetItem( ll_row , "notes" , "إضافة تقرير توقع المبيعات السنوية")

END IF

IF dw_1.Find(  "version = '1.0.3.75'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.75")
	dw_1.SetItem( ll_row , "notes" , "اضافة تقرير مردودات المبيعات" )

END IF

IF dw_1.Find(  "version = '1.0.3.76'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.76")
	dw_1.SetItem( ll_row , "notes" , "اضافة إمكانية لصق الاصناف في التحويلات " )
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.76")
	dw_1.SetItem( ll_row , "notes" , "اضافة إمكانية لصق الاصناف في المبيعات" )

END IF

IF dw_1.Find(  "version = '1.0.3.77'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.77")
	dw_1.SetItem( ll_row , "notes" , " تعديل تقرير مبيعات المسوقين بحيث تقبل اكثر من مجموعة اصناف " )

END IF

IF dw_1.Find(  "version = '1.0.3.78'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.78")
	dw_1.SetItem( ll_row , "notes" , " XMLتصدير الجرد الى   " )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.78")
	dw_1.SetItem( ll_row , "notes" , " XMLتوريد تحويلات  من " )

END IF

IF dw_1.Find(  "version = '1.0.3.79'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.79")
	dw_1.SetItem( ll_row , "notes" , " تعديل تقرير حركة الاصناف" )

END IF

IF dw_1.Find(  "version = '1.0.3.80'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.80")
	dw_1.SetItem( ll_row , "notes" , "اضافة حركة تحويلات المخازن الى تقرير حركة صنف" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.80")
	dw_1.SetItem( ll_row , "notes" , "تعديل الطباعة في تقرير مبيعات المسوقين" )
	

END IF

IF dw_1.Find(  "version = '1.0.3.81'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.81")
	dw_1.SetItem( ll_row , "notes" , "اضافة زر لصق في استلام بضاعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.81")
	dw_1.SetItem( ll_row , "notes" , "إضافة زر لصق في التالف")	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.81")
	dw_1.SetItem( ll_row , "notes" , "اضافة زر نسخ في فواتير المبيعات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.81")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة اعطاء الصلاحيات")	

END IF

IF dw_1.Find(  "version = '1.0.3.82'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.82")
	dw_1.SetItem( ll_row , "notes" , "تعديل فاتورة ترجيع بضاعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.82")
	dw_1.SetItem( ll_row , "notes" , "اضافة خاصية لصق في تسعير بضاعة" )	
	
END IF

IF dw_1.Find(  "version = '1.0.3.83'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.83")
	dw_1.SetItem( ll_row , "notes" , "تطوير البحث في تسعير بضاعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.83")
	dw_1.SetItem( ll_row , "notes" , "شاشة تسعير بضاعة معالجة الخطاء عند تعديل السعر" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.83")
	dw_1.SetItem( ll_row , "notes" , "اضافة امكانية نسخ و لصق تحويلات المخازن" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.83")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة اعطاء الصلاحيات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.83")
	dw_1.SetItem( ll_row , "notes" , "تطوير شاشة المرتبات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.3.83")
	dw_1.SetItem( ll_row , "notes" , "اضافة امكانية تغير المسوق في شاشة المبيعات اليومية" )	

END IF
end subroutine

public subroutine of_1_0_3_87 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.87'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.87")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة نسخ البنود في استلام بضاعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.87")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير لصق البنود في استلام بضاعة " )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.87")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير لصق البنود في الفاقد" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.87")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل الخطاء الموجود في ترجيع بضاعة" )	

	
END IF

Return 
end subroutine

public subroutine of_1_0_3_88 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.88'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.88")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية لصق البنود في ترجيع بضاعة" )	


	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.88")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة ميزة لصق الى طلب التوريد" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.88")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية نسخ  في بريدي " )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.88")
	dw_1.SetItem( ll_row , "notes" 	, "تكبير بيان القيد في القيود اليومية" )	

END IF

Return 
end subroutine

public subroutine of_1_0_3_89 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.89'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.89")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة توريد ارقام التسلسل في استلام بضاعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.89")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة توريد ارقام التسلسل" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.89")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير مقبوضات المسوق" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.89")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة التخفيض في حركة المبيعات " )	

END IF

Return 
end subroutine

public subroutine of_1_0_3_90 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.90'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.90")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة إمكانية طباعة بطاقة تعريف المستخدمين" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.90")
	dw_1.SetItem( ll_row , "notes" 	, "تحسين سرعة تحميل البيانات في شئون المستخدمين")	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.90")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة خانة التأكد من رقم التعريف لحماية بطاقات المستخدمين من التزوير" )	

END IF

Return 
end subroutine

public subroutine of_1_0_3_91 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.91'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.91")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير بطاقة صنف و اضافة بنود اضافية للبطاقة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.91")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية تصدير و توريد الاصناف في بطاقة صنف" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.91")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقارير حركة الموردين" )	

END IF

Return 
end subroutine

public subroutine of_1_0_3_92 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.92'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.92")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة بحث في تقارير إدارة الحسابات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.92")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية طباعة تفصيل قيد اليومية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.92")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقارير ادارة الحسابات" )	

//	ll_row = dw_1.insertrow( 0 )
//	dw_1.SetItem( ll_row , "version" 	, "1.0.3.92")
//	dw_1.SetItem( ll_row , "notes" 	, "" )	
//
END IF

Return 
end subroutine

public subroutine of_1_0_3_93 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.93'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث تقرير ميزان المراجعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية توريد المقبوضات في شاشة المقبوضات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير ضريبة المبيعات  (التقريب الى نصف دينار)" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية البحث عن زبون بالرقم  المحل اليدوي" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية البحث عن زبون برقم المحل اليدوي" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "عرض قيد المبيعات من شاشة المبيعات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.93")
	dw_1.SetItem( ll_row , "notes" 	, "عرض قيد المقبوضات من شاشة المقبوضات" )	

END IF

Return 
end subroutine

public subroutine of_1_0_3_94 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.94'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.94")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة القيود اليومية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.94")
	dw_1.SetItem( ll_row , "notes" 	,"اضافة القوائم المالية في ادارة الحسابات")	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.94")
	dw_1.SetItem( ll_row , "notes" 	, "بحث عن طريق رقم المحل في بيانات الزبائن" )	
	
END IF

Return 
end subroutine

public subroutine of_1_0_3_95 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.95'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.95")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة القيود اليومية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.95")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة زر تحديث البيانات في شاشة بيانات المستخدمين")	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.95")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة توريد المبيعات و الشحن الالكتروني" )	
	
END IF

Return
end subroutine

public subroutine of_1_0_3_96 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.96'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.96")
	dw_1.SetItem( ll_row , "notes" 	, "تقرير PCSI" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.96")
	dw_1.SetItem( ll_row , "notes" 	, "إمكانية تغير لغة التطبيق" )	

	
END IF

Return
end subroutine

public subroutine of_1_0_3_97 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.97'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث تقرير خصوم المرتبات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	,  "تحديث شاشة شئون المستخدمين" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة الشئون الادارة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	, "ربط الشئون الادارة بإحتساب المرتبات")	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة اعدادت خصم المرتب في اعدادات المنظومة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث البحث في بطاقة صنف" )	


	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.97")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث البحث في قائمة الاسعار" )	

END IF

Return
end subroutine

public subroutine of_1_0_3_98 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.98'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.98")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة بيانات المسوقين" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.98")
	dw_1.SetItem( ll_row , "notes" 	, "تكبير حجم خانة المجموع  في امر تحويل بضاعة" )	


END IF

Return
end subroutine

public subroutine of_1_0_3_99 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.3.99'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.99")
	dw_1.SetItem( ll_row , "notes" 	,"صلاحية  اعطاء مجموعات الاصناف للمستخدمين")	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.99")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير الجرد ليتماشي مع صلاحيات محموعة الاصناف" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.99")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير حركة مبيعات الزبائن ليتماشي مع صلاحيات محموعة الاصناف" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.99")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير الزبائن و الاصناف ليتماشي مع صلاحيات محموعة الاصناف" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.3.99")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير تحليلي الجرد ليتماشي مع صلاحيات محموعة الاصناف" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_0 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.0'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.0")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل طريقة عقود الاستخدام")	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.0")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير حركة مبيعات الزبائن و اضافة طريقة جديدة لإختيار التاريخ" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.0")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة إمكانية ترتيب البيانات في تقرير مبيعات المسوقين التجميعي")	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.0")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة إمكانية تصفية البيانات في تقرير مبيعات المسوقين التجميعي" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_1 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.1'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.1")
	dw_1.SetItem( ll_row , "notes" 	, "إمكانية إقاف المبيعات للفروع" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.1")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة إمكانية الترتيب في تقرير حركة المبيعات التفصيلي" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.1")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة امكانية تحديث أسعار البيع في فاتورة المبيعات" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_2 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.2'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.2")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة إمكانية توريد طلب توريد" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.2")
	dw_1.SetItem( ll_row , "notes" 	, "زيادة خانة الرقم اليدوي في طلب التوريد لتقبل 20 خانة بدل من 10" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.2")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقارير إدارة المخازن" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.2")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير تحليلي الجرد بالقيمة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.2")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة تقرير تحليلي الجرد تجميعي" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.2")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل مفاتيح البحث في تقرير حركة المبيعات" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_3 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.3'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.3")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة القيود اليومية" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.3")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث شاشة المساهمات و الاعانات في الارشيف" )	
	
END IF

Return
end subroutine

public subroutine of_1_0_4_4 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.4'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.4")
	dw_1.SetItem( ll_row , "notes" 	, "فواتير المبيعات باللغة الانجليزية" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.4")
	dw_1.SetItem( ll_row , "notes" 	, "فواتير استلام بضاعة باللغة الانجليزية" )	
	


END IF

Return
end subroutine

public subroutine of_1_0_4_5 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.5'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.5")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة   اعطاء الصلاحيات" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.5")
	dw_1.SetItem( ll_row , "notes" 	, "تغير اسم شاشة اعطاء الصلاحيات الى  المستخدمين" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.5")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة مجموعات المستخدمين")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.5")
	dw_1.SetItem( ll_row , "notes" 	,"اضافة صلاحيات المجموعات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.5")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة خاصية ارجاع فواتير المبيعات من الارشيف" )

END IF

Return
end subroutine

public subroutine of_1_0_4_6 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.6'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.6")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة الرصيد المتبقي عند طباعة استلام نقدية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.6")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير حركة الاصناف الفعلية" )	
	

END IF

Return
end subroutine

public subroutine of_1_0_4_7 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.7'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.7")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل فاتورة  المبيعات باللغة الانجليزية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.7")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل شاشة تحويلات الخزينة" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_8 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.8'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.8")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل الطباعة في  تقارير الجرد و الجرد التحليلي" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.8")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل التصدير في تقارير الجرد" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.8")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة اسم المستفيد في إذن استلام و صرف يضاعة" )	
		

END IF

Return
end subroutine

public subroutine of_1_0_4_9 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.9'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.9")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة ملاحظات في استلام بضاعة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.9")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير طباعة اذنات الصرف و الاستلام" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.9")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل سند القبض" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.9")
	dw_1.SetItem( ll_row , "notes" 	, "A5 امكانية طباعة تحويلات الخزينة حجم " )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.9")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة ملاحظات الزيائن" )	


	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.9")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية طباعة قائمة الزيائن دون الحاجة للدخول الى بيانات الزبائن" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_10 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.10'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.10")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير مقارنة الجرد المادي مع الجرد التجاري" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.10")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقرير حركة الاصناف الفعلية" )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.10")
	dw_1.SetItem( ll_row , "notes" 	, "معالجة ارقام التسلسل الالية " )	
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.10")
	dw_1.SetItem( ll_row , "notes" 	,"تطوير شاشة بيانات المركبات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.10")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير البحث في شاشة تحويلات الخزينة")	


END IF

Return
end subroutine

public subroutine of_1_0_4_11 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.11'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.11")
	dw_1.SetItem( ll_row , "notes" 	, "فصل الرقم الالي في اذنات الاستلام و الصرف" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.11")
	dw_1.SetItem( ll_row , "notes" 	, "شريط استدعاء الوظائف" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.11")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية سحب من المخزن في حالة عدم توفر الكمية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.11")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث البحث في المقبوضات" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_12 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.12'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.12")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير الاصول و طريقة حساب الاهلاكات" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.12")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل شكل سند القبض في اللعة الانجليزية" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.12")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير مقارنة الجرد" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.12")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة شاشة لتوضيح الاختصارات المساعدة في عملية ادخال الفواتير" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.12")
	dw_1.SetItem( ll_row , "notes" 	, "تقرير مجموع الزبائن يوضح اخر فاتورة بيع و ااخر سند قبض لكل زبون " )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.12")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث تقرير حركة الخزينة" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_13 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.13'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.13")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل شاشة بيانات المستخدمين" )


	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.13")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تبويب خاص بالاجازات لكل مستخدم في الموارد البشرية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.13")
	dw_1.SetItem( ll_row , "notes" 	, "استبدال اسم شئون المستخدمين باسم الموارد البشرية" )

END IF

Return
end subroutine

public subroutine of_1_0_4_14 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.14'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.14")
	dw_1.SetItem( ll_row , "notes" 	,  "تعديل الترتيب في تقرير حركة الاصناف الفعلية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.14")
	dw_1.SetItem( ll_row , "notes" 	,  "اضافة المستفيد في طباعة اذن الصرف" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.14")
	dw_1.SetItem( ll_row , "notes" 	,  "تعديل البحث في دليل الحسابات" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.14")
	dw_1.SetItem( ll_row , "notes" 	,  "اضافة اختصارات في اعداد القيود اليومية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.14")
	dw_1.SetItem( ll_row , "notes" 	,  "اضافة بحث برقم المحل اليدوي في شاشة بيانات الزبائن" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.14")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية توزيع المركبات الى مجموعات" )
	

END IF

Return
end subroutine

public subroutine of_1_0_4_15 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.15'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.15")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير دفتر  الاستاذ في ادارة الحسابات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.15")
	dw_1.SetItem( ll_row , "notes" 	, "تغير اسم تقرير التحليلي في ادارة  الحسابات  الى  دفتر استاذ عام" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.15")
	dw_1.SetItem( ll_row , "notes" 	, "تغير اسم تقرير قيود اليومية في ادارة  الحسابات  الى  دفتر استاذ مساعد" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.15")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل اسم الزبون في طباعة ترجيع نقدي" ) 

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.15")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل الخطاء في ارشفة تحويلات الخزينة" )	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.15")
	dw_1.SetItem( ll_row , "notes" 	, " تعديل ارشيف تحويلات الخزينة" )	

END IF

Return
end subroutine

public subroutine of_1_0_4_16 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.16'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.16")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية تقسيم المستخدمين في الموارد البشرية الى مجموعات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.16")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير البحت في بيانات المستخدمين في الموارد البشرية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.16")
	dw_1.SetItem( ll_row , "notes" 	,  "تعديل البيانات في طباعة قائمة المستخدمين في الموارد البشرية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.16")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة ملاحظات  في تقرير قائمة الزبائن" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.16")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة الرصيد في تقرير حركة الخزينة" )

	
END IF

Return
end subroutine

public subroutine of_1_0_4_17 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.17'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير ميزان المراجعة و اضافة خاصية عرض الحسابات الصفرية")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة  اذن الاستلام و اذن الصرف في الأرشيف " )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة بيانات المركبات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقرير الاستاذ المساعد")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "اخفاء البيانات المالية للمستخدم في حالة عدم وجود صلاحية اعداد المرتبات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة شراء الاصول  و تقرير الاصول" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" 	, "1.0.4.17")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة ارشفة  الاصول و ارشيف الاصول" )

	
END IF

Return
end subroutine

public subroutine of_1_0_4_18 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.18'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.18")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير البحث في بيانات المستخدمين" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.18")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة مدفوعات مورد")
	
END IF

Return
end subroutine

public subroutine of_1_0_4_19 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.19'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.19")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث تقرير بيانات المستخدمين" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.19")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة الحولات الى الشئون المالية" )
	
END IF

Return
end subroutine

public subroutine of_1_0_4_20 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.20'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.20")
	dw_1.SetItem( ll_row , "notes" 	, "أضافة تقرير متايعة تحويلات المخازن  في حركة الاصناف")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.20")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير حركة صنف الشاملة في شاشة حركة الاصناف الفعلية")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.20")
	dw_1.SetItem( ll_row , "notes" 	, "تفعيل شاشة توزيع الاصناف  في شاشة الجرد المادي")
	
END IF

Return
end subroutine

public subroutine of_1_0_4_21 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.21'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.21")
	dw_1.SetItem( ll_row , "notes" 	, "توسيع حقل الرصيد في تقرير حركة الخزينة" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.21")
	dw_1.SetItem( ll_row , "notes" 	, "المجموعة في تقرير الجرد المادي لمجموعة مخازن" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.21")
	dw_1.SetItem( ll_row , "notes" 	, "توسعة خانة المبلغ في تقرير حركة المقبوضات" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.21")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية عرض الاصناف المسعرة في المبيعات" )

END IF

Return
end subroutine

public subroutine of_1_0_4_22 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.22'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.22")
	dw_1.SetItem( ll_row , "notes" 	, "إضافة إمكانية البحث باستخدام ( الجنسية -  الحالة الاجتماعية ) في واجهة بيانات المستخدمين")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.22")
	dw_1.SetItem( ll_row , "notes" 	, "توفير إمكانية بحث عن المقبوضات التي تندرج تحت بند دفعة على الحساب و هو بند خاص بسداد الفواتير الآجلـــة  و من ثم ظهور نتيجة البحث في تقرير المقبوضات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.22")
	dw_1.SetItem( ll_row , "notes" 	, "تــطوير قائمة الاختصارات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.22")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل ستد القبض و عرض المتبقي من الفاتورة و تعديل العنوان من الرصيد الى ؤصيد الفاتورة")



END IF

Return
end subroutine

public subroutine of_1_0_4_23 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.23'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.23")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة رقم البصمة في بيانات المستخدمين")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.23")
	dw_1.SetItem( ll_row , "notes" 	, "فصل الاجازات عن بيانات المستخدمين")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.23")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية ارسال الفواتير عبر البريد الالكتروني مباشر من شاشة الطباعة")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.23")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة تحليل الحظور و الانصراف في الموارد البشرية")


END IF

Return
end subroutine

public subroutine of_1_0_4_24 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.24'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "تحديث البحث في القيزد اليومية")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة مراكزالتكلفة في ادارة الحسابات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة مراكز التكلفة في القيود اليومية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة العطلات الرسمية")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "اعدادات البريد الالكتروني الخاص بالشركة")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير حركة زبون" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير حركة الاصناف الفعلية")


	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.24")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير الجرد المادي الشامل")


END IF

Return
end subroutine

public subroutine of_1_0_4_25 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.25'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير الحوالات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	,"اضافة شريط التمرير عند اختيار المخزن في اذن الاستلام و إذن الصرف")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانة اختيار جميع المحازن في جميع تقارير الجرد")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة تحليل الحضور و الانصراف")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "تغير اسم شاشة تحليل الحضور و الانصراف الى تحليل الملف" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة جزء جديد لحساب خصوم المرتب حسب تحليل ملف البصمة" )


	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل شاشة صرف نقدية و اضافة امكانية ربط بند الصرف مع عهدة (تسوية العهد)" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.25")
	dw_1.SetItem( ll_row , "notes" 	, "تطويرالبحث في بنود الصرف في شاشة صرف نقدية")

END IF

Return
end subroutine

public subroutine of_1_0_4_26 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.26'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.26")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير الاجازات")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.26")
	dw_1.SetItem( ll_row , "notes" 	, "امكانية اضافة شركات في إدارة الحسابات" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.26")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل تقرير حركة الزبائن الشامل" )
	
END IF

Return
end subroutine

public subroutine of_1_0_4_27 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.27'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.27")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل شاشة الحوالات" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.27")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير عملية توريد القيود اليومية")
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.27")
	dw_1.SetItem( ll_row , "notes" 	, "اعادة ترتيب رسائل الاخطاء التى يعرضها النظام" )
	
	
END IF

Return
end subroutine

public subroutine of_1_0_4_28 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.28'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.28")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة ادارة المستخدمين" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.28")
	dw_1.SetItem( ll_row , "notes" 	, "توزيع الشركات على المستخدمين في ادارة الحسابات" )

END IF

Return
end subroutine

public subroutine of_1_0_4_29 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.29'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.29")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير خوارزمية التشفير" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.29")
	dw_1.SetItem( ll_row , "notes" 	, "ترتيب القيود في دليل الحسابات" )

END IF

Return
end subroutine

public subroutine of_1_0_4_30 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.30'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة رسائل ملاحظات عند رد قيد اليومية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة بعض الاختصارات في شاشة القيود اليومية للمساعدة في العمل")

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "تغير لون الخلفية للقيود الراجعة من المراقبة" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة بيع الاصول " )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "تغير اسم شاشة بيع الاصول الى استبعاد الاصول" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة حقل جديد في شاشة استبعاد  الاصول وهو سبب الاستبعاد" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.30")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة حركة الاصول في مشتريات الاصول" )

END IF

Return
end subroutine

public subroutine of_1_0_4_31 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.31'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "تعديل طريقة حساب عدد ايام الاجازة" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية اضافة صورة الوثائق في إذن صرف نقدية" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية اضافة صورة في القيود اليومية" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة امكانية اضافة صورة الوئائق في بيانات المستخدمين" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة استلام العهد" )
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة تسليم العهد" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.31")
	dw_1.SetItem( ll_row , "notes" 	, "تغير اسم تسليم العهد الى اقفال العهد" )


END IF

Return
end subroutine

public subroutine of_1_0_4_32 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.32'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.32")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقرير الموظفين" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.32")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقارير السلف" )
	

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.32")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقرير اشئون الادارية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.32")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير شاشة تحليل ملف البصمة" )


END IF

Return
end subroutine

public subroutine of_1_0_4_33 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.33'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.33")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقارير الشئون المالية" )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.33")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة مخالفة لعدم وجود بصمة في الدخول و الخروج" )
	

END IF

Return
end subroutine

public subroutine of_1_0_4_34 ();Long ll_row 

IF dw_1.Find(  "version = '1.0.4.34'", 1, dw_1.rowcount( ) ) = 0 THEN
	
	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.34")
	dw_1.SetItem( ll_row , "notes" 	, "تطوير تقرير دفتر الاستاذ " )

	ll_row = dw_1.insertrow( 0 )
	dw_1.SetItem( ll_row , "version" , "1.0.4.34")
	dw_1.SetItem( ll_row , "notes" 	, "اضافة تقرير الحضور و الانصراف في الموارد البشرية" )
	

END IF

Return
end subroutine

on w_appversion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_appversion.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.dw_1)
end on

type pb_1 from u_pb within w_appversion
integer x = 2866
integer y = 4
integer width = 110
integer height = 96
integer taborder = 10
string text = ""
string picturename = "C:\Applications\icons\hot\png\16x16\Cancel.png"
long backcolor = 67108864
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_1 from u_dw within w_appversion
integer y = 124
integer width = 2981
integer height = 1660
integer taborder = 10
string dataobject = "d_appversions"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;Long ll_row = 0

This.SetTransObject(SQLCA)
This.Retrieve( )

of_pre_versions()
of_1_0_3_84()
of_1_0_3_85()
of_1_0_3_86()
of_1_0_3_87()
of_1_0_3_88()
of_1_0_3_89()
of_1_0_3_90()
of_1_0_3_91()
of_1_0_3_92()
of_1_0_3_93()
of_1_0_3_94()
of_1_0_3_95()
of_1_0_3_96()
of_1_0_3_97()
of_1_0_3_98()
of_1_0_3_99()
of_1_0_4_0()
of_1_0_4_1()
of_1_0_4_2()
of_1_0_4_3()
of_1_0_4_4()
of_1_0_4_5()
of_1_0_4_6()
of_1_0_4_7()
of_1_0_4_8()
of_1_0_4_9()
of_1_0_4_10()
of_1_0_4_11()
of_1_0_4_12()
of_1_0_4_13()
of_1_0_4_14()
of_1_0_4_15()
of_1_0_4_16()
of_1_0_4_17()
of_1_0_4_18()
of_1_0_4_19()
of_1_0_4_20()
of_1_0_4_21()
of_1_0_4_22()
of_1_0_4_23()
of_1_0_4_24()
of_1_0_4_25()
of_1_0_4_26()
of_1_0_4_27()
of_1_0_4_28()
of_1_0_4_29()
of_1_0_4_30()
of_1_0_4_31()
of_1_0_4_32()
of_1_0_4_33()
of_1_0_4_34()
This.Update()

This.Retrieve( )
end event

event doubleclicked;call super::doubleclicked;Close(Parent)
end event

event clicked;call super::clicked;String ls_FilePath

if(row > 0)then
	ls_FilePath = gs_AppPath+This.GetItemString(row , "version")+".wmv"
	
	OpenWithParm(w_wmp,ls_FilePath)
	
end if
end event

