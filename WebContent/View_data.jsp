<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@include file="connectionString.jsp" %>
<!--%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
         <%
     		    String buildingName = request.getParameter("param1");
         		if(buildingName==null)
        				buildingName = session.getAttribute("building_name").toString();
                 session.setAttribute("building_name", buildingName);
         %>
    </head>
    <body vlink="black" alink="black" link="black">
    <u><a href="building_created.jsp" target="f2" ><font size="4">Home</font></a></u>
    <font size="4">View data</font><br>
   <center><b><%out.println(buildingName);%></b></center>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
                    <tr><td><a href="view_basic_data.jsp"><font color="black" ><b>1. View Node/edge information of building </b></font></a></td></tr>                     
                    <tr><td><a href="view_scenario.jsp"><font color="black"><b>2. View Scenario of building </b></font></a></td></tr>
                    <<!-- tr><td><a href="view_ladderplacement_data.jsp"><font color="black"><b>3. View Ladder Placement information of building </b></font></a></td></tr> -->                        
                    <tr><td><a href="view_name.jsp" ><font color="black"><b>3. All Scenario names of a building</b></font></a></td></tr>
                    <!-- <tr><td><a href="view_history.jsp" ><font color="black"><b>5. View past runs</b></font></a></td></tr> -->
                 
            
        </table>
   
    </body>
</html>