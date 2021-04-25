$PBExportHeader$n_cryptoapi.sru
$PBExportComments$Object for Microsoft CryptoAPI
forward
global type n_cryptoapi from nonvisualobject
end type
type hmac_info from structure within n_cryptoapi
end type
type systemtime from structure within n_cryptoapi
end type
type filetime from structure within n_cryptoapi
end type
end forward

type hmac_info from structure
	unsignedlong		hashalgid
	unsignedlong		pbinnerstring
	unsignedlong		cbinnerstring
	unsignedlong		pbouterstring
	unsignedlong		cbouterstring
end type

type systemtime from structure
	integer		wyear
	integer		wmonth
	integer		wdayofweek
	integer		wday
	integer		whour
	integer		wminute
	integer		wsecond
	integer		wmilliseconds
end type

type filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

global type n_cryptoapi from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetLastError ( &
	) Library "kernel32.dll"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"

Function long CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileW"

Function boolean CloseHandle ( &
	long hObject &
	) Library "kernel32.dll"

Function boolean ReadFile ( &
	long hFile, &
	Ref blob lpBuffer, &
	ulong nNumberOfBytesToRead, &
	Ref ulong lpNumberOfBytesRead, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function boolean WriteFile ( &
	ulong hFile, &
	blob lpBuffer, &
	ulong nNumberOfBytesToWrite, &
	Ref ulong lpNumberOfBytesWritten, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function boolean TzSpecificLocalTimeToSystemTime ( &
	ulong lpTimeZoneInformation, &
	SYSTEMTIME lpLocalTime, &
	Ref SYSTEMTIME lpUniversalTime &
	) Library "kernel32.dll"

// used by of_Blob2Hex
Function boolean CryptBinaryToString ( &
	blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringW"

// used by of_Base64Encode
Function boolean CryptBinaryToString ( &
	string pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	ulong pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringA;Ansi"

// used by of_Base64Encode
Function boolean CryptBinaryToString ( &
	string pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringA;Ansi"

// used by of_Hex2Blob
Function boolean CryptStringToBinary ( &
	string pszString, &
	ulong cchString, &
	ulong dwFlags, &
	Ref blob pbBinary, &
	Ref ulong pcbBinary, &
	Ref ulong pdwSkip, &
	Ref ulong pdwFlags &
	) Library "crypt32.dll" Alias For "CryptStringToBinaryW"

Function boolean CryptAcquireContext ( &
	Ref ulong phProv, &
	ulong pszContainer, &
	string pszProvider, &
	ulong dwProvType, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptAcquireContextW"

Function boolean CryptReleaseContext ( &
	ulong hProv, &
	ulong dwFlags &
	) Library "advapi32.dll"

Function boolean CryptImportKey ( &
	ulong hProv, &
	byte pbData[], &
	ulong dwDataLen, &
	ulong hPubKey, &
	ulong dwFlags, &
	Ref ulong phKey &
	) Library "advapi32.dll"

Function boolean CryptDestroyKey ( &
	ulong hKey &
	) Library "advapi32.dll"

Function boolean CryptCreateHash ( &
	ulong hProv, &
	ulong Algid, &
	ulong hKey, &
	ulong dwFlags, &
	Ref ulong phHash &
	) Library "advapi32.dll"

Function boolean CryptDestroyHash ( &
	ulong hHash &
	) Library "advapi32.dll"

Function boolean CryptGetHashParam ( &
	ulong hHash, &
	ulong dwParam, &
	ref blob pbData, &
	ref ulong pdwDataLen, &
	ulong dwFlags &
	) Library "advapi32.dll"

Function boolean CryptSetHashParam ( &
	ulong hHash, &
	ulong dwParam, &
	HMAC_INFO pbData, &
	ulong dwFlags &
	) Library "advapi32.dll"

Function boolean CryptHashData ( &
	ulong hHash, &
	blob pbData, &
	ulong dwDataLen, &
	ulong dwFlags &
	) Library "advapi32.dll"

Function boolean CryptDeriveKey ( &
	ulong hProv, &
	ulong Algid, &
	ulong hBaseData, &
	ulong dwFlags, &
	Ref ulong phKey &
	) Library "advapi32.dll" Alias For "CryptDeriveKey"

Function boolean CryptEncrypt ( &
	ulong hKey, &
	ulong hHash, &
	boolean Final, &
	ulong dwFlags, &
	Ref blob pbData, &
	Ref ulong pdwDataLen, &
	ulong dwBufLen &
	) Library "advapi32.dll" Alias For "CryptEncrypt"

Function boolean CryptDecrypt ( &
	ulong hKey, &
	ulong hHash, &
	boolean Final, &
	ulong dwFlags, &
	Ref blob pbData, &
	Ref ulong pdwDataLen &
	) Library "advapi32.dll" Alias For "CryptDecrypt"

Function boolean CryptGenRandom ( &
	ulong hProv, &
	ulong dwLen, &
	Ref ulong pbBuffer &
	) Library "advapi32.dll"

Function boolean CryptGenRandom ( &
	ulong hProv, &
	ulong dwLen, &
	Ref blob pbBuffer &
	) Library "advapi32.dll"

end prototypes

type variables
Private:

// General Constants
Constant ULong HP_HASHVAL    = 2
Constant ULong HP_HMAC_INFO  = 5
Constant ULong CRYPT_NO_SALT = 16
Constant ULong CRYPT_IPSEC_HMAC_KEY = 256
Constant ULong CRYPT_STRING_BASE64	= 1
Constant ULong CRYPT_STRING_HEXRAW	= 12
Constant Ulong CRYPT_STRING_NOCRLF	= 1073741824	// 0x40000000
Constant ULong CRYPT_VERIFYCONTEXT	= 4026531840	// 0xF0000000
Constant ULong CRYPT_NEWKEYSET		= 8

// Encryption Algorithms
Constant ULong CALG_3DES			= 26115
Constant ULong CALG_3DES_112		= 26121
Constant ULong CALG_AES				= 26129
Constant ULong CALG_AES_128		= 26126
Constant ULong CALG_AES_192		= 26127
Constant ULong CALG_AES_256		= 26128
Constant ULong CALG_CYLINK_MEK	= 26124
Constant ULong CALG_DES				= 26113
Constant ULong CALG_DESX			= 26116
Constant ULong CALG_DH_EPHEM		= 43522
Constant ULong CALG_DH_SF			= 43521
Constant ULong CALG_DSS_SIGN		= 8704
Constant ULong CALG_RC2				= 26114
Constant ULong CALG_RC4				= 26625
Constant ULong CALG_RC5				= 26125
Constant ULong CALG_RSA_KEYX		= 41984
Constant ULong CALG_RSA_SIGN		= 9216

// Hashing Algorithms
Constant ULong CALG_HUGHES_MD5	= 40963
Constant ULong CALG_HMAC			= 32777
Constant ULong CALG_MAC				= 32773
Constant ULong CALG_MD2				= 32769
Constant ULong CALG_MD5				= 32771
Constant ULong CALG_SHA				= 32772
Constant ULong CALG_SHA1			= 32772
Constant ULong CALG_SHA_256		= 32780
Constant ULong CALG_SHA_384		= 32781
Constant ULong CALG_SHA_512		= 32782

// constants for CreateFile API function
Constant Long INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ      = 2147483648
Constant ULong GENERIC_WRITE     = 1073741824
Constant ULong FILE_SHARE_READ   = 1
Constant ULong FILE_SHARE_WRITE  = 2
Constant ULong CREATE_NEW			= 1
Constant ULong CREATE_ALWAYS		= 2
Constant ULong OPEN_EXISTING		= 3
Constant ULong OPEN_ALWAYS			= 4
Constant ULong TRUNCATE_EXISTING = 5

// Handles
ULong iul_hProv
ULong iul_hKey
ULong iul_hHash
ULong iul_hRand

Public:

// Cryptographic Provider Names
Constant String MS_DEF_DH_SCHANNEL_PROV	= "Microsoft DH Schannel Cryptographic Provider" 
Constant String MS_DEF_DSS_DH_PROV			= "Microsoft Base DSS and Diffie-Hellman Cryptographic Provider" 
Constant String MS_DEF_DSS_PROV				= "Microsoft Base DSS Cryptographic Provider" 
Constant String MS_DEF_PROV					= "Microsoft Base Cryptographic Provider v1.0" 
Constant String MS_DEF_RSA_SCHANNEL_PROV	= "Microsoft RSA Schannel Cryptographic Provider" 
Constant String MS_DEF_RSA_SIG_PROV			= "Microsoft RSA Signature Cryptographic Provider" 
Constant String MS_ENH_DSS_DH_PROV			= "Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider" 
Constant String MS_ENH_RSA_AES_PROV			= "Microsoft Enhanced RSA and AES Cryptographic Provider" 
Constant String MS_ENH_RSA_AES_PROV_XP		= "Microsoft Enhanced RSA and AES Cryptographic Provider (Prototype)"
Constant String MS_ENHANCED_PROV				= "Microsoft Enhanced Cryptographic Provider v1.0" 
Constant String MS_SCARD_PROV					= "Microsoft Base Smart Card Crypto Provider" 
Constant String MS_STRONG_PROV				= "Microsoft Strong Cryptographic Provider" 

// Cryptographic Provider Types
Constant ULong PROV_RSA_FULL			= 1
Constant ULong PROV_RSA_SIG			= 2
Constant ULong PROV_DSS					= 3
Constant ULong PROV_FORTEZZA			= 4
Constant ULong PROV_MS_EXCHANGE		= 5
Constant ULong PROV_SSL					= 6
Constant ULong PROV_RSA_SCHANNEL		= 12
Constant ULong PROV_DSS_DH				= 13
Constant ULong PROV_EC_ECDSA_SIG		= 14
Constant ULong PROV_EC_ECNRA_SIG		= 15
Constant ULong PROV_EC_ECDSA_FULL	= 16
Constant ULong PROV_EC_ECNRA_FULL	= 17
Constant ULong PROV_DH_SCHANNEL		= 18
Constant ULong PROV_SPYRUS_LYNKS		= 20
Constant ULong PROV_RNG					= 21
Constant ULong PROV_INTEL_SEC			= 22
Constant ULong PROV_REPLACE_OWF		= 23
Constant ULong PROV_RSA_AES			= 24

// Current Settings
String iCryptoProvider = MS_ENH_RSA_AES_PROV
ULong iProviderType    = PROV_RSA_AES

// Error Info
String LastFunction
String LastErrText
ULong  LastErrCode

end variables

forward prototypes
private subroutine of_finalcleanup ()
public function unsignedlong of_getlasterror (ref string as_msgtext)
public function string of_hmac (readonly string as_algorithm, readonly string as_message, readonly string as_password)
private subroutine of_errorcleanup (readonly string as_function)
private function string of_hmac (readonly unsignedlong aul_algid, readonly string as_message, readonly string as_password)
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
private function string of_hash (readonly unsignedlong aul_algid, readonly string as_message)
public function string of_hash (readonly string as_algorithm, readonly string as_message)
public function string of_blob2hex (blob ablb_data)
public function string of_encrypt (readonly string as_algorithm, readonly string as_message, readonly string as_password)
public function blob of_encryptdecrypt (readonly unsignedlong aul_algid, readonly blob ablb_message, readonly blob ablb_password, readonly boolean ab_encrypt)
public function blob of_encrypt (readonly string as_algorithm, readonly blob ablb_message, readonly blob ablb_password)
public function blob of_hex2blob (string as_hexstring)
public function string of_encrypthex (readonly string as_algorithm, readonly string as_message, readonly string as_password)
public function unsignedlong of_randomnbr ()
public function blob of_decrypt (readonly string as_algorithm, readonly blob ablb_message, readonly blob ablb_password)
public function string of_decrypt (readonly string as_algorithm, readonly string as_message, readonly string as_password)
public function string of_decrypthex (readonly string as_algorithm, readonly string as_message, readonly string as_password)
public function blob of_randomblob (readonly unsignedlong aul_size)
public function string of_decode64 (string as_message)
public function string of_encode64 (string as_message)
public function boolean of_readfile (string as_filename, ref blob ablob_filedata)
public function boolean of_writefile (string as_filename, blob ablob_filedata)
public function string of_hashfile (string as_algorithm, string as_filename)
private function string of_hash (readonly unsignedlong aul_algid, readonly blob ablb_message)
public function string of_hash (readonly string as_algorithm, readonly blob ablb_message)
public function blob of_encryptfile (readonly string as_algorithm, readonly string as_filename, readonly string as_password)
public function string of_decrypt (readonly string as_algorithm, readonly blob ablb_message, readonly string as_password)
public function datetime of_currentutc ()
end prototypes

private subroutine of_finalcleanup ();// --------------------------------------------------------------------------------------
// SCRIPT:		of_FinalCleanup
//
// PURPOSE:		This function performs final cleanup tasks.
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/19/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

If iul_hProv > 0 Then
	CryptReleaseContext(iul_hProv, 0)
	iul_hProv = 0
End If

If iul_hKey > 0 Then
	CryptDestroyKey(iul_hKey)
	iul_hKey = 0
End If

If iul_hHash > 0 Then
	CryptDestroyHash(iul_hHash)
	iul_hHash = 0
End If

If iul_hRand > 0 Then
	CryptReleaseContext(iul_hRand, 0)
	iul_hRand = 0
End If

end subroutine

public function unsignedlong of_getlasterror (ref string as_msgtext);// --------------------------------------------------------------------------------------
// SCRIPT:     of_GetLastError
//
// PURPOSE:    This function returns the most recent API error message.
//
// ARGUMENTS:  as_msgtext	- The error text ( by ref )
//
// RETURN:		The error number
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		--------------------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
ULong lul_error, lul_Size = 255

lul_error = GetLastError()

as_msgtext = Space(lul_Size)

FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
					lul_error, LANG_NEUTRAL, as_msgtext, lul_Size, 0)

Return lul_error

end function

public function string of_hmac (readonly string as_algorithm, readonly string as_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Hmac
//
// PURPOSE:		This function calculates the HMAC of a string using the passed algorithm.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_message		-	The message to hash
//					as_password		-	The password to use
//
// RETURN:		The hashed message
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/19/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

ULong lul_AlgId

choose case Upper(as_algorithm)
	case "MD2"
		lul_AlgId = CALG_MD2
	case "MD5"
		lul_AlgId = CALG_MD5
	case "SHA1"
		lul_AlgId = CALG_SHA1
	case "SHA256"
		lul_AlgId = CALG_SHA_256
	case "SHA384"
		lul_AlgId = CALG_SHA_384
	case "SHA512"
		lul_AlgId = CALG_SHA_512
end choose

Return of_Hmac(lul_AlgId, as_message, as_password)

end function

private subroutine of_errorcleanup (readonly string as_function);// --------------------------------------------------------------------------------------
// SCRIPT:		of_ErrorCleanup
//
// PURPOSE:		This function sets the error message for BCrypt functions and
//					then calls of_FinalCleanup.
//
// ARGUMENTS:	as_function	-	Name of function that failed
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/19/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

LastFunction = as_function
LastErrCode  = of_GetLastError(LastErrText)

of_FinalCleanup()

end subroutine

private function string of_hmac (readonly unsignedlong aul_algid, readonly string as_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Hmac
//
// PURPOSE:		This function calculates the HMAC of a string using the passed algorithm.
//
// ARGUMENTS:	aul_algid		-	The algorithm to use
//					as_message		-	The message to hash
//					as_password		-	The password to use
//
// RETURN:		The hashed message
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/19/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

HMAC_INFO HmacInfo
Byte KeyBlob[] = {8,2,0,0,2,102,0,0,0,0,0,0}
Blob lblb_Msg, lblb_Hash
ULong lul_KeyLen, lul_DataLen
String ls_Result
Long ll_idx

SetNull(ls_Result)

// acquire a handle to a key container
If Not CryptAcquireContext(iul_hProv, 0, &
				iCryptoProvider, iProviderType, &
				CRYPT_VERIFYCONTEXT + CRYPT_NEWKEYSET) Then
	of_ErrorCleanup("CryptAcquireContext")
	Return ls_Result
End If

// copy password to byte array
KeyBlob[9] = Len(as_password)
For ll_idx = 1 To KeyBlob[9]
	KeyBlob[12 + ll_idx] = AscA(Mid(as_password,ll_idx,1))
Next
lul_KeyLen = UpperBound(KeyBlob)

// import the key blob into the container's service provider
If Not CryptImportKey(iul_hProv, KeyBlob, lul_KeyLen, 0, &
				CRYPT_IPSEC_HMAC_KEY, iul_hKey) Then
	of_ErrorCleanup("CryptImportKey")
	Return ls_Result
End If

// create the hash object
If Not CryptCreateHash(iul_hProv, CALG_HMAC, &
				iul_hKey, 0, iul_hHash) Then
	of_ErrorCleanup("CryptCreateHash")
	Return ls_Result
End If

// set the hashing algorithm
HmacInfo.HashAlgId = aul_algid
If Not CryptSetHashParam(iul_hHash, HP_HMAC_INFO, &
				HmacInfo, 0) Then
	of_ErrorCleanup("CryptSetHashParam")
	Return ls_Result
End If

// import the message
lblb_Msg = Blob(as_message, EncodingAnsi!)
If Not CryptHashData(iul_hHash, lblb_Msg, &
				Len(as_message), 0) Then
	of_ErrorCleanup("CryptHashData")
	Return ls_Result
End If

// Determine size of hash value
CryptGetHashParam(iul_hHash, HP_HASHVAL, &
				lblb_Hash, lul_DataLen, 0)

// get the resulting hash value
lblb_Hash = Blob(Space(lul_DataLen), EncodingAnsi!)
If Not CryptGetHashParam(iul_hHash, HP_HASHVAL, &
				lblb_Hash, lul_DataLen, 0) Then
	of_ErrorCleanup("CryptGetHashParam")
	Return ls_Result
End If

// close all handles
of_FinalCleanup()

// convert blob to hex string
ls_Result = of_Blob2Hex(lblb_Hash)

Return ls_Result

end function

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);// --------------------------------------------------------------------------------------
// SCRIPT:     of_ReplaceAll
//
// PURPOSE:    This function replaces all occurrences of a string in another.
//
// ARGUMENTS:  as_oldstring	- The string to update
//					as_findstr		- The string to look for
//					as_replace		- The string to replace with
//
// RETURN:     The updated string
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/19/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

String ls_newstring
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

private function string of_hash (readonly unsignedlong aul_algid, readonly string as_message);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Hash
//
// PURPOSE:		This function hashes a string using the passed algorithm id.
//
// ARGUMENTS:	aul_algid	-	The algorithm to use
//					as_message	-	The message to hash
//
// RETURN:		The hashed message
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

Blob lblb_Msg

lblb_Msg = Blob(as_message, EncodingAnsi!)

Return of_Hash(aul_AlgId, lblb_Msg)

end function

public function string of_hash (readonly string as_algorithm, readonly string as_message);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Hash
//
// PURPOSE:		This function hashes a string using the passed algorithm name.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_message		-	The message to hash
//
// RETURN:		The hashed message
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

Blob lblb_Msg

lblb_Msg = Blob(as_message, EncodingAnsi!)

Return of_Hash(as_algorithm, lblb_Msg)

end function

public function string of_blob2hex (blob ablb_data);// -----------------------------------------------------------------------------
// SCRIPT:     of_Blob2Hex
//
// PURPOSE:    This function converts a blob to a hex string.
//
//					This code is not supported on Windows Server 2003 and Windows XP
//					due to use of CRYPT_STRING_HEXRAW & CRYPT_STRING_NOCRLF.
//
// ARGUMENTS:  ablb_data	- The blob data
//
// RETURN:		String representing the blob in hex
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_Result
ULong lul_MsgLen, lul_BufLen

lul_MsgLen = Len(ablb_data)
lul_BufLen = lul_MsgLen * 4

// allocate encoded buffer
ls_Result = Space(lul_BufLen)

// encode the binary data as Hexidecimal string
If Not CryptBinaryToString(ablb_data, lul_MsgLen, &
				CRYPT_STRING_HEXRAW + CRYPT_STRING_NOCRLF, &
				ls_result, lul_BufLen) Then
	LastErrCode  = of_GetLastError(LastErrText)
	LastFunction = "CryptBinaryToString"
	SetNull(ls_result)
End If

Return ls_result

end function

public function string of_encrypt (readonly string as_algorithm, readonly string as_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Encrypt
//
// PURPOSE:    This function will encrypt the string passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_message		-	Message to be encrypted
//					as_password		-	The password to use
//
// RETURN:		String containing encrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Message, lblb_Password, lblb_Encrypted

lblb_Message  = Blob(as_message, EncodingAnsi!)
lblb_Password = Blob(as_password, EncodingAnsi!)

lblb_Encrypted = of_Encrypt(as_algorithm, &
								lblb_Message, lblb_Password)

Return String(lblb_Encrypted, EncodingAnsi!)

end function

public function blob of_encryptdecrypt (readonly unsignedlong aul_algid, readonly blob ablb_message, readonly blob ablb_password, readonly boolean ab_encrypt);// --------------------------------------------------------------------------------------
// SCRIPT:		of_EncryptDecrypt
//
// PURPOSE:    This function will encrypt/decrypt the blob passed to it. Both
//					encrypt/decrypt have the same api calls except one so they are
//					combined to save coding.
//
// ARGUMENTS:	aul_algid		-	The algorithm to use
//					ablb_message	-	Message to be encrypted/decrypted
//					ablb_password	-	The password to use
//					ab_encrypt		-	True=encrypt, False=decrypt
//
// RETURN:		Blob containing encrypted/decrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Result, lblb_Buffer
ULong lul_DataLen, lul_BufLen

SetNull(lblb_Result)

// acquire a handle to a key container
If Not CryptAcquireContext(iul_hProv, 0, &
			iCryptoProvider, iProviderType, &
			CRYPT_VERIFYCONTEXT + CRYPT_NEWKEYSET) Then
	of_ErrorCleanup("CryptAcquireContext")
	Return lblb_Result
End If

// create the hash object
If Not CryptCreateHash(iul_hProv, CALG_MD5, &
				0, 0, iul_hHash) Then
	of_ErrorCleanup("CryptCreateHash")
	Return lblb_Result
End If

// hash the password
If Not CryptHashData(iul_hHash, ablb_Password, &
				Len(ablb_Password), 0) Then
	of_ErrorCleanup("CryptHashData")
	Return lblb_Result
End If

// derive a session key from the hash object
If Not CryptDeriveKey(iul_hProv, aul_AlgId, &
				iul_hHash, CRYPT_NO_SALT, iul_hKey) Then
	of_ErrorCleanup("CryptDeriveKey")
	Return lblb_Result
End If

// allocate buffer space
lul_DataLen = Len(ablb_Message)
lblb_Buffer = ablb_Message + Blob(Space(lul_DataLen), EncodingAnsi!)
lul_BufLen  = Len(lblb_Buffer)

If ab_encrypt Then
	// encrypt the message
	If CryptEncrypt(iul_hKey, 0, True, 0, &
				lblb_Buffer, lul_DataLen, lul_BufLen) Then
		lblb_Result = BlobMid(lblb_Buffer, 1, lul_DataLen)
	Else
		of_ErrorCleanup("CryptEncrypt")
		Return lblb_Result
	End If
Else
	// decrypt the message
	If CryptDecrypt(iul_hKey, 0, True, 0, &
				lblb_Buffer, lul_DataLen) Then
		lblb_Result = BlobMid(lblb_Buffer, 1, lul_DataLen)
	Else
		of_ErrorCleanup("CryptDecrypt")
		Return lblb_Result
	End If
End If

// close all handles
of_FinalCleanup()

Return lblb_Result

end function

public function blob of_encrypt (readonly string as_algorithm, readonly blob ablb_message, readonly blob ablb_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Encrypt
//
// PURPOSE:    This function will encrypt the blob passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					ablb_message	-	Message to be encrypted
//					ablb_password	-	The password to use
//
// RETURN:		Blob containing encrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Encrypted
ULong lul_AlgId

choose case Upper(as_algorithm)
	case "AES128"
		lul_AlgId = CALG_AES_128
	case "AES256"
		lul_AlgId = CALG_AES_256
	case "DES"
		lul_AlgId = CALG_DES
	case "RC2"
		lul_AlgId = CALG_RC2
	case "RC4"
		lul_AlgId = CALG_RC4
	case "3DES"
		lul_AlgId = CALG_3DES
	case "3DES_112"
		lul_AlgId = CALG_3DES_112
end choose

lblb_Encrypted = of_EncryptDecrypt(lul_AlgId, &
								ablb_Message, ablb_password, True)

Return lblb_Encrypted

end function

public function blob of_hex2blob (string as_hexstring);// -----------------------------------------------------------------------------
// SCRIPT:     of_Hex2Blob
//
// PURPOSE:    This function converts a hex string to a blob.
//
//					This code is not supported on Windows Server 2003 and Windows XP
//					due to use of CRYPT_STRING_HEXRAW.
//
// ARGUMENTS:  as_hexstring	- The hex data
//
// RETURN:		Blob representing the passed hex characters
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/13/2017	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Blob lblb_Output
ULong lul_MsgLen, lul_BufLen, lul_Skip, lul_pFlags

lul_MsgLen = Len(as_hexstring)
lul_BufLen = lul_MsgLen / 2
lblb_Output = Blob(Space(lul_Buflen), EncodingAnsi!)

// decode the Hexidecimal string
If Not CryptStringToBinary(as_hexstring, &
					lul_MsgLen, CRYPT_STRING_HEXRAW, lblb_Output, &
					lul_BufLen, lul_Skip, lul_pFlags) Then
	LastErrCode  = of_GetLastError(LastErrText)
	LastFunction = "CryptStringToBinary"
	SetNull(lblb_Output)
End If

Return lblb_Output

end function

public function string of_encrypthex (readonly string as_algorithm, readonly string as_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_EncryptHex
//
// PURPOSE:    This function will encrypt the blob passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_message		-	Message to be encrypted/decrypted
//					as_password		-	The password to use
//
// RETURN:		String containing encrypted/decrypted data in Hex format
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Message, lblb_Password, lblb_Encrypted

lblb_Message  = Blob(as_message, EncodingAnsi!)
lblb_Password = Blob(as_password, EncodingAnsi!)

lblb_Encrypted = of_Encrypt(as_algorithm, &
								lblb_Message, lblb_Password)

Return of_Blob2Hex(lblb_Encrypted)

end function

public function unsignedlong of_randomnbr ();// --------------------------------------------------------------------------------------
// SCRIPT:		of_RandomNbr
//
// PURPOSE:		This function returns a random number.
//
// RETURN:		ULong random number
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/20/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

ULong lul_Random

// acquire a handle to a key container
If Not CryptAcquireContext(iul_hRand, 0, &
			iCryptoProvider, iProviderType, &
			CRYPT_VERIFYCONTEXT + CRYPT_NEWKEYSET) Then
	of_ErrorCleanup("CryptAcquireContext")
	SetNull(lul_Random)
	Return lul_Random
End If

// generate random number
If Not CryptGenRandom(iul_hRand, 4, lul_Random) Then
	of_ErrorCleanup("CryptGenRandom")
	SetNull(lul_Random)
	Return lul_Random
End If

// close all handles
of_FinalCleanup()

Return lul_Random

end function

public function blob of_decrypt (readonly string as_algorithm, readonly blob ablb_message, readonly blob ablb_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Decrypt
//
// PURPOSE:    This function will decrypt the blob passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					ablb_message	-	Message to be decrypted
//					ablb_password	-	The password to use
//
// RETURN:		Blob containing decrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Decrypted
ULong lul_AlgId

choose case Upper(as_algorithm)
	case "AES128"
		lul_AlgId = CALG_AES_128
	case "AES256"
		lul_AlgId = CALG_AES_256
	case "DES"
		lul_AlgId = CALG_DES
	case "RC2"
		lul_AlgId = CALG_RC2
	case "RC4"
		lul_AlgId = CALG_RC4
	case "3DES"
		lul_AlgId = CALG_3DES
	case "3DES_112"
		lul_AlgId = CALG_3DES_112
end choose

lblb_Decrypted = of_EncryptDecrypt(lul_AlgId, &
								ablb_Message, ablb_Password, False)

Return lblb_Decrypted

end function

public function string of_decrypt (readonly string as_algorithm, readonly string as_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Decrypt
//
// PURPOSE:    This function will decrypt the string passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_message		-	Message to be decrypted
//					as_password		-	The password to use
//
// RETURN:		String containing encrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Message, lblb_Password, lblb_Decrypted

lblb_Message  = Blob(as_message, EncodingAnsi!)
lblb_Password = Blob(as_password, EncodingAnsi!)

lblb_Decrypted = of_Decrypt(as_algorithm, &
								lblb_Message, lblb_Password)

Return String(lblb_Decrypted, EncodingAnsi!)

end function

public function string of_decrypthex (readonly string as_algorithm, readonly string as_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_DecryptHex
//
// PURPOSE:    This function will decrypt the string passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_message		-	Message to be decrypted
//					as_password		-	The password to use
//
// RETURN:		String containing encrypted data in Hex format
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Message, lblb_Password, lblb_Decrypted

lblb_Message  = of_Hex2Blob(as_message)
lblb_Password = Blob(as_password, EncodingAnsi!)

lblb_Decrypted = of_Decrypt(as_algorithm, &
								lblb_Message, lblb_Password)

Return String(lblb_Decrypted, EncodingAnsi!)

end function

public function blob of_randomblob (readonly unsignedlong aul_size);// --------------------------------------------------------------------------------------
// SCRIPT:		of_RandomBlob
//
// PURPOSE:		This function returns blob containing random characters.
//
// ARGUMENTS:  aul_size	- The number of bytes in the returned blob
//
// RETURN:		Random Blob
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/20/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

Blob lblb_Random

// acquire a handle to a key container
If Not CryptAcquireContext(iul_hRand, 0, &
			iCryptoProvider, iProviderType, &
			CRYPT_VERIFYCONTEXT + CRYPT_NEWKEYSET) Then
	of_ErrorCleanup("CryptAcquireContext")
	SetNull(lblb_Random)
	Return lblb_Random
End If

// generate blob of random characters
If Not CryptGenRandom(iul_hRand, aul_size, lblb_Random) Then
	of_ErrorCleanup("CryptGenRandom")
	SetNull(lblb_Random)
	Return lblb_Random
End If

// close all handles
of_FinalCleanup()

Return lblb_Random

end function

public function string of_decode64 (string as_message);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Decode64
//
// PURPOSE:		This function converts Base64 encoded string to original string.
//
// ARGUMENTS:	as_message	-	The string the be decoded
//
// RETURN:		Decoded string
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/23/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

Blob lblob_data
ULong lul_len, lul_buflen, lul_skip, lul_pflags
String ls_decoded

SetNull(ls_decoded)

// allocate decoded buffer
lul_len = Len(as_message)
lul_buflen = lul_len
lblob_data = Blob(Space(lul_len))

// decode the Base64 string to a blob
If Not CryptStringToBinary(as_message, &
					lul_len, CRYPT_STRING_BASE64, lblob_data, &
					lul_buflen, lul_skip, lul_pflags) Then
	LastFunction = "CryptStringToBinary"
	LastErrCode  = of_GetLastError(LastErrText)
	Return ls_decoded
End If

// convert blob to a string
Return String(BlobMid(lblob_data, 1, lul_buflen), EncodingAnsi!)

end function

public function string of_encode64 (string as_message);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Encode64
//
// PURPOSE:		This function converts a string to Base64 encoding.
//
// ARGUMENTS:	as_message	-	The string the be encoded
//
// RETURN:		Encoded string
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 01/23/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

String ls_encoded
ULong lul_len, lul_buflen

SetNull(ls_encoded)

// determine size of the encoded buffer
lul_len = Len(as_message)
If Not CryptBinaryToString(as_message, lul_len, &
					CRYPT_STRING_BASE64, 0, lul_buflen) Then
	LastFunction = "CryptBinaryToString"
	LastErrCode  = of_GetLastError(LastErrText)
	Return ls_encoded
End If

// allocate encoded buffer
ls_encoded = Space(lul_buflen)

// encode the binary data as Base64 string
If Not CryptBinaryToString(as_message, lul_len, &
				CRYPT_STRING_BASE64, ls_encoded, lul_buflen) Then
	LastFunction = "CryptBinaryToString"
	LastErrCode  = of_GetLastError(LastErrText)
	Return ls_encoded
End If

Return of_ReplaceAll(ls_encoded, "~r~n", "")

end function

public function boolean of_readfile (string as_filename, ref blob ablob_filedata);// --------------------------------------------------------------------------------------
// SCRIPT:     of_ReadFile
//
// PURPOSE:    This function is used to read a file from disk to a blob.
//
// ARGUMENTS:  as_filename		- Filename
//					ablob_filedata	- By ref blob to receive the file contents
//
// RETURN:     True = Success, False = Failure
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

ULong lul_bytes, lul_length
Long ll_hFile
Blob lblob_filedata
Boolean lb_result

// get file length
lul_length = FileLength(as_filename)

// open file for read
ll_hFile = CreateFile(as_filename, GENERIC_READ, &
					FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
If ll_hFile = INVALID_HANDLE_VALUE Then
	LastErrCode  = of_GetLastError(LastErrText)
	LastFunction = "CreateFile"
	Return False
End If

// read the entire file contents in one shot
lblob_filedata = Blob(Space(lul_length), EncodingAnsi!)
lb_result = ReadFile(ll_hFile, lblob_filedata, &
					lul_length, lul_bytes, 0)
ablob_filedata = BlobMid(lblob_filedata, 1, lul_length)

// close the file
CloseHandle(ll_hFile)

Return lb_result

end function

public function boolean of_writefile (string as_filename, blob ablob_filedata);// --------------------------------------------------------------------------------------
// SCRIPT:     of_WriteFile
//
// PURPOSE:    This function writes a blob to a file on disk.
//
// ARGUMENTS:  as_filename		- The name of the file
//					ablob_filedata	- The blob data of the file
//
// RETURN:     True = Success, False = Failure
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

ULong lul_file, lul_length, lul_written
Boolean lb_rtn

lul_length = Len(ablob_filedata)

// open file for write
lul_file = CreateFile(as_filename, GENERIC_WRITE, &
					FILE_SHARE_WRITE, 0, CREATE_ALWAYS, 0, 0)
If lul_file = INVALID_HANDLE_VALUE Then
	LastErrCode  = of_GetLastError(LastErrText)
	LastFunction = "CreateFile"
	Return False
End If

// write file to disk
lb_rtn = WriteFile(lul_file, ablob_filedata, &
					lul_Length, lul_written, 0)

// close the file
CloseHandle(lul_file)

Return True

end function

public function string of_hashfile (string as_algorithm, string as_filename);// --------------------------------------------------------------------------------------
// SCRIPT:		of_HashFile
//
// PURPOSE:		This function reads a file into a blob and then returns a hash.
//
// ARGUMENTS:	as_algorithm	-	The algorithm identifier
//					as_filename		-	The name of the file
//
// RETURN:		Hash string
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

Blob lblb_content
String ls_null

If of_ReadFile(as_filename, lblb_content) Then
	Return of_Hash(as_algorithm, lblb_content)
Else
	SetNull(ls_null)
	Return ls_null
End If

end function

private function string of_hash (readonly unsignedlong aul_algid, readonly blob ablb_message);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Hash
//
// PURPOSE:		This function hashes a string using the passed algorithm id.
//
// ARGUMENTS:	aul_algid		-	The algorithm to use
//					ablb_message	-	The message to hash
//
// RETURN:		The hashed message
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

Blob lblb_Hash
String ls_Result
ULong lul_DataLen

SetNull(ls_Result)

// acquire a handle to a key container
If Not CryptAcquireContext(iul_hProv, 0, &
				iCryptoProvider, iProviderType, &
				CRYPT_VERIFYCONTEXT + CRYPT_NEWKEYSET) Then
	of_ErrorCleanup("CryptAcquireContext")
	Return ls_Result
End If

// create the hash object
If Not CryptCreateHash(iul_hProv, aul_AlgId, &
				0, 0, iul_hHash) Then
	of_ErrorCleanup("CryptCreateHash")
	Return ls_Result
End If

// import the message
If Not CryptHashData(iul_hHash, ablb_message, &
				Len(ablb_message), 0) Then
	of_ErrorCleanup("CryptHashData")
	Return ls_Result
End If

// Determine size of hash value
CryptGetHashParam(iul_hHash, HP_HASHVAL, &
				lblb_Hash, lul_DataLen, 0)

// get the resulting hash value
lblb_Hash = Blob(Space(lul_DataLen), EncodingAnsi!)
If Not CryptGetHashParam(iul_hHash, HP_HASHVAL, &
				lblb_Hash, lul_DataLen, 0) Then
	of_ErrorCleanup("CryptGetHashParam")
	Return ls_Result
End If

// close all handles
of_FinalCleanup()

// convert blob to hex string
ls_Result = of_Blob2Hex(lblb_Hash)

Return ls_Result

end function

public function string of_hash (readonly string as_algorithm, readonly blob ablb_message);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Hash
//
// PURPOSE:		This function hashes a string using the passed algorithm name.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					ablb_message	-	The message to hash
//
// RETURN:		The hashed message
//
// DATE			PROG/ID			DESCRIPTION OF CHANGE / REASON
// --------		-------------	-----------------------------------------------------------
// 02/09/2017	Roland Smith	Initial Creation
// --------------------------------------------------------------------------------------

ULong lul_AlgId

choose case Upper(as_algorithm)
	case "MD2"
		lul_AlgId = CALG_MD2
	case "MD5"
		lul_AlgId = CALG_MD5
	case "SHA1"
		lul_AlgId = CALG_SHA1
	case "SHA256"
		lul_AlgId = CALG_SHA_256
	case "SHA384"
		lul_AlgId = CALG_SHA_384
	case "SHA512"
		lul_AlgId = CALG_SHA_512
end choose

Return of_Hash(lul_AlgId, ablb_message)

end function

public function blob of_encryptfile (readonly string as_algorithm, readonly string as_filename, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_EncryptFile
//
// PURPOSE:    This function will encrypt the file passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					as_filename		-	The name of the file to encrypt
//					as_password		-	The password to use
//
// RETURN:		String containing encrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 02/09/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_FileData, lblb_Password, lblb_Encrypted

If of_ReadFile(as_filename, lblb_FileData) Then
	lblb_Password = Blob(as_password, EncodingAnsi!)
	lblb_Encrypted = of_Encrypt(as_algorithm, &
									lblb_FileData, lblb_Password)
	Return lblb_Encrypted
Else
	SetNull(lblb_Encrypted)
	Return lblb_Encrypted
End If

end function

public function string of_decrypt (readonly string as_algorithm, readonly blob ablb_message, readonly string as_password);// --------------------------------------------------------------------------------------
// SCRIPT:		of_Decrypt
//
// PURPOSE:    This function will decrypt the blob passed to it.
//
// ARGUMENTS:	as_algorithm	-	The algorithm to use
//					ablb_message	-	Message to be decrypted
//					as_password		-	The password to use
//
// RETURN:		String containing encrypted data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/19/2017	RolandS		Initial Coding
// --------------------------------------------------------------------------------------

Blob lblb_Password, lblb_Decrypted

lblb_Password = Blob(as_password, EncodingAnsi!)

lblb_Decrypted = of_Decrypt(as_algorithm, &
								ablb_message, lblb_Password)

Return String(lblb_Decrypted, EncodingAnsi!)

end function

public function datetime of_currentutc ();// -----------------------------------------------------------------------------
// SCRIPT:     of_CurrentUTC
//
// PURPOSE:    This function converts the current local time to GMT/UTC. Some
//					OAuth/REST services require this to be passed.
//
//					According to Wikipedia:
//
//					Prior to 1972, this time was called Greenwich Mean Time (GMT)
//					but is now referred to as Coordinated Universal Time or
//					Universal Time Coordinated (UTC).
//
// RETURN:		Datetime
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 09/26/2017	RolandS		Initial Coding
// -----------------------------------------------------------------------------

SYSTEMTIME lstr_Local, lstr_UTC
DateTime ldt_local, ldt_gmt

ldt_local = DateTime(Today(), Now())

lstr_Local.wYear   = Year(Date(ldt_local))
lstr_Local.wMonth  = Month(Date(ldt_local))
lstr_Local.wDay    = Day(Date(ldt_local))
lstr_Local.wHour   = Hour(Time(ldt_local))
lstr_Local.wMinute = Minute(Time(ldt_local))
lstr_Local.wSecond = Second(Time(ldt_local))
lstr_Local.wMilliSeconds = Integer(String(ldt_local, "fff"))

TzSpecificLocalTimeToSystemTime(0, lstr_Local, lstr_UTC)

ldt_gmt = DateTime(Date(lstr_UTC.wYear, &
								lstr_UTC.wMonth, &
								lstr_UTC.wDay), &
						 Time(lstr_UTC.wHour, &
								lstr_UTC.wMinute, &
								lstr_UTC.wSecond, &
								lstr_UTC.wMilliseconds))

Return ldt_gmt

end function

on n_cryptoapi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cryptoapi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

