$PBExportHeader$u_toolbar.sru
forward
global type u_toolbar from nonvisualobject
end type
end forward

global type u_toolbar from nonvisualobject
end type
global u_toolbar u_toolbar

forward prototypes
public subroutine restore (window win, string file, string section)
public subroutine save (window win, string file, string section)
end prototypes

public subroutine restore (window win, string file, string section);// Restore toolbar settings for the passed window

integer index, row, offset, x, y, w, h
boolean visible
string visstring, alignstring, title
toolbaralignment alignment

FOR index = 1 to 16
  // Try to get the attributes for the bar.
  IF win.GetToolbar(index, visible, alignment, &
    title)= 1 THEN
    // Try to get the attributes from the .ini
    // file
    visstring = ProfileString(file, section +  &
      String(index), "visible", "")
    IF visstring > "" THEN
      // Get all of the attributes
      alignstring = ProfileString(file, section +  &
        String(index), "alignment", "left")
      title = ProfileString(file, section +  &
        String(index), "title", "(Untitled)")
      row = Integer(ProfileString(file, section +  &
        String(index), "row", "1"))
      offset = Integer(ProfileString(file, &
        section + String(index), "offset", "0"))
      x = Integer(ProfileString(file, section +  &
        String(index), "x", "0"))
      y = Integer(ProfileString(file, section +  &
        String(index), "y", "0"))
      w = Integer(ProfileString(file, section +  &
        String(index), "w", "0"))
      h = Integer(ProfileString(file, section +  &
        String(index), "h", "0"))

      // Convert visstring to a boolean
      CHOOSE CASE visstring
      CASE "true"
        visible = true
      CASE "false"
        visible = false
      END CHOOSE

      // Convert alignstring to toolbaralignment
      CHOOSE CASE alignstring
      CASE "left"
        alignment = AlignAtLeft!
      CASE "top"
        alignment = AlignAtTop!
      CASE "right"
        alignment = AlignAtRight!
      CASE "bottom"
        alignment = AlignAtBottom!
      CASE "floating"
        alignment = Floating!
      END CHOOSE

      // Set the new position
      win.SetToolbar(index, visible, alignment, title)
      win.SetToolbarPos(index, row, offset, false)
      win.SetToolbarPos(index, x, y, w, h)
    END IF
  END IF
NEXT

end subroutine

public subroutine save (window win, string file, string section);// Store the toolbar settings for the passed window
integer index, row, offset, x, y, w, h
boolean visible
string visstring, alignstring, title
toolbaralignment alignment
FOR index = 1 to 16 

// Try to get the attributes for the bar.   
IF win.GetToolbar(index, visible, alignment, &
   title)= 1 THEN   
   // Convert visible to a string
   CHOOSE CASE visible
   CASE true
      visstring = "true"
   CASE false   
      visstring = "false"   
   END CHOOSE// Convert alignment to a string   

   CHOOSE CASE alignment      
   CASE AlignAtLeft!      
      alignstring = "left"
   CASE AlignAtTop!
      alignstring = "top"      
   CASE AlignAtRight!      
      alignstring = "right"      
   CASE AlignAtBottom!      
      alignstring = "bottom"      
   CASE Floating!      
      alignstring = "floating"
   END CHOOSE

   // Save the basic attributes   
   SetProfileString(file, section +  &      
      String(index), "visible", visstring)         
   SetProfileString(file, section +  &
      String(index), "alignment", alignstring)   
   SetProfileString(file, section +  &
      String(index), "title", title)

   // Save the fixed position
   win.GetToolbarPos(index, row, offset)
   SetProfileString(file, section +  &
      String(index), "row", String(row))
   SetProfileString(file, section +  &
      String(index), "offset", String(offset))

   // Save the floating position
   win.GetToolbarPos(index, x, y, w, h)
   SetProfileString(file, section +  &
      String(index), "x", String(x))
   SetProfileString(file, section +  &
      String(index), "y", String(y))
   SetProfileString(file, section +  &
      String(index), "w", String(w))

   SetProfileString(file, section +  &
      String(index), "h", String(h))
   END IF
NEXT

end subroutine

on u_toolbar.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_toolbar.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

