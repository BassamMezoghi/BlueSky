$PBExportHeader$n_cst_wsock32.sru
forward
global type n_cst_wsock32 from nonvisualobject
end type
end forward

global type n_cst_wsock32 from nonvisualobject autoinstantiate
end type

type prototypes
Function uint accept (uint s,str_sockaddr addr, ref int addrlen)  Library "wsock32.dll" alias for "accept;Ansi"
Function integer bind (uint s, str_sockaddr name, int namelen)  Library "wsock32.dll" alias for "bind;Ansi"  
Function integer closesocket (uint socket) Library "wsock32.dll"  
Function integer getsockname (uint s,ref str_sockaddr name, ref int  namelen) Library "wsock32.dll" alias for "getsockname;Ansi"  
Function integer getsockopt (uint socket, int level, int optname,str_linger optval, int optlen) Library "wsock32.dll" alias for "getsockopt;Ansi"  
Function integer htons (int hostshort) Library "wsock32.dll"  
Function integer ntohs (int netshort) Library "wsock32.dll"  
Function integer listen (uint s, int backlog) Library "wsock32.dll"  
Function integer shutdown (uint s, int how) Library "wsock32.dll"  
Function integer send (int socket, ref blob buf, int len, int flags) Library "wsock32.dll"  
Function integer setsockopt (uint socket, int level, int optname,str_linger optval, int optlen) Library "wsock32.dll" alias for "setsockopt;Ansi"  
Function uint socket (int af, int ttype, int protocol) Library "wsock32.dll"  
Function integer recv (int socket, ref blob buf, int len, int flags) Library "wsock32.dll"  
Function integer wsconnect (uint socket, str_sockaddr name, int namelen) Library "wsock32.dll" alias for "connect;Ansi"
Function integer WSACleanup ()  Library "wsock32.dll"  
Function integer WSAAsyncSelect (uint socket, uint Wnd, uint wMsg, long lEvent) Library "wsock32.dll"  
Function integer WSACancelBlockingCall () Library "wsock32.dll"  
Function integer WSAGetLastError () Library "wsock32.dll"  
Function integer WSAStartup (uint wVersionRequested, ref str_wsadata lpWSAData) Library "wsock32.dll" alias for "WSAStartup;Ansi"  
Function integer gethostname(ref string name, uint namelen) library "wsock32.DLL"
function string GetHost(string lpszhost,ref blob lpszaddress) library "pbws32.dll"

end prototypes

on n_cst_wsock32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_wsock32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

