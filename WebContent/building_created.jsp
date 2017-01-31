<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>   
    </head>

<body vlink="black" alink="black" link="black">
<font size="4">Home</font><br>
 <table border="0" cellpadding="3" align="center"  >
<center>
<%
                                //System.out.println("Hello");
                                connectionString cs = new connectionString();
                                String url = cs.url;
                                String username = cs.username;
                                String password = cs.password;
                                try {
                                    Class.forName("org.postgresql.Driver");
                                    //String url = "jdbc:postgresql://localhost:5432/MTP";
                                    //Connection con = DriverManager.getConnection(url, "postgres", "postgres");
                                    Connection con = DriverManager.getConnection(url, username, password);
                                    ResultSet rs = null;
                                    // out.println("connectionnnn stablished");
                                    Statement s = con.createStatement();
                                    String q1 = "Select * from buildings where creator='"+session.getAttribute("uName").toString()+"'";
                                    rs = (s.executeQuery(q1));%> <thead>Buildings created :</thead>
                                    <tr>
                                    <th>Building Name</th>
                                           <td></td><td></td>
                                    <th>Date</th>
                                           <td></td><td></td>
                                    <th>Time</th>
                                           <td></td><td></td>
                                    <th>Image</th>
                                    </tr>
                                   <% 
                                	   while (rs.next()) {
                                	   String file_name1=rs.getString("building_name") +"_Floor_plan.png";%>
                                
   									
        							   <tr>
         							 
      							       <td><a href="View_data.jsp?param1=<%=rs.getString("building_name")%>"><%out.println(rs.getString("building_name"));%></a></td>
      							       
      							       <td></td><td></td>
      							      <%-- <td><%out.println(rs.getString("image"));%></td> --%>
      							        <td ><%out.println(rs.getDate("timestmp"));%></td>
      							        <td></td><td></td>
      							       <td ><%out.println(rs.getTime("timestmp"));%></td>
      							       <td></td><td></td>
      							       <td><img src="<%out.println(file_name1);%>" height=100 width=100/></td>
 								       </tr>
								  
								
                            
                            <%
                                    }
                                   
                                   %></center></table><%
                                   rs.close();
                                   s.close();
                                   con.close();
                               } catch (Exception e) {//Catch exception if any
                                   System.err.println("Error: " + e.getMessage());
                                   //out.println(count2);
                               }
                           %>
                          
                           
</body>
</html>