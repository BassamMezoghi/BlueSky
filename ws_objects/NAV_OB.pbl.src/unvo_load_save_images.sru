$PBExportHeader$unvo_load_save_images.sru
forward
global type unvo_load_save_images from nonvisualobject
end type
end forward

global type unvo_load_save_images from nonvisualobject
end type
global unvo_load_save_images unvo_load_save_images

forward prototypes
public function integer uf_write_to_file (string as_file_nm, string as_file_type, blob ablb_blob)
public function integer uf_clear (string as_tbl_nm, string as_blob_field_nm, string as_search_field_nm, string as_search_val)
public function blob uf_load_pic (string as_tbl_nm, string as_blob_field_nm, string as_search_field_nm, string as_search_val)
public function integer uf_add_blob (string as_tbl_nm, string as_blob_field_nm, string as_search_field_nm, string as_search_val, string as_fullname)
end prototypes

public function integer uf_write_to_file (string as_file_nm, string as_file_type, blob ablb_blob);Integer li_fileNum , li_loops , i
Long ll_file_len,ll_tot_bytes ,ll_bytes , ll_res = 0
Blob  b_temp

if (FileExists(as_file_nm)) then 
   FileDelete(as_file_nm) 
end if 

ll_file_len = LenA(ablb_blob) 

// Opens picture file 
li_fileNum = FileOpen(as_file_nm, StreamMode!, Write!, LockReadWrite!) 

// Determine how many times to call FileWrite 
IF (ll_file_len > 32765) THEN 

   // Determines how many loops we need 
   IF (Mod(ll_file_len, 32765) = 0) THEN 
    	li_loops = ll_file_len / 32765 
   ELSE 
    	li_loops = (ll_file_len / 32765) + 1 
   END IF 

  ELSE 
   	li_loops = 1 
  END IF 

  // Initializes 
  ll_tot_bytes = 1 

  // Writes blob to file 
  FOR i = 1 to li_loops
	
   	b_temp = BlobMid(ablb_blob, ll_tot_bytes, 32765) 
  	ll_bytes = FileWrite(li_fileNum, b_temp) 
   	ll_tot_bytes += ll_bytes

  NEXT 

// Closes file 
FileClose(li_fileNum) 

Return ll_res
end function

public function integer uf_clear (string as_tbl_nm, string as_blob_field_nm, string as_search_field_nm, string as_search_val);long   ll_val
DataStore lds_img
Transaction lt_temp

lt_temp = Create Transaction

lt_temp.DBMS       = SQLCA.DBMS 
lt_temp.Database   = SQLCA.Database
lt_temp.ServerName = SQLCA.ServerName 
lt_temp.Logid      = SQLCA.Logid 
lt_temp.Logpass    = SQLCA.Logpass 
lt_temp.AutoCommit = TRUE
lt_temp.dbparm			= SQLCA.dbparm

CONNECT USING lt_temp;

If lt_temp.SqlCode < 0 Then
	MessageBox("Database Error","Please contact the database administrator.",StopSign!)
	Return -1
End If

ll_val = Long(as_search_val)

lds_img = Create Datastore
lds_img.DataObject = "d_sp_clear_image"
lds_img.SetTransObject(lt_temp)
lds_img.retrieve( ll_val )
COMMIT;
return 1
end function

public function blob uf_load_pic (string as_tbl_nm, string as_blob_field_nm, string as_search_field_nm, string as_search_val);Blob lb_blob
Transaction lt_temp

lt_temp = Create Transaction

lt_temp.DBMS       		= SQLCA.DBMS 
lt_temp.Database     	= SQLCA.Database
lt_temp.ServerName 		= SQLCA.ServerName 
lt_temp.Logid   			= SQLCA.Logid  
lt_temp.Logpass 			= SQLCA.Logpass 
lt_temp.AutoCommit 		= TRUE
lt_temp.dbparm				= SQLCA.dbparm

CONNECT USING lt_temp;

If lt_temp.SqlCode < 0 Then
	MessageBox("Database Error","Please contact the database administrator.",StopSign!)
	Return lb_blob
End If

