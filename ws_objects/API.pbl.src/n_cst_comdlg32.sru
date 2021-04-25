$PBExportHeader$n_cst_comdlg32.sru
forward
global type n_cst_comdlg32 from nonvisualobject
end type
end forward

global type n_cst_comdlg32 from nonvisualobject
event setupdlg pbm_custom01
end type
global n_cst_comdlg32 n_cst_comdlg32

type prototypes
Function ulong CommDlgExtendedError() Library "COMDLG32.DLL"
Function boolean ChooseColor(ref CHOOSECOLOR lpcc) Library "COMDLG32.DLL" Alias For "ChooseColorA;Ansi"
Function boolean ChooseFont(ref CHOOSEFONT lpcf) Library "COMDLG32.DLL" Alias For "ChooseFontA;Ansi"
Function boolean GetOpenFileName(ref OPENFILENAME lpofn) Library "COMDLG32.DLL" Alias For "GetOpenFileNameA;Ansi"
Function boolean GetSaveFileName(ref OPENFILENAME lpofn) Library "COMDLG32.DLL" Alias For "GetSaveFileNameA;Ansi"
Function boolean PrintDlg(ref PRINTDLG lppd) Library "COMDLG32.DLL" Alias For "PrintDlgA;Ansi"
//Function boolean PageSetupDlg(ref LPPAGESETUPDLG lppsd) Library "COMDLG32.DLL" Alias For "PageSetupDlgA"
//Function integer GetFileTitle(ref string lpszFile, ref string lpszTitle, ulong cbBuf) Library "COMDLG32.DLL" Alias For "GetFileTitleA"
end prototypes

type variables
Protectedwrite CONSTANT ulong MAX_PATH = 255

//////Colors constants ////////////////
Protectedwrite CONSTANT ulong CC_ENABLEHOOK 					= 16 	//&H10
Protectedwrite CONSTANT ulong CC_ANYCOLOR 					= 256	//&H100
Protectedwrite CONSTANT ulong CC_ENABLETEMPLATE 			= 32 	//&H20
Protectedwrite CONSTANT ulong CC_ENABLETEMPLATEHANDLE 	= 64 	//&H40
Protectedwrite CONSTANT ulong CC_FULLOPEN 					= 2 	//&H2
Protectedwrite CONSTANT ulong CC_PREVENTFULLOPEN 			= 4 	//&H4
Protectedwrite CONSTANT ulong CC_RGBINIT 						= 1 	//&H1
Protectedwrite CONSTANT ulong CC_SHOWHELP 					= 8	//&H8
Protectedwrite CONSTANT ulong CC_SOLIDCOLOR 					= 128 //&H80

///// Fonts constants //////////////////////
Protectedwrite CONSTANT ulong CF_ANSIONLY = 1024 //&H400&
Protectedwrite CONSTANT ulong CF_APPLY = 512 //&H200&
Protectedwrite CONSTANT ulong CF_DIB = 8
Protectedwrite CONSTANT ulong CF_DIF = 5
Protectedwrite CONSTANT ulong CF_DSPBITMAP = 130  //&H82
Protectedwrite CONSTANT ulong CF_DSPENHMETAFILE = 142 //&H8E
Protectedwrite CONSTANT ulong CF_DSPMETAFILEPICT = 131 //&H83
Protectedwrite CONSTANT ulong CF_DSPTEXT = 129 //&H81
Protectedwrite CONSTANT ulong CF_EFFECTS = 256 //&H100&
Protectedwrite CONSTANT ulong CF_ENABLEHOOK = 8 //&H8&
Protectedwrite CONSTANT ulong CF_ENABLETEMPLATE = 16 //&H10&
Protectedwrite CONSTANT ulong CF_ENABLETEMPLATEHANDLE = 32 //&H20&
Protectedwrite CONSTANT ulong CF_ENHMETAFILE = 14
Protectedwrite CONSTANT ulong CF_FIXEDPITCHONLY = 16384 //&H4000&
Protectedwrite CONSTANT ulong CF_FORCEFONTEXIST = 65536 //&H10000
Protectedwrite CONSTANT ulong CF_GDIOBJFIRST = 768 //&H300
Protectedwrite CONSTANT ulong CF_GDIOBJLAST = 1023 //&H3FF
Protectedwrite CONSTANT ulong CF_INITTOLOGFONTSTRUCT = 64 //&H40&
Protectedwrite CONSTANT ulong CF_LIMITSIZE = 8192 //&H2000&
Protectedwrite CONSTANT ulong CF_METAFILEPICT = 3
Protectedwrite CONSTANT ulong CF_NOFACESEL = 524288 //&H80000
Protectedwrite CONSTANT ulong CF_NOSCRIPTSEL = 8388608 //&H800000
Protectedwrite CONSTANT ulong CF_NOSIMULATIONS = 4096 //&H1000&
Protectedwrite CONSTANT ulong CF_NOSIZESEL = 2097152 //&H200000
Protectedwrite CONSTANT ulong CF_NOSTYLESEL = 1048576 //&H100000
Protectedwrite CONSTANT ulong CF_NOVECTORFONTS = 2048 //&H800&
Protectedwrite CONSTANT ulong CF_NOVERTFONTS = 16777216 //&H1000000
Protectedwrite CONSTANT ulong CF_OWNERDISPLAY = 128 //&H80
Protectedwrite CONSTANT ulong CF_OEMTEXT = 7
Protectedwrite CONSTANT ulong CF_PALETTE = 9
Protectedwrite CONSTANT ulong CF_PENDATA = 10
Protectedwrite CONSTANT ulong CF_PRINTERFONTS = 2 //&H2
Protectedwrite CONSTANT ulong CF_PRIVATEFIRST = 512 //&H200
Protectedwrite CONSTANT ulong CF_PRIVATELAST = 767 //&H2FF
Protectedwrite CONSTANT ulong CF_RIFF = 11
Protectedwrite CONSTANT ulong CF_SCALABLEONLY = 131072 //&H20000
Protectedwrite CONSTANT ulong CF_SCREENFONTS = 1 //&H1
Protectedwrite CONSTANT ulong CF_SELECTSCRIPT = 4194304 //&H400000
Protectedwrite CONSTANT ulong CF_SHOWHELP = 4 //&H4&
Protectedwrite CONSTANT ulong CF_SYLK = 4
Protectedwrite CONSTANT ulong CF_TEXT = 1
Protectedwrite CONSTANT ulong CF_TIFF = 6
Protectedwrite CONSTANT ulong CF_TTONLY = 262144 //&H40000
Protectedwrite CONSTANT ulong CF_UNICODETEXT = 13
Protectedwrite CONSTANT ulong CF_USESTYLE = 128 //&H80&
Protectedwrite CONSTANT ulong CF_WAVE = 12
Protectedwrite CONSTANT ulong CF_WYSIWYG = 32768 //&H8000 '  must also have CF_SCREENFONTS CF_PRINTERFONTS
Protectedwrite CONSTANT ulong CF_BOTH = (CF_SCREENFONTS + CF_PRINTERFONTS)
Protectedwrite CONSTANT ulong CF_SCRIPTSONLY = CF_ANSIONLY
Protectedwrite CONSTANT ulong CF_NOOEMFONTS = CF_NOVECTORFONTS

