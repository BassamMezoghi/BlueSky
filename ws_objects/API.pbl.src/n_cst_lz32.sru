$PBExportHeader$n_cst_lz32.sru
forward
global type n_cst_lz32 from nonvisualobject
end type
end forward

global type n_cst_lz32 from nonvisualobject
end type
global n_cst_lz32 n_cst_lz32

type prototypes
Function long LZCopy ( int hfsource, int hfdest ) Library "LZ32.DLL"
Subroutine LZClose (int hfile) Library "LZ32.DLL"
Function int LZOpenFile (ref string lpfilename, ref OFSTRUCT lpreopenbuf, long wstyle) Library "LZ32.DLL" Alias for "LZOpenFileA;Ansi"
end prototypes

type variables
public:
/*
** Error Return Codes
*/

constant int LZERROR_BADINHANDLE   = -1  /* invalid input handle */
constant int LZERROR_BADOUTHANDLE  = -2  /* invalid output handle */
constant int LZERROR_READ          = -3  /* corrupt compressed file format */
constant int LZERROR_WRITE         = -4  /* out of space for output file */
constant int LZERROR_GLOBALLOC     = -5  /* insufficient memory for LZFile struct */
constant int LZERROR_GLOBLOCK      = -6  /* bad global handle */
constant int LZERROR_BADVALUE      = -7  /* input parameter out of acceptable range*/
constant int LZERROR_UNKNOWNALG    = -8  /* compression algorithm not recognized */

constant int OFS_MAXPATHNAME = 128
end variables

on n_cst_lz32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_lz32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

