<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%--@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"--%>
<%@ page import="java.util.StringTokenizer"%>
<%int i = 0;
    int edge_id = 0;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <center>
                        <%
                            String building_name = request.getParameter("building_name");
                        	String creator = request.getParameter("creator");
                         %>
                        <p align="center"><b>Editing data for building <%
                          /*   building_name = building_name.replace("_", " "); */
                            out.println(building_name);
                        %></b></p>
                    </center>
                        
                        <%   out.println("Add edge for building : " + building_name);
                          /*   building_name = building_name.replace(" ", "_"); */
                            //out.println(building_name);     
                        %>
                        <form method="post" action="add_edge.jsp">
                            <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>    
                            <table border="0" cellpadding="1" cellspacing="4" align="center">
                                <tr></tr>
<!--<input type="hidden" name="Edge_number" value = <% out.println(edge_id);%> > -->  
                                <!----------------------------------------->                                
                                <tr><td>Edge Id</td> 
                                    <td><input type="text" name="Edge_Id"/></td>
                                    <td>Edge Name</td>
                                    <td><input type="text" name="Edge_name"/></td>             
                                    <td>Edge Floor</td> 
                                <td><input type="text" name="Edge_floor"/></td> 
                                <tr> <td>Start Node</td>
                                <td><input type="text" name="From_Node"/></td>
                            	<td>End Node</td> 
                                <td><input type="text" name="To_Node"/></td>
                                <td>Edge Length</td> 
                                <td><input type="text" name="Edge_length"/></td>
                                <td>Edge Capacity</td> 
                                <td><input type="text" name="Edge_capacity"/></td> 
                               
                            </tr>
                                <tr>
                                    <td><input type="submit" name="B1" value="Submit" />
                                    <td><input type="reset" name="B2" value="Reset" /></td>        
                                </tr>       
                            </table>
                        </form>    
                        <b> Edges Present earlier:</b>
                        <table border="1" cellpadding="5" cellspacing="5" align="center">    
                            <tr><td>Edge ID</td><td>Edge Name</td><td>To Node</td><td>From Node</td><td>Travel Time</td><td>Edge Capacity</td><td>Edge Floor</td></tr>                         
                            <%
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
                                    //   System.out.println("connectionnnn stablished");
                                    Statement s = con.createStatement();
                                    /* String q1 ="Select * from buildings where building_name = '" + building_name + "' and creator ='"+creator+"'";
                                    rs = (s.executeQuery(q1));
                                    int building_id = 0;
                                    while (rs.next()) {
                                        building_id = rs.getInt("building_id");
                                        //   System.out.println("print building iddddd" + building_id);
                                    } */
                                    String query1 = "Select * from edge where building_name = '"+building_name+"'";
                                    rs = (s.executeQuery(query1));
                                    while (rs.next()) {
                                %>
                                <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getInt(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getString(5));%> </td><td> <% out.println(rs.getString(6));%> </td><td> <% out.println(rs.getInt(7));%> </td><td> <% out.println(rs.getInt(8));%> </td></tr>
                                <%
                                                }%>
                            </table>
                            <%
                                    rs.close();
                                    s.close();
                                    con.close();
                                } catch (Exception e) {
                                    System.err.println(e.getMessage());
                                }
                            %>
                        </table>
                </td>
            </tr>
        </table>
    </body>
</html>

