$PBExportHeader$w_send_email.srw
forward
global type w_send_email from w_response
end type
type pb_list from picturebutton within w_send_email
end type
type sle_cc from u_sle within w_send_email
end type
type st_5 from statictext within w_send_email
end type
type pb_2 from u_pb within w_send_email
end type
type pb_add from u_pb within w_send_email
end type
type st_4 from statictext within w_send_email
end type
type lb_attachments from listbox within w_send_email
end type
type st_3 from statictext within w_send_email
end type
type st_2 from statictext within w_send_email
end type
type st_1 from statictext within w_send_email
end type
type sle_subject from u_sle within w_send_email
end type
type sle_from from u_sle within w_send_email
end type
type mle_body from u_mle within w_send_email
end type
type pb_1 from u_pb within w_send_email
end type
type gb_1 from groupbox within w_send_email
end type
end forward

global type w_send_email from w_response
integer x = 214
integer y = 221
integer width = 2245
integer height = 1736
boolean righttoleft = true
pb_list pb_list
sle_cc sle_cc
st_5 st_5
pb_2 pb_2
pb_add pb_add
st_4 st_4
lb_attachments lb_attachments
st_3 st_3
st_2 st_2
st_1 st_1
sle_subject sle_subject
sle_from sle_from
mle_body mle_body
pb_1 pb_1
gb_1 gb_1
end type
global w_send_email w_send_email

type variables

str_pass_parmeters istr_parm
String is_type = ""
Private :
			String is_server
			String is_port
			String is_userid
			String is_password
			String is_smtp_auth
			String is_crypto

end variables

forward prototypes
public function string of_replace (string as_oldstring, string as_findstr, string as_replace)
public function boolean of_send_email (string as_client_nm, string as_subject, string as_task, string as_status, string as_contact_name[], string as_contact_email[], string as_reported_by)
end prototypes

public function string of_replace (string as_oldstring, string as_findstr, string as_replace);String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring

end function

public function boolean of_send_email (string as_client_nm, string as_subject, string as_task, string as_status, string as_contact_name[], string as_contact_email[], string as_reported_by);String ls_body, ls_server, ls_uid, ls_pwd
String ls_filename, ls_port
String ls_from_email , ls_from_name
String ls_to_email ,ls_to_name
Integer li_idx, li_max
Boolean lb_html, lb_Return
UInt lui_port
Long ll_retry , ll_itr

SetPointer(HourGlass!)

ls_server 		= trim(is_server)//"smtp.gmail.com"
ls_from_email	= trim(is_userid)//"info.bs.technology@gmail.com"

IF is_type = "pdf" THEN
	ls_from_name	= as_reported_by
ELSE
	ls_from_name	= "Blue Sky Technology"
END IF