Protectedwrite CONSTANT ulong BOLD_FONTTYPE = 256 //&H100
Protectedwrite CONSTANT ulong ITALIC_FONTTYPE = 512 //&H200
Protectedwrite CONSTANT ulong PRINTER_FONTTYPE = 16384 //&H4000
Protectedwrite CONSTANT ulong REGULAR_FONTTYPE = 1024 //&H400
Protectedwrite CONSTANT ulong SCREEN_FONTTYPE = 8192 //&H2000
Protectedwrite CONSTANT ulong SIMULATED_FONTTYPE = 32768 //&H8000

/////// File Constants /////////////
Protectedwrite CONSTANT long OFN_NOLONGNAMES = 262144 //&H40000                      
Protectedwrite CONSTANT long OFN_NONETWORKBUTTON = 131072 //&H20000
Protectedwrite CONSTANT long OFN_NOREADONLYRETURN = 32768 //&H8000
Protectedwrite CONSTANT long OFN_NOTESTFILECREATE = 65536 //&H10000
Protectedwrite CONSTANT long OFN_READONLY = 1 //&H1
Protectedwrite CONSTANT long OFN_OVERWRITEPROMPT = 2 //&H2
Protectedwrite CONSTANT long OFN_HIDEREADONLY = 4 //&H4
Protectedwrite CONSTANT long OFN_NOCHANGEDIR = 8 //&H8
Protectedwrite CONSTANT long OFN_SHOWHELP = 16 //&H10
Protectedwrite CONSTANT long OFN_ENABLEHOOK = 32 //&H20
Protectedwrite CONSTANT long OFN_ENABLETEMPLATE = 64 //&H40
Protectedwrite CONSTANT long OFN_ENABLETEMPLATEHANDLE = 128 //&H80
Protectedwrite CONSTANT long OFN_NOVALIDATE = 256 //&H100
Protectedwrite CONSTANT long OFN_EXTENSIONDIFFERENT = 1024 //&H400
Protectedwrite CONSTANT long OFN_PATHMUSTEXIST = 2048 //&H800
Protectedwrite CONSTANT long OFN_FILEMUSTEXIST = 4096 //&H1000
Protectedwrite CONSTANT long OFN_CREATEPROMPT = 8192 //&H2000
Protectedwrite CONSTANT long OFN_SHAREAWARE = 16384 //&H4000
Protectedwrite CONSTANT long OFN_NODEREFERENCELINKS = 1048576 //&H100000
Protectedwrite CONSTANT long OFN_LONGNAMES = 2097152 //&H200000                       
Protectedwrite CONSTANT long OFN_SHARENOWARN = 1
Protectedwrite CONSTANT long OFN_SHAREFALLTHROUGH = 2
Protectedwrite CONSTANT long OFN_SHAREWARN = 0

// Variables de error
Protectedwrite CONSTANT ulong CDERR_FINDRESFAILURE = 6 // &H6
Protectedwrite CONSTANT ulong CDERR_INITIALIZATION = 2 //&H2
Protectedwrite CONSTANT ulong CDERR_LOCKRESFAILURE = 8//&H8
Protectedwrite CONSTANT ulong CDERR_LOADRESFAILURE = 7 //&H7
Protectedwrite CONSTANT ulong CDERR_LOADSTRFAILURE = 5 //&H5
Protectedwrite CONSTANT ulong CDERR_MEMALLOCFAILURE = 9//&H9
Protectedwrite CONSTANT ulong CDERR_MEMLOCKFAILURE = 10 //&HA
Protectedwrite CONSTANT ulong CDERR_NOHINSTANCE = 4 //&H4
Protectedwrite CONSTANT ulong CDERR_NOHOOK = 11 //&HB
Protectedwrite CONSTANT ulong CDERR_NOTEMPLATE = 3 //&H3
Protectedwrite CONSTANT ulong CDERR_STRUCTSIZE = 1 //&H1
Protectedwrite CONSTANT ulong CFERR_MAXLESSTHANMIN = 8194 //&H2002
Protectedwrite CONSTANT ulong CFERR_NOFONTS = 8193 //&H2001

CONSTANT ulong WM_USER = 1024 //&H400
CONSTANT ulong WM_APP = 32768 //&H8000

