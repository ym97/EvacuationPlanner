<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
   /* String name = request.getParameter( "uname" );
   session.setAttribute( "uName", "guest" );
   String pwd = request.getParameter( "pwd" );
   session.setAttribute( "pwd", pwd ); */
%>
<html>
<head>
<title>Evacuation Planner </title>
<script language="javascript" type="text/javascript">
if (self != top) {
    if (document.images)
        top.location.replace(window.location.href);
    else
        top.location.href = window.location.href;
}
</script>
</head>

<frameset rows="23%,*" cols="10%,80%,10%" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
    <frame/>
    <frame src="frame1.jsp" name="f1" scrolling="no" noresize="true">
    <frame/>
    <frame/>
    <!-- <frameset  cols="20%,*" FRAMEBORDER=NO FRAMESPACING=0 BORDER=0>
   <frame src="View_data.jsp" name="View_data" scrolling="yes" noresize="true">
   <frame  name="View" scrolling="yes" noresize="true">
  	<frameset/> -->
    
    <frame src="building_created.jsp" name="f2" scrolling="yes" noresize="true">
    <frame/>  
<frameset/>
</html>