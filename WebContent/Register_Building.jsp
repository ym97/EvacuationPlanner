<%-- 
    Document   : Running_Module
    Created on : Feb 18, 2012, 9:26:52 AM
    Author     : abc
--%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%    String buildingName="'Enter Building Name'";
%>
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>

<body vlink="black" alink="black" link="black">
<!-- <table border="0" cellpadding="5" cellspacing="5" align ="center">
<tr>
----------------------------------------------------------------------------------
<td bgcolor="white">  
   
   -->
<center> 
 <font size="4"><b>Register New Building:</b></font><br><br>
 <!-- enctype="multipart/form-data" -->
    <!-- <form method="post" action="input_files.jsp" > -->
	<form action="RegisterBuilding9" onSubmit="WriteToFile(this)" method="post" enctype="multipart/form-data">
	<table align="center">
            <tr>
                <td>Building Name</td> 
                <td><input type="text" name="buildingName" /></td>
            </tr>
            <tr>
                <td>Description</td> 
                <td><input type="text" name="description" /></td>
            </tr>
            <tr>
                <td>Floors</td> 
                <td><input type="text" name="floors"/></td>
              
            </tr>
            <tr>
                <td>Upload image</td> 
                 <td><input type="file" name="file1"><!-- Here You Can Add more numbers of Files For Uploading --></td>
            </tr>
            <tr><td><input type="submit" value="Submit"/></td>
             <td> <a href="building_created.jsp" align="right"><input type="button" color="black" name="back" value="Back"></input></a></td></tr>
        </table>
        </form>
</center>       

<!-- </td> 
</tr>
</table> -->
</body>
</html>
