$PBExportHeader$nvo_security.sru
forward
global type nvo_security from n_base
end type
end forward

global type nvo_security from n_base
end type
global nvo_security nvo_security

type prototypes

end prototypes

type variables
DataStore ids_access_right
Long il_TotalRows

end variables

forward prototypes
public function integer of_checkaccessright (string as_transaction)
public function string of_serialnumber (string strrootpath)
public function string of_long2hex (long al_number, integer ai_digit)
public function boolean of_checkserialnoregistration (string as_serial_no)
public function integer of_registerserialno (string as_serial_no, string as_computername)
public function string of_getcomputername ()
public function string of_getcurrentipaddress ()
public subroutine of_setcomputername (string as_computername, string as_serial_no)
public function string of_real_hard_drive_serial_number ()
public function boolean of_checkserialnoregistration (string as_serial_no, long ar_branch_id)
public function string of_get_access_right_title (long ar_acid_row)
public function long of_get_branch_by_serial_no (string as_serial_no)
end prototypes

public function integer of_checkaccessright (string as_transaction);
return ids_access_right.find( "ACID="+as_transaction, 0 , il_TotalRows)
end function

public function string of_serialnumber (string strrootpath);String ls_volbuffer, ls_fsname, sReturn
unsignedlong   ll_MaxCompLength, ll_FileSystemFlags, ll_rtn,ll_serial
n_cst_kernel32 cs

cs = Create n_cst_kernel32

ll_rtn 					= 255
ls_volbuffer 			= Space(255)
ls_fsname 				= Space(255)
ll_maxCompLength 		= 0
ll_FileSystemFlags 	= 0

IF(cs.GetVolumeinformation( strrootpath&
, ls_volbuffer&
, ll_rtn&
, ll_serial&
, ll_MaxCompLength&
, ll_FileSystemFlags&
, ls_fsname&
, ll_rtn))Then
		return string(ll_serial)+'-'+gnv_services.of_remove_space(of_real_hard_drive_serial_number())
else
	return ""
end if

//ll_rtn = GetVolumeinformation(strrootpath , ls_volbuffer, 255, ll_serial, ll_MaxCompLength, ll_FileSystemFlags , ls_fsname, 255)
                      
//sReturn = of_long2hex(abs(ll_serial),8)
//return left(sReturn,4)+"-"+right(sReturn,4)
end function

public function string of_long2hex (long al_number, integer ai_digit);long ll_temp0, ll_temp1
char lc_ret
  
IF ai_digit > 0 THEN
    ll_temp0 = abs(al_number / (16 ^ (ai_digit - 1)))
    ll_temp1 = ll_temp0 * (16 ^ (ai_digit - 1))
    IF ll_temp0 > 9 THEN
        lc_ret = char(ll_temp0 + 55)
    ELSE
        lc_ret = char(ll_temp0 + 48)
    END IF
    RETURN lc_ret + of_long2hex(al_number - ll_temp1 , ai_digit - 1) 
END IF
RETURN ""
end function

public function boolean of_checkserialnoregistration (string as_serial_no);Long ll_count
String ls_branch_nm,ls_teamviewer_fg

SELECT count(*)
	INTO :ll_count 
	FROM SERIAL_NO
	WHERE HDSERIAL_NO = :as_serial_no and SUSPEND_FG = 'N';

SELECT TITLE,TV_FG
INTO :ls_branch_nm,:ls_teamviewer_fg
FROM SERIAL_NO left join 
BRANCH_CD on (SERIAL_NO.BRANCH_ID = BRANCH_CD.ID) 
WHERE HDSERIAL_NO = :as_serial_no and SUSPEND_FG = 'N';

IF IsNull(ls_branch_nm) THEN
	gstr_user_info.branch_nm = "الرئيسي"
else
	gstr_user_info.branch_nm = ls_branch_nm	
END IF


IF ll_count >= 1 Then 
	gstr_user_info.teamviewer = ls_teamviewer_fg
	Return True
else
	Return False
end if
end function

public function integer of_registerserialno (string as_serial_no, string as_computername);DataStore lds
Long ll_row

lds = Create DataStore
lds.DataObject = "d_serial_no"
lds.SetTRansObject( SQLCA )
lds.retrieve( )

if(lds.RowCount() >= Licenses )then return -200

