$PBExportHeader$n_cst_odbc32.sru
$PBExportComments$Creator: Thomas Jنckel email: jaeckel@netcologne.de 1999
forward
global type n_cst_odbc32 from nonvisualobject
end type
end forward

global type n_cst_odbc32 from nonvisualobject
end type
global n_cst_odbc32 n_cst_odbc32

type prototypes

FUNCTION integer SQLAllocEnv (REF ulong henv) LIBRARY "ODBC32.DLL";

FUNCTION integer SQLFreeEnv(ulong henv)  LIBRARY "ODBC32.DLL";

FUNCTION integer SQLDataSources( ulong henv,  &
				integer fDirection, &
				ref string szDSN, &
				integer cbDSNMax, &
				ref integer pcbDSN,  &
				ref string szDescription, &
				integer cbDescriptionMax, &
				ref integer pcbDescription) LIBRARY "ODBC32.DLL" alias for "SQLDataSources;Ansi";

FUNCTION integer SQLAllocConnect( ulong henv,  ref ulong phdbc) LIBRARY "ODBC32.DLL";

FUNCTION integer SQLFreeConnect( ulong hdbc) LIBRARY "ODBC32.DLL";

FUNCTION integer SQLConnect( ulong hdbc, &
			     string szDSN, &
			integer cbDSN, &
			string szUID, &
			integer cbUID, & 
			string szAuthStr, & 
			integer cbAuthStr) LIBRARY "ODBC32.DLL" alias for "SQLConnect;Ansi";
  
FUNCTION integer SQLDisconnect( ulong hdbc) LIBRARY "ODBC32.DLL";

FUNCTION integer SQLAllocStmt( ulong hdbc, ref ulong phstmt) LIBRARY "ODBC32.DLL";

FUNCTION integer SQLFreeStmt( ulong hstmt, integer fOption) LIBRARY "ODBC32.DLL";
  
FUNCTION integer SQLTables( ulong hstmt, &
			string szTableQualifier, &
			integer cbTableQualifier, &
			string szTableOwner, &
			integer cbTableOwner, &
			string szTableName, &
			integer cbTableName, &
			string szTableType, &
			integer cbTableType) LIBRARY "ODBC32.DLL" alias for "SQLTables;Ansi";
  
FUNCTION integer SQLBindCol( ulong hstmt, &
			uint icol,   &
			integer fCType, &
			ref string rgbValue, &
			long cbValueMax, &
			ref long pcbValue) LIBRARY "ODBC32.DLL" alias for "SQLBindCol;Ansi";

FUNCTION integer SQLColumns( ulong hstmt, &
			string szTableQualifier, &
			integer cbTableQualifier, &
			string szTableOwner, &
			integer cbTableOwner, &
			string szTableName, &
			integer cbTableName, &
			string szColumnName, &
			integer cbColumnName) LIBRARY "ODBC32.DLL" alias for "SQLColumns;Ansi";
									  
FUNCTION integer SQLFetch( ulong hstmt) LIBRARY "ODBC32.DLL";

end prototypes

type variables
// ODBC Operationscodes (not complete!!!)
constant integer SQL_FETCH_NEXT  = 1;
constant integer SQL_FETCH_FIRST = 2;

// ODBC Returncodes (complete!!)
constant integer SQL_INVALID_HANDLE       = (-2);
constant integer SQL_ERROR                = (-1);
constant integer SQL_SUCCESS              = 0;
constant integer SQL_SUCCESS_WITH_INFO  	= 1;
constant integer SQL_NO_DATA_FOUND			= 100;

// /* SQLFreeStmt defines */
constant integer SQL_CLOSE                = 0;
constant integer SQL_DROP                 = 1;
constant integer SQL_UNBIND               = 2;
constant integer SQL_RESET_PARAMS         = 3;

// SQL datatypes
constant integer SQL_CHAR                 = 1;
constant integer SQL_NUMERIC              = 2;
constant integer SQL_DECIMAL              = 3;
constant integer SQL_INTEGER              = 4;
constant integer SQL_SMALLINT             = 5;
constant integer SQL_FLOAT                = 6;
constant integer SQL_REAL                 = 7;
constant integer SQL_DOUBLE               = 8;
constant integer SQL_VARCHAR              = 12;