Choose Case UPPER(as_tbl_nm)
	Case "EMPLOYEES"
		SELECTBLOB EMP_PICS
			INTO :lb_blob
			FROM EMPLOYEES
			WHERE EMID = :as_search_val USING lt_temp;
	Case "STORE_CARD"
		SELECTBLOB ITEM_IMG
			INTO :lb_blob
			FROM STORE_CARD
			WHERE SC_ID = :as_search_val USING lt_temp;
	Case "SYNC_DATA"
		SELECTBLOB _BACKUP
			INTO :lb_blob
			FROM SYNC_DATA
			WHERE ID = :as_search_val USING lt_temp;	
	Case "DOCS"
		SELECTBLOB IMG
			INTO :lb_blob
			FROM DOCS
			WHERE SYSPART = :as_blob_field_nm AND PID = :as_search_field_nm AND SEQ = :as_search_val USING lt_temp;
End Choose

DISCONNECT USING lt_temp;

Destroy lt_temp;

Return lb_blob
end function

public function integer uf_add_blob (string as_tbl_nm, string as_blob_field_nm, string as_search_field_nm, string as_search_val, string as_fullname);string ls_id
integer li_FileNum, li_counter,li_loops
long    ll_bytes_read,ll_new_pos, ll_filelen ,ll_val
blob    tot_b,blob_temp,lb_tot_b,total_blob,blank_blob 

ll_val = Long(as_search_val)
Transaction lt_temp

lt_temp = Create Transaction

lt_temp.DBMS       		= SQLCA.DBMS 
lt_temp.Database		= SQLCA.Database
lt_temp.ServerName	= SQLCA.ServerName 
lt_temp.Logid      		= SQLCA.Logid 
lt_temp.Logpass    		= SQLCA.Logpass 
lt_temp.AutoCommit	= TRUE
lt_temp.dbparm			= SQLCA.dbparm

CONNECT USING lt_temp;

If lt_temp.SqlCode < 0 Then
	MessageBox("Database Error","Please contact the database administrator.",StopSign!)
	Return -1
End If

IF as_fullname <> "" THEN

//Find out how long the file specified in sle_filename.text is 
ll_filelen = FileLength( as_fullname ) 

//Assign Open for read, and assign a filenumber to the specified file 
li_filenum = FileOpen(as_fullname, STREAMMODE!,READ!,LOCKREAD!) 

//Determine how many FileReads will be necessary to read all of the file 

//You can't read in more than 32K at a time 
IF ll_filelen > 32765 THEN 
     IF Mod(ll_filelen,32765) = 0 THEN 
         li_loops = ll_filelen/32765 
     ELSE 
         li_loops = (ll_filelen/32765) + 1 
     END IF 
ELSE 
     li_loops = 1 
END IF 

//read the file ... 
FOR li_counter = 1 to li_loops 
	
     ll_bytes_read = FileRead(li_filenum,blob_temp) 
     lb_tot_b      = lb_tot_b + blob_temp 
     ll_new_pos    = ll_new_pos + ll_bytes_read 
	  
     FileSeek(li_filenum,ll_new_pos,FROMBEGINNING!) 

     if LenA(lb_tot_b) > 1000000 then 
		
         total_blob = total_blob + lb_tot_b 
         lb_tot_b   = blank_blob 
			
     end if 
	  
NEXT 

total_blob = total_blob + lb_tot_b 

FileClose(li_filenum) 
ELSE
	setNull(total_blob)
END IF

Choose Case UPPER(as_tbl_nm)
	Case "EMPLOYEES"
			UPDATEBLOB EMPLOYEES
				SET EMP_PICS = :total_blob
				WHERE EMID = :ll_val USING lt_temp ;
	Case "STORE_CARD"
			UPDATEBLOB STORE_CARD
				SET ITEM_IMG = :total_blob
				WHERE SC_ID = :ll_val USING lt_temp ;
	Case "SYNC_DATA"
			UPDATEBLOB SYNC_DATA
				SET _BACKUP = :total_blob
				WHERE ID = :ll_val USING lt_temp ;
	Case "DOCS"
			ls_id = String(as_search_field_nm)			
			UPDATEBLOB DOCS
				SET IMG = :total_blob
				WHERE SYSPART = :as_blob_field_nm AND PID = :ls_id AND SEQ = :ll_val USING lt_temp;
End Choose

If(lt_temp.sqlcode < 0 )Then
	MessageBox("",lt_temp.sqlerrtext )
	DISCONNECT Using lt_temp;
   	Destroy lt_temp;
	return -2
End if

if( lt_temp.SQLNRows > 0 )then

	 COMMIT USING lt_temp;

	 DISCONNECT Using lt_temp;

   Destroy lt_temp;

    Return 1
    	 
End If

DISCONNECT using lt_temp;

Destroy lt_temp;

return 0
end function

on unvo_load_save_images.create
call super::create
TriggerEvent( this, "constructor" )
end on

on unvo_load_save_images.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

