<%-- 
    Document   : view_arcs
    Created on : Apr 4, 2012, 2:24:51 AM
    Author     : abc
--%>
<%@include file="connectionString.jsp" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
    <body vlink="black" alink="black" link="black">
    <u><a href="building_created.jsp" target="f2" >Home</a></u> > 
     <u><a href="View_data.jsp" target="f2" >View data</a></u> > 
     View name
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">
                    <h2>
                        <font size="4" >
                            Select Building
                        </font>
                    </h2>
                    <form method="post" action="View_data.jsp">
                        <table>     
                                 
                                        <% 
                                        String building_name = session.getAttribute("building_name").toString();
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
                                                
                                                String query1 = "select distinct scenario_name, scenario_description from scenario_node where building_name = '"+building_name+"'";
                    			                rs = s.executeQuery(query1);
                    			                while(rs.next()) {
                    			                	%>
                    			                	<tr><td><% 
                                                    out.println(rs.getString("scenario_name"));%></td>
                                                    </tr>
                                                	
                                                	<tr><td><%
                                                	out.println(rs.getString("scenario_description"));%></td>
                                                </tr><%
                    			                }
                                                rs.close();
                                                s.close();
                                                con.close();
                                            } catch (Exception e) {//Catch exception if any
                                                System.err.println("Error: " + e.getMessage());
                                                //out.println(count2);
                                            }%>
                                 
                                </td><td><input type="submit" value="Back"/></td></tr>
                        </table>
                        </form>
                </td>
            </tr>
        </table>
    </body>
</html>
