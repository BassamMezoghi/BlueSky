$PBExportHeader$nvo_file.sru
forward
global type nvo_file from n_base
end type
end forward

global type nvo_file from n_base autoinstantiate
end type

forward prototypes
public function long of_filesize (string as_filename)
public function String of_filetype (string as_filename)
end prototypes

public function long of_filesize (string as_filename);String ls_path, ls_file, ls_test
str_pass_parmeters lstr_parm
Long ll_ret
OLEObject obj_shell, obj_folder, obj_item

obj_shell = CREATE OLEObject
obj_shell.ConnectToNewObject( 'shell.application' )

ls_path = Left( as_filename, LastPos( as_filename, "\" ) )
ls_file = Mid( as_filename, LastPos( as_filename, "\" ) + 1 )

IF FileExists( as_filename ) THEN
    obj_folder = obj_shell.NameSpace( ls_path )
    
    IF IsValid( obj_folder ) THEN
        obj_item = obj_folder.ParseName( ls_file )
        
        IF IsValid( obj_item ) THEN
            ls_test = obj_folder.GetDetailsOf( obj_item, 1 )
				lstr_parm = gnv_services.of_split( ls_test , " ")
				IF lstr_parm.string_parm[2] = "MB" THEN
					ll_ret = Long(lstr_parm.string_parm[1] ) * 1024
				ELSE
					ll_ret = Long(lstr_parm.string_parm[1] ) 
				END IF
          
        END IF
    END IF
END IF

DESTROY obj_shell
DESTROY obj_folder
DESTROY obj_item

RETURN ll_ret
end function

public function String of_filetype (string as_filename);String ls_path, ls_file, ls_ret
OLEObject obj_shell, obj_folder, obj_item

obj_shell = CREATE OLEObject
obj_shell.ConnectToNewObject( 'shell.application' )

ls_path = Left( as_filename, LastPos( as_filename, "\" ) )
ls_file = Mid( as_filename, LastPos( as_filename, "\" ) + 1 )

IF FileExists( as_filename ) THEN
    obj_folder = obj_shell.NameSpace( ls_path )
    
    IF IsValid( obj_folder ) THEN
        obj_item = obj_folder.ParseName( ls_file )
        
        IF IsValid( obj_item ) THEN
            ls_ret = obj_folder.GetDetailsOf( obj_item, 2 )
        END IF
    END IF
END IF

DESTROY obj_shell
DESTROY obj_folder
DESTROY obj_item

RETURN ls_ret
end function

on nvo_file.create
call super::create
end on

on nvo_file.destroy
call super::destroy
end on