ls_body = "<!DOCTYPE HTML PUBLIC '-//W3C//DTD XHTML 1.0 Transitional //EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>&
<html>&
<head>&
<title>&
</title>&
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>&
<style type='text/css'>&
/* Client-specific Styles */&
#outlook a { padding: 0; }	&
/* Force Outlook to provide a 'view in browser' button. */&
body {width: 100% !important; }.ReadMsgBody { width: 100%; }.ExternalClass { width: 100%; display:block !important;} &
/* Force Hotmail to display emails at full width */&
/* Reset Styles */&
/* Add 100px so mobile switch bar doesn't cover street address. */&
body { background-color: #ececec; margin: 0; padding: 0; }&
img { outline: none; text-decoration: none; display: block;}&
br, &
strong br, &
b br, &
em br, &
i br { line-height:100%; }h1, &
h2, h3, h4, h5, h6 { line-height: 100% !important; -webkit-font-smoothing: antialiased; }h1 a, &
h2 a, h3 a, h4 a, h5 a, h6 a { color: blue !important; }h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {	color: red !important; }&
/* Preferably not the same color as the normal header link color.  There is limited support for psuedo classes in email clients, this was added just for good measure. */&
h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited { color: purple !important; }&
/* Preferably not the same color as the normal header link color. There is limited support for psuedo classes in email clients, this was added just for good measure. */  &
table td, &
table tr { border-collapse: collapse; }.yshortcuts, .yshortcuts a, .yshortcuts a:link,.yshortcuts a:visited, .yshortcuts a:hover, .yshortcuts a span {color: black; text-decoration: none !important; border-bottom: none !important; background: none !important;}	&
/* Body text color for the New Yahoo.  This example sets the font of Yahoo's Shortcuts to black. */&
/* This most probably won't work in all email clients. Don't include <code _tmplitem='123' > blocks in email. */&
code {  white-space: normal;  word-break: break-all;}&
#background-table { background-color: #ececec; }&
/* Webkit Elements */&
#top-bar { border-radius:6px 6px 0px 0px; -moz-border-radius: 6px 6px 0px 0px; -webkit-border-radius:6px 6px 0px 0px; -webkit-font-smoothing: antialiased; background-color: #00386f; color: #f6faff; }&
#top-bar a { font-weight: bold; color: #f6faff; text-decoration: none;}&
#footer { border-radius:0px 0px 6px 6px; -moz-border-radius: 0px 0px 6px 6px; -webkit-border-radius:0px 0px 6px 6px; -webkit-font-smoothing: antialiased; }&
/* Fonts and Content */&
body, &
td { font-family: 'Helvetica Neue', Arial, Helvetica, Geneva, sans-serif; }.header-content, .footer-content-left, .footer-content-right { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; }&
/* Prevent Webkit and Windows Mobile platforms from changing default font sizes on header and footer. */&
.header-content { font-size: 12px; color: #f6faff; }.header-content a { font-weight: bold; color: #f6faff; text-decoration: none; }&
#headline p { color: #f6faff; font-family: 'Helvetica Neue', Arial, Helvetica, Geneva, sans-serif; font-size: 36px; text-align: center; margin-top:0px; margin-bottom:30px; }&
#headline p a { color: #f6faff; text-decoration: none; }.article-title { font-size: 18px; line-height:24px; color: #d9653b; font-weight:bold; margin-top:0px; margin-bottom:18px; font-family: 'Helvetica Neue', Arial, Helvetica, Geneva, sans-serif; }.article-title a { color: #d9653b; text-decoration: none; }.article-title.with-meta {margin-bottom: 0;}.article-meta { font-size: 13px; line-height: 20px; color: #ccc; font-weight: bold; margin-top: 0;}.article-content { font-size: 14px; line-height: 18px; color: #00386f; margin-top: 0px; margin-bottom: 18px; font-family: 'Helvetica Neue', Arial, Helvetica, Geneva, sans-serif; }.article-content a { color: #7f8c4f; font-weight:bold; text-decoration:none; }.article-content img { max-width: 100% }.article-content ol, .article-content ul { margin-top:0px; margin-bottom:18px; margin-left:19px; padding:0; }.article-content li { font-size: 13px; line-height: 18px; color: #00386f; }.article-content li a { color: #7f8c4f; text-decoration:underline; }.article-content p {margin-bottom: 15px;}.footer-content-left { font-size: 12px; line-height: 15px; color: #f6faff; margin-top: 0px; margin-bottom: 15px; }.footer-content-left a { color: #00386f; font-weight: bold; text-decoration: none; }.footer-content-right { font-size: 11px; line-height: 16px; color: #f6faff; margin-top: 0px; margin-bottom: 15px; }.footer-content-right a { color: #00386f; font-weight: bold; text-decoration: none; }&
#footer { background-color: #00386f; color: #f6faff; }&
#footer a { color: #00386f; text-decoration: none; font-weight: bold; }&
#permission-reminder { white-space: normal; }&
#street-address { color: #00386f; white-space: normal; }&
</style>&
</head>&
<body>&
<table id='background-table' border='0' cellpadding='0' cellspacing='0' width='100%'>	&
	<tbody>&
		<tr>&
			<td align='center' bgcolor='#ececec'>&
				<table class='w640' style='margin:0 10px;' border='0' cellpadding='0' cellspacing='0' width='640'>&
					<tbody>&
						<tr>&
							<td class='w640' height='20' width='640'></td>&
						</tr>&
						<tr>&
						<td class='w640' width='640'>&
							<table id='top-bar' class='w640' bgcolor='#00386f' border='0' cellpadding='0' cellspacing='0' width='640'>&
								<tbody>&
									<tr>&
										<td class='w325' height='8' width='350' align='left' colspan='5'></td>&
									</tr>&
									<tr>&
										<td class='w15' width='15'></td>&
										<td class='w325' align='left' valign='middle' width='350'>&
											<div class='header-content'><p>Blue Sky Technology</p></div>&
										</td>&
										<td class='w30' width='30'></td>&
										<td class='w255' align='right' valign='middle' width='255'></td>&
										<td class='w15' width='15'></td>&
									</tr>&
								</tbody>&
							</table>&
						</td>&
						</tr>&
						<tr>&
						<td id='header' class='w640' align='center' bgcolor='#00386f' width='640'>&
							<table class='w640' border='0' cellpadding='0' cellspacing='0' width='640'>&
								<tbody>&
									<tr>&
										<td class='w30' width='30'></td>&
										<td class='w580' height='30' width='580'></td>&
										<td class='w30' width='30'></td>&
									</tr>&
									<tr>&
									<td class='w30' width='30'></td>&
										<td class='w580' width='580'><div id='headline' align='center'><p>"+of_replace(as_client_nm, "~r~n", "<br>")+"</p></div></td>&
										<td class='w30' width='30'></td>&
									</tr>&
								</tbody>&
							</table>&
						</td>&
						</tr>&
						<tr><td class='w640' bgcolor='#ffffff' height='30' width='640'></td>&
						</tr>&
						<tr id='simple-content-row'>&
							<td class='w640' bgcolor='#ffffff' width='640'>&
								<table class='w640' border='0' cellpadding='0' cellspacing='0' width='640'>&
									<tbody>&
										<tr><td class='w30' width='30'></td>&
											<td class='w580' width='580'>&
												<table class='w580' border='0' cellpadding='0' cellspacing='0' width='580'>&
													<tbody>&
													<tr>&
														<td class='w580' width='580'>&
															<p class='article-content' align='center'></p>&
														</td>&
													</tr>&
														<tr>&
															<td class='w580' width='580'>&
																<p class='article-title' align='right'>"+of_replace(as_status, "~r~n", "<br>")+"</p>&
																<div class='article-content' align='right'>"+of_replace(as_task, "~r~n", "<br>")+"</div>&
															</td>&
														</tr>&
														<tr>&
															<td class='w580' height='10' width='580'>&
																<div class='article-content' align='left'>"+of_replace(as_reported_by, "~r~n", "<br>")+"</div>&
															</td>&
														</tr>&
													</tbody>&
												</table>&
											</td>&
											<td class='w30' width='30'></td>&
										</tr>&
									</tbody>&
								</table>&
							</td>&
						</tr>&
						<tr><td class='w640' bgcolor='#ffffff' height='15' width='640'></td>&
						</tr>&
						<tr>&
							<td class='w640' width='640'>&
								<table id='footer' class='w640' bgcolor='#4b4c44' border='0' cellpadding='0' cellspacing='0' width='640'>&
									<tbody>&
										<tr>&
											<td class='w30' height='10' width='30'></td>&
											<td class='w580' width='360'></td>&
											<td class='hide w0' width='60'></td>&
											<td class='hide w0' width='160'></td>&
											<td class='w30' width='30'></td>&
										</tr>&
									</tbody>&
								</table>&
							</td>&
						</tr>&
						<tr>&
							<td class='w640' height='60' width='640'></td>&
						</tr>&
					</tbody>&
				</table>&
			</td>&
		</tr>&
	</tbody>&
</table>&
</body>&
</html>"

lb_html = True

lui_port = Long(trim(is_port))//465 //587 

// *** set email properties *********************
gn_smtp.of_ResetAll()
gn_smtp.of_SetPort(lui_port)
gn_smtp.of_SetServer(ls_server)
gn_smtp.of_SetReceipt(False)
gn_smtp.of_SetLogFile(False, "smtp_logfile.txt")
gn_smtp.of_SetSubject(as_subject)
gn_smtp.of_SetBody(ls_body, lb_html)
gn_smtp.of_SetFrom(ls_from_email, ls_from_name)
gn_smtp.of_SetXMailer("Microsoft Outlook 14.0")

li_max = UPPERBOUND(as_contact_name)

IF is_type = "pdf" THEN
	
	FOR li_idx = 1 To li_max
		gn_smtp.of_AddAddress(as_contact_email[li_idx], as_contact_name[li_idx])
	NEXT

ELSE
	gn_smtp.of_AddAddress("bassam.mezoghi@outlook.com", "Bassam S.Mezoghi")
	FOR li_idx = 1 To li_max
		gn_smtp.of_AddAddress(as_contact_email[li_idx], as_contact_name[li_idx])
	NEXT
END IF


//// *** add any attachments **********************
li_max = lb_attachments.TotalItems()
For li_idx = 1 To li_max
	ls_filename = lb_attachments.Text(li_idx)
	gn_smtp.of_AddAttachment(ls_filename)
Next


IF trim(is_smtp_auth) = "Y" THEN
	ls_uid = trim(is_userid) //"info.bs.technology@gmail.com"
	ls_pwd = trim(is_password) //"M@sS@b77"
	gn_smtp.of_SetLogin(ls_uid, ls_pwd)
END IF

// *** send the message *************************
ll_retry = 5

Choose case trim(is_crypto)
	case "S"
		lb_Return = gn_smtp.of_SendSSLMail()
	case "T"
		lb_Return = gn_smtp.of_SendTLSMail()
	Case else
		lb_Return = gn_smtp.of_SendMail()
End Choose

DO WHILE Not lb_Return 

	Choose case trim(is_crypto)
		case "S"
			lb_Return = gn_smtp.of_SendSSLMail()
		case "T"
			lb_Return = gn_smtp.of_SendTLSMail()
		Case else
			lb_Return = gn_smtp.of_SendMail()
	End Choose
	ll_retry --
	IF ll_retry = 0 and NOT lb_Return THEN
		Return lb_Return
	END IF
LOOP 

Return lb_Return


end function

on w_send_email.create
int iCurrent
call super::create
this.pb_list=create pb_list
this.sle_cc=create sle_cc
this.st_5=create st_5
this.pb_2=create pb_2
this.pb_add=create pb_add
this.st_4=create st_4
this.lb_attachments=create lb_attachments
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_subject=create sle_subject
this.sle_from=create sle_from
this.mle_body=create mle_body
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_list
this.Control[iCurrent+2]=this.sle_cc
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.pb_add
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.lb_attachments
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.sle_subject
this.Control[iCurrent+12]=this.sle_from
this.Control[iCurrent+13]=this.mle_body
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.gb_1
end on

on w_send_email.destroy
call super::destroy
destroy(this.pb_list)
destroy(this.sle_cc)
destroy(this.st_5)
destroy(this.pb_2)
destroy(this.pb_add)
destroy(this.st_4)
destroy(this.lb_attachments)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_subject)
destroy(this.sle_from)
destroy(this.mle_body)
destroy(this.pb_1)
destroy(this.gb_1)
end on

event open;call super::open;DataStore ds
//n_cst_crypto lnv_crypt 

//lnv_crypt = CREATE n_cst_crypto 

istr_parm = Message.PowerObjectParm

IF Not IsValid(istr_parm) THEN
	
	sle_from.text = gnv_services.of_Company_name( )
	is_type = "support"
	
	st_5.text = ": نسخة الى"
	
ELSE
	
	IF UPPERBOUND(istr_parm.string_parm ) > 0 THEN
	
		sle_from.text = gstr_user_info.employee_name
		is_type = "pdf"
		pb_list.enabled = True
		sle_cc.enabled = False
		
		IF is_type = "pdf" THEN
			lb_attachments.AddItem(istr_parm.string_parm[2])
		END IF
	
	END IF
	
END IF



ds = CREATE Datastore
ds.DataObject = "d_email_settings"
ds.SetTransObject(SQLCA)
ds.Retrieve()

IF ds.RowCount() <= 0 THEN
	
	MessageBox("Error" , "Not Valid SMTP")
	Destroy ds;
	
	Close(This)
	
END IF

is_server 		= ds.GetitemString(1 , "string_val")
is_port			= String(ds.GetitemNumber(1 , "int_val"))
is_userid 		= ds.GetItemString(2 , "string_val")
is_password 	= gnv_services.of_decrypt(ds.GetItemString(3 , "string_val")) //lnv_crypt.decryptdata(  , lnv_crypt.of_getmykey( ))
is_smtp_auth 	= ds.GetItemString(1 , "char_val")
is_crypto		= ds.GetItemString(2 , "char_val") 
		
Destroy ds;
//Destroy lnv_crypt;
	

end event

type pb_list from picturebutton within w_send_email
integer x = 87
integer y = 216
integer width = 128
integer height = 112
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\Applications\icons\hot\png\20x20\Conference.png"
string disabledname = "C:\Applications\icons\disabled\png\20x20\Conference.png"
alignment htextalign = left!
end type

event clicked;Long ll_row , ll_RowCount

sle_cc.text = ""

//OpenWithParm( w_search_employees_email_list , istr_parm )	

istr_parm = Message.PowerObjectParm

ll_RowCount = Upperbound( istr_parm.String_parm )

FOR ll_row = 1 To ll_RowCount
	
	sle_cc.text = istr_parm.string_parm[ll_row]
	
	ll_row++
	
	sle_cc.text += " <"+istr_parm.string_parm[ll_row]+">;"
	
NEXT




end event

type sle_cc from u_sle within w_send_email
integer x = 219
integer y = 224
integer width = 1659
integer height = 96
integer taborder = 20
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
end type

type st_5 from statictext within w_send_email
integer x = 1906
integer y = 236
integer width = 293
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": الى"
boolean focusrectangle = false
end type

type pb_2 from u_pb within w_send_email
integer x = 1545
integer y = 1244
integer width = 146
integer height = 128
integer taborder = 60
string text = ""
string picturename = "C:\Applications\icons\hot\png\24x24\Erase.png"
end type

event clicked;call super::clicked;// delete attachment

Integer li_row

li_row = lb_attachments.SelectedIndex()

If li_row > 0 Then
	FileDelete(gs_AppPath + lb_attachments.selecteditem( ))
	lb_attachments.DeleteItem(li_row)
End If

end event

type pb_add from u_pb within w_send_email
integer x = 1705
integer y = 1244
integer width = 146
integer height = 128
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "C:\Applications\icons\hot\png\24x24\Add.png"
end type

event clicked;call super::clicked;String ls_pathname, ls_filename, ls_filter
Integer li_rc

ls_filter = "All files,*.*"

li_rc = GetFileOpenName("Select File to Attach", &
		ls_pathname, ls_filename, "", ls_filter)

If li_rc = 1 Then
	//FileCopy(ls_pathname , gs_AppPath+ls_filename,True)
	lb_attachments.AddItem(ls_pathname)
End If
end event

type st_4 from statictext within w_send_email
integer x = 1906
integer y = 932
integer width = 283
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": مرفقات"
boolean focusrectangle = false
end type

type lb_attachments from listbox within w_send_email
integer x = 82
integer y = 936
integer width = 1787
integer height = 296
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_send_email
integer x = 1906
integer y = 488
integer width = 283
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": الرسالة"
boolean focusrectangle = false
end type

type st_2 from statictext within w_send_email
integer x = 1906
integer y = 372
integer width = 283
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": العنوان"
boolean focusrectangle = false
end type

type st_1 from statictext within w_send_email
integer x = 1906
integer y = 104
integer width = 283
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = ": المرسل"
boolean focusrectangle = false
end type

type sle_subject from u_sle within w_send_email
integer x = 82
integer y = 364
integer width = 1801
integer height = 96
integer taborder = 30
integer textsize = -10
fontcharset fontcharset = arabiccharset!
string facename = "Arial"
boolean righttoleft = true
end type

type sle_from from u_sle within w_send_email
integer x = 82
integer y = 92
integer width = 1801
integer height = 96
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 67108864
boolean displayonly = true
boolean righttoleft = true
end type

type mle_body from u_mle within w_send_email
integer x = 82
integer y = 500
integer width = 1797
integer height = 404
integer taborder = 40
integer textsize = -10
fontcharset fontcharset = arabiccharset!
string facename = "Arial"
boolean righttoleft = true
end type

type pb_1 from u_pb within w_send_email
integer x = 9
integer y = 1408
integer width = 256
integer height = 224
integer taborder = 70
string text = ""
boolean originalsize = false
string picturename = "C:\Applications\icons\hot\png\32x32\Mail.png"
end type

event clicked;call super::clicked;str_pass_parmeters lstr_parm 
Long ll_row , ll_RowCount ,ll_itr
Boolean lb_Return
string as_contact_email[]
string as_contact_name[]


IF is_type = "pdf" THEN
	
	IF istr_parm.string_parm[1] <> "-1" THEN
		
		ll_RowCount = Upperbound( istr_parm.String_parm )
		ll_row = 1
		
		FOR ll_itr = 1 To ll_RowCount
			as_contact_name[ll_row] 	= istr_parm.string_parm[ll_itr]
			ll_itr++
			as_contact_email[ll_row] 	= istr_parm.string_parm[ll_itr]
			ll_row++
		NEXT
		
	END IF
	
	IF sle_cc.text = "" THEN
		
		MessageBox("تنبيه" , "يحب اختيار بريد المرسل اليه")
		sle_cc.SetFocus( )
		Return
		
	END IF
END IF


lb_Return = of_send_email( gnv_services.of_Company_name( ) &
										, sle_subject.text  /*string as_subject*/&
										, mle_body.text     /*string as_task*/&
										, ""                /*string as_status*/&
										, as_contact_name[] /*string as_contact_name[]*/&
										, as_contact_email[]/*string as_contact_email[]*/&
										, gstr_user_info.employee_name/*string as_reported_by */)

IF lb_Return THEN
	MessageBox("تنبيه", "تم ارسال الرسالة بنجاح")
ELSE
	MessageBox("Error", gn_smtp.of_getlastsmtperror( ) ) 
END IF

end event

type gb_1 from groupbox within w_send_email
integer x = 18
integer width = 2203
integer height = 1392
integer taborder = 90
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "بيانات الرسالة"
boolean righttoleft = true
end type