CONSTANT ulong pbm_custom01 = WM_USER + 0
CONSTANT ulong pbm_custom02 = WM_USER + 1
CONSTANT ulong pbm_custom03 = WM_USER + 2
CONSTANT ulong pbm_custom04 = WM_USER + 3
CONSTANT ulong pbm_custom05 = WM_USER + 4
CONSTANT ulong pbm_custom06 = WM_USER + 5
CONSTANT ulong pbm_custom07 = WM_USER + 6
CONSTANT ulong pbm_custom08 = WM_USER + 7
CONSTANT ulong pbm_custom09 = WM_USER + 8
CONSTANT ulong pbm_custom10 = WM_USER + 9
CONSTANT ulong pbm_custom11 = WM_USER + 10
CONSTANT ulong pbm_custom12 = WM_USER + 11
CONSTANT ulong pbm_custom13 = WM_USER + 12
CONSTANT ulong pbm_custom14 = WM_USER + 13
CONSTANT ulong pbm_custom15 = WM_USER + 14
CONSTANT ulong pbm_custom16 = WM_USER + 15
CONSTANT ulong pbm_custom17 = WM_USER + 16
CONSTANT ulong pbm_custom18 = WM_USER + 17
CONSTANT ulong pbm_custom19 = WM_USER + 18
CONSTANT ulong pbm_custom20 = WM_USER + 19
CONSTANT ulong pbm_custom21 = WM_USER + 20
CONSTANT ulong pbm_custom22 = WM_USER + 21
CONSTANT ulong pbm_custom23 = WM_USER + 23
CONSTANT ulong pbm_custom24 = WM_USER + 24
CONSTANT ulong pbm_custom25 = WM_USER + 25
CONSTANT ulong pbm_custom26 = WM_USER + 26
CONSTANT ulong pbm_custom27 = WM_USER + 27
CONSTANT ulong pbm_custom28 = WM_USER + 28
CONSTANT ulong pbm_custom29 = WM_USER + 29
CONSTANT ulong pbm_custom31 = WM_USER + 30
CONSTANT ulong pbm_custom32 = WM_USER + 31
CONSTANT ulong pbm_custom33 = WM_USER + 32
CONSTANT ulong pbm_custom34 = WM_USER + 33
CONSTANT ulong pbm_custom35 = WM_USER + 34
CONSTANT ulong pbm_custom36 = WM_USER + 35
CONSTANT ulong pbm_custom37 = WM_USER + 36
CONSTANT ulong pbm_custom38 = WM_USER + 37
CONSTANT ulong pbm_custom39 = WM_USER + 38
CONSTANT ulong pbm_custom40 = WM_USER + 39
CONSTANT ulong pbm_custom41 = WM_USER + 40
CONSTANT ulong pbm_custom42 = WM_USER + 41
CONSTANT ulong pbm_custom43 = WM_USER + 42
CONSTANT ulong pbm_custom44 = WM_USER + 43
CONSTANT ulong pbm_custom45 = WM_USER + 44
CONSTANT ulong pbm_custom46 = WM_USER + 45
CONSTANT ulong pbm_custom47 = WM_USER + 46
CONSTANT ulong pbm_custom48 = WM_USER + 47
CONSTANT ulong pbm_custom49 = WM_USER + 48
CONSTANT ulong pbm_custom50 = WM_USER + 49
CONSTANT ulong pbm_custom51 = WM_USER + 50
CONSTANT ulong pbm_custom52 = WM_USER + 51
CONSTANT ulong pbm_custom53 = WM_USER + 52
CONSTANT ulong pbm_custom54 = WM_USER + 53
CONSTANT ulong pbm_custom55 = WM_USER + 54
CONSTANT ulong pbm_custom56 = WM_USER + 55
CONSTANT ulong pbm_custom57 = WM_USER + 56
CONSTANT ulong pbm_custom58 = WM_USER + 57
CONSTANT ulong pbm_custom59 = WM_USER + 58
CONSTANT ulong pbm_custom60 = WM_USER + 59
CONSTANT ulong pbm_custom61 = WM_USER + 60
CONSTANT ulong pbm_custom62 = WM_USER + 61
CONSTANT ulong pbm_custom63 = WM_USER + 62
CONSTANT ulong pbm_custom64 = WM_USER + 63
CONSTANT ulong pbm_custom65 = WM_USER + 64
CONSTANT ulong pbm_custom66 = WM_USER + 65
CONSTANT ulong pbm_custom67 = WM_USER + 66 
CONSTANT ulong pbm_custom68 = WM_USER + 67
CONSTANT ulong pbm_custom69 = WM_USER + 68
CONSTANT ulong pbm_custom70 = WM_USER + 69
CONSTANT ulong pbm_custom71 = WM_USER + 70
CONSTANT ulong pbm_custom72 = WM_USER + 71
CONSTANT ulong pbm_custom73 = WM_USER + 72
CONSTANT ulong pbm_custom74 = WM_USER + 73

//Privadas de uso en otras funciones
Private:
CONSTANT long OFN_ALLOWMULTISELECT = 512 //&H200
CONSTANT long OFN_EXPLORER = 524288 //&H80000
// PrintDlg constants //
CONSTANT ulong PD_ALLPAGES = 0 //&H0
CONSTANT ulong PD_COLLATE = 16 //&H10
CONSTANT ulong PD_DISABLEPRINTTOFILE = 524288 //&H80000
CONSTANT ulong PD_ENABLEPRINTHOOK = 4096 //&H1000
CONSTANT ulong PD_ENABLEPRINTTEMPLATE = 16384 //&H4000
CONSTANT ulong PD_ENABLEPRINTTEMPLATEHANDLE = 65536 //&H10000
CONSTANT ulong PD_ENABLESETUPHOOK =  8192 //&H2000
CONSTANT ulong PD_ENABLESETUPTEMPLATE = 32768 //&H8000
CONSTANT ulong PD_ENABLESETUPTEMPLATEHANDLE = 131072 //&H20000
CONSTANT ulong PD_HIDEPRINTTOFILE = 1048576 //&H100000
CONSTANT ulong PD_NONETWORKBUTTON = 2097152 //&H200000
CONSTANT ulong PD_NOPAGENUMS =  8 //&H8
CONSTANT ulong PD_NOSELECTION = 4 //&H4
CONSTANT ulong PD_PAGENUMS = 2 //&H2
CONSTANT ulong PD_NOWARNING = 128 //&H80
CONSTANT ulong PD_PRINTSETUP = 64 //&H40
CONSTANT ulong PD_PRINTTOFILE = 32 //&H20
CONSTANT ulong PD_RETURNDC = 256 //&H100
CONSTANT ulong PD_RETURNDEFAULT = 1024 //&H400
CONSTANT ulong PD_RETURNIC = 512 //&H200
CONSTANT ulong PD_SELECTION = 1 //&H1
CONSTANT ulong PD_SHOWHELP = 2048 //&H800
CONSTANT ulong PD_USEDEVMODECOPIES = 262144 //&H40000
CONSTANT ulong PD_USEDEVMODECOPIESANDCOLLATE = 262144 //&H40000

CONSTANT ulong WM_INITDIALOG = 272                 //0x0110
CONSTANT ulong WM_COMMAND = 273                    //0x0111
CONSTANT ulong WM_SYSCOMMAND = 274                 //0x0112
CONSTANT ulong WM_TIMER = 275                      //0x0113
CONSTANT ulong WM_HSCROLL = 276                    //0x0114
CONSTANT ulong WM_VSCROLL = 277                    //0x0115
CONSTANT ulong WM_INITMENU = 278                   //0x0116
CONSTANT ulong WM_INITMENUPOPUP = 279              //0x0117
CONSTANT ulong WM_MENUSELECT = 287                 //0x011F
CONSTANT ulong WM_MENUCHAR = 288                   //0x0120
CONSTANT ulong WM_ENTERIDLE = 289                  //0x0121

CONSTANT long GWL_WNDPROC = (-4)
CONSTANT long GWL_HINSTANCE = (-6)
CONSTANT long GWL_HWNDPARENT = (-8)
CONSTANT long GWL_STYLE = (-16)
CONSTANT long GWL_EXSTYLE = (-20)
CONSTANT long GWL_USERDATA = (-21)
CONSTANT long GWL_ID = (-12)

logfont log
custcolors colors

Public:
// Variables para color
ulong rgbresult

// Variables para fuentes
long FontWidth 
long FontEscapement 
long FontOrientation 
long FontWeight 
boolean FontItalic 
boolean FontUnderline 
boolean FontStrikeOut 
int FontCharSet 
int FontOutPrecision 
int FontClipPrecision 
int FontQuality 
int FontPitchAndFamily 
string FontFaceName
ulong FontColor
long FontTextSize

