$PBExportHeader$n_cst_guidb.sru
forward
global type n_cst_guidb from n_base
end type
end forward

global type n_cst_guidb from n_base
end type
global n_cst_guidb n_cst_guidb

type variables
Public :
	String is_SystemPart
	DataStore ids_GUIDB
end variables

forward prototypes
public subroutine of_load (string syspart)
public function string of_filter (string ar_section, string ar_id, string ar_default)
public subroutine of_add (string as_syspart, string as_section, string as_id, string as_val)
public subroutine of_save ()
public subroutine of_apply_gui (string as_section, ref u_dw ar_dw)
public subroutine of_apply_gui (string as_systempart, string as_section, ref u_dw ar_dw)
public subroutine of_generate_gui (string as_systempart, string as_section, ref u_dw ar_dw)
end prototypes

public subroutine of_load (string syspart);ids_guidb.SetTransObject( SQLCA )
ids_guidb.Retrieve( gs_lan , syspart )


end subroutine

public function string of_filter (string ar_section, string ar_id, string ar_default);String ls_res
Long ll_row

ls_res = ar_default

ll_row = ids_guidb.Find(" Section='"+ar_section+"' and ID='"+ar_id+"' " , 1, ids_guidb.RowCount() ) 

IF ll_row > 0 THEN ls_res = ids_guidb.GetItemString( ll_row , "VAL" ) 

Return ls_res



end function

public subroutine of_add (string as_syspart, string as_section, string as_id, string as_val);Long ll_row

IF of_Filter(as_section ,as_id , "-") = "-" THEN
	
	ll_row = ids_guidb.Insertrow( 0 )
	
	ids_guidb.SetItem(ll_row , "LANG" , gs_lan)
	ids_guidb.SetItem(ll_row , "SYSPART" , as_syspart)
	ids_guidb.SetItem(ll_row , "SECTION" , as_section)
	ids_guidb.SetItem(ll_row , "ID" , as_id)
	ids_guidb.SetItem(ll_row , "VAL" , as_val)

END IF
end subroutine

public subroutine of_save ();ids_guidb.update( )

Commit;
end subroutine

public subroutine of_apply_gui (string as_section, ref u_dw ar_dw);Long li_col_idx,li_pos 
String  ls_objects, ls_control,ls_type, ls_visible
Long ll_StartPos , ll_Rows , ll_pos, ll_tag
Boolean lb_change = False , lb_itr_change = True
str_Objects lstr_Object[] ,lstr_Sort[]

IF is_SystemPart = "" THEN Return

li_col_idx = 1
ls_objects = ar_dw.object.datawindow.objects 

Do While ls_Objects <> ""
	   	 
		 li_pos = Pos(ls_objects, "~t")

		 IF li_pos > 0 THEN
			  lstr_Object[li_col_idx].obj = left(ls_objects, li_pos - 1)			  
			  ls_objects = mid(ls_objects, li_pos + 1)
		 ELSE
			  lstr_Object[li_col_idx].obj = ls_objects
			  ls_objects = ""
		 END IF
		 
		 IF IsNumber(ar_dw.describe( lstr_Object[li_col_idx].obj + ".tag")) THEN  
					lstr_Object[li_col_idx].tag = Long(ar_dw.describe( lstr_Object[li_col_idx].obj + ".tag"))
		 ELSE
					lstr_Object[li_col_idx].tag = 60000
		 END IF

		 li_col_idx++
		 
LOOP

ll_Rows = UPPERBOUND(lstr_Object)