ll_row = lds.insertRow(0)
lds.SetItem(ll_row , "HDSERIAL_NO" , as_serial_no)
lds.SetItem(ll_row , "COMPUTER_NM" , as_computername)
lds.update()

Commit;

return SQLCA.sqlcode
end function

public function string of_getcomputername ();String ls_system_name

RegistryGet( "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ComputerName", "ComputerName", RegString!, ls_system_name) 



return ls_system_name
end function

public function string of_getcurrentipaddress ();//DataStore lds
//
//lds.DataObject = "d_getcurrentip"
//lds.SetTransObject(SQLCA)
//if(lds.Retrieve( ) <= 0)Then Return ""
//
//Return lds.GetItemString(1 , "ip")
n_cst_wsock32 wsock

String ls_ip, ls_host
Blob{4} lb_host
unsignedinteger li_version, li_rc
str_wsadata lpwsadata

ls_host = Space(128)
li_version = 257

If wsock.WSAStartup(li_version, lpwsadata) = 0 Then
   If wsock.GetHostName(ls_host, Len(ls_host)) < 0 Then
      li_rc = wsock.WSAGetLastError()
   Else
      wsock.GetHost(ls_host, lb_host)
      ls_ip = String(Asc(String(BlobMid(lb_host, 1, 1)))) + "."
      ls_ip += String(Asc(String(BlobMid(lb_host, 2, 1)))) + "."
      ls_ip += String(Asc(String(BlobMid(lb_host, 3, 1)))) + "."
      ls_ip += String(Asc(String(BlobMid(lb_host, 4, 1))))
      li_rc = 0
   End If
   
Else
   li_rc = wsock.WSAGetLastError()
End If

wsock.WSACleanup()

return ls_ip

end function

public subroutine of_setcomputername (string as_computername, string as_serial_no);DataStore lds
Long ll_row

lds = Create DataStore
lds.DataObject = "d_serial_no"
lds.SetTRansObject( SQLCA )
lds.retrieve( )

lds.SetFilter("HDSERIAL_NO='"+as_serial_no+"' and title <> '"+as_computername+"'")
lds.filter()

if(lds.RowCount() <=0 )Then return

lds.SetItem(1 , "title" , as_computername)

lds.update()

Commit;

return 
end subroutine

public function string of_real_hard_drive_serial_number ();oleobject objWMIService
long ret
oleobject ddList
oleobject dd
int i
string str
string serial

objWMIService = create oleobject

ret =      objWMIService.ConnectToObject( "winmgmts:" )

ddList = objWMIService.ExecQuery ("SELECT * FROM Win32_PhysicalMedia ")
str=""
TRY

    dd = ddList.ItemIndex(0)
    serial = string(dd.SerialNumber )


CATCH( oleruntimeerror ex2)
	MessageBox("", ex2.description + ex2.text)
END TRY

ddList.disconnectobject( )

objWMIService.disconnectobject( )

return serial

end function

public function boolean of_checkserialnoregistration (string as_serial_no, long ar_branch_id);Long ll_count

SELECT count(*) 
	INTO :ll_count 
	FROM SERIAL_NO 
	WHERE HDSERIAL_NO = :as_serial_no and SUSPEND_FG = 'N' and BRANCH_ID = :ar_branch_id;
	
if(ll_count = 1)Then 
	return True
else
	return False
end if
end function

public function string of_get_access_right_title (long ar_acid_row);Return ids_access_right.describe("evaluate('lookupdisplay(acid)',"+String(ar_acid_row)+")")

end function

public function long of_get_branch_by_serial_no (string as_serial_no);Long ll_branch_id

SELECT IsNull(BRANCH_ID , 0)
INTO :ll_branch_id
FROM SERIAL_NO
WHERE HDSERIAL_NO = :as_serial_no and SUSPEND_FG = 'N';

return ll_branch_id
end function

on nvo_security.create
call super::create
end on

on nvo_security.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_access_right = Create DataStore
ids_access_right.dataobject = "d_access_right_fg"
ids_access_right.settransobject(SQLCA)
ids_access_right.retrieve(gstr_user_info.id)

il_TotalRows = ids_access_right.rowcount()
end event

event destructor;call super::destructor;Destroy ids_access_right
end event