//Variables para impresora
boolean PDTodasLasPaginas
boolean PDIntercalarCopias
boolean PDDeshabilitaArchivo
boolean PDOcultaCasillaArchivo 
boolean PDSinBotonDeRed
boolean PDDeshabilitaRadioDePaginas
boolean PDDeshabilitaRadioDeSeleccion
boolean PDSinMensajesDeAviso
integer PDSeleccion
boolean PDActivaConfiguracionesDeImpresora
boolean PDRetornaContextoDC
boolean PDChequeaCasillaArchivo
boolean PDRetornaContextoIC
boolean PDMuestraBotonDeAyuda
boolean PDSetCopiasIntercaldoSobreDispositivo
unsignedinteger PDPaginaDesde
unsignedinteger PDPaginaHasta
unsignedinteger PDRangoMinimo
unsignedinteger PDRangoMaximo
unsignedinteger PDCopias
protectedwrite string PDNombreImpresora


Protectedwrite ulong DC
Protectedwrite CONSTANT unsignedinteger max_pag = 34463
Protectedwrite CONSTANT unsignedinteger max_cop = 9999
end variables

forward prototypes
public function integer nombrearchivograbar (unsignedlong hwnd, string title, ref string pathname[], ref string filename[], string filter, string initialdirectory, boolean multiselect, boolean explorer, long flags)
public function integer nombrearchivoabrir (unsignedlong hwnd, string title, ref string pathname[], ref string filename[], string filter, string initialdirectory, boolean multiselect, boolean explorer, long flags)
public function boolean seleccionarfuente (unsignedlong hwnd)
public function boolean seleccionarcolor (unsignedlong hwnd)
public function boolean impresora (unsignedlong hwnd)
end prototypes

event setupdlg;messagebox("hook setupprintdlg", string(wparam) + " " + string(lparam) )
end event

public function integer nombrearchivograbar (unsignedlong hwnd, string title, ref string pathname[], ref string filename[], string filter, string initialdirectory, boolean multiselect, boolean explorer, long flags);openfilename	ofn
blob				lblb_filter
blob				lblb_filename
blob				lblb_filetitle
double			li_pos, li_len, li_count
uint				li_rc
string			ls_pathname
string			ls_filename
string			ls_null[]

if isnull(hwnd) then
	return -1
end if

ofn.lstructsize   = 76
ofn.hwdowner = 0
ofn.hinstance   = 0

lblb_filter = blob (filter + space(1))
li_pos = PosA ( filter, ',' )
DO WHILE li_pos > 0
	blobedit ( lblb_filter, li_pos, CharA(0))
	li_pos = PosA ( filter, ',', li_pos + 1 )
LOOP
blobedit (lblb_filter,LenA(lblb_filter),CharA(0))
ofn.lpstrfilter = lblb_filter
	
setnull( ofn.lpstrcustomfilter )
ofn.nmaxcustfilter  = 0
ofn.nfilterindex  = 1

if multiselect then					  	
	ofn.nmaxfile = 2048000
	ofn.lpstrfile = blob (space(2047990))
else
	ofn.nmaxfile = 25600
	ofn.lpstrfile = blob (space(25590))
end if
ls_pathname += Space (ofn.nmaxfile)
blobedit(ofn.lpstrfile,1,CharA(0))

ofn.nmaxfiletitle  = 138
ls_filename = filename[1]
ls_filename += Space ( ofn.nmaxfiletitle - LenA ( filename[1]) - 10 ) 
lblb_filetitle = blob (ls_filename)
blobedit(lblb_filetitle,(LenA(filename[1])+1),CharA(0))
ofn.lpstrfiletitle = lblb_filetitle

ofn.lpstrinitialdir = initialdirectory
ofn.lpstrtitle = title

IF multiselect THEN
	flags += OFN_ALLOWMULTISELECT
END IF

IF explorer THEN
	flags += OFN_EXPLORER
END IF

ofn.flags   = flags

//ofn.nfileoffset   = 0
//ofn.nfileextension  = 0
ofn.lpstrdefext   = ''
//ofn.lcustdata   = 0
//ofn.lpfnhook   = 0
//ofn.lptemplatename  = ''

IF NOT this.GetSaveFileName (ofn) THEN
	li_rc = CommDlgExtendedError()
	if li_rc > 0 then
		messagebox ("Error interno", "Error N؛ " + string(li_rc))
	end if
	return li_rc
ELSE
	setpointer(hourglass!)
	IF multiselect THEN
		IF explorer THEN
			//For explorer, the first element is the directory, the rest are the filenames
			//and then are null seperated
			ls_pathname = Trim ( String ( ofn.lpstrfile ) )
			li_len = LenA ( ls_pathname )
			ofn.lpstrfile = BlobMid ( ofn.lpstrfile, li_len + 2 )
			ls_filename = Trim ( String ( ofn.lpstrfile ) )
			li_len = LenA ( ls_filename )
			filename[] = ls_null[]
			li_count = 0
			DO WHILE li_len > 0
				filename[UpperBound(filename)+1] = ls_filename
				pathname[UpperBound(pathname)+1] = ls_pathname + '\' + ls_filename
				ofn.lpstrfile = BlobMid ( ofn.lpstrfile, li_len + 2 )
				ls_filename = Trim ( String ( ofn.lpstrfile ) )
				li_len = LenA ( ls_filename )
				li_count++
			LOOP
			if li_count = 0 then
				if LenA(ls_pathname) > 0 then
					ls_filename = trim ( string( ofn.lpstrfiletitle ) )
					filename[UpperBound(filename)+1] = ls_filename
					pathname[UpperBound(pathname)+1] = ls_pathname
				end if	
			end if
		ELSE
			//For old style, the first element is the directory, the rest are the filenames
			//and the are seperated by spaces
			ls_pathname = Trim ( String ( ofn.lpstrfile ) )
			li_pos = PosA ( ls_pathname, ' ' )
			ls_filename = MidA ( ls_pathname, li_pos + 1 )
			ls_pathname = LeftA ( ls_pathname, li_pos - 1 )
			li_pos = PosA ( ls_filename, ' ' )
			filename[] = ls_null[]
			DO WHILE li_pos > 0
				filename[UpperBound(filename)+1] = LeftA ( ls_filename, li_pos - 1 )
				pathname[UpperBound(pathname)+1] = ls_pathname + '\' + LeftA ( ls_filename, li_pos - 1 )
				ls_filename = MidA ( ls_filename, li_pos + 1 )
				li_pos = PosA ( ls_filename, ' ' )
			LOOP
			filename[UpperBound(filename)+1] = ls_filename
			pathname[UpperBound(pathname)+1] = ls_pathname + '\' + ls_filename
		END IF
	ELSE
		//Only one file, don't need to loop through
		pathname[1] = String ( ofn.lpstrfile )
		filename[1] = String ( ofn.lpstrfiletitle )
	END IF
	setpointer(arrow!)
	Return 1
END IF
end function

public function integer nombrearchivoabrir (unsignedlong hwnd, string title, ref string pathname[], ref string filename[], string filter, string initialdirectory, boolean multiselect, boolean explorer, long flags);openfilename	ofn
blob				lblb_filter
blob				lblb_filename
blob				lblb_filetitle
double			li_pos, li_len, li_count
uint				li_rc
string			ls_pathname
string			ls_filename
string			ls_null[]

