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
        <table border="0" cellpadding="5" cellspacing="5" width="100%">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white">
                    <h2>
                        <font size="4" >
                            Select Building
                        </font>
                    </h2>
                    <form method="post" action="display_arcs.jsp">
                        <table><tr><td>        
                                    <select name="building_name" id="building_name">
                                        <% connectionString cs = new connectionString();
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
                                                String q1 = "Select * from buildings";
                                                rs = (s.executeQuery(q1));
                                                while (rs.next()) {%>
                                        <option value=<%out.println(rs.getString("building_name"));%>>
                                            <%
                                                out.println(rs.getString("building_name"));
                                            %>
                                        </option>
                                        <%
                                                }
                                                rs.close();
                                                s.close();
                                                con.close();
                                            } catch (Exception e) {//Catch exception if any
                                                System.err.println("Error: " + e.getMessage());
                                                //out.println(count2);
                                            }%>
                                    </select>  
                                </td><td><input type="submit" value="Submit"/></td></tr>
                        </table>
                </td>
            </tr>
        </table>
    </body>
</html>
