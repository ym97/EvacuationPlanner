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
                <td>
                    <%
                        String building_name = session.getAttribute("building_name").toString();
                        String algo = request.getParameter("algo");
                        String scenario_name = session.getAttribute("scenario_name").toString();
                        int algo1 = Integer.parseInt(algo);
                    %>

                    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
                <p align="center">Editing Node information for building: <%
                    //building_name = building_name.replace("_", " ");
                    out.println(building_name);
                    //building_name = building_name.replace(" ", "_");
                    %> </p>   
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
                        // out.println("connectionnnn stablished");
                        Statement stm = con.createStatement();
                        
                %>
                <form action ="edited_node_info_at_run.jsp" method="post" >
                    <table border="0" cellpadding="5" cellspacing="5" align="center">
                        <%

                           /*  if (algo1 == 1) {
                                System.out.println("inside edit node before run.jsp"); */
                        %>
                        <tr><td>Node ID</td><td>Node Name</td><td>Building Name</td><td>Capacity</td><td>Floor</td><td>Latitude</td><td>Longitude</td></tr>     
            <% // out.println("kuch to print ho");
                String query = "Select * from node where building_name = '"+building_name+"'";
                rs = stm.executeQuery(query);
                while (rs.next()) {
            %>
            <tr><td> <% out.println(rs.getString(1));%> </td><td> <% out.println(rs.getString(2));%> </td><td> <% out.println(rs.getString(3));%> </td><td> <% out.println(rs.getInt(4));%> </td><td> <% out.println(rs.getInt(5));%> </td><td> <% out.println(rs.getFloat(6));%> </td><td> <% out.println(rs.getFloat(7));%> </td></tr>
            <%
                    }
                %>
                        <tr>
                        <input type="hidden" name="building_name" value=<% out.println(building_name);%>/>
                        <input type="hidden" name="algo" value=<%out.println(algo);%>/>
                        <td><input type="submit" name="B1" value="Submit" /></td>
                        </tr>  
                    </table>
                    <%
                rs.close();
                stm.close();
                con.close();
            } catch (Exception e) {//Catch exception if any
                System.err.println("Error: " + e.getMessage());
                //out.println(count2);
            }
        %>
                    
                </form>
                </td>
                </tr>
        </table>
    </body>
</html>