if isnull(hwnd) then
	return -1
end if

ofn.lstructsize   = 76
ofn.hwdowner = 0
ofn.hinstance   = 0

lblb_filter = blob (filter + space(1))
li_pos = PosA ( filter, ',' )
DO WHILE li_pos > 0
	blobedit ( lblb_filter, li_pos, CharA(0))
	li_pos = PosA ( filter, ',', li_pos + 1 )
LOOP
blobedit (lblb_filter,LenA(lblb_filter),CharA(0))
ofn.lpstrfilter = lblb_filter
	
setnull( ofn.lpstrcustomfilter )
ofn.nmaxcustfilter  = 0
ofn.nfilterindex  = 1

if multiselect then					  	
	ofn.nmaxfile = 2048000
	ofn.lpstrfile = blob (space(2047990))
else
	ofn.nmaxfile = 25600
	ofn.lpstrfile = blob (space(25590))
end if
ls_pathname += Space (ofn.nmaxfile)
blobedit(ofn.lpstrfile,1,CharA(0))

ofn.nmaxfiletitle  = 138
ls_filename = filename[1]
ls_filename += Space ( ofn.nmaxfiletitle - LenA ( filename[1]) - 10 ) 
lblb_filetitle = blob (ls_filename)
blobedit(lblb_filetitle,(LenA(filename[1])+1),CharA(0))
ofn.lpstrfiletitle = lblb_filetitle

ofn.lpstrinitialdir = initialdirectory
ofn.lpstrtitle = title

IF multiselect THEN
	flags += OFN_ALLOWMULTISELECT
END IF

IF explorer THEN
	flags += OFN_EXPLORER
END IF

ofn.flags   = flags

//ofn.nfileoffset   = 0
//ofn.nfileextension  = 0
ofn.lpstrdefext   = ''
//ofn.lcustdata   = 0
//ofn.lpfnhook   = 0
//ofn.lptemplatename  = ''

IF NOT this.GetOpenFileName (ofn) THEN
	li_rc = CommDlgExtendedError()
	if li_rc > 0 then
		messagebox ("Error interno", "Error N؛ " + string(li_rc))
	end if
	return li_rc
ELSE
	setpointer(hourglass!)
	IF multiselect THEN
		IF explorer THEN
			//For explorer, the first element is the directory, the rest are the filenames
			//and then are null seperated
			ls_pathname = Trim ( String ( ofn.lpstrfile ) )
			li_len = LenA ( ls_pathname )
			ofn.lpstrfile = BlobMid ( ofn.lpstrfile, li_len + 2 )
			ls_filename = Trim ( String ( ofn.lpstrfile ) )
			li_len = LenA ( ls_filename )
			filename[] = ls_null[]
			li_count = 0
			DO WHILE li_len > 0
				filename[UpperBound(filename)+1] = ls_filename
				pathname[UpperBound(pathname)+1] = ls_pathname + '\' + ls_filename
				ofn.lpstrfile = BlobMid ( ofn.lpstrfile, li_len + 2 )
				ls_filename = Trim ( String ( ofn.lpstrfile ) )
				li_len = LenA ( ls_filename )
				li_count++
			LOOP
			if li_count = 0 then
				if LenA(ls_pathname) > 0 then
					ls_filename = trim ( string( ofn.lpstrfiletitle ) )
					filename[UpperBound(filename)+1] = ls_filename
					pathname[UpperBound(pathname)+1] = ls_pathname
				end if	
			end if
		ELSE
			//For old style, the first element is the directory, the rest are the filenames
			//and the are seperated by spaces
			ls_pathname = Trim ( String ( ofn.lpstrfile ) )
			li_pos = PosA ( ls_pathname, ' ' )
			ls_filename = MidA ( ls_pathname, li_pos + 1 )
			ls_pathname = LeftA ( ls_pathname, li_pos - 1 )
			li_pos = PosA ( ls_filename, ' ' )
			filename[] = ls_null[]
			DO WHILE li_pos > 0
				filename[UpperBound(filename)+1] = LeftA ( ls_filename, li_pos - 1 )
				pathname[UpperBound(pathname)+1] = ls_pathname + '\' + LeftA ( ls_filename, li_pos - 1 )
				ls_filename = MidA ( ls_filename, li_pos + 1 )
				li_pos = PosA ( ls_filename, ' ' )
			LOOP
			filename[UpperBound(filename)+1] = ls_filename
			pathname[UpperBound(pathname)+1] = ls_pathname + '\' + ls_filename
		END IF
	ELSE
		//Only one file, don't need to loop through
		pathname[1] = String ( ofn.lpstrfile )
		filename[1] = String ( ofn.lpstrfiletitle )
	END IF
	setpointer(arrow!)
	Return 1
END IF
end function

public function boolean seleccionarfuente (unsignedlong hwnd);n_cst_kernel32 kernel32
n_cst_gdi32 gdi32
choosefont fontselect
ulong cmmdlgerr
ulong hheap
ulong ll_logfont
boolean aceptar

aceptar = false

