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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Evacuation Planner</title>
    </head>
    <body vlink="black" alink="black" link="black">
    <u><a href="edit_data.jsp" target="f2" ><font size="4">Edit data</font></a></u>>
    <u><a href="Edit_options_passed.jsp" target="f2" ><font size="4">Options</font></a></u>>
     <font size="4">Delete node</font>
        <table border="0" cellpadding="5" cellspacing="5" align="center">
            <tr>
                <!-- ------------------------------------------------------------------------------------>
                <td bgcolor="white" >
                    <%
                        //String lineToRemove = "My name is node2";
                        //System.out.println("Successfuly Deleted node with information '" +node_to_be_deleted);
                        String lineToRemove = request.getParameter("node_to_be_deleted");
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
                            Statement stm = con.createStatement();
                            /* String q1 = "Select * from buildings where building_name = '" + building_name + "'";
                            rs = (stm.executeQuery(q1));
                            int building_id = 0;
                            while (rs.next()) {
                                building_id = rs.getInt("building_id");
                            } */
                            String query1 = "Select *  from node as n where n.node_id = '" + lineToRemove+"' and building_name = '"+building_name+"'";
                            rs = (stm.executeQuery(query1));
                            while (rs.next()) {%>
                    <p>Successfully deleted the node with information: <br/>
                        {Node ID, Node Name, Floor, Actual Capacity, Initial Capacity, Latitude, Longitude} <br/>
                        <% //out.println(file); 
                                out.println(rs.getString(2) + " , " + rs.getString(3) + " , " + rs.getInt(4) + " , " + rs.getInt(5) + " , " + rs.getFloat(6) + " , " + rs.getFloat(7));
                            }%>
                    </p><hr/> <%
                        String query2 = "DELETE FROM node as n where n.node_id = '" + lineToRemove+"' and building_name = '"+building_name+"'";
                        stm.executeUpdate(query2);

                       /*  String query3 = "select * from information_schema.tables where table_name = node";
                        rs = stm.executeQuery(query3);
                        if (rs.next()) {
                            String query4 = "DELETE FROM node_" + building_id + "_withladder as nl where nl.node_id = " + Integer.parseInt(lineToRemove);
                            stm.executeUpdate(query4);
                        } */
                        //out.println("print building iddddd" + building_id);
%>
                    <form action ="delete_another_node.jsp" method="post" >
                        <input type="hidden" name="building_name" value = <% out.println(building_name);%>/>
                        <table align="center"><tr>
                                <td><input type="submit" name="B1" value="Delete another node" /></td>
                            </tr>
                        </table>
                    </form>
                </td></tr>
        </table>
        <table border="1" cellpadding="5" cellspacing="5" align="center">  
            <b>Updated Node File:</b><br/> 
          <!--Print these details-->
            
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

         <form method="post" action="edit_data.jsp">
            <center><input type="submit" value="Back"></center>
        </form>
    </body>
</html>