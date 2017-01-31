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
<form method="post" action="Register_User.jsp">
<center>
 <div id="fotlinks1">
      <br/><p align="right"><h2>Building Evacuation Planner</h2></p>
    </div>
</center>    
<!-- <table border="0" cellpadding="5" cellspacing="5" width="60%" align="left" bgcolor="gray">
<tr>
----------------------------------------------------------------------------------
<td bgcolor="white">
			<h2>
                        
                            Evacuation in large building complexes
                        
                        </h2>
				<p>
                                <font color ="Black" size="3" face="arial" >
                                <br/>    
                        This tool for evacuation planning will help you to organize your emergency action 
                        plan to evacuate your building, given the topology of the building and 
                        approximate occupancy of the building.<br/><br/>
                        Given the building input as a graph, the tool provides a plan of 
                        how many number of people should be evacuated by which path, so that 
                        it minimizes the evacuation time.<br/><br/>
                        The user can store the building graph with capacity of each room, corridors, 
                        staircase and travel time of each. When there is need of evacuation, user needs 
                        input the approximate number of persons currently at the places.<br/><br/>
                        In this project, we explore algorithms to carry out evaluation planning from large buildings (offering multiple exits, multi-modal travel options) taking into account capacity constraints as well as priorities in evacuation. We also consider specific scenario of a building for example fire, bomb blast where we need to focus on the priority of a node based on its danger level. We also provide interface for visualization of a building where we can visualize the situation of building in a particular timestamp as well as path going from a source node.
<br/><br/> For more details Contact us at: <a href="mailto:giseiitb@gmail.com"><b>giseiitb@gmail.com</b></a>
                                </font>    
                                </p>					
</td>
</tr>
 </table> -->
<!-- <table border="0" cellpadding="5" cellspacing="5" width="30%">

<tr> -->
<!-------------------------------------------------------------------------------------->


<table border="0" cellpadding="5" align="center" bgcolor="gray">
                <thead>
                	
                    <tr>
                    <h2>
                        <th colspan="2" rowspan="3">Register here</th>
                        </h2>
                    </tr>
                </thead>
                <tbody>
                <tr>
                        <td>First Name</td>
                        <td><input type="text" name="fName" value="" /></td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td><input type="text" name="lName" value="" /></td>
                    </tr>
                   
                    <tr>
                       <td>Enter Username</td>
                        <td><input type="text" name="uname" value="" /></td>
                      
                    </tr>
                    
                    <tr>
                    	<td>Enter password</td>
                        <td><input type="password" name="pwd" value="" /></td>
                    </tr>
                    <!--  <tr>
                        <td>Confirm your password</td>
                    </tr> -->
                    <!-- <tr>
                        <td><input type="password" name="conf_pass" value="" /></td>
                    </tr> -->
                   <!--  <tr>
                        <td>Email ID</td>
                    </tr> -->
                    <!-- <tr>
                        <td><input type="text" name="eid" value="" /></td>
                    </tr> -->
                     <tr>
                        <td>Email</td>
                        <td><input type="text" name="email" value="" /></td>
                    </tr>
                   <%--  <%
                    String hash = Random(5);
					
                    %> --%>
                    <tr>
                    
                        <td ><input type="submit" value="Register" /><input type="reset" value="Reset" /></td>
                    </tr>
                   
                </tbody>
            </table>
            </form>
</body>
</html>