if not isnull(hwnd) then
	if not isnull(fontselect) then
		if not isnull(log.lfHeight) or log.lfHeight <= 0 then
			kernel32 = create n_cst_kernel32
			
			gdi32 = create n_cst_gdi32 
			log.lfheight = -kernel32.muldiv(abs(this.fonttextsize),gdi32.getdevicecaps(gdi32.getdc(hwnd),90),72)
			destroy gdi32
			
			log.lfwidth = this.FontWidth 
			log.lfescapement = this.FontEscapement 
			log.lfOrientation = this.FontOrientation 
			log.lfWeight = this.FontWeight 
			
			if this.FontItalic then
				log.lfItalic = CharA(255)  
			else
				log.lfItalic = CharA(0)  
			end if
			if this.FontUnderline then
				log.lfUnderline = CharA(1)
			else
				log.lfUnderline = CharA(0)
			end if
			if this.FontStrikeOut then
				log.lfStrikeOut = CharA(1)
			else
				log.lfStrikeOut = CharA(0)
			end if
			if this.FontCharSet >= 0 and this.FontCharSet <= 255 then
				log.lfCharSet = CharA(this.FontCharSet)
			else
				log.lfCharSet = CharA(0)				
			end if
			if this.FontOutPrecision >= 0 and this.FontOutPrecision <= 255 then
				log.lfOutPrecision = CharA(this.FontOutPrecision)
			else
				log.lfOutPrecision = CharA(0)				
			end if
			if this.FontClipPrecision >= 0 and this.FontClipPrecision <= 255 then
				log.lfClipPrecision = CharA(this.FontClipPrecision) 
			else
				log.lfClipPrecision = CharA(0) 				
			end if
			if this.FontQuality >= 0 and this.FontQuality <= 255 then
				log.lfQuality = CharA(this.FontQuality)
			else
				log.lfQuality = CharA(0)
			end if
			if this.FontPitchAndFamily >= 0 and this.FontPitchAndFamily <= 255 then
				log.lfPitchAndFamily = CharA(this.FontPitchAndFamily)
			else	
				log.lfPitchAndFamily = CharA(0)				
			end if	
			if LenA(this.FontFaceName) <= 32 then
				log.lfFaceName = this.FontFaceName
			else
				log.lfFaceName = ""
			end if
		end if	
		
		hheap = kernel32.heapcreate((kernel32.heap_no_serialize + kernel32.heap_generate_exceptions),0,60)
		
		if hheap > 0 then
			ll_logfont = kernel32.heapalloc(hheap,(kernel32.heap_no_serialize + kernel32.heap_generate_exceptions + kernel32.heap_zero_memory),60)
		else
			messagebox ("Error de memoria N؛ " + string(kernel32.getlasterror()),"No se pudo alocar memoria")
			return false
		end if
		
		//if not kernel32.heaplock(hheap) then //Funciona solo en NT
		//	messagebox ("Error de memoria N؛ " + string(kernel32.getlasterror()),"No se pudo lockear memoria") 
		//	return -1
		//end if

		kernel32.copymemory(ll_logfont,log,60)
		
		fontselect.lStructSize = 60 
		fontselect.hwndOwner = hwnd 
		fontselect.lplogfont =  ll_logfont
		setnull(fontselect.hDC)  
		if isnull(log.lfHeight) then
			fontselect.Flags = this.cf_both + this.CF_EFFECTS
		else
			fontselect.Flags = this.cf_both + this.CF_EFFECTS + this.cf_inittologfontstruct
		end if
		if isnull(FontColor) then
			fontselect.rgbColors = RGB(0,0,0) 
		else
			fontselect.rgbColors = FontColor
		end if
		setnull(fontselect.lpfnHook)
		setnull(fontselect.lpTemplateName)
		setnull(fontselect.hInstance)
		setnull(fontselect.lpszStyle)
		fontselect.nFontType = this.SCREEN_FONTTYPE
		fontselect.nSizeMin = 0 
		fontselect.nSizeMax = 0 
		
		if this.choosefont(fontselect) then
			
			kernel32.copymemory(log,ll_logfont,60)

			//if kernel32.heapunlock(hheap) then  //Funciona solo en NT
				kernel32.heapfree(hheap,kernel32.heap_no_serialize,ll_logfont)
				kernel32.heapdestroy(hheap)
			//end if	
			
			destroy kernel32
			
			this.FontWidth = log.lfwidth
			this.FontEscapement = log.lfescapement
			this.FontOrientation = log.lfOrientation
			this.FontWeight = log.lfWeight
			this.FontItalic = (log.lfItalic <> CharA(0))
			this.FontUnderline = (log.lfUnderline  <> CharA(0))
			this.FontStrikeOut = (log.lfStrikeOut  <> CharA(0))
			this.FontCharSet = AscA(log.lfCharSet)
			this.FontOutPrecision = AscA(log.lfOutPrecision)
			this.FontClipPrecision = AscA(log.lfClipPrecision)
			this.FontQuality = AscA(log.lfQuality)
			this.FontPitchAndFamily = AscA(log.lfPitchAndFamily)
			this.FontFaceName = log.lfFaceName 
			this.FontColor = fontselect.rgbColors
			this.FontTextSize = -long(fontselect.ipointsize)/10
			
			aceptar = true
		else
			cmmdlgerr = this.commdlgextendederror()
			if cmmdlgerr > 0 then
				messagebox ("Error interno", "Error N؛ " + string(cmmdlgerr))
			end if
		end if
	end if
end if
return aceptar
end function

public function boolean seleccionarcolor (unsignedlong hwnd);n_cst_kernel32 kernel32 
choosecolor colorelec
ulong hheap
ulong ll_array
integer colores
ulong retcolor
ulong cmmdlgerr
boolean aceptar

aceptar = false

retcolor = this.rgbresult

setnull(colorelec.lStructSize)
setnull(colorelec.hwndOwner) 
setnull(colorelec.hInstance) 
setnull(colorelec.rgbResult) 
setnull(colorelec.lpCustColors) 
setnull(colorelec.Flags) 
setnull(colorelec.lCustData) 
setnull(colorelec.lpfnHook) 
setnull(colorelec.lpTemplateName)

for colores = lowerbound(colors.colors) to upperbound(colors.colors)
	if isnull(colors.colors[colores]) or colors.colors[colores] = 0 then
		colors.colors[colores] = rgb(255,255,255)
	end if
next

if not isnull(hwnd) then
	if not isnull(colors.colors) then
		kernel32 = create n_cst_kernel32
		
		hheap = kernel32.heapcreate((kernel32.heap_no_serialize + kernel32.heap_generate_exceptions),0,64)
		
		if hheap > 0 then
			ll_array = kernel32.heapalloc(hheap,(kernel32.heap_no_serialize + kernel32.heap_generate_exceptions + kernel32.heap_zero_memory),64)
		else
			messagebox ("Error de memoria N؛ " + string(kernel32.getlasterror()),"No se pudo capturar la memoria")
			return false
		end if
		
		//if not kernel32.heaplock(hheap) then //Funciona solo en NT
		//	messagebox ("Error de memoria N؛ " + string(kernel32.getlasterror()),"No se pudo lockear memoria") 
		//	return -1
		//end if

		kernel32.copymemory(ll_array,colors,64)
			
		colorelec.hwndOwner = hwnd
		colorelec.lpcustcolors = ll_array
		colorelec.lstructsize = 36
		colorelec.flags = this.cc_rgbinit
		colorelec.rgbResult = retcolor

		if this.choosecolor(colorelec) then

			kernel32.copymemory(colors,ll_array,64)
			
			//if kernel32.heapunlock(hheap) then  //Funciona solo en NT
				kernel32.heapfree(hheap,kernel32.heap_no_serialize,ll_array)
				kernel32.heapdestroy(hheap)
			//end if	
							
			if not isnull(colorelec.rgbResult) then
				this.rgbresult = colorelec.rgbResult
			else
					messagebox ("es nulo lo seleccionado","es nulo lo seleccionado")
			end if	
			
			aceptar = true
		else	
			cmmdlgerr = this.commdlgextendederror()
			if cmmdlgerr > 0 then
				messagebox ("Error interno", "Error N؛ " + string(cmmdlgerr))
			end if
		end if
		
		destroy kernel32	
		
	end if
end if
return aceptar
end function

public function boolean impresora (unsignedlong hwnd);n_cst_kernel32 k32
devnames dvn
devicemode dvm
long ret_var
printdlg prd
ulong cmmdlgerr, flags_orig, pointermemory
boolean aceptar

