$PBExportHeader$uo_resize.sru
forward
global type uo_resize from nonvisualobject
end type
end forward

global type uo_resize from nonvisualobject
end type
global uo_resize uo_resize

type variables
//Window Control
windowobject io_Control[]

end variables

forward prototypes
public subroutine of_settag (window aw_window)
public subroutine of_doresize (window aw_window)
end prototypes

public subroutine of_settag (window aw_window);integer li_i, li_j, li_k
int li_tabpageCount
int li_controlCount

io_Control  = aw_window.control
//
// Scan all the controls in the control list and build up the tags
// for the resizing

for li_i=1 to upperbound(io_Control)

   choose case io_Control[li_i].typeof()
      case Commandbutton!
         Commandbutton lcb
         lcb=create commandbutton
         lcb=io_Control[li_i]
         lcb.tag=lcb.tag+&
                "<Y"+string(lcb.y/aw_window.workspaceheight())+"Y>"+&
                "<X"+string(lcb.x/aw_window.workspacewidth())+"X>"+&
                "<H"+string(lcb.height/aw_window.workspaceheight())+"H>"+&
                "<W"+string(lcb.width/aw_window.workspacewidth())+"W>"
      case DropDownListBox!
         DropDownListBox lddlb
         lddlb=create dropdownlistbox
         lddlb=io_Control[li_i]
         lddlb.tag=lddlb.tag+&
                  "<Y"+string((lddlb.y/aw_window.workspaceheight()))+"Y>"+&
                  "<X"+string((lddlb.x/aw_window.workspacewidth()))+"X>"+&
                  "<H"+string((lddlb.height/aw_window.workspaceheight()))+"H>"+&
                  "<W"+string((lddlb.width/aw_window.workspacewidth()))+"W>"

      case CheckBox!
         CheckBox lcbx
         lcbx=create checkbox
         lcbx=io_Control[li_i]
         lcbx.tag= lcbx.tag+&
                 "<Y"+string((lcbx.y/aw_window.workspaceheight()))+"Y>"+&
                 "<X"+string((lcbx.x/aw_window.workspacewidth()))+"X>"+&
                 "<H"+string((lcbx.height/aw_window.workspaceheight()))+"H>"+&
                 "<W"+string((lcbx.width/aw_window.workspacewidth()))+"W>"

      case GroupBox!
         GroupBox lgb
         lgb=create groupbox
         lgb=io_Control[li_i]
         lgb.tag= lgb.tag+&
                "<Y"+string((lgb.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgb.x/aw_window.workspacewidth())) +"X>"+&
                "<H"+string((lgb.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgb.width/aw_window.workspacewidth()))+"W>"

      case HScrollBar!
         HScrollBar lhsb
         lhsb=create hscrollbar
         lhsb=io_Control[li_i]
         lhsb.tag= lhsb.tag+&
	         "<Y"+string((lhsb.y/aw_window.workspaceheight()))+"Y>"+&
                 "<X"+string((lhsb.x/aw_window.workspacewidth())) +"X>"+&
                 "<H"+string((lhsb.height/aw_window.workspaceheight()))+"H>"+&
                 "<W"+string((lhsb.width/aw_window.workspacewidth()))+"W>"

      case Oval!
         Oval lGOval
         lgoval=create oval
         lgoval=io_Control[li_i]
         lgoval.tag= lgoval.tag+&
	             "<Y"+string((lgoval.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgoval.x/aw_window.workspacewidth())) +"X>"+&
                "<H"+string((lgoval.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgoval.width/aw_window.workspacewidth()))+"W>"

      case Picture!
         Picture lGPicture
         lgpicture=create picture
         lgpicture=io_Control[li_i]
         lgpicture.tag= lgpicture.tag+&
	             "<Y"+string((lgpicture.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgpicture.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lgpicture.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgpicture.width/aw_window.workspacewidth()))+"W>"

      case PictureButton!
         PictureButton lpb
         lpb=create picturebutton
         lpb=io_Control[li_i]
         lpb.tag= lpb.tag+&
	             "<Y"+string((lpb.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lpb.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lpb.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lpb.width/aw_window.workspacewidth()))+"W>"

      case RadioButton!
         RadioButton lrb
         lrb=create radiobutton
         lrb=io_Control[li_i]
         lrb.tag= lrb.tag+&
	             "<Y"+string((lrb.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lrb.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lrb.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lrb.width/aw_window.workspacewidth()))+"W>"

      case Rectangle!
         Rectangle lGRectangle
         lgrectangle=create rectangle
         lgrectangle=io_Control[li_i]
         lgrectangle.tag= lgrectangle.tag+&
	             "<Y"+string((lgrectangle.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgrectangle.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lgrectangle.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgrectangle.width/aw_window.workspacewidth()))+"W>"

      case RoundRectangle!
         RoundRectangle lGRRectangle
         lgrrectangle=create roundrectangle
         lgrrectangle=io_Control[li_i]
         lgrrectangle.tag= lgrrectangle.tag+&
	             "<Y"+string((lgrrectangle.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgrrectangle.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lgrrectangle.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgrrectangle.width/aw_window.workspacewidth()))+"W>"

      case SingleLineEdit!
         SingleLineEdit lsle
         lsle=create singlelineedit
         lsle=io_Control[li_i]
         lsle.tag= lsle.tag+&
	               "<Y"+string((lsle.y/aw_window.workspaceheight()))+"Y>"+&
                  "<X"+string((lsle.x/aw_window.workspacewidth())) +"X>"+&
                  "<H"+string((lsle.height/aw_window.workspaceheight())) +"H>"+&
                  "<W"+string((lsle.width/aw_window.workspacewidth()))+"W>"

      case StaticText!
         StaticText lst
         lst=create statictext
         lst=io_Control[li_i]
         lst.tag= lst.tag+&
	             "<Y"+string((lst.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lst.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lst.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lst.width/aw_window.workspacewidth()))+"W>"

      case VScrollBar!
         VScrollBar lvsb
         lvsb=create vscrollbar
         lvsb=io_Control[li_i]
         lvsb.tag= lvsb.tag+&
	             "<Y"+string((lvsb.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lvsb.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lvsb.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lvsb.width/aw_window.workspacewidth()))+"W>"

      case Datawindow!
         Datawindow ldw
         ldw=create datawindow
         ldw=io_Control[li_i]
         // on datawindows we save the old tage because we are going
         // to use the ZC tag to tell us if we should leave the
         // datawindow zoom alone.
         ldw.tag= ldw.tag+&
	             "<Y"+string((ldw.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((ldw.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((ldw.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((ldw.width/aw_window.workspacewidth()))+"W>"+&
                "<Z"+string((100/aw_window.workspacewidth()))+"Z>"

      case EditMask!
         EditMask lem
         lem=create editmask
         lem=io_Control[li_i]
         lem.tag= lem.tag+&
	             "<Y"+string((lem.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lem.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lem.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lem.width/aw_window.workspacewidth()))+"W>"

      case Graph!
         Graph lGph
         lgph=create graph
         lgph=io_Control[li_i]
         lgph.tag= lgph.tag+&
	             "<Y"+string((lgph.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgph.x/aw_window.workspacewidth())) +"X>"+&
                "<H"+string((lgph.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgph.width/aw_window.workspacewidth()))+"W"

      case Line!
         Line lGLine
         lgline=create line
         lgline=io_Control[li_i]
         lgline.tag= lgline.tag+&
	             "<Y"+string((lgline.beginy/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lgline.beginx/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lgline.endy/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lgline.endx/aw_window.workspacewidth()))+"W>"

      case ListBox!
         ListBox llb
         llb=create listbox
         llb=io_Control[li_i]
         llb.tag= llb.tag+&
	             "<Y"+string((llb.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((llb.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((llb.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((llb.width/aw_window.workspacewidth()))+"W>"

      case MultiLineEdit!
         MultiLineEdit lmle
         lmle=create multilineedit
         lmle=io_Control[li_i]
         lmle.tag= lmle.tag+&
	             "<Y"+string((lmle.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((lmle.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((lmle.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((lmle.width/aw_window.workspacewidth()))+"W>"

      case UserObject!
         UserObject luo
         luo=create UserObject
         luo=io_Control[li_i]
         luo.tag= luo.tag+&
	             "<Y"+string((luo.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((luo.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((luo.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((luo.width/aw_window.workspacewidth()))+"W>"
case treeview!
         treeview tv
         tv=create treeview
         tv=io_Control[li_i]
         tv.tag= tv.tag+&
	             "<Y"+string((tv.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((tv.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((tv.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((tv.width/aw_window.workspacewidth()))+"W>"
		
    case tab!
         tab ltb
         ltb=create tab
         ltb=io_Control[li_i]
         ltb.tag= ltb.tag+&
	             "<Y"+string((ltb.y/aw_window.workspaceheight()))+"Y>"+&
                "<X"+string((ltb.x/aw_window.workspacewidth()))+"X>"+&
                "<H"+string((ltb.height/aw_window.workspaceheight()))+"H>"+&
                "<W"+string((ltb.width/aw_window.workspacewidth()))+"W>"
            // for tabs we are going to walk through the tab hierarchy
            // to make sure we have all the visual elements in our control
            // array.
            li_tabpageCount = Upperbound(ltb.Control[])
            For li_j = 1 to li_tabpageCount
                li_controlCount =  Upperbound(ltb.Control[li_j].control[])
                for li_k =1 To li_controlCount
                     io_Control[Upperbound(io_Control) +1] = ltb.Control[li_j].control[li_k]
                     choose case ltb.Control[li_j].control[li_k].typeof()
                         case Datawindow!
                    end choose
                Next
            Next
   end choose
next


end subroutine

public subroutine of_doresize (window aw_window);integer li_i
integer li_foundYStart, li_foundXStart, li_foundHStart, li_foundWStart, li_foundZoomStart
integer li_foundYEnd, li_foundXEnd, li_foundHEnd, li_foundWEnd, li_foundZoomEnd 
integer  li_foundEnd
decimal ld_x,ld_y,ld_w,ld_h,ld_zf
boolean lb_noZoom, lb_moveOnly
windowobject lwo_control[]
lwo_control = io_Control //aw_window.control

for li_i=1 to upperbound(lwo_control)
   if lwo_control[li_i].tag<>"" then
     // extract tagged values
      li_foundYStart=PosA(lwo_control[li_i].tag,"<Y",1)
		li_foundXStart=PosA(lwo_control[li_i].tag,"<X",1)
		li_foundHStart=PosA(lwo_control[li_i].tag,"<H",1)
		li_foundWSTart=PosA(lwo_control[li_i].tag,"<W",1)
		li_foundZoomStart=PosA(lwo_control[li_i].tag,"<Z",1)
      li_foundYEnd=PosA(lwo_control[li_i].tag,"Y>",1)
		li_foundXEnd=PosA(lwo_control[li_i].tag,"X>",1)
		li_foundHEnd=PosA(lwo_control[li_i].tag,"H>",1)
		li_foundWEnd=PosA(lwo_control[li_i].tag,"W>",1)
		li_foundZoomEnd=PosA(lwo_control[li_i].tag,"Z>",1)
		li_foundEnd=PosA(lwo_control[li_i].tag,"<END>",1)
		
		ld_y=real(MidA(lwo_control[li_i].tag, li_foundYStart+2,li_foundYEnd -li_foundYStart -2))
      ld_x=real(MidA(lwo_control[li_i].tag,li_foundXStart+2,li_foundXEnd -li_foundXStart -2))
   	ld_h=real(MidA(lwo_control[li_i].tag,li_foundHStart+2,li_foundHEnd -li_foundHStart -2))
		ld_w=real(MidA(lwo_control[li_i].tag,li_foundWStart+2,li_foundWEnd -li_foundWStart -2))

		IF lwo_control[li_i].typeof() = DataWindow! THEN
	      ld_zf=real(MidA(lwo_control[li_i].tag,li_foundZoomStart+2,li_foundZoomEnd - li_foundZoomStart -2))
			ld_zf = aw_window.workspacewidth()*ld_zf
			if PosA(lwo_control[li_i].tag,"<NOZOOM>",1) > 0 then
				lb_noZoom=TRUE
				ld_zf=100
			end if
		END IF

      if PosA(lwo_control[li_i].tag,"<NORESIZE>",1) > 0 then
			lb_moveOnly = TRUE
		else 
			lb_moveOnly = FALSE
		end if
		
     // dynamically adjust control
	 ld_y*=aw_window.workspaceheight()
      ld_x*=aw_window.workspacewidth()
      ld_h*=aw_window.workspaceheight()
      ld_w*=aw_window.workspacewidth()
      
		
   choose case lwo_control[li_i].typeof()
      case Commandbutton!
         Commandbutton cb
         cb=create commandbutton
         cb=lwo_control[li_i]
         cb.y=ld_y;cb.x=ld_x
			if not lb_moveOnly then
			   cb.width=ld_w;cb.height=ld_h
	      end if		
			
      case DropDownListBox!
         DropDownListBox ddlb
         ddlb=create dropdownlistbox
         ddlb=lwo_control[li_i]
         ddlb.y=ld_y;ddlb.x=ld_x;ddlb.width=ld_w;ddlb.height=ld_h
			
      case CheckBox!
         CheckBox cbx
         cbx=create checkbox
         cbx=lwo_control[li_i]
         cbx.y=ld_y;cbx.x=ld_x;cbx.width=ld_w;cbx.height=ld_h

      case GroupBox!
         GroupBox gb
         gb=create groupbox
         gb=lwo_control[li_i]
         gb.y=ld_y;gb.x=ld_x;gb.width=ld_w;gb.height=ld_h

      case HScrollBar!
         HScrollBar hsb
         hsb=create hscrollbar
         hsb=lwo_control[li_i]
         hsb.y=ld_y;hsb.x=ld_x;hsb.width=ld_w;hsb.height=ld_h

      case Oval!
         Oval GOval
         goval=create oval
         goval=lwo_control[li_i]
         goval.y=ld_y;goval.x=ld_x;goval.width=ld_w;goval.height=ld_h

      case Picture!
         Picture GPicture
         gpicture=create picture
         gpicture=lwo_control[li_i]
         gpicture.y=ld_y;gpicture.x=ld_x;gpicture.width=ld_w;gpicture.height=ld_h

      case PictureButton!
         PictureButton pb
         pb=create picturebutton
         pb=lwo_control[li_i]
         pb.y=ld_y;pb.x=ld_x;pb.width=ld_w;pb.height=ld_h

      case RadioButton!
         RadioButton rb
         rb=create radiobutton
         rb=lwo_control[li_i]
         rb.y=ld_y;rb.x=ld_x;rb.width=ld_w;rb.height=ld_h

      case Rectangle!
         Rectangle GRectangle
         grectangle=create rectangle
         grectangle=lwo_control[li_i]
         grectangle.y=ld_y;grectangle.x=ld_x;grectangle.width=ld_w;grectangle.height=ld_h

      case RoundRectangle!
         RoundRectangle GRRectangle
         grrectangle=create roundrectangle
         grrectangle=lwo_control[li_i]
         grrectangle.y=ld_y;grrectangle.x=ld_x;grrectangle.width=ld_w;grrectangle.height=ld_h


      case SingleLineEdit!
         SingleLineEdit sle
         sle=create singlelineedit
         sle=lwo_control[li_i]
         sle.y=ld_y;sle.x=ld_x;sle.width=ld_w;sle.height=ld_h

      case StaticText!
         StaticText st
         st=create statictext
         st=lwo_control[li_i]
         st.y=ld_y;st.x=ld_x;st.width=ld_w;st.height=ld_h

      case VScrollBar!
         VScrollBar vsb
         vsb=create vscrollbar
         vsb=lwo_control[li_i]
         vsb.y=ld_y;vsb.x=ld_x;vsb.width=ld_w;vsb.height=ld_h

      case Datawindow!
         Datawindow dw
         dw=create datawindow
         dw=lwo_control[li_i]
         dw.y=ld_y;dw.x=ld_x;dw.width=ld_w;dw.height=ld_h
			// just in case the datawindow is assigned dynamically
			// we don't want a messy blowup.
		   If dw.DataObject <> "" and dw.Describe("DataWindow.Processing") <> "3"  then 
            	dw.Object.DataWindow.Zoom = Integer(ld_zf)
         	   End if    
			
      case EditMask!
         EditMask em
         em=create editmask
         em=lwo_control[li_i]
         em.y=ld_y;em.x=ld_x;em.width=ld_w;em.height=ld_h

      case Graph!
         Graph Gph
         gph=create graph
         gph=lwo_control[li_i]
         gph.y=ld_y;gph.x=ld_x;gph.width=ld_w;gph.height=ld_h

      case Line!
         Line GLine
         gline=create line
         gline=lwo_control[li_i]
         gline.beginy=ld_y;gline.beginx=ld_x;gline.endx=ld_w;gline.endy=ld_h

      case ListBox!
         ListBox lb
         lb=create listbox
         lb=lwo_control[li_i]
         lb.y=ld_y;lb.x=ld_x;lb.width=ld_w;lb.height=ld_h

      case MultiLineEdit!
         MultiLineEdit mle
         mle=create multilineedit
         mle=lwo_control[li_i]
         mle.y=ld_y;mle.x=ld_x;mle.width=ld_w;mle.height=ld_h
		
	case UserObject!
         UserObject uo
         uo=create UserObject
         uo=lwo_control[li_i]
         uo.y=ld_y;uo.x=ld_x;uo.width=ld_w;uo.height=ld_h
			
	case tab!
         tab tb
         tb=create tab
         tb=lwo_control[li_i]
         tb.y=ld_y;tb.x=ld_x;tb.width=ld_w;tb.height=ld_h
			
	case treeview!
         treeview tv
         tv=create treeview
         tv=lwo_control[li_i]
         tv.y=ld_y;tv.x=ld_x;tv.width=ld_w;tv.height=ld_h
		
		
   end choose

   end if
next
end subroutine

on uo_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