// C datatype to SQL datatype mapping      SQL types  */
constant integer SQL_C_CHAR    = SQL_CHAR             /* CHAR, VARCHAR, DECIMAL, NUMERIC */
constant integer SQL_C_LONG    = SQL_INTEGER          /* INTEGER                      */
constant integer SQL_C_SHORT   = SQL_SMALLINT         /* SMALLINT                     */
constant integer SQL_C_FLOAT   = SQL_REAL             /* REAL                         */
constant integer SQL_C_DOUBLE  = SQL_DOUBLE           /* FLOAT, DOUBLE                */
constant integer SQL_C_DEFAULT = 99

/* SQL extended datatypes */
constant integer SQL_DATE                  = 9
constant integer SQL_TIME                  = 10
constant integer SQL_TIMESTAMP             = 11
constant integer SQL_LONGVARCHAR           = (-1)

constant integer SQL_BINARY                = (-2)
constant integer SQL_VARBINARY             = (-3)
constant integer SQL_LONGVARBINARY         = (-4)
constant integer SQL_BIGINT                = (-5)
constant integer SQL_TINYINT               = (-6)
constant integer SQL_BIT                   = (-7)

constant integer SQL_INTERVAL_YEAR           = (-80)
constant integer SQL_INTERVAL_MONTH          = (-81)
constant integer SQL_INTERVAL_YEAR_TO_MONTH  = (-82)
constant integer SQL_INTERVAL_DAY            = (-83)
constant integer SQL_INTERVAL_HOUR           = (-84)
constant integer SQL_INTERVAL_MINUTE         = (-85)
constant integer SQL_INTERVAL_SECOND         = (-86)
constant integer SQL_INTERVAL_DAY_TO_HOUR    = (-87)
constant integer SQL_INTERVAL_DAY_TO_MINUTE  = (-88)
constant integer SQL_INTERVAL_DAY_TO_SECOND  = (-89)
constant integer SQL_INTERVAL_HOUR_TO_MINUTE = (-90)
constant integer SQL_INTERVAL_HOUR_TO_SECOND = (-91)
constant integer SQL_INTERVAL_MINUTE_TO_SECOND = (-92)
constant integer SQL_UNICODE                 = (-95)
constant integer SQL_UNICODE_VARCHAR         = (-96)
constant integer SQL_UNICODE_LONGVARCHAR     = (-97)
constant integer SQL_UNICODE_CHAR            = SQL_UNICODE

constant integer SQL_TYPE_DRIVER_START       = SQL_INTERVAL_YEAR
constant integer SQL_TYPE_DRIVER_END         = SQL_UNICODE_LONGVARCHAR


constant integer SQL_SIGNED_OFFSET           = (-20)
constant integer SQL_UNSIGNED_OFFSET         = (-22)

/* C datatype to SQL datatype mapping */
constant integer SQL_C_DATE       		= SQL_DATE
constant integer SQL_C_TIME       		= SQL_TIME
constant integer SQL_C_TIMESTAMP  		= SQL_TIMESTAMP
constant integer SQL_C_BINARY     		= SQL_BINARY
constant integer SQL_C_BIT        		= SQL_BIT
constant integer SQL_C_TINYINT    		= SQL_TINYINT
constant integer SQL_C_SLONG      		= SQL_C_LONG+SQL_SIGNED_OFFSET    /* SIGNED INTEGER   */
constant integer SQL_C_SSHORT     		= SQL_C_SHORT+SQL_SIGNED_OFFSET   /* SIGNED SMALLINT  */
constant integer SQL_C_STINYINT   		= SQL_TINYINT+SQL_SIGNED_OFFSET   /* SIGNED TINYINT   */
constant integer SQL_C_ULONG      		= SQL_C_LONG+SQL_UNSIGNED_OFFSET  /* UNSIGNED INTEGER */
constant integer SQL_C_USHORT     		= SQL_C_SHORT+SQL_UNSIGNED_OFFSET /* UNSIGNED SMALLINT*/
constant integer SQL_C_UTINYINT   		= SQL_TINYINT+SQL_UNSIGNED_OFFSET /* UNSIGNED TINYINT */
constant integer SQL_C_BOOKMARK   		= SQL_C_ULONG                     /* BOOKMARK         */

end variables

on n_cst_odbc32.create
TriggerEvent( this, "constructor" )
end on

on n_cst_odbc32.destroy
TriggerEvent( this, "destructor" )
end on