FOR ll_pos = 1 TO ll_Rows
	
		//IF csGui.of_filter( as_section, lstr_Object[ll_pos].obj+".visible" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".visible")) = "0" THEN

		ar_dw.Modify( lstr_Object[ll_pos].obj + ".visible="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".visible" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".visible")) )			
			
		//END IF
	
		 ls_type 		= ar_dw.describe( lstr_Object[ll_pos].obj + ".type")
		 ls_visible 	= ar_dw.describe( lstr_Object[ll_pos].obj + ".visible")
		 
		 
 		 IF ls_visible = "1" THEN

			ar_dw.Modify( lstr_Object[ll_pos].obj + ".x="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".x" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".x")) )
	  	   ar_dw.Modify( lstr_Object[ll_pos].obj + ".y="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".y" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".y")) )
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".width="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".width" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".width")) )
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".height="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".height" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".height")) )
			
			 IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".righttoleft" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".righttoleft="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".righttoleft" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".righttoleft")) )
			 END IF

			 IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".alignment" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".alignment="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".alignment" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".alignment")) )
			 END IF

			 IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".font.weight" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".font.weight='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".font.weight" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".font.weight")) +"'")
			 END IF

			 IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".font.height" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".font.height='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".font.height" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".font.height")) +"'")
			 END IF

			
		END IF
		
		 IF ls_type = "column" AND ls_visible = "1" THEN
			
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".format='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".format" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".format")) +"'")
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".tabsequence='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".tabsequence" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tabsequence")) +"'")
			
			IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , "?") <> "?" THEN
				
				IF ar_dw.Describe(lstr_Object[ll_pos].obj +".editmask.ddcalendar") = "yes" THEN	
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.mask='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".editmask.mask"))+"'")
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.ddcalendar=yes" )
				ELSE
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.mask='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".editmask.mask"))+"'")
				END  IF	
			END IF

			IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".values" , "!") <> "!" THEN 	ar_dw.Modify( lstr_Object[ll_pos].obj + ".values='"+This.of_filter( as_section, lstr_Object[ll_pos].obj+".values" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".values") )+"'" )
			
			IF This.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.name" , "?") <> "?" THEN
				
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.name="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.name" , ar_dw.Describe(ls_control + ".dddw.name") ) )
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.datacolumn="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.datacolumn" , ar_dw.Describe(ls_control + ".dddw.datacolumn")) )
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.displaycolumn="+This.of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.displaycolumn" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".dddw.displaycolumn")) )
				
			END IF
			
		 END IF
		 
		 IF ( ls_type = "text" or ls_type = "groupbox") AND ls_visible = "1" THEN
			
			  ar_dw.Modify( lstr_Object[ll_pos].obj + '.text="'+This.of_filter( as_section, lstr_Object[ll_pos].obj+".text" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".text"))+'"')

		 END IF
		 
		 IF ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.enabled") = "1" THEN
			ar_dw.Modify( lstr_Object[ll_pos].obj + '.tooltip.tip="'+This.of_filter( as_section, lstr_Object[ll_pos].obj+".tooltip.tip" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.tip"))+'"')
			IF ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.title") <> "?" THEN		ar_dw.Modify( lstr_Object[ll_pos].obj + '.tooltip.title="'+This.of_filter( as_section, lstr_Object[ll_pos].obj+".tooltip.title" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.title"))+'"')		
		END IF
		 
	NEXT 

end subroutine

public subroutine of_apply_gui (string as_systempart, string as_section, ref u_dw ar_dw);Long li_col_idx,li_pos 
String  ls_objects, ls_control,ls_type, ls_visible
Long ll_StartPos , ll_Rows , ll_pos, ll_tag
Boolean lb_change = False , lb_itr_change = True
str_Objects lstr_Object[] ,lstr_Sort[]

IF is_SystemPart = "" THEN Return

ar_dw.setredraw( False )

li_col_idx = 1
ls_objects = ar_dw.object.datawindow.objects 

Do While ls_Objects <> ""
	   	 
		 li_pos = Pos(ls_objects, "~t")

		 IF li_pos > 0 THEN
			  lstr_Object[li_col_idx].obj = left(ls_objects, li_pos - 1)			  
			  ls_objects = mid(ls_objects, li_pos + 1)
		 ELSE
			  lstr_Object[li_col_idx].obj = ls_objects
			  ls_objects = ""
		 END IF
		 
		 IF IsNumber(ar_dw.describe( lstr_Object[li_col_idx].obj + ".tag")) THEN  
					lstr_Object[li_col_idx].tag = Long(ar_dw.describe( lstr_Object[li_col_idx].obj + ".tag"))
		 ELSE
					lstr_Object[li_col_idx].tag = 60000
		 END IF

		 li_col_idx++
		 
LOOP

ll_Rows = UPPERBOUND(lstr_Object)

FOR ll_pos = 1 TO ll_Rows
	
		 ls_type 		= ar_dw.describe( lstr_Object[ll_pos].obj + ".type")
		 ls_visible 	= ar_dw.describe( lstr_Object[ll_pos].obj + ".visible")
		 
		 IF of_filter( as_section, lstr_Object[ll_pos].obj+".visible" , "0") = "0" THEN 
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".visible=0" )
			Continue
		END IF
		
		 IF ls_visible = "1" THEN

			ar_dw.Modify( lstr_Object[ll_pos].obj + ".x="+of_filter( as_section, lstr_Object[ll_pos].obj+".x" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".x")) )
	  	   	ar_dw.Modify( lstr_Object[ll_pos].obj + ".y="+of_filter( as_section, lstr_Object[ll_pos].obj+".y" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".y")) )
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".width="+of_filter( as_section, lstr_Object[ll_pos].obj+".width" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".width")) )
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".height="+of_filter( as_section, lstr_Object[ll_pos].obj+".height" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".height")) )
			
			 IF of_filter( as_section, lstr_Object[ll_pos].obj+".righttoleft" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".righttoleft="+of_filter( as_section, lstr_Object[ll_pos].obj+".righttoleft" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".righttoleft")) )
			 END IF

			 IF of_filter( as_section, lstr_Object[ll_pos].obj+".alignment" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".alignment="+of_filter( as_section, lstr_Object[ll_pos].obj+".alignment" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".alignment")) )
			 END IF

			 IF of_filter( as_section, lstr_Object[ll_pos].obj+".font.weight" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".font.weight='"+of_filter( as_section, lstr_Object[ll_pos].obj+".font.weight" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".font.weight")) +"'")
			 END IF

			 IF of_filter( as_section, lstr_Object[ll_pos].obj+".font.height" , "!") <> "!" THEN
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".font.height='"+of_filter( as_section, lstr_Object[ll_pos].obj+".font.height" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".font.height")) +"'")
			 END IF

			
		END IF
		
		 IF ls_type = "column" AND ls_visible = "1" THEN
			
			ar_dw.Modify( lstr_Object[ll_pos].obj + ".format='"+of_filter( as_section, lstr_Object[ll_pos].obj+".format" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".format")) +"'")
			IF of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , "?") <> "?" THEN
				
				IF ar_dw.Describe(lstr_Object[ll_pos].obj +".editmask.ddcalendar") = "yes" THEN	
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.mask='"+of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".editmask.mask"))+"'")
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.ddcalendar=yes" )
				ELSE
					ar_dw.Modify( lstr_Object[ll_pos].obj + ".editmask.mask='"+of_filter( as_section, lstr_Object[ll_pos].obj+".editmask.mask" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".editmask.mask"))+"'")
				END  IF	
			END IF

			IF of_filter( as_section, lstr_Object[ll_pos].obj+".values" , "!") <> "!" THEN 	ar_dw.Modify( lstr_Object[ll_pos].obj + ".values='"+of_filter( as_section, lstr_Object[ll_pos].obj+".values" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".values") )+"'" )
			
			IF of_filter( as_section, lstr_Object[ll_pos].obj+".checkbox.text" , "?") <> "?" THEN 	ar_dw.Modify( lstr_Object[ll_pos].obj + ".checkbox.text='"+of_filter( as_section, lstr_Object[ll_pos].obj+".checkbox.text" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".checkbox.text") )+"'" )

			IF of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.name" , "?") <> "?" THEN
				
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.name="+of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.name" , ar_dw.Describe(ls_control + ".dddw.name") ) )
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.datacolumn="+of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.datacolumn" , ar_dw.Describe(ls_control + ".dddw.datacolumn")) )
				ar_dw.Modify( lstr_Object[ll_pos].obj + ".dddw.displaycolumn="+of_filter( as_section, lstr_Object[ll_pos].obj+".dddw.displaycolumn" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".dddw.displaycolumn")) )
				
			END IF
			
		 END IF
		 
		 IF ( ls_type = "text" or ls_type = "groupbox") AND ls_visible = "1" THEN
			
			  ar_dw.Modify( lstr_Object[ll_pos].obj + '.text="'+of_filter( as_section, lstr_Object[ll_pos].obj+".text" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".text"))+'"')

		 END IF
		 
		 IF ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.enabled") = "1" THEN
			ar_dw.Modify( lstr_Object[ll_pos].obj + '.tooltip.tip="'+of_filter( as_section, lstr_Object[ll_pos].obj+".tooltip.tip" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.tip"))+'"')
			IF ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.title") <> "?" THEN		ar_dw.Modify( lstr_Object[ll_pos].obj + '.tooltip.title="'+of_filter( as_section, lstr_Object[ll_pos].obj+".tooltip.title" , ar_dw.Describe(lstr_Object[ll_pos].obj + ".tooltip.title"))+'"')		
		END IF
		 
	NEXT 


ar_dw.setredraw( True )
end subroutine

public subroutine of_generate_gui (string as_systempart, string as_section, ref u_dw ar_dw);
Integer li_col_idx, &
        li_pos

String  ls_objects, &
        ls_control, &
        ls_columns[], &
        ls_type, &
        ls_visible


li_col_idx = 1
ls_objects = ar_dw.object.datawindow.objects 

DO while ls_objects <> ""
   	 	li_pos = Pos(ls_objects, "~t")

		 IF li_pos > 0 THEN
			  ls_control = left(ls_objects, li_pos - 1)
			  ls_objects = mid(ls_objects, li_pos + 1)
		 ELSE
			  ls_control = ls_objects
			  ls_objects = ""
		 END IF
	
		 ls_type = ar_dw.describe(ls_control + ".type")
		 ls_visible = ar_dw.describe(ls_control + ".visible")
		 of_add( as_systempart  , as_section, ls_control+".visible", ar_dw.Describe(ls_control + ".visible") )
		 
		 IF ls_visible = "1" THEN

			 of_add( as_systempart  , as_section, ls_control+".x", ar_dw.Describe(ls_control + ".x") )
			 of_add( as_systempart  , as_section, ls_control+".y", ar_dw.Describe(ls_control + ".y") )
			 of_add( as_systempart  , as_section, ls_control+".width", ar_dw.Describe(ls_control + ".width") )
			 of_add( as_systempart  , as_section, ls_control+".height", ar_dw.Describe(ls_control + ".height") )
 			 of_add( as_systempart  , as_section, ls_control+".font.weight", ar_dw.Describe(ls_control + ".font.weight") )
			 of_add( as_systempart  , as_section, ls_control+".font.height", ar_dw.Describe(ls_control + ".font.height") )
 
			 IF ar_dw.Describe(ls_control + ".righttoleft") <> "!" THEN
						of_add( as_systempart , as_section, ls_control+".righttoleft", ar_dw.Describe(ls_control + ".righttoleft") )
			 END IF

			 IF ar_dw.Describe(ls_control + ".alignment") <> "!" THEN
						of_add( as_systempart  , as_section, ls_control+".alignment", ar_dw.Describe(ls_control + ".alignment") )
			 END IF

		END IF
		 
		 IF ls_type = "column" AND ls_visible = "1" THEN 
			
			  of_add( as_systempart  , as_section, ls_control+".format", ar_dw.Describe(ls_control + ".format") )
			  IF ar_dw.Describe(ls_control + ".editmask.mask") <> "?" THEN
			  	 of_add( as_systempart  , as_section, ls_control+".editmask.mask", ar_dw.Describe(ls_control + ".editmask.mask") )			  
			  END IF
			  
			IF ar_dw.Describe(ls_control + ".dddw.name") <> "?" THEN
				
				of_add( as_systempart  , as_section, ls_control+".dddw.name", ar_dw.Describe(ls_control + ".dddw.name") )
				of_add( as_systempart  , as_section, ls_control+".dddw.datacolumn", ar_dw.Describe(ls_control + ".dddw.datacolumn") )
				of_add( as_systempart  , as_section, ls_control+".dddw.displaycolumn", ar_dw.Describe(ls_control + ".dddw.displaycolumn") )
							
			END IF
			
			IF ar_dw.Describe(ls_control + ".checkbox.text") <> "?" THEN
				of_add( as_systempart  , as_section, ls_control+".checkbox.text", ar_dw.Describe(ls_control + ".checkbox.text") )
			END IF

		
		 END IF
		 
		 IF ( ls_type = "text" or ls_type = "groupbox") AND ls_visible = "1" THEN
			
			  of_add( as_systempart  , as_section, ls_control+".text", ar_dw.Describe(ls_control + ".text") )

		 END IF
		 
		IF ar_dw.Describe(ls_control + ".tooltip.enabled") = "1" THEN
			of_add( as_systempart  , as_section, ls_control+".tooltip.tip", ar_dw.Describe(ls_control + ".tooltip.tip") )
			of_add( as_systempart  , as_section, ls_control+".tooltip.title", ar_dw.Describe(ls_control + ".tooltip.title") )			
		END IF
		
		IF ar_dw.Describe(ls_control + ".values") <> "?" and ar_dw.Describe(ls_control + ".values") <> "!" THEN
			of_add( as_systempart  , as_section, ls_control+".values", ar_dw.Describe(ls_control + ".values") )
		END IF
		
LOOP

of_save( )

end subroutine

on n_cst_guidb.create
call super::create
end on

on n_cst_guidb.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_guidb = Create DataStore
ids_guidb.DataObject = "d_gui"



end event

