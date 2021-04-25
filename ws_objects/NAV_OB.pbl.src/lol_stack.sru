$PBExportHeader$lol_stack.sru
forward
global type lol_stack from nonvisualobject
end type
end forward

global type lol_stack from nonvisualobject
end type
global lol_stack lol_stack

type variables
Long il_index = 1
Long il_ptr = 1
Long il_Max = 1
str_stack istr_stack[]
end variables

forward prototypes
public subroutine of_push (str_stack astr)
public function str_stack of_pop ()
public function boolean of_isempty ()
public function str_stack of_popfirst ()
end prototypes

public subroutine of_push (str_stack astr);istr_stack[il_index] = astr

il_index++
il_Max = UpperBound(istr_stack)

return 
end subroutine

public function str_stack of_pop ();str_stack lstr

il_index --

lstr = istr_stack[il_index]

return lstr
end function

public function boolean of_isempty ();if(il_index = 1 Or il_Max < il_ptr)then
  return True
else
  return False
end if
end function

public function str_stack of_popfirst ();str_stack lstr

lstr = istr_stack[il_ptr]

il_ptr++

return lstr
end function

on lol_stack.create
call super::create
TriggerEvent( this, "constructor" )
end on

on lol_stack.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