aceptar = false

if this.PDSeleccion < 1 or this.PDSeleccion > 3 then
	this.PDSeleccion = 1
end if
if this.PDTodasLasPaginas then 
	prd.flags += this.pd_allpages
end if	
if this.PDIntercalarCopias then
	prd.flags += this.pd_collate
end if	
if this.PDDeshabilitaArchivo then 
	prd.flags += this.pd_disableprinttofile
end if	
if this.PDOcultaCasillaArchivo then 
	prd.flags += this.pd_hideprinttofile
end if	
if this.PDSinBotonDeRed then 
	prd.flags += this.pd_nonetworkbutton
end if	
if this.PDDeshabilitaRadioDePaginas then 
	prd.flags += this.pd_nopagenums
end if	
if this.PDDeshabilitaRadioDeSeleccion then 
	prd.flags += this.pd_noselection
end if	
if this.PDSinMensajesDeAviso then 
	prd.flags += this.pd_nowarning
end if	
if this.PDSeleccion = 2 then 
	prd.flags += this.pd_pagenums
end if	
if this.PDActivaConfiguracionesDeImpresora then 
	prd.flags += this.pd_printsetup
end if	
if this.PDRetornaContextoDC then 
	prd.flags += this.pd_returndc
end if	
if this.PDChequeaCasillaArchivo then 
	prd.flags += this.pd_printtofile
end if
if this.PDRetornaContextoIC then 
	prd.flags += this.pd_returnic
end if	
if this.PDSeleccion = 3 then 
	prd.flags += this.pd_selection
end if
if this.PDMuestraBotonDeAyuda then 
	prd.flags += this.pd_showhelp
end if	
if this.PDSetCopiasIntercaldoSobreDispositivo then 
	prd.flags += this.pd_usedevmodecopiesandcollate
end if
if this.PDPaginaDesde >= 0 and this.PDPaginaDesde <= max_pag then
	prd.nFromPage = this.PDPaginaDesde
end if
if this.PDPaginaHasta >= 0 and this.PDPaginaHasta >= this.PDPaginaDesde and this.PDPaginaHasta <= max_pag then
	prd.nToPage = this.PDPaginaHasta
end if
if this.PDRangoMinimo >= 0 and this.PDRangoMinimo <= max_pag then
	prd.nMinPage = this.PDRangoMinimo
end if
if this.PDRangoMaximo >=0 and this.PDRangoMaximo >= this.PDRangoMinimo then
	prd.nMaxPage = this.PDRangoMaximo
end if
if this.PDCopias > 0 and this.PDCopias <= max_cop then
	prd.nCopies = this.PDCopias 
else
	prd.nCopies = 1
end if

if not isnull(hwnd) then
	if not isnull(prd) then
		prd.lStructSize = 66
		prd.hwndOwner = hwnd
		setnull(prd.hDevMode)
		setnull(prd.hDevNames)
		setnull(prd.hInstance)
		setnull(prd.lCustData)
		setnull(prd.lpfnPrintHook)
		setnull(prd.lpPrintTemplateName)
		setnull(prd.lpSetupTemplateName)
		setnull(prd.hPrintTemplate)
		setnull(prd.hSetupTemplate)

		flags_orig = prd.flags
	
		if this.printdlg(prd) then
			this.PDPaginaDesde = prd.nFromPage
			this.PDPaginaHasta = prd.nToPage
			this.pdcopias = prd.nCopies
			if this.PDRetornaContextoDC or this.PDRetornaContextoIC then
				this.dc = prd.hdc
			end if
			
			k32 = create n_cst_kernel32
			
			pointermemory = k32.globallock(prd.hdevnames)
			if pointermemory > 0 then
				k32.copymemory(dvn,pointermemory,8)
			end if	
			pointermemory = k32.globallock(prd.hdevmode) 
			if pointermemory > 0 then
				k32.copymemory(dvm,pointermemory,152)
			end if
			k32.globalunlock(prd.hdevnames)
			k32.globalunlock(prd.hdevmode)	

			destroy k32
			
			if not isnull(dvm.dmdevicename) then
				this.PDNombreImpresora = dvm.dmdevicename
			end if	

			
			ret_var = prd.flags - flags_orig
			if ret_var <> 0 then
				choose case true
					case PDSeleccion = 1 and pdchequeacasillaarchivo and pdintercalarcopias
						choose case ret_var
							case 2
								pdseleccion = 2
							case 1
								pdseleccion = 3
							case -16
								pdintercalarcopias = false
							case -14
								pdseleccion = 2
								pdintercalarcopias = false
							case -15
								pdSeleccion = 3
								pdintercalarcopias = false
							case -32
								pdchequeacasillaarchivo = false
							case -30
								pdseleccion = 2
								pdchequeacasillaarchivo = false
							case -31
								pdseleccion = 3
								pdchequeacasillaarchivo = false
							case -48
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
							case -46
								pdseleccion = 2
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
							case -47
								pdseleccion = 3
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
					end choose	
					case PDSeleccion = 2 and pdchequeacasillaarchivo and pdintercalarcopias
						choose case ret_var
							case -2
								pdseleccion = 1
							case -1
								pdseleccion = 3
							case -18
								pdseleccion = 1
								pdintercalarcopias = false
							case -16
								pdintercalarcopias = false
							case -17
								pdseleccion = 3
								pdintercalarcopias = false
							case -34
								pdseleccion = 1
								pdchequeacasillaarchivo = false
							case -32
								pdchequeacasillaarchivo = false
							case -33
								pdseleccion = 3
								pdchequeacasillaarchivo = false
							case -50
								pdseleccion = 1
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
							case -48
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
							case -49
								pdseleccion = 3
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
						end choose
					case PDSeleccion = 3 and pdchequeacasillaarchivo and pdintercalarcopias
						choose case ret_var
							case -1
								pdseleccion = 1
							case 1
								pdseleccion = 2
							case -17
								pdseleccion = 1
								pdintercalarcopias = false
							case -15
								pdseleccion = 2
								pdintercalarcopias = false
							case -16
								pdintercalarcopias = false
							case -33
								pdseleccion = 1
								pdchequeacasillaarchivo = false
							case -31
								pdseleccion = 2
								pdchequeacasillaarchivo = false
							case -32
								pdchequeacasillaarchivo = false
							case -49
								pdseleccion = 1
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
							case -47
								pdseleccion = 2
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
							case -48
								pdchequeacasillaarchivo = false
								pdintercalarcopias = false
						end choose
					case PDSeleccion = 1 and pdchequeacasillaarchivo and not pdintercalarcopias	
						choose case ret_var
							case 16
								pdintercalarcopias = true
							case 18
								pdseleccion = 2
								pdintercalarcopias = true
							case 17
								pdseleccion = 3
								pdintercalarcopias = true
							case 2
								pdseleccion = 2
							case 1
								pdseleccion = 3								
							case -16
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true	
							case -14
								pdseleccion = 2								
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true	
							case -15
								pdseleccion = 3								
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true	
							case -32
								pdchequeacasillaarchivo = true
							case -30
								pdseleccion = 2								
								pdchequeacasillaarchivo = true
							case -31
								pdseleccion = 3								
								pdchequeacasillaarchivo = true
						end choose
					case PDSeleccion = 2 and pdchequeacasillaarchivo and not pdintercalarcopias	
						choose case ret_var
							case 14
								pdseleccion = 1
								pdintercalarcopias = true
							case 16
								pdintercalarcopias = true
							case 15
								pdseleccion = 3
								pdintercalarcopias = true
							case -2
								pdseleccion = 1
							case -1
								pdseleccion = 3
							case -18
								pdseleccion = 1
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true
							case -16
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true
							case -17
								pdseleccion = 3
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true
							case -34
								pdseleccion = 1
								pdchequeacasillaarchivo = false
							case -32
								pdchequeacasillaarchivo = false
							case -33
								pdseleccion = 3								
								pdchequeacasillaarchivo = false
						end choose
					case PDSeleccion = 3 and pdchequeacasillaarchivo and not pdintercalarcopias	
						choose case ret_var
							case 15
								pdseleccion = 1
								pdintercalarcopias = true
							case 17
								pdseleccion = 2
								pdintercalarcopias = true
							case 16
								pdintercalarcopias = true
							case -1
								pdseleccion = 1
							case 1
								pdseleccion = 2
							case -17
								pdseleccion = 1
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true	
							case -15
								pdseleccion = 2
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true	
							case -16
								pdchequeacasillaarchivo = false
								pdintercalarcopias = true	
							case -33
								pdseleccion = 1
								pdchequeacasillaarchivo = false
							case -31
								pdseleccion = 2
								pdchequeacasillaarchivo = false
							case -32
								pdchequeacasillaarchivo = false
						end choose
					case PDSeleccion = 1 and not pdchequeacasillaarchivo and pdintercalarcopias	
						choose case ret_var
							case 32
								pdchequeacasillaarchivo = true
							case 34
								pdseleccion = 2
								pdchequeacasillaarchivo = true
							case 33
								pdseleccion = 3
								pdchequeacasillaarchivo = true
							case 16
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 18
								pdseleccion = 2
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 17
								pdseleccion = 3
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 2
								pdseleccion = 2
							case 1
								pdseleccion = 3
							case -16
								pdintercalarcopias = false
							case -14
								pdseleccion = 2
								pdintercalarcopias = false
							case -15
								pdseleccion = 3
								pdintercalarcopias = false
						end choose
					case PDSeleccion = 2 and not pdchequeacasillaarchivo and pdintercalarcopias	
						choose case ret_var
							case 30
								pdseleccion = 1
								pdchequeacasillaarchivo = true
							case 32
								pdchequeacasillaarchivo = true
							case 31
								pdseleccion = 3
								pdchequeacasillaarchivo = true
							case 14
								pdseleccion = 1
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 16
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 15
								pdseleccion = 3
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case -2
								pdseleccion = 1
							case -1
								pdseleccion = 3
							case -18
								pdseleccion = 1
								pdintercalarcopias = false
							case -16
								pdintercalarcopias = false
							case -17
								pdseleccion = 3
								pdintercalarcopias = false
						end choose
					case PDSeleccion = 3 and not pdchequeacasillaarchivo and pdintercalarcopias
						choose case ret_var
							case 31
								pdseleccion = 1
								pdchequeacasillaarchivo = true
							case 33
								pdseleccion = 2
								pdchequeacasillaarchivo = true
							case 32
								pdchequeacasillaarchivo = true
							case 15
								pdseleccion = 1
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 17
								pdseleccion = 2
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case 16
								pdchequeacasillaarchivo = true
								pdintercalarcopias = false
							case -1
								pdseleccion = 1
							case 1
								pdseleccion = 2
							case -17
								pdseleccion = 1
								pdintercalarcopias = false
							case -15
								pdseleccion = 2
								pdintercalarcopias = false
							case -16
								pdintercalarcopias = false
						end choose
					case PDSeleccion = 1 and not pdchequeacasillaarchivo and not pdintercalarcopias		
						choose case ret_var
							case 48
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 50
								pdseleccion = 2
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 49
								pdseleccion = 3
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 32
								pdchequeacasillaarchivo = true
							case 34
								pdseleccion = 2
								pdchequeacasillaarchivo = true
							case 33
								pdseleccion = 3
								pdchequeacasillaarchivo = true
							case 16
								pdintercalarcopias = true
							case 18
								pdseleccion = 2
								pdintercalarcopias = true
							case 17
								pdseleccion = 3
								pdintercalarcopias = true
							case 2
								pdseleccion = 2
							case 1
								pdseleccion = 3
						end choose
					case PDSeleccion = 2 and not pdchequeacasillaarchivo and not pdintercalarcopias		
						choose case ret_var
							case 46
								pdseleccion = 1
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 48
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 47
								pdseleccion = 3
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 30
								pdseleccion = 1
								pdchequeacasillaarchivo = true
							case 32
								pdchequeacasillaarchivo = true
							case 31
								pdseleccion = 3
								pdchequeacasillaarchivo = true
							case 14
								pdseleccion = 1
								pdintercalarcopias = true
							case 16
								pdintercalarcopias = true
							case 15
								pdseleccion = 3
								pdintercalarcopias = true
							case -2
								pdseleccion = 1
							case -1
								pdseleccion = 3
						end choose
					case PDSeleccion = 3 and not pdchequeacasillaarchivo and not pdintercalarcopias			
						choose case ret_var
							case 47
								pdseleccion = 1
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 49
								pdseleccion = 2
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 48
								pdchequeacasillaarchivo = true
								pdintercalarcopias = true
							case 31
								pdseleccion = 1
								pdchequeacasillaarchivo = true
							case 33
								pdseleccion = 2
								pdchequeacasillaarchivo = true
							case 32
								pdchequeacasillaarchivo = true
							case 15
								pdseleccion = 1
								pdintercalarcopias = true
							case 17
								pdseleccion = 2
								pdintercalarcopias = true
							case 16
								pdintercalarcopias = true
							case -1
								pdseleccion = 1
							case 1
								pdseleccion = 2
						end choose
				end choose	
			end if
			aceptar = true
		else	
			cmmdlgerr = this.commdlgextendederror()
			if cmmdlgerr > 0 then
				messagebox ("Error interno", "Error N؛ " + string(cmmdlgerr))
			end if
		end if
	end if
end if
return aceptar
end function

on n_cst_comdlg32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_comdlg32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;this.fontfacename = "Arial"
this.fonttextsize = 10
this.fontweight = 400
end event

